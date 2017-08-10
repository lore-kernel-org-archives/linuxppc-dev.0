Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xT0YW4HfhzDr0G
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 06:46:55 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7AKihSE047358
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 16:46:53 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c8tbt53x7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 16:46:52 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 10 Aug 2017 14:46:52 -0600
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-10-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: Re: [RFC v7 09/25] powerpc: store and restore the pkey state across
 context switches
In-reply-to: <1501459946-11619-10-git-send-email-linuxram@us.ibm.com>
Date: Thu, 10 Aug 2017 17:46:43 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874ltfkv64.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ram Pai <linuxram@us.ibm.com> writes:
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -42,6 +42,7 @@
>  #include <linux/hw_breakpoint.h>
>  #include <linux/uaccess.h>
>  #include <linux/elf-randomize.h>
> +#include <linux/pkeys.h>
>
>  #include <asm/pgtable.h>
>  #include <asm/io.h>
> @@ -1096,6 +1097,13 @@ static inline void save_sprs(struct thread_struct *t)
>  		t->tar = mfspr(SPRN_TAR);
>  	}
>  #endif
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	if (arch_pkeys_enabled()) {
> +		t->amr = mfspr(SPRN_AMR);
> +		t->iamr = mfspr(SPRN_IAMR);
> +		t->uamor = mfspr(SPRN_UAMOR);
> +	}
> +#endif
>  }

Is it worth having a flag in thread_struct saying whether it has every
called pkey_alloc and only do the mfsprs if it did?

> @@ -1131,6 +1139,16 @@ static inline void restore_sprs(struct thread_struct *old_thread,
>  			mtspr(SPRN_TAR, new_thread->tar);
>  	}
>  #endif
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	if (arch_pkeys_enabled()) {
> +		if (old_thread->amr != new_thread->amr)
> +			mtspr(SPRN_AMR, new_thread->amr);
> +		if (old_thread->iamr != new_thread->iamr)
> +			mtspr(SPRN_IAMR, new_thread->iamr);
> +		if (old_thread->uamor != new_thread->uamor)
> +			mtspr(SPRN_UAMOR, new_thread->uamor);
> +	}
> +#endif
>  }
>
>  struct task_struct *__switch_to(struct task_struct *prev,
> @@ -1689,6 +1707,13 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
>  	current->thread.tm_tfiar = 0;
>  	current->thread.load_tm = 0;
>  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	if (arch_pkeys_enabled()) {
> +		current->thread.amr   = 0x0ul;
> +		current->thread.iamr  = 0x0ul;
> +		current->thread.uamor = 0x0ul;
> +	}
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>  }
>  EXPORT_SYMBOL(start_thread);

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
