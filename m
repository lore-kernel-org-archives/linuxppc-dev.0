Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id B971767B5E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 09:07:08 +1000 (EST)
In-Reply-To: <61cc712d0506091509527ee680@mail.gmail.com>
References: <61cc712d0506091509527ee680@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <815f92995891b6f6e5333d0658637788@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 9 Jun 2005 18:07:04 -0500
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


On Jun 9, 2005, at 5:09 PM, Kylo Ginsberg wrote:

> I'm running 2.6.11 on a Freescale 8555 with 1GB of DDR memory.
> Looking in arch/ppc/mm/fsl_booke_mmu.c, I see that at most 3 TLB
> entries will be used to map memory.  Since the max tlb size on
> Freescale Book E is 256 MB, this caps mapped in memory at 768 MB.
>
> I've modified fsl_booke_mmu.c to use a 4th TLB, thus mapping the full
> 1 GB of memory.  However, I'm new to linux memory management, so I'd
> appreciate any comments as to whether there are tradeoffs or dangers
> here that I am missing.

There is a danger here in that you have left no virtual address space 
for the kernel.  Since KERNEL_BASE is normally 0xc000_0000 + 1G ends up 
a the end of memory.  There for any devices that need virtual memory 
space would not have any to map out of.  I'm kinda amazed this works at 
all.  I'd be interested in seeing what a boot log looks like for this 
config.

The way to handle this is by enabling HIGHMEM support in the kernel or 
dropping the KERNEL_START in the config.  I'm haven't ever tried to 
drop KERNEL_START so your milage may very on what if anything that will 
break.

- kumar
