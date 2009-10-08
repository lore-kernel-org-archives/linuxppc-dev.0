Return-Path: <rcjenn@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 86474B7B7A
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 00:14:01 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n98DCjkj025498
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2009 09:12:45 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n98DDvG4246860
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2009 09:13:57 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n98DDuwH001317
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2009 09:13:57 -0400
Date: Thu, 8 Oct 2009 08:13:56 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: gerald.schaefer@de.ibm.com
Subject: Re: [PATCH 2/2][v2] powerpc: Make the CMM memory hotplug aware
Message-ID: <20091008131355.GA22118@austin.ibm.com>
References: <20091002184458.GC4908@austin.ibm.com>
	<20091002185248.GD4908@austin.ibm.com>
	<4ACDD71D.30809@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4ACDD71D.30809@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Gerald Schaefer (geralds@linux.vnet.ibm.com) wrote:
> Hi,
>
> I am currently working on the s390 port for the cmm + hotplug
> patch, and I'm a little confused about the memory allocation
> policy, see below. Is it correct that the balloon cannot grow
> into ZONE_MOVABLE, while the pages for the balloon page list
> can?
>
> Robert Jennings wrote:
>> @@ -110,6 +125,9 @@ static long cmm_alloc_pages(long nr)
>>  	cmm_dbg("Begin request for %ld pages\n", nr);
>>
>>  	while (nr) {
>> +		if (atomic_read(&hotplug_active))
>> +			break;
>> +
>>  		addr = __get_free_page(GFP_NOIO | __GFP_NOWARN |
>>  				       __GFP_NORETRY | __GFP_NOMEMALLOC);
>>  		if (!addr)
>> @@ -119,8 +137,10 @@ static long cmm_alloc_pages(long nr)
>>  		if (!pa || pa->index >= CMM_NR_PAGES) {
>>  			/* Need a new page for the page list. */
>>  			spin_unlock(&cmm_lock);
>> -			npa = (struct cmm_page_array *)__get_free_page(GFP_NOIO | __GFP_NOWARN |
>> -								       __GFP_NORETRY | __GFP_NOMEMALLOC);
>> +			npa = (struct cmm_page_array *)__get_free_page(
>> +					GFP_NOIO | __GFP_NOWARN |
>> +					__GFP_NORETRY | __GFP_NOMEMALLOC |
>> +					__GFP_MOVABLE);
>>  			if (!npa) {
>>  				pr_info("%s: Can not allocate new page list\n", __func__);
>>  				free_page(addr);
>
> Why is the __GFP_MOVABLE added here, for the page list alloc, and not
> above for the balloon page alloc?

The pages allocated as __GFP_MOVABLE are used to store the list of pages
allocated by the balloon.  They reference virtual addresses and it would
be fine for the kernel to migrate the physical pages for those, the
balloon would not notice this.

The pages loaned by the balloon are not allocated with __GFP_MOVABLE
because we will inform the hypervisor which page has been loaned by
Linux according to the physical address.  Migration of those physical
pages would invalidate the loan, so we do not mark them as movable.

Regards,
Robert Jennings
