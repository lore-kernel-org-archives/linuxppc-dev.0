Return-Path: <nfont@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 70414B7121
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Sep 2010 04:07:02 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8SI09C1021952
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 14:00:09 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8SI6U4M2011282
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 14:06:31 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8SI6TW1023169
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 14:06:30 -0400
Message-ID: <4CA22EA2.8060307@austin.ibm.com>
Date: Tue, 28 Sep 2010 13:06:26 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/8] v2 Allow memory block to span multiple memory sections
References: <4CA0EBEB.1030204@austin.ibm.com>	
	<4CA0EFAA.8050000@austin.ibm.com>
	<1285631707.19976.3385.camel@nimitz>
In-Reply-To: <1285631707.19976.3385.camel@nimitz>
Content-Type: text/plain; charset=us-ascii
Cc: linux-mm@kvack.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/27/2010 06:55 PM, Dave Hansen wrote:
> On Mon, 2010-09-27 at 14:25 -0500, Nathan Fontenot wrote:
>> +static inline int base_memory_block_id(int section_nr)
>> +{
>> +       return section_nr / sections_per_block;
>> +}
> ...
>> -       mutex_lock(&mem_sysfs_mutex);
>> -
>> -       mem->phys_index = __section_nr(section);
>> +       scn_nr = __section_nr(section);
>> +       mem->phys_index = base_memory_block_id(scn_nr) * sections_per_block; 
> 
> I'm really regretting giving this variable such a horrid name.  I suck.
> 
> I think this is correct now:
> 
> 	mem->phys_index = base_memory_block_id(scn_nr) * sections_per_block;
> 	mem->phys_index = section_nr / sections_per_block * sections_per_block;
> 	mem->phys_index = section_nr
> 
> Since it gets exported to userspace this way:
> 
>> +static ssize_t show_mem_start_phys_index(struct sys_device *dev,
>>                         struct sysdev_attribute *attr, char *buf)
>>  {
>>         struct memory_block *mem =
>>                 container_of(dev, struct memory_block, sysdev);
>> -       return sprintf(buf, "%08lx\n", mem->phys_index / sections_per_block);
>> +       unsigned long phys_index;
>> +
>> +       phys_index = mem->start_phys_index / sections_per_block;
>> +       return sprintf(buf, "%08lx\n", phys_index);
>> +}
> 
> The only other thing I'd say is that we need to put phys_index out of
> its misery and call it what it is now: a section number.  I think it's
> OK to call them "start/end_section_nr", at least inside the kernel.  I
> intentionally used "phys_index" terminology in sysfs so that we _could_
> eventually do this stuff and break the relationship between sections and
> the sysfs dirs, but I think keeping the terminology around inside the
> kernel is confusing now.

Yes, it took me a couple o looks to get the phys_index <-> section number
correlation.  I think changing the kernel names to start/end_section_number
is a good idea.

-Nathan

> 
> -- Dave
> 
