Return-Path: <heiko.carstens@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRc1T4GjGzDqLK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 09:17:33 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4FNDwAv113197
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 19:17:23 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2afn8ph8ff-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 19:17:23 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Tue, 16 May 2017 00:17:20 +0100
Date: Tue, 16 May 2017 01:17:16 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, borntraeger@de.ibm.com, davem@davemloft.net
Subject: Re: [v3 9/9] s390: teach platforms not to zero struct pages memory
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
 <1494003796-748672-10-git-send-email-pasha.tatashin@oracle.com>
 <20170508113624.GA4876@osiris>
 <0669a945-4540-096e-799a-2d2b3c18abaa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0669a945-4540-096e-799a-2d2b3c18abaa@oracle.com>
Message-Id: <20170515231716.GA3314@osiris>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Pasha,

> Thank you for looking at this patch. I am worried to make the proposed
> change, because, as I understand in this case we allocate memory not for
> "struct page"s but for table that hold them. So, we will change the behavior
> from the current one, where this table is allocated zeroed, but now it won't
> be zeroed.

The page table, if needed, is allocated and populated a couple of lines
above. See the vmem_pte_alloc() call. So my request to include the hunk
below is still valid ;)

> >If you add the hunk below then this is
> >
> >Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> >
> >diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> >index ffe9ba1aec8b..bf88a8b9c24d 100644
> >--- a/arch/s390/mm/vmem.c
> >+++ b/arch/s390/mm/vmem.c
> >@@ -272,7 +272,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
> >  		if (pte_none(*pt_dir)) {
> >  			void *new_page;
> >-			new_page = vmemmap_alloc_block(PAGE_SIZE, node, true);
> >+			new_page = vmemmap_alloc_block(PAGE_SIZE, node, VMEMMAP_ZERO);
> >  			if (!new_page)
> >  				goto out;
> >  			pte_val(*pt_dir) = __pa(new_page) | pgt_prot;
> >
> 
