Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F0F0EDE43A
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 02:35:06 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6EGYwkX027751
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 12:34:58 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6EGYwtA164066
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 12:34:58 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6EGYwsS011089
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 12:34:58 -0400
Subject: Re: [PATCH] powerpc: mman.h export fixups
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080714192557.331a50f5.sfr@canb.auug.org.au>
References: <20080714170301.93f940fd.sfr@canb.auug.org.au>
	<20080714192557.331a50f5.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 14 Jul 2008 11:34:56 -0500
Message-Id: <1216053296.30251.4.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linux-next@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-14 at 19:25 +1000, Stephen Rothwell wrote:
> Commit ef3d3246a0d06be622867d21af25f997aeeb105f ("powerpc/mm: Add Strong
> Access Ordering support") in the powerpc/{next,master} tree caused the
> following in a powerpc allmodconfig build:
> 
> usr/include/asm/mman.h requires linux/mm.h, which does not exist in exported headers
> 
> We should not use CONFIG_PPC64 in an unprotected (by __KERNEL__)
> section of an exported include file and linux/mm.h is not exported.  So
> protect the whole section that is CONFIG_PPC64 with __KERNEL__ and put
> the two introduced includes in there as well.

Agreed.  None of the code in the CONFIG_PPC64 ifdef needs to be seen by
user space.

> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> ---
>  include/asm-powerpc/Kbuild |    2 +-
>  include/asm-powerpc/mman.h |    8 ++++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> I have included this patch in today's linux-next tree.
> 
> diff --git a/include/asm-powerpc/Kbuild b/include/asm-powerpc/Kbuild
> index 34a0a8d..329ecfd 100644
> --- a/include/asm-powerpc/Kbuild
> +++ b/include/asm-powerpc/Kbuild
> @@ -2,7 +2,6 @@ include include/asm-generic/Kbuild.asm
> 
>  header-y += auxvec.h
>  header-y += ioctls.h
> -header-y += mman.h
>  header-y += sembuf.h
>  header-y += siginfo.h
>  header-y += stat.h
> @@ -28,6 +27,7 @@ unifdef-y += byteorder.h
>  unifdef-y += cputable.h
>  unifdef-y += elf.h
>  unifdef-y += nvram.h
> +unifdef-y += mman.h
>  unifdef-y += param.h
>  unifdef-y += posix_types.h
>  unifdef-y += ptrace.h
> diff --git a/include/asm-powerpc/mman.h b/include/asm-powerpc/mman.h
> index f8a32e2..9209f75 100644
> --- a/include/asm-powerpc/mman.h
> +++ b/include/asm-powerpc/mman.h
> @@ -1,9 +1,7 @@
>  #ifndef _ASM_POWERPC_MMAN_H
>  #define _ASM_POWERPC_MMAN_H
> 
> -#include <asm/cputable.h>
>  #include <asm-generic/mman.h>
> -#include <linux/mm.h>
> 
>  /*
>   * This program is free software; you can redistribute it and/or
> @@ -28,7 +26,12 @@
>  #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
>  #define MAP_NONBLOCK	0x10000		/* do not block on IO */
> 
> +#ifdef __KERNEL__
>  #ifdef CONFIG_PPC64
> +
> +#include <asm/cputable.h>
> +#include <linux/mm.h>
> +
>  /*
>   * This file is included by linux/mman.h, so we can't use cacl_vm_prot_bits()
>   * here.  How important is the optimization?
> @@ -56,4 +59,5 @@ static inline int arch_validate_prot(unsigned long prot)
>  #define arch_validate_prot(prot) arch_validate_prot(prot)
> 
>  #endif /* CONFIG_PPC64 */
> +#endif /* __KERNEL__ */
>  #endif	/* _ASM_POWERPC_MMAN_H */
-- 
David Kleikamp
IBM Linux Technology Center
