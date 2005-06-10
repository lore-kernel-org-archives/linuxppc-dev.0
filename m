Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id BBF1D67B7B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 11:08:35 +1000 (EST)
In-Reply-To: <61cc712d050609162565d8bbfd@mail.gmail.com>
References: <61cc712d050609162565d8bbfd@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f9515cd0efd9087f985eaa2462d0c06e@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 9 Jun 2005 20:08:31 -0500
To: "Kylo Ginsberg" <kylo.ginsberg@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Mapping full 1 GB of memory on a Freescale Book E part
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 9, 2005, at 6:25 PM, Kylo Ginsberg wrote:

> On 6/9/05, Kumar Gala <kumar.gala@freescale.com> wrote:
>>
>> On Jun 9, 2005, at 5:09 PM, Kylo Ginsberg wrote:
>>> I've modified fsl_booke_mmu.c to use a 4th TLB, thus mapping the full
>>> 1 GB of memory.  However, I'm new to linux memory management, so I'd
>>> appreciate any comments as to whether there are tradeoffs or dangers
>>> here that I am missing.
>>
>> There is a danger here in that you have left no virtual address space
>> for the kernel.  Since KERNEL_BASE is normally 0xc000_0000 + 1G ends 
>> up
>> a the end of memory.  There for any devices that need virtual memory
>> space would not have any to map out of.  I'm kinda amazed this works 
>> at
>> all.  I'd be interested in seeing what a boot log looks like for this
>> config.
>
> Sorry, should have mentioned this in the first post.  I dropped
> KERNEL_BASE to 0xa0000000 and upped LOWMEM_SIZE to 0x40000000.  So the
> Advanced Setup portion of my .config reads:
>
> #
> # Advanced setup
> #
> CONFIG_ADVANCED_OPTIONS=y
> CONFIG_HIGHMEM_START=0xfe000000
> CONFIG_LOWMEM_SIZE_BOOL=y
> CONFIG_LOWMEM_SIZE=0x40000000
> CONFIG_KERNEL_START_BOOL=y
> CONFIG_KERNEL_START=0xa0000000
> # CONFIG_TASK_SIZE_BOOL is not set
> CONFIG_TASK_SIZE=0x80000000
> # CONFIG_BOOT_LOAD_BOOL is not set
> CONFIG_BOOT_LOAD=0x00800000
>
> and under Platform Options:
>
> # CONFIG_HIGHMEM is not set
>
>> The way to handle this is by enabling HIGHMEM support in the kernel or
>> dropping the KERNEL_START in the config.  I'm haven't ever tried to
>> drop KERNEL_START so your milage may very on what if anything that 
>> will
>> break.
>
> So, an alternative would be to leave fsl_booke_mmu.c untouched, revert
> my KERNEL_START/LOWMEM mods, and instead enable HIGHMEM?  Setting
> HIGHMEM_START to ...? Will that entail more TLB thrashing?

You have to set HIGHMEM_START to something. I think the default is 
fine.  It only means more TLB thrasing if the kernel has to touch one 
of the pages in HIGHMEM.  If its only application code that is using 
memory > 768M then you shouldn't really see any performance impact.

either solution should work, it just depends on what you want to 
accomplish at the end.

- kumar
