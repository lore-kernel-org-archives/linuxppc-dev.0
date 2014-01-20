Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0154.outbound.protection.outlook.com [207.46.163.154])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D3A832C009B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 09:17:54 +1100 (EST)
Message-ID: <1390256262.24905.315.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc: hugetlb: replace __get_cpu_var with get_cpu_var
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Mon, 20 Jan 2014 16:17:42 -0600
In-Reply-To: <1390207175-2181-1-git-send-email-tiejun.chen@windriver.com>
References: <1390207175-2181-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-01-20 at 16:39 +0800, Tiejun Chen wrote:
>  	if (atomic_read(&tlb->mm->mm_users) < 2 ||
>  	    cpumask_equal(mm_cpumask(tlb->mm),
>  			  cpumask_of(smp_processor_id()))) {
>  		kmem_cache_free(hugepte_cache, hugepte);
> +        put_cpu_var(hugepd_freelist_cur);
>  		return;
>  	}
>  

Whitespace

> @@ -491,6 +492,7 @@ static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
>  		call_rcu_sched(&(*batchp)->rcu, hugepd_free_rcu_callback);
>  		*batchp = NULL;
>  	}
> +	put_cpu_var(hugepd_freelist_cur);
>  }

A blank line before "put_cpu_var" would be nice.

-Scott
