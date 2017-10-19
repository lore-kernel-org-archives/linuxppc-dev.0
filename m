Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHbMD0hXJzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 15:20:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: Re: [PATCH 01/25] powerpc: initial pkey plumbing
In-Reply-To: <1504910713-7094-10-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-10-git-send-email-linuxram@us.ibm.com>
Date: Thu, 19 Oct 2017 15:20:36 +1100
Message-ID: <87lgk7kbu3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 9fc3c0b..a4cd210 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -864,6 +864,22 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config PPC64_MEMORY_PROTECTION_KEYS

That's pretty wordy, can we make it CONFIG_PPC_MEM_KEYS ?

I think you're a sufficient vim wizard to search and replace all
usages at once, if not I can do it before I apply the series.

> +	prompt "PowerPC Memory Protection Keys"
> +	def_bool y
> +	# Note: only available in 64-bit mode

We don't need the note, that's exactly what the next line says:
> +	depends on PPC64

But shouldn't it be BOOK3S_64 ?

I don't think it works on BookE does it?

> +	select ARCH_USES_HIGH_VMA_FLAGS
> +	select ARCH_HAS_PKEYS
> +	---help---

I prefer just "help".

> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 3095925..7badf29 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -141,5 +141,10 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
>  	/* by default, allow everything */
>  	return true;
>  }
> +
> +#ifndef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +#define pkey_initialize()
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */

You don't need ifdefs around that. But you also don't need it (see below).

> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> new file mode 100644
> index 0000000..c02305a
> --- /dev/null
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -0,0 +1,45 @@
> +#ifndef _ASM_PPC64_PKEYS_H
> +#define _ASM_PPC64_PKEYS_H

_ASM_POWERPC_KEYS_H

Missing copyright header here.

> +
> +extern bool pkey_inited;
> +extern bool pkey_execute_disable_support;
> +#define ARCH_VM_PKEY_FLAGS 0
> +
> +static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
> +{
> +	return (pkey == 0);

That means pkey 1 is not allocated and pkey 0 is?

Surely this should just return false for now?

> +}
> +
> +static inline int mm_pkey_alloc(struct mm_struct *mm)
> +{
> +	return -1;
> +}
> +
> +static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
> +{
> +	return -EINVAL;
> +}
> +
> +/*
> + * Try to dedicate one of the protection keys to be used as an
> + * execute-only protection key.
> + */
> +static inline int execute_only_pkey(struct mm_struct *mm)
> +{
> +	return 0;
> +}
> +
> +static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
> +		int prot, int pkey)

static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
					      int prot, int pkey)

> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index b89c6aa..3b67014 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -316,6 +317,9 @@ void __init early_setup(unsigned long dt_ptr)
>  	/* Initialize the hash table or TLB handling */
>  	early_init_mmu();
>  
> +	/* initialize the key subsystem */
> +	pkey_initialize();
> +

I'm not sure we need to initialise this that early, but if we do, it
should be done in early_init_mmu(), not here.

> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 0dff57b..67f62b5 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -35,6 +35,7 @@
>  #include <linux/memblock.h>
>  #include <linux/context_tracking.h>
>  #include <linux/libfdt.h>
> +#include <linux/pkeys.h>

This should go in a later patch when it's needed.

> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> new file mode 100644
> index 0000000..418a05b
> --- /dev/null
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -0,0 +1,33 @@
> +/*
> + * PowerPC Memory Protection Keys management
> + * Copyright (c) 2015, Intel Corporation.

Is any of it really copyright Intel?

> + * Copyright (c) 2017, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.

We're meant to use "or later" on new code.

> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.

But not this part.

> + */

Blank line.

> +#include <linux/pkeys.h>                /* PKEY_*                       */

Comment is wrong and unnecessary.

> +bool pkey_inited;
> +bool pkey_execute_disable_support;
> +
> +void __init pkey_initialize(void)
> +{
> +	/* disable the pkey system till everything
> +	 * is in place. A patch further down the
> +	 * line will enable it.
> +	 */

	/*
         * Disable the pkey system till everything is in place. A patch
         * further down the line will enable it.
	 */

I'm going to stop commenting on every badly formatted comment :)


> +	pkey_inited = false;
> +
> +	/*
> +	 * disable execute_disable support for now.
> +	 * A patch further down will enable it.
> +	 */
> +	pkey_execute_disable_support = false;

Those are both false anyway, so I'm not sure we really needed to
initialise them to false again, but I don't feel that strongly about it.

cheers
