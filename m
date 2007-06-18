Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5666EDDF7A
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 09:12:07 +1000 (EST)
Message-ID: <46771140.5000205@am.sony.com>
Date: Mon, 18 Jun 2007 16:12:00 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Jimi Xenidis <jimix@pobox.com>
Subject: Re: CONFIG_PS3_USE_LPAR_ADDR dramically increases boot time
References: <F4482BED-242B-42AD-96FF-3CB14B6BC5BE@watson.ibm.com>	<200706182314.26918.arnd@arndb.de>
	<F8264F80-17F0-47C6-AF58-9EBBF42DC24C@pobox.com>
In-Reply-To: <F8264F80-17F0-47C6-AF58-9EBBF42DC24C@pobox.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jimi.

Jimi Xenidis wrote:
> On Jun 18, 2007, at 5:14 PM, Arnd Bergmann wrote:
> 
>> On Monday 18 June 2007, Jimi Xenidis wrote:
>>>
>>> The following change set:
>>>    http://git.kernel.org/?p=linux/kernel/git/paulus/
>>> powerpc.git;a=commit;h=261efc3f178c8c5b55d76208aee1f39ce247f723
>>>
>>> setting CONFIG_PS3_USE_LPAR_ADDR (which is the default for PS3)
>>> changes increases MAX_PHYSADDR_BITS  from 44 to 47 which makes the
>>> array 8 time bigger and takes way longer for sparse_init() to run on
>>> simulator.
>>>
>>> Is this really the right approach?
>>> Cell is actually 42 so could not the special address space be 43  
>>> or 44?
>>
>> Unfortunately, the hypervisor chooses the addresses where things get
>> mapped, and since they are guest-real, there is no hard limit where
>> the hypervisor puts them, like the 42 bit limit on bare metal.
>>
>> I guess this will improve if we get virt_mem_map support on powerpc,
>> but I'm not sure if that's currently being worked on.
> 
> I feel a little nit-picky worrying about slowing down boot, I'm sure  
> it negligible on HW, and complaining about 2K vs 16K memsection. But  
> it is important to point out that this effects all PPC64 targets if a  
> distro decides to include the PS3 config in their PPC64 image.


When CONFIG_PS3_USE_LPAR_ADDR=n a translation in the platform code
sets up the page table to map the region to low addresses (continuous
with the boot mem region), but that translation is not compatible
with the mapping scheme used by the spu regions, which use sparse mem.

Arnd mention that he planed to re-do the spu region management, and
I think with that we can use CONFIG_PS3_USE_LPAR_ADDR=n and the spufs
at the same time.  Arnd, what is the status?

-Geoff
