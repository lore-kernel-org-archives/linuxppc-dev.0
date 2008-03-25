Return-Path: <Haiying.Wang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 65EBDDE0EE
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 07:48:30 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m2PKmPxi023110
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 13:48:25 -0700 (MST)
Received: from az33exm23.fsl.freescale.net (az33exm23.am.freescale.net
	[10.64.32.8])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m2PKmOwE007730
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 15:48:24 -0500 (CDT)
Subject: Re: how to use head_fsl_booke.S:abort to restart
From: Haiying Wang <Haiying.Wang@freescale.com>
To: Philippe De Muyter <phdm@macqel.be>, kumar.gala@freescale.com
In-Reply-To: <20080325202001.GA31145@frolo.macqel>
References: <20080325161513.GB15991@frolo.macqel>
	<1206462895.2960.10.camel@r54964-12.am.freescale.net>
	<20080325202001.GA31145@frolo.macqel>
Content-Type: text/plain
Date: Tue, 25 Mar 2008 16:48:23 -0400
Message-Id: <1206478103.2960.29.camel@r54964-12.am.freescale.net>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, I see the problem here. For 8540/60 which has e500 v1 core, it
doesn't use RSTCR to assert HRESET_REQ signal to reset the whole system.
We probably need to add abort() in fsl_rstcr_restart() for those
silicons:

diff --git a/arch/powerpc/sysdev/fsl_soc.c
b/arch/powerpc/sysdev/fsl_soc.c
index 2c5388c..c2d07cd 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1434,7 +1434,8 @@ void fsl_rstcr_restart(char *cmd)
        if (rstcr)
                /* set reset control register */
                out_be32(rstcr, 0x2);   /* HRESET_REQ */
-
+       else
+               abort();
        while (1) ;
 }
 #endif

I don't have 8540 board to test.

Haiying


On Tue, 2008-03-25 at 21:20 +0100, Philippe De Muyter wrote:
> Hi Haiying,
> 
> On Tue, Mar 25, 2008 at 12:34:55PM -0400, Haiying Wang wrote:
> > 8540 doesn't have RSTCR register. You should not use fsl_rstcr_restart
> > for reboot your 8540 board.
> > 
> That's what I was thinking also (see my Post-Scriptum below), but current
> linux/powerpc sources use fsl_rstcr_restart for the mpc8540_ads board :( 
> 
> Philippe
> 
> > On Tue, 2008-03-25 at 17:15 +0100, Philippe De Muyter wrote:
> > > Hi all,
> > > 
> > > I have a mpc8540 board that could reboot when driven by a ARCH=ppc linux,
> > > but that hangs now in arch/powerpc/sysdev/fsl_soc.c:fsl_rstcr_restart when
> > > asked to reboot with a ARCH=powerpc linux.
> > > 
> > > I have found that if I call arch/powerpc/kernel/head_fsl_booke.S:abort from
> > > there, my board reboots correctly, but I feel that's not the right place
> > > to put that call.  Where/how should I do that ?
> > > 
> > > Philippe
> > > 
> > > PS : Does arch/powerpc/sysdev/fsl_soc.c:fsl_rstcr_restart actually work
> > > for mpc8540_ads boards ?
