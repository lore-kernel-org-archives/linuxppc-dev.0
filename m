Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id A60A8DE161
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 23:48:25 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Wed, 13 Aug 2008 15:48:11 +0200
References: <20080710123909.GA4275@pengutronix.de>
	<20080710153101.GD446@secretlab.ca>
In-Reply-To: <20080710153101.GD446@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808131548.11813.jbe@pengutronix.de>
Subject: Re: [BUG] fec_mpc52xx: Don't call mpc52xx_fec_reset() in ISR
Cc: Wolfram Sang <w.sang@pengutronix.de>, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Donnerstag, 10. Juli 2008, Grant Likely wrote:
> On Thu, Jul 10, 2008 at 02:39:09PM +0200, Wolfram Sang wrote:
> > Hello,
> >
> > today, I was debugging a kernel crash on a board with a MPC5200B using
> > 2.6.26-rc9. I found the following code in drivers/net/fec_mpc52xx.c:
>
> <snip>
>
> > I assume the proper thing to do is to set a flag in the ISR and handle
> > the soft reset later in some other context. Having never dealt with the
> > network core and its drivers so far, I am not sure which place would be
> > the right one to perform the soft reset. To not make things worse, I
> > hope people with more insight to network stuff can deliver a suitable
> > solution to this problem.
>
> Thanks for the bug report.  I'll take a look.

Some update:

Enabling XLB pipelining let occure this error less often. Kernel disables t=
his=20
feature by default yet.
The comment talks about "cfr errate 292." that is valid for MPC5200A, but=20
_it_seems_ no longer for MPC5200B. Has anybody experience if we can enablin=
g=20
pipelining on MPC5200B CPUs without triggering this bug?

We currently are playing with this setting:

Index: arch/powerpc/platforms/52xx/mpc52xx_common.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- arch/powerpc/platforms/52xx/mpc52xx_common.c.orig
+++ arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -99,11 +99,11 @@
 	out_be32(&xlb->master_pri_enable, 0xff);
 	out_be32(&xlb->master_priority, 0x11111111);
=20
=2D	/* Disable XLB pipelining
=2D	 * (cfr errate 292. We could do this only just before ATA PIO
=2D	 *  transaction and re-enable it afterwards ...)
+	/*
+	 * Enable pipelining, fixes FEC problems. The previous workaround seems
+	 * not needed, as we have an MPC5200B (not A).
 	 */
=2D	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
+	out_be32(&xlb->config, in_be32(&xlb->config) & ~MPC52xx_XLB_CFG_PLDIS);
=20
 	iounmap(xlb);
 }

jbe

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
