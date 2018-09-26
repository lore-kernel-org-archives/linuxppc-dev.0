Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kj1w3sCfzF3JJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 12:44:04 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8Q2dR1u095817
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:44:02 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mr19dgj61-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:44:01 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 26 Sep 2018 03:43:59 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 15/22] powerpc/mm: Avoid useless lock with single page
 fragments
In-Reply-To: <18c62230b394eee9f49832d5dbd518ba69f39a18.1537892499.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
 <18c62230b394eee9f49832d5dbd518ba69f39a18.1537892499.git.christophe.leroy@c-s.fr>
Date: Wed, 26 Sep 2018 08:13:53 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87r2hhgeqe.fsf@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> There is no point in taking the page table lock as pte_frag or
> pmd_frag are always NULL when we have only one fragment.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/mm/pgtable-book3s64.c | 3 +++
>  arch/powerpc/mm/pgtable-frag.c     | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index 723cd324fa34..c43e225e124d 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -239,6 +239,9 @@ static pmd_t *get_pmd_from_cache(struct mm_struct *mm)
>  {
>  	void *pmd_frag, *ret;
>  
> +	if (PMD_FRAG_NR == 1)
> +		return NULL;
> +
>  	spin_lock(&mm->page_table_lock);
>  	ret = mm->context.pmd_frag;
>  	if (ret) {
> diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> index d61e7c2a9a79..7544d0d7177d 100644
> --- a/arch/powerpc/mm/pgtable-frag.c
> +++ b/arch/powerpc/mm/pgtable-frag.c
> @@ -34,6 +34,9 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
>  {
>  	void *pte_frag, *ret;
>  
> +	if (PTE_FRAG_NR == 1)
> +		return NULL;
> +
>  	spin_lock(&mm->page_table_lock);
>  	ret = mm->context.pte_frag;
>  	if (ret) {
> -- 
> 2.13.3
