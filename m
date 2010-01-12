Return-Path: <nfont@austin.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63D331007D7
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jan 2010 06:35:04 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0CJTlvb003481
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 12:29:47 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o0CJYjD9238324
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 12:34:47 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0CJYfKo002443
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 12:34:41 -0700
Message-ID: <4B4CCECF.3040800@austin.ibm.com>
Date: Tue, 12 Jan 2010 13:34:39 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Make cpu hotplug driver lock part of ppc_md
References: <4B30DB8B.3030305@austin.ibm.com>	
	<1261520982.17348.8.camel@concordia>
	<4B322DD6.60801@austin.ibm.com> <1263262996.724.176.camel@pasglop>
In-Reply-To: <1263262996.724.176.camel@pasglop>
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

Benjamin Herrenschmidt wrote:
>> The intention of the cpu_hotplug_driver_locks to add additional serialization
>> during cpu hotplug operations.  For pseries this is used during DLPAR of cpu
>> operations so that cpu hotplug actions cannot be initiated whiloe a DLPAR
>> operation is in flight.  For example, during DLPAR add we take the lock while
>> acquiring the cpu from firmware and updating the device tree with the new
>> cpu information, after which we hotplug add the cpu to the system.  
>>
>> There is nothing harmless about taking the lock on all platforms, I was just
>> trying to avoid taking the lock if the additional serialization is not needed.
>>
>>> If so, you could just make the mutex available to all powerpc code, and
>>> rename it, and then we wouldn't need all this jiggery pokery just to
>>> take & release a lock.
>> I can make the lock available to all powerpc code and not go through the
>> ppc_md struct, it makes no difference to me personally.  Of course this would
>> make all that fun pokery jiggery go away :)
> 
> Yeah, Michael is right, just make it global to powerpc, it should make
> things simpler.

Sounds good, I'll get a patch out to do this.

-Nathan
