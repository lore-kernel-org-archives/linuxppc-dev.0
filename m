Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A124DDE43
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 14:17:34 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lBB3HS5V020090
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 20:17:28 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lBB3HQMw013998
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 21:17:27 -0600 (CST)
Subject: Re: [PATCH] Fix rounding bug in emulation for double floatoperating
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AD0028E8-E305-443F-8872-C935D4E18F80@kernel.crashing.org>
References: <11972628522442-git-send-email-b13201@freescale.com>
	<20071210045616.GC29611@localhost.localdomain>
	<6EBEC19BF4A8F843BCD6B9155BBE2515C79D0D@zch01exm26.fsl.freescale.net>
	<AD0028E8-E305-443F-8872-C935D4E18F80@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1197343143.13519.2.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 11 Dec 2007 11:19:03 +0800
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

On Mon, 2007-12-10 at 23:00, Kumar Gala wrote:
> On Dec 9, 2007, at 11:25 PM, Liu Yu wrote:
> >
> >> -----Original Message-----
> >> From: David Gibson [mailto:david@gibson.dropbear.id.au]
> >> Sent: Monday, December 10, 2007 12:56 PM
> >> To: Liu Yu
> >> Cc: linuxppc-dev@ozlabs.org
> >> Subject: Re: [PATCH] Fix rounding bug in emulation for double
> >> floatoperating
> >>
> >>
> >> On Mon, Dec 10, 2007 at 01:00:52PM +0800, Liu Yu wrote:
> >>>
> >>> This patch fixes rounding bug in emulation for double float
> >> operating on PowerPC platform.
> >>>
> >>> When pack double float operand, it need to truncate the
> >> tail due to the limited precision.
> >>> If the truncated part is not zero, the last bit of work bit
> >> (totally 3 bits) need to '|' 1.
> >>>
> >>> This patch is completed in _FP_FRAC_SRS_2(X,N,sz)
> >> (arch/powerpc/math-emu/op-2.h).
> >>> Originally the code leftwards rotates the operand to just keep the
> >>> truncated part, then check whether it is zero. However, the
> >> number it
> >>> rotates is not correct when N is not smaller than
> >> _FP_W_TYPE_SIZE, and it will cause the work bit '|' 1 in the
> >> improper case.
> >>>
> >>> This patch fixes this issue.
> >>>
> >>> Signed-off-by: Liu Yu <b13201@freescale.com>
> >>
> >> Wow someone deciphered the hideous macro hell of the math
> >> emulation code enough to fix a bug.  I don't suppose you'd
> >> care to fix the millions of warnings that the math-emu code
> >> generates...?
> >
> > Oh, I don't like macro define either. But it's really a bug...
> 
> 
> how did you find this?
> 
It supposed to run the following test case on a powerpc platform.
Yu's patch fixes the issue.
Could you help to merge this patch in your tree?
---
#include <stdio.h>
#include <math.h>
#include <bits/nan.h>
#ifdef __SPE__
#include <spe.h>
int
getSPEFSCR()
{
    return __builtin_spe_mfspefscr();
}

void
setSPEFSCR(int i)
{
    __builtin_spe_mtspefscr(i);
}
#else
int
getSPEFSCR()
{
    return 0;
}

void
setSPEFSCR(int i)
{
}
#endif

void
dmul(double d, double d1, double expected)
{
    double d2;
    int before, after;

    before = getSPEFSCR();
    d2 = d * d1;
    after = getSPEFSCR();

    printf("dmul %llx * %llx = %llx expected %llx %s [0x%x 0x%x]\n", d, d1, d2, expected,
           (d2 == expected) ? "(PASS)" : "(FAIL)", before, after);
}

void
ddiv(double d, double d1, double expected)
{
    register double d2;
    int before, after;

    before = getSPEFSCR();
    d2 = d / d1;
    after = getSPEFSCR();

    printf("ddiv %llx / %llx = %llx expected %llx %s [0x%x 0x%x]\n", d, d1, d2, expected,
           (d2 == expected) ? "(PASS)" : "(FAIL)", before, after);
}

main()
{
    const double min_double = 4.9406564584124654e-324L;

    printf("\n");
    dmul(0.5L, min_double, 0.0L);
    dmul(-0.5L, min_double, 0.0L);
    dmul(-min_double, -0.5L, 0.0L);
    printf("\n");
    ddiv(min_double, 2.0L, 0.0L);
}
