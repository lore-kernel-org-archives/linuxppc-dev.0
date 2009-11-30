Return-Path: <nfont@austin.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 920B41007D2
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 07:48:42 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAUKhqai010149
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 13:43:52 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAUKmOeY106790
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 13:48:30 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAUKmNpV026044
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 13:48:23 -0700
Message-ID: <4B142F94.7010602@austin.ibm.com>
Date: Mon, 30 Nov 2009 14:48:20 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 0/3] Kernel handling of Dynamic Logical Partitioning
References: <4B0CD70F.6090600@austin.ibm.com>
	<m13a3ztwtw.fsf@fess.ebiederm.org>
In-Reply-To: <m13a3ztwtw.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de, paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Eric W. Biederman wrote:
> Nathan Fontenot <nfont@austin.ibm.com> writes:
> 
>> version 2 of the patch set with updates from comments.
>>
>> The Dynamic Logical Partitioning (DLPAR) capabilities of the powerpc pseries
>> platform allows for the addition and removal of resources (i.e. cpus,
>> memory, pci devices) from a partition. The removal of a resource involves
>> removing the resource's node from the device tree and then returning the
>> resource to firmware via the rtas set-indicator call.  To add a resource, it
>> is first obtained from firmware via the rtas set-indicator call and then a
>> new device tree node is created using the ibm,configure-coinnector rtas call
>> and added to the device tree.
>>
>> The following set of patches implements the needed infrastructure to have the
>> kernel handle the DLPAR addition and removal of cpus (other DLPAR'able items to
>> follow in future patches).  The framework for this is to create a set of
>> probe/release sysfs files that will facilitate arch-specific call-outs to handle
>> addition and removal of cpus to the system.
> 
> How does this differ from /sys/devices/system/cpu/cpuX/online ?
> 
> From the descriptions it appears that we already have what you are trying to
> add and you just need to tie it into DLPAR on ppc.
> 

The DLPAR and hotplug operations need to be kept separate for ppc.  One big reason
for this is that DLPAR operations on ppc are driven from the Hardware Management
Console (HMC).  It is (almost always) not possible to DLPAR add a resource (i.e.
cpu, memory,pcie device) from the OS.  There are HMC <=> firmware interactions
that must occur to make the resource available to the partition.

Second is that there are times when one would want to hotplug add/remove
a cpu but not dlpar add/remove it.

When a resource is DLPAR removed, the OS has no knowledge that the resource exists. 
Likewise, this allows the addition of resources from the HMC after the system is booted.
This is a feature of ppc partitions that allows for the dynamic movement of resources
between partitions.

-Nathan Fontenot
