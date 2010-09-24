Return-Path: <nfont@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 553BBB70F8
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Sep 2010 00:36:06 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8OEaBj7022100
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 10:36:11 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8OEZbC5774206
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 10:35:38 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8OEZald031514
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 10:35:37 -0400
Message-ID: <4C9CB737.9000903@austin.ibm.com>
Date: Fri, 24 Sep 2010 09:35:35 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: balbir@linux.vnet.ibm.com
Subject: Re: [PATCH 0/8] De-couple sysfs memory directories from memory
	sections
References: <4C9A0F8F.2030409@austin.ibm.com>
	<20100923184002.GM3952@balbir.in.ibm.com>
In-Reply-To: <20100923184002.GM3952@balbir.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/23/2010 01:40 PM, Balbir Singh wrote:
> * Nathan Fontenot <nfont@austin.ibm.com> [2010-09-22 09:15:43]:
> 
>> This set of patches decouples the concept that a single memory
>> section corresponds to a single directory in 
>> /sys/devices/system/memory/.  On systems
>> with large amounts of memory (1+ TB) there are performance issues
>> related to creating the large number of sysfs directories.  For
>> a powerpc machine with 1 TB of memory we are creating 63,000+
>> directories.  This is resulting in boot times of around 45-50
>> minutes for systems with 1 TB of memory and 8 hours for systems
>> with 2 TB of memory.  With this patch set applied I am now seeing
>> boot times of 5 minutes or less.
>>
>> The root of this issue is in sysfs directory creation. Every time
>> a directory is created a string compare is done against all sibling
>> directories to ensure we do not create duplicates.  The list of
>> directory nodes in sysfs is kept as an unsorted list which results
>> in this being an exponentially longer operation as the number of
>> directories are created.
>>
>> The solution solved by this patch set is to allow a single
>> directory in sysfs to span multiple memory sections.  This is
>> controlled by an optional architecturally defined function
>> memory_block_size_bytes().  The default definition of this
>> routine returns a memory block size equal to the memory section
>> size. This maintains the current layout of sysfs memory
>> directories as it appears to userspace to remain the same as it
>> is today.
>>
>> For architectures that define their own version of this routine,
>> as is done for powerpc in this patchset, the view in userspace
>> would change such that each memoryXXX directory would span
>> multiple memory sections.  The number of sections spanned would
>> depend on the value reported by memory_block_size_bytes.
>>
>> In both cases a new file 'end_phys_index' is created in each
>> memoryXXX directory.  This file will contain the physical id
>> of the last memory section covered by the sysfs directory.  For
>> the default case, the value in 'end_phys_index' will be the same
>> as in the existing 'phys_index' file.
>>
> 
> What does this mean for memory hotplug or hotunplug? 
> 

Memory hotplug will function on a memory block size basis.  For
architectures that do not define their own memory_block_size_bytes()
routine, they will get the default size and everything will work
the same as it does today.

For architectures that define their own memory_block_size_bytes()
routine and have multiple memory sections per memory block, hotplug
operations will add or remove all of the memory sections in the memory
memory block.

-Nathan
