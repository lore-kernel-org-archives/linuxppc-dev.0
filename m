Return-Path: <dave.hansen@intel.com>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40d6q75VN8zDr4K
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 08:57:36 +1000 (AEST)
Subject: Re: [PATCH v13 3/3] mm, powerpc, x86: introduce an additional vma bit
 for powerpc pkey
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au, mingo@redhat.com,
 akpm@linux-foundation.org
References: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
 <1525471183-21277-3-git-send-email-linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 corbet@lwn.net, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <1e37895e-5a18-11c1-58f1-834f96dfd4d5@intel.com>
Date: Fri, 4 May 2018 15:57:33 -0700
MIME-Version: 1.0
In-Reply-To: <1525471183-21277-3-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 0c9e392..3ddddc7 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -679,6 +679,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_PKEY_BIT1)]	= "",
>  		[ilog2(VM_PKEY_BIT2)]	= "",
>  		[ilog2(VM_PKEY_BIT3)]	= "",
> +		[ilog2(VM_PKEY_BIT4)]	= "",
>  #endif /* CONFIG_ARCH_HAS_PKEYS */
...
> +#if defined(CONFIG_PPC)
> +# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
> +#else 
> +# define VM_PKEY_BIT4	0
> +#endif
>  #endif /* CONFIG_ARCH_HAS_PKEYS */

That new line boils down to:

		[ilog2(0)]	= "",

on x86.  It wasn't *obvious* to me that it is OK to do that.  The other
possibly undefined bits (VM_SOFTDIRTY for instance) #ifdef themselves
out of this array.

I would just be a wee bit worried that this would overwrite the 0 entry
("??") with "".
