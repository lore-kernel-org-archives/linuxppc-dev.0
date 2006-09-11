Return-Path: <rimas@cnmat.berkeley.edu>
Received: from cnmat.berkeley.edu (cnmat.CNMAT.Berkeley.EDU [128.32.122.12])
	by ozlabs.org (Postfix) with ESMTP id 809F367B57
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Sep 2006 08:53:17 +1000 (EST)
From: "rimas" <rimas@cnmat.berkeley.edu>
Subject: Re: simple ELF bootloader for embedded xilinx linux ? 
To: Michael Galassi <mgalassi@c-cor.com>, 
Date: Mon, 11 Sep 2006 15:53:17 -0700
Message-ID: <web-1977965@cnmat.berkeley.edu>
In-Reply-To: <200609112120.k8BLKnFF097143@penguin.ncube.com>
References: <1354DD02-657B-4777-8378-BC408DA3D800@cnmat.berkeley.edu>
	<200609112120.k8BLKnFF097143@penguin.ncube.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format="flowed"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 11 Sep 2006 14:20:49 -0700
  Michael Galassi <mgalassi@c-cor.com> wrote:
>>whats the best/easiest way for me to boot from an ELF file in the  
>>flash ? i'm aware of u-boot but it seems like overkill for this  
>>application.  however if it would work and the footprint is  
>>relatively small i could give it a try.  i imagine i could write my  
>>own bootloader, i just thought i'd ask first to avoid reinventing the  
>>wheel.
> 
> If you're using the zImage file the only bootloader you need is an
> unconditional, unlinked branch to the first instruction you want to
> execute in the zImage located at -4 (0xfffffffc).  To save a few extra
> bytes you can strip the ELF header from the zImage, then you flash it
> at the same address you jump to.  I do that with objcopy:
>    make zImage && \
>    ppc_405-objcopy -O binary arch/ppc/boot/images/zImage.elf zImage.bin
> 
> Remember that the first instruction of the kernel must reside within
> your relative jump limit if you take this approach.  If you place your 3
> meg kernel right below the branch instruction you'll have no problems
> with this at all.  If you prefer mapping your flash lower down and use a
> blockram (or whatever) for your boot-code you can branch a dozen bytes
> backward in the instruction at -4 and have an absolute branch there
> which could reach anyplace in your address space.

Thanks for clarifying that for me !  Using objcopy to create a binary file, 
flashing the binary file and then jumping to the start of the flash works 
perfectly.

> 
>>another somewhat related question is whether i can use a portion of  
>>the flash (the part thats left over after the kernel/root fs image is  
>>programmed) as nonvolatile storage using the JFFS2 filesystem ?   
>>anyone have any pointers to information on how to set this up ?
> 
> Most flash must be erased in 128K blocks, once two are paired to yield
> a 32bit wide data bus you'll find yourself segmenting your space into
> 256K blocks.  I use an integral number of these blocks for a cramfs
> image, I see no reason you shouldn't do the same for a jffs2.  Just be
> careful not to accidentally write past the space you allocate to your
> filesystem and onto your boot-code, kernel, and what ever else you place
> in flash.  Since bricking(*) a system is viewed as a bad thing we don't
> allow writes to the filesystem in flash, we instead write entire images
> at once in carefully controlled conditions.
> 

Thanks for pointing out the potential risks in using the same flash as a 
read/write filesystem and storage for the kernel/root filesystem/etc. I hadn't 
considered that.  I only need minimal low speed non volatile storage so maybe 
I'll use an eeprom or something instead for the sake of reliability.

-rimas

> An over-simplified flash map ends up looking something like:
>    "size-4bytes"     branch instruction to "top-4meg"
>    "size-4meg"	      kernel stripped of elf header
>    "size-20meg"      filesystem image
>    "0"		      bitstream loaded into FPGA at power-up
> 
> Adjust the sizes to fit your kernel size, filesystem size, bistream
> size, and to accommodate the flash size you're using and other data
> you might with to store in flash.
> 
> (*) brick (verb) to render functionally brick-like
> 
> -michael
