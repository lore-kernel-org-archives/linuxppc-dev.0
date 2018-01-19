Return-Path: <ebiederm@xmission.com>
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNQm20HxTzF0yf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jan 2018 03:10:40 +1100 (AEDT)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org,
 paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
 <1516326648-22775-28-git-send-email-linuxram@us.ibm.com>
Date: Fri, 19 Jan 2018 10:09:41 -0600
In-Reply-To: <1516326648-22775-28-git-send-email-linuxram@us.ibm.com> (Ram
 Pai's message of "Thu, 18 Jan 2018 17:50:48 -0800")
Message-ID: <87shb1de4a.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v10 27/27] mm: display pkey in smaps if
 arch_pkeys_enabled() is true
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> Currently the  architecture  specific code is expected to
> display  the  protection  keys  in  smap  for a given vma.
> This can lead to redundant code and possibly to divergent
> formats in which the key gets displayed.
>
> This  patch  changes  the implementation. It displays the
> pkey only if the architecture support pkeys.
>
> x86 arch_show_smap() function is not needed anymore.
> Delete it.
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/x86/kernel/setup.c |    8 --------
>  fs/proc/task_mmu.c      |   11 ++++++-----
>  2 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 8af2e8d..ddf945a 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1326,11 +1326,3 @@ static int __init register_kernel_offset_dumper(void)
>  	return 0;
>  }
>  __initcall(register_kernel_offset_dumper);
> -
> -void arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
> -{
> -	if (!boot_cpu_has(X86_FEATURE_OSPKE))
> -		return;
> -
> -	seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> -}
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 0edd4da..4b39a94 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -18,6 +18,7 @@
>  #include <linux/page_idle.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/uaccess.h>
> +#include <linux/pkeys.h>
>  
>  #include <asm/elf.h>
>  #include <asm/tlb.h>
> @@ -728,10 +729,6 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
>  }
>  #endif /* HUGETLB_PAGE */
>  
> -void __weak arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
> -{
> -}
> -
>  static int show_smap(struct seq_file *m, void *v, int is_pid)
>  {
>  	struct proc_maps_private *priv = m->private;
> @@ -851,9 +848,13 @@ static int show_smap(struct seq_file *m, void *v, int is_pid)
>  			   (unsigned long)(mss->pss >> (10 + PSS_SHIFT)));
>  
>  	if (!rollup_mode) {
> -		arch_show_smap(m, vma);
> +#ifdef CONFIG_ARCH_HAS_PKEYS
> +		if (arch_pkeys_enabled())
> +			seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> +#endif

Would it be worth it making vma_pkey a noop on architectures that don't
support protection keys so that we don't need the #ifdef here?

Eric


>  		show_smap_vma_flags(m, vma);
>  	}
> +
>  	m_cache_vma(m, vma);
>  	return ret;
>  }
