Return-Path: <heiko.carstens@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wM0p35jd3zDqG4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 May 2017 21:36:43 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v48BTwwk030178
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 May 2017 07:36:33 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aadbcty0n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 May 2017 07:36:32 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Mon, 8 May 2017 12:36:29 +0100
Date: Mon, 8 May 2017 13:36:24 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, borntraeger@de.ibm.com, davem@davemloft.net
Subject: Re: [v3 9/9] s390: teach platforms not to zero struct pages memory
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
 <1494003796-748672-10-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494003796-748672-10-git-send-email-pasha.tatashin@oracle.com>
Message-Id: <20170508113624.GA4876@osiris>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 05, 2017 at 01:03:16PM -0400, Pavel Tatashin wrote:
> If we are using deferred struct page initialization feature, most of
> "struct page"es are getting initialized after other CPUs are started, and
> hence we are benefiting from doing this job in parallel. However, we are
> still zeroing all the memory that is allocated for "struct pages" using the
> boot CPU.  This patch solves this problem, by deferring zeroing "struct
> pages" to only when they are initialized on s390 platforms.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  arch/s390/mm/vmem.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index 9c75214..ffe9ba1 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -252,7 +252,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>  				void *new_page;
>  
>  				new_page = vmemmap_alloc_block(PMD_SIZE, node,
> -							       true);
> +							       VMEMMAP_ZERO);
>  				if (!new_page)
>  					goto out;
>  				pmd_val(*pm_dir) = __pa(new_page) | sgt_prot;

If you add the hunk below then this is

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index ffe9ba1aec8b..bf88a8b9c24d 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -272,7 +272,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 		if (pte_none(*pt_dir)) {
 			void *new_page;
 
-			new_page = vmemmap_alloc_block(PAGE_SIZE, node, true);
+			new_page = vmemmap_alloc_block(PAGE_SIZE, node, VMEMMAP_ZERO);
 			if (!new_page)
 				goto out;
 			pte_val(*pt_dir) = __pa(new_page) | pgt_prot;
