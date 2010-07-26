Return-Path: <nfont@austin.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97AF4B70AB
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 05:10:38 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6QIrvar013546
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 14:53:57 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6QJAYhA411250
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 15:10:34 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6QJAX68001455
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 16:10:34 -0300
Message-ID: <4C4DDDA7.2000302@austin.ibm.com>
Date: Mon, 26 Jul 2010 14:10:31 -0500
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

I'm not sure I like that for a couple of reasons.  I think there may still be a
path through the find_memory_block() code that this race condition can occur.
We could take a time sslice after the kobject_get and before getting the
memory_block pointer.

The second reason is that the node sysfs code calls find_memory_block() and it
may be a bit kludgy to have callers of find_memory_block have to reduce the
section_count after using it.

With the way the memory_block structs are kept, retrieved via a kobject_get()
call instead maintained on a local list, there may not be a solution that is
foolproof without changing this.

-Nathan 
> -- Dave
> 
