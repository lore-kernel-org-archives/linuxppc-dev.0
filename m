Return-Path: <srs0=j5dm=h3=us.ibm.com=linuxram@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gPmy67LwzF14v
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 02:18:42 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40gPmy5RjFz8t79
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 02:18:42 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40gPmy1c9bz9s1w
 for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2018 02:18:42 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w48GH7mf044323
 for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2018 12:18:40 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hucw0r5x6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 08 May 2018 12:18:39 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 8 May 2018 17:18:37 +0100
Date: Tue, 8 May 2018 09:18:28 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: Re: [PATCH 2/8] mm, powerpc, x86: introduce an additional vma bit
 for powerpc pkey
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180508145948.9492-1-mpe@ellerman.id.au>
 <20180508145948.9492-3-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180508145948.9492-3-mpe@ellerman.id.au>
Message-Id: <20180508161828.GA5474@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 09, 2018 at 12:59:42AM +1000, Michael Ellerman wrote:
> From: Ram Pai <linuxram@us.ibm.com>
> 
> Currently only 4bits are allocated in the vma flags to hold 16
> keys. This is sufficient for x86. PowerPC  supports  32  keys,
> which needs 5bits. This patch allocates an  additional bit.
> 
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> [mpe: Fold in #if VM_PKEY_BIT4 as noticed by Dave Hansen]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  fs/proc/task_mmu.c | 3 +++
>  include/linux/mm.h | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 541392a62608..c2163606e6fb 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -679,6 +679,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_PKEY_BIT1)]	= "",
>  		[ilog2(VM_PKEY_BIT2)]	= "",
>  		[ilog2(VM_PKEY_BIT3)]	= "",
> +#if VM_PKEY_BIT4
> +		[ilog2(VM_PKEY_BIT4)]	= "",
> +#endif
>  #endif /* CONFIG_ARCH_HAS_PKEYS */
>  	};
>  	size_t i;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c6a6f2492c1b..abfd758ff83a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -231,9 +231,10 @@ extern unsigned int kobjsize(const void *objp);
>  #ifdef CONFIG_ARCH_HAS_PKEYS
>  # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
>  # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
> -# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
> +# define VM_PKEY_BIT1	VM_HIGH_ARCH_1	/* on x86 and 5-bit value on ppc64   */
>  # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
>  # define VM_PKEY_BIT3	VM_HIGH_ARCH_3
> +# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
>  #endif /* CONFIG_ARCH_HAS_PKEYS */

this has to be: 

+#if defined(CONFIG_PPC)
+# define VM_PKEY_BIT4  VM_HIGH_ARCH_4
+#else
+# define VM_PKEY_BIT4  0
+#endif
