Return-Path: <david@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DHs84vTdzF1QT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 17:32:44 +1000 (AEST)
Subject: Re: [PATCH RFCv2 3/6] mm/memory_hotplug: fix online/offline_pages
 called w.o. mem_hotplug_lock
To: Rashmica <rashmica.g@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, devel@linuxdriverproject.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross
 <jgross@suse.com>, Michael Neuling <mikey@neuling.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Pavel Tatashin <pasha.tatashin@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
 Oscar Salvador <osalvador@suse.de>,
 YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
 Mathieu Malaterre <malat@debian.org>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-4-david@redhat.com>
 <70372ef5-e332-6c07-f08c-50f8808bde6d@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5f80ca56-9f34-4e6e-bc83-8f8b3c888163@redhat.com>
Date: Mon, 17 Sep 2018 09:32:27 +0200
MIME-Version: 1.0
In-Reply-To: <70372ef5-e332-6c07-f08c-50f8808bde6d@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 03.09.18 um 02:36 schrieb Rashmica:
> Hi David,
> 
> 
> On 21/08/18 20:44, David Hildenbrand wrote:
> 
>> There seem to be some problems as result of 30467e0b3be ("mm, hotplug:
>> fix concurrent memory hot-add deadlock"), which tried to fix a possible
>> lock inversion reported and discussed in [1] due to the two locks
>> 	a) device_lock()
>> 	b) mem_hotplug_lock
>>
>> While add_memory() first takes b), followed by a) during
>> bus_probe_device(), onlining of memory from user space first took b),
>> followed by a), exposing a possible deadlock.
> 
> Do you mean "onlining of memory from user space first took a),
> followed by b)"? 

Very right, thanks.

> 
>> In [1], and it was decided to not make use of device_hotplug_lock, but
>> rather to enforce a locking order.
>>
>> The problems I spotted related to this:
>>
>> 1. Memory block device attributes: While .state first calls
>>    mem_hotplug_begin() and the calls device_online() - which takes
>>    device_lock() - .online does no longer call mem_hotplug_begin(), so
>>    effectively calls online_pages() without mem_hotplug_lock.
>>
>> 2. device_online() should be called under device_hotplug_lock, however
>>    onlining memory during add_memory() does not take care of that.
>>
>> In addition, I think there is also something wrong about the locking in
>>
>> 3. arch/powerpc/platforms/powernv/memtrace.c calls offline_pages()
>>    without locks. This was introduced after 30467e0b3be. And skimming over
>>    the code, I assume it could need some more care in regards to locking
>>    (e.g. device_online() called without device_hotplug_lock - but I'll
>>    not touch that for now).
> 
> Can you mention that you fixed this in later patches?

Sure!

> 
> 
> The series looks good to me. Feel free to add my reviewed-by:
> 
> Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
> 

Thanks, r-b only for this patch or all of the series?

-- 

Thanks,

David / dhildenb
