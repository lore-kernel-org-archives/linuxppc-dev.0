Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v9gMp6SSJzDq6j
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jan 2017 02:59:50 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0SFrd7q100848
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2017 10:59:47 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 288nt3e12y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2017 10:59:47 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 28 Jan 2017 08:59:47 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] powerpc/mm: use the correct pointer when setting a 2M pte
In-Reply-To: <1485359673-4474-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1485359673-4474-1-git-send-email-arbab@linux.vnet.ibm.com>
Date: Sat, 28 Jan 2017 21:29:39 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <871svnch04.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> When setting a 2M pte, radix__map_kernel_page() is using the address
>
> 	ptep = (pte_t *)pudp;
>
> Fix this conversion to use pmdp instead. Use pmdp_ptep() to do this
> instead of casting the pointer.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index cfa53cc..34f1a0d 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -65,7 +65,7 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
>  		if (!pmdp)
>  			return -ENOMEM;
>  		if (map_page_size == PMD_SIZE) {
> -			ptep = (pte_t *)pudp;
> +			ptep = pmdp_ptep(pmdp);
>  			goto set_the_pte;
>  		}
>  		ptep = pte_alloc_kernel(pmdp, ea);
> @@ -90,7 +90,7 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
>  		}
>  		pmdp = pmd_offset(pudp, ea);
>  		if (map_page_size == PMD_SIZE) {
> -			ptep = (pte_t *)pudp;
> +			ptep = pmdp_ptep(pmdp);
>  			goto set_the_pte;
>  		}
>  		if (!pmd_present(*pmdp)) {
> -- 
> 1.8.3.1
