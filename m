Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLyN82kx8zDr4m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 02:48:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: Re: [PATCH 19/25] powerpc: implementation for
 arch_vma_access_permitted()
In-Reply-To: <1504910713-7094-28-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-28-git-send-email-linuxram@us.ibm.com>
Date: Tue, 24 Oct 2017 17:48:00 +0200
Message-ID: <8737684ken.fsf@concordia.ellerman.id.au>
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

> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index 24589d9..21c3b42 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -320,3 +320,46 @@ bool arch_pte_access_permitted(u64 pte, bool write, bool execute)
>  	return pkey_access_permitted(pte_to_pkey_bits(pte),
>  			write, execute);
>  }
> +
> +/*
> + * We only want to enforce protection keys on the current process
> + * because we effectively have no access to AMR/IAMR for other
> + * processes or any way to tell *which * AMR/IAMR in a threaded
> + * process we could use.

This comment doesn't match the code, or at least is confusing to me.

A "threaded process" is two tasks that have the same mm. ie. where
current->mm == vma->mm.

And in that case we *do* enforce protection, based on the AMR/IAMR of
the current thread.

> + * So do not enforce things if the VMA is not from the current
> + * mm, or if we are in a kernel thread.
> + */
> +static inline bool vma_is_foreign(struct vm_area_struct *vma)
> +{
> +	if (!current->mm)
> +		return true;
> +	/*
> +	 * if the VMA is from another process, then AMR/IAMR has no
> +	 * relevance and should not be enforced.
> +	 */
> +	if (current->mm != vma->vm_mm)
> +		return true;

ie. threaded processes end up here, because they *do* share an mm.

> +
> +	return false;
> +}
> +
> +bool arch_vma_access_permitted(struct vm_area_struct *vma,
> +		bool write, bool execute, bool foreign)
> +{
> +	int pkey;
> +
> +	if (!pkey_inited)
> +		return true;
> +
> +	/* allow access if the VMA is not one from this process */
> +	if (foreign || vma_is_foreign(vma))
> +		return true;
> +
> +	pkey = vma_pkey(vma);
> +
> +	if (!pkey)
> +		return true;

I think I'd prefer if we didn't special case key 0, instead just let it
go through to pkey_access_permitted().

> +
> +	return pkey_access_permitted(pkey, write, execute);
> +}

cheers
