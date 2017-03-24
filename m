Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqHGB4D0hzDqcK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 19:51:30 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2O8ipWx048413
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 04:51:16 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29cpeuruqf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 04:51:15 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Fri, 24 Mar 2017 02:51:15 -0600
Subject: Re: [v1 0/5] parallelized "struct page" zeroing
To: Pavel Tatashin <pasha.tatashin@oracle.com>, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>
References: <1490310113-824438-1-git-send-email-pasha.tatashin@oracle.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 24 Mar 2017 09:51:09 +0100
MIME-Version: 1.0
In-Reply-To: <1490310113-824438-1-git-send-email-pasha.tatashin@oracle.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <341568c3-0473-860f-aa20-63723aa40b87@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/24/2017 12:01 AM, Pavel Tatashin wrote:
> When deferred struct page initialization feature is enabled, we get a
> performance gain of initializing vmemmap in parallel after other CPUs are
> started. However, we still zero the memory for vmemmap using one boot CPU.
> This patch-set fixes the memset-zeroing limitation by deferring it as well.
> 
> Here is example performance gain on SPARC with 32T:
> base
> https://hastebin.com/ozanelatat.go
> 
> fix
> https://hastebin.com/utonawukof.go
> 
> As you can see without the fix it takes: 97.89s to boot
> With the fix it takes: 46.91 to boot.
> 
> On x86 time saving is going to be even greater (proportionally to memory size)
> because there are twice as many "struct page"es for the same amount of memory,
> as base pages are twice smaller.

Fixing the linux-s390 mailing list email.
This might be useful for s390 as well.

> 
> 
> Pavel Tatashin (5):
>   sparc64: simplify vmemmap_populate
>   mm: defining memblock_virt_alloc_try_nid_raw
>   mm: add "zero" argument to vmemmap allocators
>   mm: zero struct pages during initialization
>   mm: teach platforms not to zero struct pages memory
> 
>  arch/powerpc/mm/init_64.c |    4 +-
>  arch/s390/mm/vmem.c       |    5 ++-
>  arch/sparc/mm/init_64.c   |   26 +++++++----------------
>  arch/x86/mm/init_64.c     |    3 +-
>  include/linux/bootmem.h   |    3 ++
>  include/linux/mm.h        |   15 +++++++++++--
>  mm/memblock.c             |   46 ++++++++++++++++++++++++++++++++++++------
>  mm/page_alloc.c           |    3 ++
>  mm/sparse-vmemmap.c       |   48 +++++++++++++++++++++++++++++---------------
>  9 files changed, 103 insertions(+), 50 deletions(-)
> 
