Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 77007DDF35
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 19:28:55 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lBC8SmM6028066
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 01:28:49 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lBC8SkBe006322
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 02:28:47 -0600 (CST)
Subject: Re: [PATCH] Fix rounding bug in emulation for double floatoperating
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <A069B515-C07A-4471-9473-7A7E29F12685@kernel.crashing.org>
References: <11972628522442-git-send-email-b13201@freescale.com>
	<20071210045616.GC29611@localhost.localdomain>
	<6EBEC19BF4A8F843BCD6B9155BBE2515C79D0D@zch01exm26.fsl.freescale.net>
	<AD0028E8-E305-443F-8872-C935D4E18F80@kernel.crashing.org>
	<1197343143.13519.2.camel@localhost.localdomain>
	<A069B515-C07A-4471-9473-7A7E29F12685@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1197448223.29372.12.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 12 Dec 2007 16:30:24 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Liu Yu <B13201@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-12-11 at 23:26, Kumar Gala wrote:
> >>
> >> how did you find this?
> >>
> > It supposed to run the following test case on a powerpc platform.
> > Yu's patch fixes the issue.
> > Could you help to merge this patch in your tree?
> > ---
> > #include <stdio.h>
> > #include <math.h>
> > #include <bits/nan.h>
> > #ifdef __SPE__
> > #include <spe.h>
> > int
> > getSPEFSCR()
> > {
> >    return __builtin_spe_mfspefscr();
> > }
> >
> > void
> > setSPEFSCR(int i)
> > {
> >    __builtin_spe_mtspefscr(i);
> > }
> > #else
> > int
> > getSPEFSCR()
> > {
> >    return 0;
> > }
> >
> > void
> > setSPEFSCR(int i)
> > {
> > }
> > #endif
> >
> > void
> > dmul(double d, double d1, double expected)
> > {
> >    double d2;
> >    int before, after;
> >
> >    before = getSPEFSCR();
> >    d2 = d * d1;
> >    after = getSPEFSCR();
> >
> >    printf("dmul %llx * %llx = %llx expected %llx %s [0x%x 0x%x]\n", 
> > d, d1, d2, expected,
> >           (d2 == expected) ? "(PASS)" : "(FAIL)", before, after);
> > }
> >
> > void
> > ddiv(double d, double d1, double expected)
> > {
> >    register double d2;
> >    int before, after;
> >
> >    before = getSPEFSCR();
> >    d2 = d / d1;
> >    after = getSPEFSCR();
> >
> >    printf("ddiv %llx / %llx = %llx expected %llx %s [0x%x 0x%x]\n", 
> > d, d1, d2, expected,
> >           (d2 == expected) ? "(PASS)" : "(FAIL)", before, after);
> > }
> >
> > main()
> > {
> >    const double min_double = 4.9406564584124654e-324L;
> >
> >    printf("\n");
> >    dmul(0.5L, min_double, 0.0L);
> >    dmul(-0.5L, min_double, 0.0L);
> >    dmul(-min_double, -0.5L, 0.0L);
> >    printf("\n");
> >    ddiv(min_double, 2.0L, 0.0L);
> > }
> 
> When I run this on a G5 (w/HW FP) I get:
> 
> dmul 3fe0000000000000 * 1 = 0 expected 0 (PASS)
> dmul bfe0000000000000 * 1 = 8000000000000000 expected 0 (PASS)
> dmul 8000000000000001 * bfe0000000000000 = 0 expected 0 (PASS)
> 
> ddiv 1 / 4000000000000000 = 0 expected 0 (PASS)
> 
> and on the 85xx w/FP emu:
> 
> dmul 3fe0000000000000 * 1 = 0 expected 0 (PASS)
> dmul bfe0000000000000 * 1 = 8000000000000000 expected 0 (PASS)
> dmul 8000000000000001 * bfe0000000000000 = 0 expected 0 (PASS)
> 
> ddiv 1 / 4000000000000000 = 0 expected 0 (PASS)
> 
> Maybe I'm missing where the error is.
I am missing ...
It is supposed to run based on previous IEEE 754 patch.
http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031351.html
Roy
