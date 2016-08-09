Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7kJp2n9bzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 16:04:58 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id h186so285086pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 23:04:58 -0700 (PDT)
Date: Tue, 9 Aug 2016 16:04:44 +1000
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>, Paul Mackerras
 <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel 05/15] powerpc/iommu: Stop using @current in
 mm_iommu_xxx
Message-ID: <20160809160444.74802e7b@roar.ozlabs.ibm.com>
In-Reply-To: <cb29b1f1-8ba0-56e5-004c-59d38bbcd3ba@gmail.com>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-6-git-send-email-aik@ozlabs.ru>
 <cb29b1f1-8ba0-56e5-004c-59d38bbcd3ba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 9 Aug 2016 14:43:00 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> On 03/08/16 18:40, Alexey Kardashevskiy wrote:

> > -long mm_iommu_get(unsigned long ua, unsigned long entries,
> > +long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
> >  		struct mm_iommu_table_group_mem_t **pmem)
> >  {
> >  	struct mm_iommu_table_group_mem_t *mem;
> >  	long i, j, ret = 0, locked_entries = 0;
> >  	struct page *page = NULL;
> >  
> > -	if (!current || !current->mm)
> > -		return -ESRCH; /* process exited */  
> 
> VM_BUG_ON(mm == NULL)?


> > @@ -128,10 +129,17 @@ static long tce_iommu_register_pages(struct tce_container *container,
> >  			((vaddr + size) < vaddr))
> >  		return -EINVAL;
> >  
> > -	ret = mm_iommu_get(vaddr, entries, &mem);
> > +	if (!container->mm) {
> > +		if (!current->mm)
> > +			return -ESRCH; /* process exited */  
> 
> You may even want to check for PF_EXITING and ignore those tasks?


These are related to some of the questions I had about the patch.

But I think it makes sense just to take this approach as a minimal
bug fix without changing logic too much or adding BUG_ONs, and then
if we we can consider how iommu takes references to mm and uses it
(if anybody finds the time).

Thanks,
Nick
