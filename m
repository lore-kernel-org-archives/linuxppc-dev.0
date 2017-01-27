Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8g1X74YzzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:40:32 +1100 (AEDT)
In-Reply-To: <20161103051055.GA8368@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/2] powerpc/64: Fix checksum folding in csum_tcpudp_nofold and
 ip_fast_csum_nofold
Message-Id: <3v8g1X5rqwz9t0t@ozlabs.org>
Date: Fri, 27 Jan 2017 11:40:32 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-11-03 at 05:10:55 UTC, Paul Mackerras wrote:
> These functions compute an IP checksum by computing a 64-bit sum and
> folding it to 32 bits (the "nofold" in their names refers to folding
> down to 16 bits).  However, doing (u32) (s + (s >> 32)) is not
> sufficient to fold a 64-bit sum to 32 bits correctly.  The addition
> can produce a carry out from bit 31, which needs to be added in to
> the sum to produce the correct result.
> 
> To fix this, we copy the from64to32() function from lib/checksum.c
> and use that.
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b492f7e4e07a28e706db26cf4943bb

cheers
