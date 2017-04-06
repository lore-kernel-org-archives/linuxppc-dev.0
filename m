Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzNMP2T3PzDqL0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 23:09:05 +1000 (AEST)
In-Reply-To: <20170404045605.gmr2uqelm3uxouwt@oak.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Don't try to fix up misaligned load-with-reservation
 instructions
Message-Id: <3vzNMN6qw4z9s8S@ozlabs.org>
Date: Thu,  6 Apr 2017 23:09:04 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-04 at 04:56:05 UTC, Paul Mackerras wrote:
> In the past, there was only one load-with-reservation instruction,
> lwarx, and if a program attempted a lwarx on a misaligned address, it
> would take an alignment interrupt and the kernel handler would emulate
> it as though it was lwzx, which was not really correct, but benign
> since it is loading the right amount of data, and the lwarx should be
> paired with a stwcx. to the same address, which would also cause an
> alignment interrupt which would result in a SIGBUS being delivered to
> the process.
> 
> We now have 5 different sizes of load-with-reservation instruction.
> Of those, lharx and ldarx cause an immediate SIGBUS by luck since
> their entries in aligninfo[] overlap instructions which were not
> fixed up, but lqarx overlaps with lhz and will be emulated as such.
> lbarx can never generate an alignment interrupt since it only
> operates on 1 byte.
> 
> To straighten this out and fix the lqarx case, this adds code to
> detect the l[hwdq]arx instructions and return without fixing them
> up, resulting in a SIGBUS being delivered to the process.
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/48fe9e9488743eec9b7c1addd3c93f

cheers
