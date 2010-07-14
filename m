Return-Path: <nfont@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2506B6F10
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 13:18:15 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6E3HC6x001072
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 23:17:12 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6E3ICH4116396
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 23:18:12 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6E3IBwa013065
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 23:18:12 -0400
Message-ID: <4C3D2C6B.3050203@austin.ibm.com>
Date: Tue, 13 Jul 2010 22:18:03 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 4/7] Allow sysfs memory directories to be split
References: <4C3B3446.5090302@austin.ibm.com>	<4C3B3895.3040209@austin.ibm.com>	<20100713152854.ec1f4d6a.kamezawa.hiroyu@jp.fujitsu.com>	<4C3C8B9E.7000208@austin.ibm.com>
	<20100714093550.40036034.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20100714093550.40036034.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/13/2010 07:35 PM, KAMEZAWA Hiroyuki wrote:
> On Tue, 13 Jul 2010 10:51:58 -0500
> Nathan Fontenot <nfont@austin.ibm.com> wrote:
> 
>>>
>>> And for what purpose this interface is ? Does this split memory block into 2 pieces
>>> of the same size ?? sounds __very__ strange interface to me.
>>
>> Yes, this splits the memory_block into two blocks of the same size.  This was
>> suggested as something we may want to do.  From ppc perspective I am not sure we
>> would use this.
>>
>> The split functionality is not required.  The main goal of the patch set is to
>> reduce the number of memory sysfs directories created.  From a ppc perspective
>> the split functionality is not really needed.
>>
> 
> Okay, this is an offer from me.
> 
>   1. I think you can add an boot option as "don't create memory sysfs".
>      please do.

I posted a patch to do that a week or so ago, it didn't go over very well.

> 
>   2. I'd like to write a configfs module for handling memory hotplug even when
>      sysfs directroy is not created.
>      Because configfs support rmdir/mkdir, the user (ppc's daemon?) has to do
>      
>      When offlining section X.
>      # insmod configfs_memory.ko
>      # mount -t configfs none /configfs
>      # mkdir /configfs/memoryX
>      # echo offline > /configfs/memoryX/state
>      # rmdir /configfs/memoryX
> 
>   And making this operation as the default bahavior for all arch's memory hotplug may
>   be better...
> 
> Dave, how do you think ? Because ppc guys uses "probe" interface already,
> this can be handled... no ?

ppc would still require the existance of the 'probe' interface.

Are you objecting to the 'split' functionality?  If so I do not see any reason from ppc
perspective that it is needed.  This was something Dave suggested, unless I am missing
something.

Since ppc needs the 'probe' interface in sysfs, and for ppc having mutliple 
memory_block_sections reside under a single memory_block makes memory hotplug
simpler.  On ppc we do emory hotplug operations on an LMB size basis.  With my
patches this now lets us set each memory_block to span an LMB's worth of
memory.  Now we could do emory hotplug in a single operation instead of multiple
operations to offline/online all of the memory sections in an LMB.

Of course the easy solution would be to increase SECTION_SIZE_BITS, but we need
support hardware that can have LMB's from 16 MB to 256 MB in size so the
SECTION_SIZE_BITS value has to remain small. 

> 
> One problem is that I don't have enough knowledge about configfs..it seems complex.

Me neither, thoug I will take a look at it.

-Nathan
