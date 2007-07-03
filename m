Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 922DDDDED2
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 21:36:13 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l63Ba6aM025917
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 04:36:07 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l63Ba56r026739
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 06:36:06 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] ucc_geth.c, make PHY device optional.
Date: Tue, 3 Jul 2007 19:38:00 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D8385E@zch01exm26.fsl.freescale.net>
In-Reply-To: <1183461586.20673.192.camel@gentoo-jocke.transmode.se>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <joakim.tjernlund@transmode.se>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]
> Sent: Tuesday, July 03, 2007 7:20 PM
> To: Li Yang-r58472
> Cc: linuxppc-dev Development; Netdev; Fleming Andy-afleming
> Subject: RE: [PATCH] ucc_geth.c, make PHY device optional.
>=20
> On Tue, 2007-07-03 at 16:22 +0800, Li Yang-r58472 wrote:
> > > -----Original Message-----
> > > From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]
> > > Sent: Tuesday, July 03, 2007 3:21 PM
> > > To: Li Yang-r58472
> > > Cc: linuxppc-dev Development; Netdev; Fleming Andy-afleming
> > > Subject: RE: [PATCH] ucc_geth.c, make PHY device optional.
> > >
> > > On Tue, 2007-07-03 at 11:42 +0800, Li Yang-r58472 wrote:
> > > > > -----Original Message-----
> > > > > From: netdev-owner@vger.kernel.org
> > > > [mailto:netdev-owner@vger.kernel.org] On
> > > > > Behalf Of Joakim Tjernlund
> > > > > Sent: Tuesday, July 03, 2007 8:52 AM
> > > > > To: 'linuxppc-dev Development'; 'Netdev'; Li Yang-r58472
> > > > > Subject: [PATCH] ucc_geth.c, make PHY device optional.
> > > > >
> > > > > > This patch makes the PHY optional for ucc_geth.c ethernet
> > driver.
> > > > > > This is useful to support a direct mii to mii connection to,
for
> > > > example,
> > > > > > a onboard swicth.
> > > > > >
> > > > > > Signed-off-by: Joakim Tjernlund
<joakim.tjernlund@transmode.se>
> > > > > ----
> > > > Hi Joakim,
> > > >
> > > > I'm wondering if we really need to have the option to disable
> > phylib.
> > >
> > > maybe, but it has to be dynamic too. I need to use PHY on UCC2 and
mii
> > > on UCC3 and UCC4.
> > >
> > > > Actually we have made phylib selected by default for ucc_geth.
Many
> > L2
> > > > switch chips have the capacity to be controlled.  Therefore they
can
> > be
> > > > managed as a phy device.
> > >
> > > Yes, they can be but why force a PHY impl. when its is of no use?
The
> > > only thing the eth driver needs from the it is speed and duplex.
If
> > > these are fixed, you don't need to talk with a PHY.
> >
> > The driver needs to get and set the link speed/status on runtime
(such
> > as for ethtool interface).  Currently this is implementation through
> > phydev interface.  IMHO, it will be easier to maintain if we only
use
> > this standard interface, rather than use different interfaces for
> > different cases.
>=20
> hmm maybe, but there is no need to much around with speed/status
> from user space. The speed and duplex must be set before user space
> is up.
>=20
> >
> > >
> > > > For the MII interface which is not
> > > > configurable, shouldn't we use the fixed phy support from
Vitaly?
> > >
> > > Well, I think the the fixed phy is great when your eth driver
requires
> > a
> > > PHY, but it is a workaround with extra processing overhead. IMHO
the
> > > best impl. is to make the PHY optional in the eth driver and as
you
> > can
> > > see from the patch, that was really simple.
> >
> > I agree there is overhead. However, it will have the advantage of
> > abstracting all the PHY related stuff out of controller driver.
> >
> > >
> > > An useful extension would be to add a new propety in the DTS to
hold
> > > initial speed and duplex(perhaps extend phy-connection-type). This
> > > would be useful for the fixed driver too as one could derive speed
and
> > > duplex for the fixed phy from that property instead of creating a
> > fixed
> > > phy for each speed and duplex one want to support.
> >
> > I agree that there should be a device node to configure it.  The
current
> > fixed phy driver is a little bit too complex to emulate the register
> > access.  Maybe it's better to have a null phy driver which just
reads
> > PHY capacity and status from device node.
>=20
> A null phy driver is better than the current fixed phy, I agree.
> Where would you like to put initial speed and duplex? In a fake phy
node
> or in the ethernet node?

I think a fake phy node is better.

- Leo
