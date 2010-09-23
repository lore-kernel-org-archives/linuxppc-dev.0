Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6934B7160
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 04:40:12 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8NIWSJc008568
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2010 12:32:28 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8NIe9U4120106
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2010 12:40:09 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8NIe7go012955
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2010 12:40:08 -0600
Date: Fri, 24 Sep 2010 00:10:02 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 0/8] De-couple sysfs memory directories from memory
	sections
Message-ID: <20100923184002.GM3952@balbir.in.ibm.com>
References: <4C9A0F8F.2030409@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4C9A0F8F.2030409@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Nathan Fontenot <nfont@austin.ibm.com> [2010-09-22 09:15:43]:

> This set of patches decouples the concept that a single memory
> section corresponds to a single directory in 
> /sys/devices/system/memory/.  On systems
> with large amounts of memory (1+ TB) there are performance issues
> related to creating the large number of sysfs directories.  For
> a powerpc machine with 1 TB of memory we are creating 63,000+
> directories.  This is resulting in boot times of around 45-50
> minutes for systems with 1 TB of memory and 8 hours for systems
> with 2 TB of memory.  With this patch set applied I am now seeing
> boot times of 5 minutes or less.
> 
> The root of this issue is in sysfs directory creation. Every time
> a directory is created a string compare is done against all sibling
> directories to ensure we do not create duplicates.  The list of
> directory nodes in sysfs is kept as an unsorted list which results
> in this being an exponentially longer operation as the number of
> directories are created.
> 
> The solution solved by this patch set is to allow a single
> directory in sysfs to span multiple memory sections.  This is
> controlled by an optional architecturally defined function
> memory_block_size_bytes().  The default definition of this
> routine returns a memory block size equal to the memory section
> size. This maintains the current layout of sysfs memory
> directories as it appears to userspace to remain the same as it
> is today.
> 
> For architectures that define their own version of this routine,
> as is done for powerpc in this patchset, the view in userspace
> would change such that each memoryXXX directory would span
> multiple memory sections.  The number of sections spanned would
> depend on the value reported by memory_block_size_bytes.
> 
> In both cases a new file 'end_phys_index' is created in each
> memoryXXX directory.  This file will contain the physical id
> of the last memory section covered by the sysfs directory.  For
> the default case, the value in 'end_phys_index' will be the same
> as in the existing 'phys_index' file.
>

What does this mean for memory hotplug or hotunplug? 

-- 
	Three Cheers,
	Balbir
