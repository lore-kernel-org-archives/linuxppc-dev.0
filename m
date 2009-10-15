Return-Path: <geralds@linux.vnet.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.17.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F3079B7B8C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 05:21:35 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.1/8.13.1) with ESMTP id n9FILQdK013522
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 18:21:26 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n9FILPeb2072612
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 20:21:25 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n9FILMIU014677
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 20:21:25 +0200
Message-ID: <4AD7681C.7060800@linux.vnet.ibm.com>
Date: Thu, 15 Oct 2009 20:21:16 +0200
From: Gerald Schaefer <geralds@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@ozlabs.org,
	Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2][v2] powerpc: Make the CMM memory hotplug aware
References: <20091002184458.GC4908@austin.ibm.com>
	<20091002185248.GD4908@austin.ibm.com>
	<4ACDD71D.30809@linux.vnet.ibm.com>
	<20091008131355.GA22118@austin.ibm.com>
In-Reply-To: <20091008131355.GA22118@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nick Piggin <npiggin@suse.de>, Christoph Lameter <cl@linux-foundation.org>,
	Mel Gorman <mel@csn.ul.ie>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Brian King <brking@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	gerald.schaefer@de.ibm.com
Reply-To: gerald.schaefer@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Robert Jennings wrote:
>>> @@ -110,6 +125,9 @@ static long cmm_alloc_pages(long nr)
>>>  	cmm_dbg("Begin request for %ld pages\n", nr);
>>>
>>>  	while (nr) {
>>> +		if (atomic_read(&hotplug_active))
>>> +			break;
>>> +
>>>  		addr = __get_free_page(GFP_NOIO | __GFP_NOWARN |
>>>  				       __GFP_NORETRY | __GFP_NOMEMALLOC);
>>>  		if (!addr)
>>> @@ -119,8 +137,10 @@ static long cmm_alloc_pages(long nr)
>>>  		if (!pa || pa->index >= CMM_NR_PAGES) {
>>>  			/* Need a new page for the page list. */
>>>  			spin_unlock(&cmm_lock);
>>> -			npa = (struct cmm_page_array *)__get_free_page(GFP_NOIO | __GFP_NOWARN |
>>> -								       __GFP_NORETRY | __GFP_NOMEMALLOC);
>>> +			npa = (struct cmm_page_array *)__get_free_page(
>>> +					GFP_NOIO | __GFP_NOWARN |
>>> +					__GFP_NORETRY | __GFP_NOMEMALLOC |
>>> +					__GFP_MOVABLE);
>>>  			if (!npa) {
>>>  				pr_info("%s: Can not allocate new page list\n", __func__);
>>>  				free_page(addr);
>> Why is the __GFP_MOVABLE added here, for the page list alloc, and not
>> above for the balloon page alloc?
> 
> The pages allocated as __GFP_MOVABLE are used to store the list of pages
> allocated by the balloon.  They reference virtual addresses and it would
> be fine for the kernel to migrate the physical pages for those, the
> balloon would not notice this.

Does page migration really work for kernel pages that were allocated
with __get_free_page()? I was wondering if we can do this on s390, where
we have a 1:1 mapping of kernel virtual to physical addresses, but
looking at migrate_pages() and friends, it seems that kernel pages
w/o mapping and rmap should not be migrateable at all. Any thoughts from
the memory migration experts?

BTW, since we have real memory hotplug support on s390, allowing us
to add and remove memory chunks to/from ZONE_MOVABLE, this basically
makes cmm ballooning in ZONE_NORMAL obsolete, so we decided not to
support memory hotplug aware cmm on s390.

Regards,
Gerald
