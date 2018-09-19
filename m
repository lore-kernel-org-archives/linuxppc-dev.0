Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FQVS00tLzF3JJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 13:35:27 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8J3ZMkT104107
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 23:35:24 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mka9s0jk8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 23:35:24 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 18 Sep 2018 23:35:09 -0400
Subject: Re: [PATCH v4 15/20] powerpc/mm: Avoid useless lock with single page
 fragments
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
 <7efec0c76fa692513c806871151a7ae20e99fe05.1537288312.git.christophe.leroy@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 19 Sep 2018 08:26:26 +0530
MIME-Version: 1.0
In-Reply-To: <7efec0c76fa692513c806871151a7ae20e99fe05.1537288312.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <78cb82d6-1a13-150d-9daa-021bd2f98e7a@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/18/18 10:27 PM, Christophe Leroy wrote:
> There is no point in taking the page table lock as
> pte_frag is always NULL when we have only one fragment.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/mm/pgtable-frag.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> index bc924822dcd6..ab4910e92aaf 100644
> --- a/arch/powerpc/mm/pgtable-frag.c
> +++ b/arch/powerpc/mm/pgtable-frag.c
> @@ -85,6 +85,9 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
>   {
>   	void *pte_frag, *ret;
> 
> +	if (PTE_FRAG_NR == 1)
> +		return NULL;
> +
>   	spin_lock(&mm->page_table_lock);
>   	ret = mm->context.pte_frag;
>   	if (ret) {
> 

May be update get_pmd_from_cache too?

-aneesh
