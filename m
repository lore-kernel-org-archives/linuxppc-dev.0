Return-Path: <nfont@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55017B7FB1
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Dec 2009 01:49:01 +1100 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBNEdZ8H023446
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 09:39:35 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBNEmwZ4102556
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 09:48:58 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBNEmv1k014862
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 12:48:58 -0200
Message-ID: <4B322DD6.60801@austin.ibm.com>
Date: Wed, 23 Dec 2009 08:48:54 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] Make cpu hotplug driver lock part of ppc_md
References: <4B30DB8B.3030305@austin.ibm.com>
	<1261520982.17348.8.camel@concordia>
In-Reply-To: <1261520982.17348.8.camel@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Tue, 2009-12-22 at 08:45 -0600, Nathan Fontenot wrote:
>> The recently introduced cpu_hotplug_driver_lock used to serialize
>> cpu hotplug operations, namely for the pseries platform, causes a build
>> issue for other platforms.  The base cpu hotplug code attempts
>> to take this lock, but it may not be needed for all platforms.  This patch
>> moves the lock/unlock routines to be part of the ppc_md structure
>> so that platforms needing the lock can take it.  This also makes the
>> previous cpu_hotplug_driver_lock, defined in pseries code, pseries specific.
>>
>> The past failure without this patch was seen when building pmac and may
>> be present in other platform builds.  The error is included below for reference.
>>
>> drivers/built-in.o: In function `.store_online':
>> cpu.c:(.ref.text+0xf5c): undefined reference to `.cpu_hotplug_driver_lock'
>> cpu.c:(.ref.text+0xfc8): undefined reference to `.cpu_hotplug_driver_unlock'
>> make: *** [.tmp_vmlinux1] Error 1
> 
> Why does the pmac code /not/ need a lock? And would it be harmless if it
> was locked too?

The intention of the cpu_hotplug_driver_locks to add additional serialization
during cpu hotplug operations.  For pseries this is used during DLPAR of cpu
operations so that cpu hotplug actions cannot be initiated whiloe a DLPAR
operation is in flight.  For example, during DLPAR add we take the lock while
acquiring the cpu from firmware and updating the device tree with the new
cpu information, after which we hotplug add the cpu to the system.  

There is nothing harmless about taking the lock on all platforms, I was just
trying to avoid taking the lock if the additional serialization is not needed.

> 
> If so, you could just make the mutex available to all powerpc code, and
> rename it, and then we wouldn't need all this jiggery pokery just to
> take & release a lock.

I can make the lock available to all powerpc code and not go through the
ppc_md struct, it makes no difference to me personally.  Of course this would
make all that fun pokery jiggery go away :)

-Nathan
