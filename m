Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E31FB7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Sep 2009 19:52:07 +1000 (EST)
Subject: Re: Linux booting issue on powerpc 440x5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sumesh Kaana <sumeshkkn@hotmail.com>
In-Reply-To: <BLU124-W15B59AFF88DB52C03BD481B4E00@phx.gbl>
References: <BLU124-W15B59AFF88DB52C03BD481B4E00@phx.gbl>
Content-Type: text/plain
Date: Mon, 21 Sep 2009 19:52:00 +1000
Message-Id: <1253526720.7103.134.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-09-18 at 09:31 +0000, Sumesh Kaana wrote:
> 
> 
> Hi,
> 
> 
> I am trying to boot linux kernel (2.6.30) on PPC440x5 processor in a
> custom built board. I am using simple ppc platform.
> 
> 
> I have a small bootloader which will only copy the
> simpleImage.myboard.bin to 0x400000 location of my SRAM from the
> flash.
> 
> 
> SRAM is only 16MB and bootloader creates one and only TLB of 16MB
> 

The 440 kernel is meant to be run from memory physical address 0 in main
memory. It's not capable of relocating itself there, so I wouldn't be
surprised that this is the source of your problem.

Ben.
 
> I am getting "Kernel access of bad area, sig: 11 [#1]" while kernel is
> booting.
> 
> 
> kernel crashes in different places, for different compilation
> 
> 
> Bellow given are 2 dumps of kernel crash
> 
> 
> In DUMP1, in back trace, execution flow is shown like,
> 
> 
> Start_kernel() --> sort_main_extable() --> sort_extable(). and sort
> extable calls some functions whose name is not mentioned.
> 
> 
> Why is it not able to get the name of the function.?
> 
> 
> i went through the 'objdump' of the kernel, I don't know whether it
> can help me somehow, it looked like this
> 
> 
> --
> c018c730:   48 00 71 9d     bl      c01938cc <sort_main_extable>
> c018c734:   48 00 3e 3d     bl      c0190570 <trap_init>
> --
> c01938e8:   4b f7 10 f1     bl      c01049d8 <sort_extable>
> c01938ec:   80 01 00 14     lwz     r0,20(r1)
> --
> c01049fc:   48 00 8d 99     bl      c010d794 <sort>
> c0104a00:   80 01 00 14     lwz     r0,20(r1)
> --
> c016b99c:   42 6f 6f 74     bc+     18,4*cr3+so,c0172910
> <kallsyms_token_index+0x7400>
> --
> 
> 
> Could this be problem with "kallsyms"..? Because sort_extable() calls
> sort() which is an exported function defined in linux-2.6.30\lib
> \sort.c
> 
> 
> when i checked 'objdump' of the kernel, i could see the usage of a
> preserved opcode of ppc440x5 (code: eciwx).
> 
> 
> I tried compiling the kernel with "kallsyms" disabled, that also did
> not work.
> 
> 
> In DUMP2, backtrace is not able to identify the name of 'caller' of
> unflatten_device_tree(). The caller is mentioned as "[00000000]
> (null)"
> 
> 
> Could this be a stack problem, like stack pointer getting corrupted.?
> 
> 
> At last, could this be a hardware problem(expecting to be memory
> problem)..?
> 
> 
> Can you tell me if i am missing something.?
> 
> 
> thanks,
> Shyju. N
> 
> 
> 
> 
> -------------------------DUMP 1------------------------------------
> id mach(): done
> MMU:enter
> MMU:hw init
> MMU:mapin
> MMU:setio
> MMU:exit
> bootmemarch: exit
> <7>Top of RAM: 0x1000000, Total RAM: 0x1000000
> Zone PFN ranges:
>   DMA      0x00000000 -> 0x00001000
>   Normal   0x00001000 -> 0x00001000
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0: 0x00000000 -> 0x00001000
> MMU: Allocated 1088 bytes of context maps for 255 contexts
> Built 1 zonelists in Zone order, mobility grouping off.  Total pages:
> 4064
> Kernel command line: console=ttyS0 root=/dev/ram
> Unable to handle kernel paging request for data at address 0x00021000
> Faulting instruction address: 0xc010a7c4
> Oops: Kernel access of bad area, sig: 11 [#1]
> PREEMPT PowerPC 44x Platform
> Modules linked in:
> NIP: c010a7c4 LR: c010dc50 CTR: 00000000
> REGS: c01bfeb0 TRAP: 0300   Not tainted  (2.6.30)
> MSR: 00021000 <ME,CE>  CR: 24000044  XER: 00000000
> DEAR: 00021000, ESR: 00000000
> TASK = c01a94b8[0] 'swapper' THREAD: c01be000
> GPR00: 00001180 c01bff60 c01a94b8 00021000 00000025 00000008 c0104968
> 00000000 
> GPR08: 2f72616d c0110000 c0155938 c01a0000 22000024 00000000 fffff104
> 00000000 
> GPR16: 00000000 00000000 00000000 00000000 fffffff8 000008b8 c010d758
> c0104968 
> GPR24: 00001198 00001190 c018a001 c01c5498 000008c0 00001188 00021000
> c01c42f0 
> NIP [c010a7c4] strchr+0x0/0x3c
> LR [c010dc50] match_token+0x138/0x228
> Call Trace:
> [c01bff60] [c016b99c] 0xc016b99c (unreliable)
> [c01bffa0] [c0104a00] sort_extable+0x28/0x38
> [c01bffb0] [c01938ec] sort_main_extable+0x20/0x30
> [c01bffc0] [c018c734] start_kernel+0x140/0x288
> [c01bfff0] [c0000200] skpinv+0x190/0x1cc
> Instruction dump:
> 7ca903a6 88040000 38a5ffff 38840001 2f800000 98090000 39290001
> 419e0010 
> 4200ffe4 98a90000 4e800020 4e800020 <88030000> 5484063e 7f802000
> 4d9e0020 
> ---[ end trace 31fd0ba7d8756001 ]---
> Kernel panic - not syncing: Attempted to kill the idle task!
> Call Trace:
> [c01bfd90] [c0005d5c] show_stack+0x4c/0x16c (unreliable)
> [c01bfdd0] [c002f17c] panic+0xa0/0x168
> [c01bfe20] [c0032eb8] do_exit+0x61c/0x638
> [c01bfe60] [c000b60c] kernel_bad_stack+0x0/0x4c
> [c01bfe90] [c000f310] bad_page_fault+0x90/0xd8
> [c01bfea0] [c000e184] handle_page_fault+0x7c/0x80
> [c01bff60] [c016b99c] 0xc016b99c
> [c01bffa0] [c0104a00] sort_extable+0x28/0x38
> [c01bffb0] [c01938ec] sort_main_extable+0x20/0x30
> [c01bffc0] [c018c734] start_kernel+0x140/0x288
> [c01bfff0] [c0000200] skpinv+0x190/0x1cc
> Rebooting in 180 seconds..
> -------------------------------------------------------------------
> 
> 
> -------------------------DUMP 2------------------------------------
> id mach(): done
> MMU:enter
> MMU:hw init
> MMU:mapin
> MMU:setio
> MMU:exit
> <1>Unable to handle kernel paging request for data at address
> 0x40ee8053
> Faulting instruction address: 0xc018ff44
> Oops: Kernel access of bad area, sig: 11 [#1]
> PREEMPT PowerPC 44x Platform
> Modules linked in:
> NIP: c018ff44 LR: c018ff20 CTR: 00000000
> REGS: c01bfe10 TRAP: 0300   Not tainted  (2.6.30)
> MSR: 00021000 <ME,CE>  CR: 44088024  XER: 00000000
> DEAR: 40ee8053, ESR: 00800000
> TASK = c01a94b8[0] 'swapper' THREAD: c01be000
> GPR00: c0ffea58 c01bfec0 c01a94b8 c0ffea6e c04eb3aa 00000003 c0ffea74
> 00000000 
> GPR08: 00000000 40ee802f c04eb3a0 c01bfec8 24082022 00000000 fffff104
> 00000000 
> GPR16: 00000000 c016cfe8 c016cfd8 c0170cbc c01bfec8 c0ffea24 c04eb3a4
> c04eb3a0 
> GPR24: 00000008 c01bff8c c04eb33c c0ffea2c 00000007 c01bff88 c0ffe984
> c0ffea6d 
> NIP [c018ff44] unflatten_dt_node+0x158/0x520
> LR [c018ff20] unflatten_dt_node+0x134/0x520
> Call Trace:
> [c01bff20] [c019023c] unflatten_dt_node+0x450/0x520
> [c01bff80] [c01903b4] unflatten_device_tree+0xa8/0x13c
> [c01bffb0] [00000000] (null)
> Instruction dump:
> 7f85e378 7ec4b378 4be81b55 81390000 381b002c 93690000 90190000
> 4192001c 
> 813e0028 93db001c 2f890000 419e03b4 <93690024> 937e0028 387b0034
> 3abb0014 
> ---[ end trace 31fd0ba7d8756001 ]---
> Kernel panic - not syncing: Attempted to kill the idle task!
> Call Trace:
> [c01bfcf0] [c0005d5c] show_stack+0x4c/0x16c (unreliable)
> [c01bfd30] [c002f17c] panic+0xa0/0x168
> [c01bfd80] [c0032eb8] do_exit+0x61c/0x638
> [c01bfdc0] [c000b60c] kernel_bad_stack+0x0/0x4c
> [c01bfdf0] [c000f310] bad_page_fault+0x90/0xd8
> [c01bfe00] [c000e184] handle_page_fault+0x7c/0x80
> [c01bfec0] [00000000] (null)
> [c01bff20] [c019023c] unflatten_dt_node+0x450/0x520
> [c01bff80] [c01903b4] unflatten_device_tree+0xa8/0x13c
> [c01bffb0] [00000000] (null)
> -------------------------------------------------------------------
> 
> 
> 
> 
> 
> 
> 
> 
> ______________________________________________________________________
> Let us find your next place for you! Need a place to rent, buy or
> share?
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
