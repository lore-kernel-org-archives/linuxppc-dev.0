To: benh@kernel.crashing.org
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SUNGEM config
References: <Pine.LNX.4.33.0202121351140.23572-100000@blues.wcg.mcgill.ca>
	<20020213105951.10807@mailhost.mipsys.com>
Reply-To: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
From: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
Date: 14 Feb 2002 01:52:46 +0900
Message-ID: <87k7th2ujl.fsf@theorie.physik.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-=-=

Hi,

> I know there are some laptop specific tools that monitor the link
> and do the shutdown of the interface when there is no link but I
> don't have any precise pointer at hand.

On Debian systems, this is done by a small daemon named ifd in the
laptop-net package.

Unfortunately, it uses the SIOCGMIIPHY and SIOCGMIIREG ioctls for link
detection, which on my Pismo reproducibly lead to machine check
oopses.  I've managed to track down the problem, a patch is included
below.  Basically, instead of really reading the registers it fakes
and returns a register setting from the cached status of the device.
Right now, it is fairly ugly, since it only works for that relevant
one bit.

Regards, Jens.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=sungem-ioctl.patch
Content-Description: Patch to SUNGEM driver for GMAC

--- linux-benh/drivers/net/sungem.c	Wed Feb  6 20:01:22 2002
+++ linux/drivers/net/sungem.c	Thu Feb 14 01:37:41 2002
@@ -2553,11 +2540,16 @@
 		break;

 	case SIOCGMIIPHY:		/* Get address of MII PHY in use. */
+	case SIOCDEVPRIVATE:		/* for binary compat, remove in 2.5 */
 		data->phy_id = gp->mii_phy_addr;
 		/* Fallthrough... */

 	case SIOCGMIIREG:		/* Read MII PHY register. */
-		data->val_out = __phy_read(gp, data->reg_num & 0x1f, data->phy_id & 0x1f);
+	case SIOCDEVPRIVATE+1:		/* for binary compat, remove in 2.5 */
+		if(data->reg_num==1 && gp->lstate==link_up)
+			data->val_out = PCS_MIISTAT_LS;
+		else
+			data->val_out = 0;
 		rc = 0;
 		break;

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


P.S.: I forget whether to include or to attach patches.  My apologies
if I have done it incorrectly.

--
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je pézqbpbe je djuz tqtaj!

--=-=-=--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
