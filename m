Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf2Wy245YzDqt0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 20:45:34 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rf2Wx60x8z9s9d
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2016 20:45:33 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5SAiM9F127392
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2016 06:45:32 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23spf9jar2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2016 06:45:32 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 04:45:30 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/mm: Use VM_WARN_ONCE() for irqs disabled check
In-Reply-To: <1467095901-4634-1-git-send-email-mpe@ellerman.id.au>
References: <1467095901-4634-1-git-send-email-mpe@ellerman.id.au>
Date: Tue, 28 Jun 2016 16:15:26 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87furx6189.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> The check for !arch_irqs_disabled() in find_linux_pte_or_hugepte() is a
> debugging aid, and needn't be enabled for production builds.
>
> Switch it to a VM_WARN_ONCE(), which is compiled out when
> CONFIG_DEBUG_VM=n.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/pgtable.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index ee09e99097f0..651848039dc4 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -71,10 +71,8 @@ pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
>  static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
>  					       bool *is_thp, unsigned *shift)
>  {
> -	if (!arch_irqs_disabled()) {
> -		pr_info("%s called with irq enabled\n", __func__);
> -		dump_stack();
> -	}
> +	VM_WARN_ONCE(!arch_irqs_disabled(),
> +		     "find_linux_pte_or_hugepte() called with irqs enabled!\n");
>  	return __find_linux_pte_or_hugepte(pgdir, ea, is_thp, shift);
>  }
>


https://lkml.kernel.org/r/574de240.uG8/5OM2Lu9RY6K+%akpm@linux-foundation.orgdd

Isn't this patch already part of -mm. And why ONCE, we want to find
about all the wrong usage.

-aneesh
