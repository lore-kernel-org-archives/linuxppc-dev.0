Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52728DE095
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 05:24:38 +1100 (EST)
Message-Id: <AF818ED4-F261-4EF8-A4CB-CA06FCA9386D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081013142100.7efc2c81@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH V2 4/4] POWERPC: Merge 32 and 64-bit dma code
Date: Mon, 13 Oct 2008 13:22:24 -0500
References: <1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
	<1221251686-5567-1-git-send-email-becky.bruce@freescale.com>
	<20081013144904.GB18363@yoda.jdub.homelinux.org>
	<20081013154127.GA27124@yoda.jdub.homelinux.org>
	<209E575D-DDE2-406A-82DE-2DD445046C02@kernel.crashing.org>
	<20081013142100.7efc2c81@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>>
>>>> While doing a buildall this morning, I notice chrp32_defconfig  
>>>> fails
>>>> to build with:
>>>>
>>>> drivers/built-in.o: In function `hard_dma_setup':
>>>> floppy.c:(.text+0x6e40e): undefined reference to  
>>>> `isa_bridge_pcidev'
>>>> floppy.c:(.text+0x6e412): undefined reference to  
>>>> `isa_bridge_pcidev'
>>>> floppy.c:(.text+0x6e53e): undefined reference to  
>>>> `isa_bridge_pcidev'
>>>> floppy.c:(.text+0x6e546): undefined reference to  
>>>> `isa_bridge_pcidev'
>>>> floppy.c:(.text+0x6e54a): undefined reference to  
>>>> `isa_bridge_pcidev'
>>>> make[1]: *** [.tmp_vmlinux1] Error 1
>>>>
>>>> (the hard_dma_setup thing is in arch/powerpc/include/asm/floppy.h).
>>>>
>>>> I did a git bisect and it pointed at this commit as causing the  
>>>> build
>>>> to fail.  Why, I have no idea.
>>>
>>> Ok, I was annoyed enough to look at why.
>>>
>>> Basically, before this patch pci_map_single on 32-bit PPC seemed to
>>> be compiled down to __dma_sync(ptr, size, direction); and the "dev"
>>> parameter to the function was never actually used.  The compiler
>>> seems to have optimized this out entirely, so we don't get the odd
>>> link reference to isa_bridge_pcidev at all.  (Neither pci_map_single
>>> or isa_bridge_pcidev are present in the vmlinux at all).
>>>
>>> With the patch, the compiler doesn't do this code elimination
>>> because pci_map_single boils down to dma_map_page, which calls
>>> get_dma_direct_offset with the "dev" parameter.  So since it is
>>> still used, the compiler can't eliminate it and hence FAIL.
>>>
>>> I have no patch for this at the moment.  Someone should look at
>>> it more closely, because this is causing the 5 chrp32_defconfig
>>> users to weep.
>>
>> Isn't this the type of regression we should fix post -rc1 :)
>
> I don't think it matters much when it gets fixed, pre or post -rc1.   
> But
> it should probably get fixed.  My hack was to pull isa_bridge_pcidev
> into pci-common.c and export it from there.  The 64-bit PCI code can
> initialized it, and the 32-bit can leave it NULL.  But I have no idea
> if that is sane.  If so, I can probably submit a patch for it.

I was just joking around about our "new" regression policy.. anyways I  
hope ben or maybe anton can comment about the ISA code.

- k
