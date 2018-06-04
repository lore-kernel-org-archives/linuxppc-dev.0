Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgC4sglzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:03 +1000 (AEST)
In-Reply-To: <20180518130116.A1A3B6F937@po14934vm.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/lib: Adjust .balign inside string functions for PPC32
Message-Id: <40zxg75qFJz9s5b@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:58 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-18 at 13:01:16 UTC, Christophe Leroy wrote:
> commit 87a156fb18fe1 ("Align hot loops of some string functions")
> degraded the performance of string functions by adding useless
> nops
> 
> A simple benchmark on an 8xx calling 100000x a memchr() that
> matches the first byte runs in 41668 TB ticks before this patch
> and in 35986 TB ticks after this patch. So this gives an
> improvement of approx 10%
> 
> Another benchmark doing the same with a memchr() matching the 128th
> byte runs in 1011365 TB ticks before this patch and 1005682 TB ticks
> after this patch, so regardless on the number of loops, removing
> those useless nops improves the test by 5683 TB ticks.
> 
> Fixes: 87a156fb18fe1 ("Align hot loops of some string functions")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1128bb7813a896bd608fb622eee3c2

cheers
