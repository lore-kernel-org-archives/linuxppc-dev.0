Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE0ADDDE19
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 11:08:22 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix bogus cache flushing on all 40x and BookE
	processors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0812031451450.7648@t2.domain.actdsltmp>
References: <20081201060152.00DCCDDDE3@ozlabs.org>
	<BD75FAE9-7D10-488B-9906-23B2D93F1FB6@kernel.crashing.org>
	<1228209641.7356.176.camel@pasglop>
	<Pine.LNX.4.64.0812031451450.7648@t2.domain.actdsltmp>
Content-Type: text/plain
Date: Thu, 04 Dec 2008 11:06:07 +1100
Message-Id: <1228349167.7356.272.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-12-03 at 15:09 -0800, Trent Piepho wrote:

> #ifdef __powerpc64__
> #define LONG_ASM_CONST(x)               ASM_CONST(x)
> #else
> #define LONG_ASM_CONST(x)               0
> #endif
> 
> #define CPU_FTR_NOEXECUTE               LONG_ASM_CONST(0x0000000800000000)
> 
> Am I not looking at the right code?  Since e200 and e500 aren't powerpc64,
> doesn't adding CPU_FTR_NOEXECUTE have no effect at all?

No, you are right, this is a case where I didn't actually verify that
the patch had the expected effect :-(

We are running out of low FTR bits, heck, I might make them 64-bit
for everybody soon.

I'll fix that up, thanks for spotting it.

Cheers,
Ben.
