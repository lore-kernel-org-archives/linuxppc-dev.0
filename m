Return-Path: <nfont@austin.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E1546B6F11
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jul 2010 03:17:11 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6EH7aYl002416
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 11:07:36 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6EHGtAH079928
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 11:16:57 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6EHGs0n015867
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 11:16:55 -0600
Message-ID: <4C3DF105.1050404@austin.ibm.com>
Date: Wed, 14 Jul 2010 12:16:53 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/7] Allow sysfs memory directories to be split
References: <4C3B3446.5090302@austin.ibm.com>	
	<4C3B3895.3040209@austin.ibm.com>	
	<20100713152854.ec1f4d6a.kamezawa.hiroyu@jp.fujitsu.com>	
	<4C3C8B9E.7000208@austin.ibm.com>	
	<20100714093550.40036034.kamezawa.hiroyu@jp.fujitsu.com>
	<1279078016.10995.58.camel@nimitz>
In-Reply-To: <1279078016.10995.58.camel@nimitz>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/13/2010 10:26 PM, Dave Hansen wrote:
> On Wed, 2010-07-14 at 09:35 +0900, KAMEZAWA Hiroyuki wrote:
>>   2. I'd like to write a configfs module for handling memory hotplug even when
>>      sysfs directroy is not created.
>>      Because configfs support rmdir/mkdir, the user (ppc's daemon?) has to do
>>      
>>      When offlining section X.
>>      # insmod configfs_memory.ko
>>      # mount -t configfs none /configfs
>>      # mkdir /configfs/memoryX
>>      # echo offline > /configfs/memoryX/state
>>      # rmdir /configfs/memoryX
>>
>>   And making this operation as the default bahavior for all arch's memory hotplug may
>>   be better...
>>
>> Dave, how do you think ? Because ppc guys uses "probe" interface already,
>> this can be handled... no ?
> 
> I think creating a interface to duplicate the existing sysfs one is a
> bad idea.  I also think removing the existing sysfs one isn't feasible
> since there are users, and it's truly part of the ABI.  So, I'm not
> really a fan on the configfs interface. :(
> 
> I really do think the sysfs interface is fixable.  We should at least
> give it a good shot before largely duplicating its functionality.

I agree with Dave, I don't think another memory hotplug interface is needed.

I am working to update the patchset to remove the split functionality and
fix other items commented on.  this new patch will just split the memory_block
structure so that a memory_block can span multiple memory sections.

Kame, I understand that offlining 16 MB is easier than 256 MB.  From the ppc
perspective though, we are still offlining 256 MB.  We do memory add/remove
on LMB size chunks, so we have to add/remove all of the memory sections contained
in an LMB.  If any one memory section covered by a LMB fails to add/remove, we
restore the memory sections to their orignal state an fail the add/remove operation.
NOTE: the code doing this is not in the kernel, but in the user-space drmgr
command (from powerpc-utils package).

-Nathan 
