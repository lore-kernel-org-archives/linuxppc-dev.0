Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y86Z131GzF0Rs
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:55:01 +1000 (AEST)
In-Reply-To: <20180529192001.30200-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/prom: Fix %u/%llx usage since prom_printf() change
Message-Id: <40y86Y5sSdz9rxs@ozlabs.org>
Date: Sat,  2 Jun 2018 01:55:01 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-05-29 at 19:20:01 UTC, Mathieu Malaterre wrote:
> In commit eae5f709a4d7 ("powerpc: Add __printf verification to
> prom_printf") __printf attribute was added to prom_printf(), which
> means GCC started warning about type/format mismatches. As part of that
> commit we changed some "%lx" formats to "%llx" where the type is
> actually unsigned long long.
> 
> Unfortunately prom_printf() doesn't know how to print "%llx", it just
> prints a literal "lx", eg:
> 
>   reserved memory map:
>     lx - lx
>     lx - lx
> 
> prom_printf() also doesn't know how to print "%u" (only "%lu"), it just
> print a literal "u", eg:
> 
>   Max number of cores passed to firmware: u (NR_CPUS = 2048)
> 
> instead of:
> 
>   Max number of cores passed to firmware: 2048 (NR_CPUS = 2048)
> 
> This commit adds support for the missing formatters.
> 
> Fixes: eae5f709a4d7 ("powerpc: Add __printf verification to prom_printf")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8af1da40669609707303eecdb857f4

cheers
