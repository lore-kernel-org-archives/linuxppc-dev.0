Return-Path: <xenidis@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.239])
	by ozlabs.org (Postfix) with ESMTP id 8DA5DDDE9E
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 07:28:08 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 69so1152489wra
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 14:28:07 -0700 (PDT)
In-Reply-To: <200706182314.26918.arnd@arndb.de>
References: <F4482BED-242B-42AD-96FF-3CB14B6BC5BE@watson.ibm.com>
	<200706182314.26918.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F8264F80-17F0-47C6-AF58-9EBBF42DC24C@pobox.com>
From: Jimi Xenidis <jimix@pobox.com>
Subject: Re: CONFIG_PS3_USE_LPAR_ADDR dramically increases boot time
Date: Mon, 18 Jun 2007 17:27:50 -0400
To: Arnd Bergmann <arnd@arndb.de>
Sender: Jimi Xenidis <xenidis@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 18, 2007, at 5:14 PM, Arnd Bergmann wrote:

> On Monday 18 June 2007, Jimi Xenidis wrote:
>>
>> The following change set:
>>    http://git.kernel.org/?p=linux/kernel/git/paulus/
>> powerpc.git;a=commit;h=261efc3f178c8c5b55d76208aee1f39ce247f723
>>
>> setting CONFIG_PS3_USE_LPAR_ADDR (which is the default for PS3)
>> changes increases MAX_PHYSADDR_BITS  from 44 to 47 which makes the
>> array 8 time bigger and takes way longer for sparse_init() to run on
>> simulator.
>>
>> Is this really the right approach?
>> Cell is actually 42 so could not the special address space be 43  
>> or 44?
>
> Unfortunately, the hypervisor chooses the addresses where things get
> mapped, and since they are guest-real, there is no hard limit where
> the hypervisor puts them, like the 42 bit limit on bare metal.
>
> I guess this will improve if we get virt_mem_map support on powerpc,
> but I'm not sure if that's currently being worked on.

I feel a little nit-picky worrying about slowing down boot, I'm sure  
it negligible on HW, and complaining about 2K vs 16K memsection. But  
it is important to point out that this effects all PPC64 targets if a  
distro decides to include the PS3 config in their PPC64 image.

-JX
