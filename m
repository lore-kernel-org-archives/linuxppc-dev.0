Date: Fri, 19 Mar 1999 08:46:12 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Michael Lundkvist <ml@epact.se>,
        David De Ridder <david.de.ridder@bitsmart.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME 2306 almost up and running
In-Reply-To: <Pine.HPP.3.96.990312140258.1078B-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.3.96.990319081706.22655A-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Gabriel Paubert wrote:
> > I'm attaching the boot log and I'm cc-ing to linuxppc-dev to see if
> > anyone there has any help to give me.
> > 
> 
> > My board is a MVME 2307SC-1 with 64MB RAM and a DEC 21143-TD etherne chip.
> 
> Matt Porter had a fix for the problems with the 21143, but I don't know
> where they can be found. Perhaps it will be simpler now that vger is back
> (although I won't switch back to vger for at least a few weeks). 

Sorry for the big delay, lost Internet at home for a couple weeks. :-/

All 21143-based boards shipped to this point had a non-compliant DEC SROM
which caused overruns in the driver's private structure that leads to the
crash in del_timer.  I've attached a patch to handle this bad value and
worked with David Davies so it should make it's way into the kernel
eventually.  Newly manufactured boards should be leaving with corrected
SROMs...I'd like to give the person who misread the spec a swift kick in
the knees...turns out that the SROMs from all the PowerPlus boards ever
made are non-compliant only they don't crash the de4x5 driver. 

diff -ud linux-2.1-bak/drivers/net/de4x5.c linux-2.1/drivers/net/de4x5.c
--- linux-2.1-bak/drivers/net/de4x5.c	Tue Jan  5 09:37:38 1999
+++ linux-2.1/drivers/net/de4x5.c	Mon Mar  8 02:30:23 1999
@@ -4794,6 +4794,7 @@
     if (lp->state == INITIALISED) {
         lp->ibn = 3;
         lp->active = *p++;
+	if (MOTO_SROM_BUG) lp->active = 0;
 	lp->phy[lp->active].gep = (*p ? p : 0); p += (2 * (*p) + 1);
 	lp->phy[lp->active].rst = (*p ? p : 0); p += (2 * (*p) + 1);
 	lp->phy[lp->active].mc  = TWIDDLE(p); p += 2;
@@ -4805,6 +4806,7 @@
     } else if ((lp->media == INIT) && (lp->timeout < 0)) {
         lp->ibn = 3;
 	lp->active = *p;
+	if (MOTO_SROM_BUG) lp->active = 0;
 	lp->infoblock_csr6 = OMR_MII_100;
 	lp->useMII = TRUE;
 	lp->infoblock_media = ANS;
diff -ud linux-2.1-bak/drivers/net/de4x5.h linux-2.1/drivers/net/de4x5.h
--- linux-2.1-bak/drivers/net/de4x5.h	Tue Jan  5 09:37:40 1999
+++ linux-2.1/drivers/net/de4x5.h	Mon Mar  8 02:30:43 1999
@@ -599,6 +599,11 @@
 #define BLOCK0_MC      0x3f        /* Media Code */
 
 /*
+** SROM fixup
+*/
+#define MOTO_SROM_BUG	((lp->active == 8) &&
((le32_to_cpu(get_unaligned((u32 *)dev->dev_addr))&0x00ffffff)==0x3e0008))
+
+/*
 ** DC21040 Full Duplex Register (DE4X5_FDR)
 */
 #define FDR_FDACV  0x0000ffff      /* Full Duplex Auto Configuration
Value */

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
