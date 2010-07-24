Return-Path: <nfont@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09AAEB6EEB
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jul 2010 13:10:04 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6O2wgnF028229
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 20:58:42 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6O39xBG131534
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 21:10:00 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6O39x8f015102
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 21:09:59 -0600
Message-ID: <4C4A5985.6000206@austin.ibm.com>
Date: Fri, 23 Jul 2010 22:09:57 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/8] v3 Allow memory_block to span multiple memory sections
References: <4C451BF5.50304@austin.ibm.com>	 <4C451E1C.8070907@austin.ibm.com>
	<1279653481.9785.4.camel@nimitz>
In-Reply-To: <1279653481.9785.4.camel@nimitz>
Content-Type: text/plain; charset=us-ascii
Cc: linux-mm@kvack.org, greg@kroah.com, linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/20/2010 02:18 PM, Dave Hansen wrote:
> On Mon, 2010-07-19 at 22:55 -0500, Nathan Fontenot wrote:
>> +static int add_memory_section(int nid, struct mem_section *section,
>> +                       unsigned long state, enum mem_add_context context)
>> +{
>> +       struct memory_block *mem;
>> +       int ret = 0;
>> +
>> +       mem = find_memory_block(section);
>> +       if (mem) {
>> +               atomic_inc(&mem->section_count);
>> +               kobject_put(&mem->sysdev.kobj);
>> +       } else
>> +               ret = init_memory_block(&mem, section, state);
>> +
>>         if (!ret) {
>> -               if (context == HOTPLUG)
>> +               if (context == HOTPLUG &&
>> +                   atomic_read(&mem->section_count) == sections_per_block)
>>                         ret = register_mem_sect_under_node(mem, nid);
>>         } 
> 
> I think the atomic_inc() can race with the atomic_dec_and_test() in
> remove_memory_block().
> 
> Thread 1 does:
> 
> 	mem = find_memory_block(section);
> 
> Thread 2 does 
> 
> 	atomic_dec_and_test(&mem->section_count);
> 
> and destroys the memory block,  Thread 1 runs again:
> 	
>        if (mem) {
>                atomic_inc(&mem->section_count);
>                kobject_put(&mem->sysdev.kobj);
>        } else
> 
> but now mem got destroyed by Thread 2.  You probably need to change
> find_memory_block() to itself take a reference, and to use
> atomic_inc_unless().
> 

You're right but I think the fix you suggested will narrow the window for the
race condition, not eliminate it.  We could still take a time splice in
find_memory_block prior to the container_of() calls to get the memory
block pointer and end up de-referencing a invalid kobject o sysdev pointer.

I think if we want to eliminate this we may need to have lock that protects
access to any of the memory_block structures.  This would need to be taken
any time find_memory_block is called and released when use of the memory_block
returned is finished.  If we're going to fix this we should eliminate the
window completely instead of just closing it further.

If we add a lock should I submit it as part of this patchset? or submit it
as a follow-on?

-Nathan 
