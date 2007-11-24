Return-Path: <jtyner@eon.cs.ucr.edu>
Received: from mail.cs.ucr.edu (mail.cs.ucr.edu [138.23.169.83])
	by ozlabs.org (Postfix) with ESMTP id 967CCDDE47
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 01:56:33 +1100 (EST)
Received: from mail.cs.ucr.edu (localhost.localdomain [127.0.0.1])
	by mail.cs.ucr.edu (Postfix) with ESMTP id 82C412AEAED
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 06:26:40 -0800 (PST)
Received: from eon.cs.ucr.edu (eon.cs.ucr.edu [138.23.169.9])
	by mail.cs.ucr.edu (Postfix) with ESMTP id 37D032AEB51
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 06:26:35 -0800 (PST)
Received: from eon.cs.ucr.edu (localhost.localdomain [127.0.0.1])
	by eon.cs.ucr.edu (Postfix) with ESMTP id 4AB99F3FC9
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 06:26:36 -0800 (PST)
Received: (from jtyner@localhost)
	by eon.cs.ucr.edu (8.13.1/8.13.1/Submit) id lAOEQa2W027171
	for linuxppc-dev@ozlabs.org; Sat, 24 Nov 2007 06:26:36 -0800
Date: Sat, 24 Nov 2007 06:26:36 -0800
From: John Tyner <jtyner@cs.ucr.edu>
To: linuxppc-dev@ozlabs.org
Subject: Re: oops trying to execute sh
Message-ID: <20071124142636.GA23058@cs.ucr.edu>
References: <Pine.LNX.4.64.0711211149210.3338@eon.cs.ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0711211149210.3338@eon.cs.ucr.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is ppc. I'm in the midst of trying to get powerpc to boot, but our 
boards are running an old version of ppcboot that can't be upgraded, so 
I'm having to figure out the translation to the open firmware stuff.

By the way, this is an 860t, not c... typo.

Do you have any suggestions about getting ppc to boot? I'd like to try to 
at least get the board booting so I can hand the user space stuff off to 
someone else while I do the powerpc port.

Thanks,
John

> On Wed, 21 Nov 2007 11:54:01 -0800 (PST)
> John Charles Tyner wrote:
> 
> > I'm trying to boot linux 2.6.22.9 on an mpc860c rev d4.
> > 
> ppc or powerpc?
> 
> 
> > When init trys to spawn sh, during the exec, the kernel oopses as
> > seen below:
> This looks like coherency problem, or kernel picks wrong entry off 
> cputable.
> I think I recall something similar when I lost a hunk applying patch for 
> new e300 core.
> ... or not. The game across that ff8.. value is very confusing.
> 
> -- 
> Sincerely, Vitaly

On Wed, Nov 21, 2007 at 11:54:01AM -0800, John Charles Tyner wrote:
> I'm trying to boot linux 2.6.22.9 on an mpc860c rev d4.
> 
> When init trys to spawn sh, during the exec, the kernel oopses as seen 
> below:
> 
> ## Starting application at 0x00400000 ...
> 
> loaded at:     00400000 004EF15C
> board data at: 03F9FBC0 03F9FBFC
> relocated to:  00404044 00404080
> zimage at:     00404E74 004EC662
> avail ram:     004F0000 04000000
> 
> Linux/PPC load: console=ttyCPM,38400
> Uncompressing Linux...done.
> Now booting the kernel
> Linux version 2.6.22.9 (jtyner@johnnyedge) (gcc version 4.2.1) #113 Wed Nov 
> 21 10:49:36 PST 2007
> Zone PFN ranges:
>   DMA             0 ->    16384
>   Normal      16384 ->    16384
> early_node_map[1] active PFN ranges
>     0:        0 ->    16384
> Built 1 zonelists.  Total pages: 16256
> Kernel command line: console=ttyCPM,38400
> PID hash table entries: 256 (order: 8, 1024 bytes)
> Decrementer Frequency = 183750000/60
> Console: colour dummy device 80x25
> cpm_uart: console: compat mode
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 63244k available (880k kernel code, 268k data, 444k init, 0k 
> highmem)
> Mount-cache hash table entries: 512
> ADDSI: Init
> io scheduler noop registered (default)
> Serial: CPM driver $Revision: 0.02 $
> ttyCPM0 at MMIO 0xc5000a80 (irq = 20) is a CPM UART
> mice: PS/2 mouse device common for all mice
> Freeing unused kernel memory: 444k init
> init started: BusyBox v1.8.0 (2007-11-16 14:24:51 PST)
> starting pid 103, tty '': '/bin/sh'
> Oops: kernel access of bad area, sig: 11 [#1]
> NIP: c0044ed0 LR: c0044ff0 CTR: 00000001
> REGS: c3c0bd00 TRAP: 0300   Not tainted  (2.6.22.9)
> MSR: 00009032 <EE,ME,IR,DR>  CR: 30099099  XER: a0008c7f
> DAR: ff80103f, DSISR: c0000000
> TASK = c0288070[103] 'init' THREAD: c3c0a000
> GPR00: c0044ff0 c3c0bdb0 c0288070 ff800fff 00000000 7faf8000 00000000 
> 00000000
> GPR08: c01a8f58 c017d91c 00000002 c0179cd0 30099093 1007687c 00000002 
> c00f8744
> GPR16: 00000000 c00f0a64 c011d1ac c00f0aa4 c00f0a90 c0120000 00000001 
> 00000003
> GPR24: c3c1ce00 00000000 c0180000 c0247550 00000000 c3c0bdc8 c0179cd0 
> ff800fff
> NIP [c0044ed0] remove_vma+0x14/0x70
> LR [c0044ff0] exit_mmap+0xc4/0xf0
> Call Trace:
> [c3c0bdb0] [c3c0bdc8] 0xc3c0bdc8 (unreliable)
> [c3c0bdc0] [c0044ff0] exit_mmap+0xc4/0xf0
> [c3c0bdf0] [c000f74c] mmput+0x50/0xd4
> [c3c0be00] [c00591f4] flush_old_exec+0x3b8/0x7a8
> [c3c0be50] [c0086cc0] load_elf_binary+0x2e8/0x1454
> [c3c0bee0] [c005892c] search_binary_handler+0x58/0x12c
> [c3c0bf00] [c0059d64] do_execve+0x13c/0x1f0
> [c3c0bf20] [c00089b4] sys_execve+0x50/0x90
> [c3c0bf40] [c0002a40] ret_from_syscall+0x0/0x38
> Instruction dump:
> 7d808120 38210040 4e800020 83c30000 4bffff18 38a00000 4bffff9c 7c0802a6
> 9421fff0 bfc10008 90010014 7c7f1b78 <81230040> 83c3000c 2f890000 419e0018
> 
> The interesting thing is that r3 points to something funny. While tracing 
> this problem down, I replaced the remove_vma function with the following:
> 
> /*
>  * Close a vm structure and free it, returning the next.
>  */
> static struct vm_area_struct * __attribute__((__noinline__)) 
> __remove_vma(struct vm_area_struct *vma)
> {
> 
> 	struct vm_area_struct *next = vma->vm_next;
> 
> 	might_sleep();
> 	if (vma->vm_ops && vma->vm_ops->close)
> 		vma->vm_ops->close(vma);
> 	if (vma->vm_file)
> 		fput(vma->vm_file);
> 	mpol_free(vma_policy(vma));
> 	kmem_cache_free(vm_area_cachep, vma);
> 	return next;
> }
> 
> static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
> {
>         asm volatile (
>                 "lis  4,-128\n"
>                 "ori  4,4,4095\n"
>                 "tweq 3,4\n"
>                 "lwz  5,0(1)\n"
>                 "tweq 3,4\n"
>                 );
>         return __remove_vma( vma );
> }
> 
> With this code, the kernel oopses on the *second* tweq instruction:
> 
> Kernel BUG at c0045fd4 [verbose debug info unavailable]
> Oops: Exception in kernel mode, sig: 5 [#1]
> NIP: c0045fd4 LR: c00460a0 CTR: 00000001
> REGS: c3c0bd10 TRAP: 0700   Not tainted  (2.6.22.9)
> MSR: 00029032 <EE,ME,IR,DR>  CR: 30099099  XER: a0008c7f
> TASK = c0292b40[103] 'init' THREAD: c3c0a000
> GPR00: 00000001 c3c0bdc0 c0292b40 ff800fff ff800fff c3c0bdf0 00000000 
> 00000000
> GPR08: c0219398 c017d91c 00000002 c0179cd0 30099093 1007687c 00000002 
> c00f8744
> GPR16: 00000000 c00f0a64 c011d1ac c00f0aa4 c00f0a90 c0120000 00000001 
> 00000003
> GPR24: c3c32e00 00000000 c0180000 c0247080 00000000 c3c0bdc8 c0179cd0 
> c017641c
> NIP [c0045fd4] remove_vma+0x10/0x18
> LR [c00460a0] exit_mmap+0xc4/0xf0
> Call Trace:
> [c3c0bdc0] [c0046074] exit_mmap+0x98/0xf0 (unreliable)
> [c3c0bdf0] [c000f74c] mmput+0x50/0xd4
> [c3c0be00] [c005920c] flush_old_exec+0x3b8/0x7a8
> [c3c0be50] [c0086cd8] load_elf_binary+0x2e8/0x1454
> [c3c0bee0] [c0058944] search_binary_handler+0x58/0x12c
> [c3c0bf00] [c0059d7c] do_execve+0x13c/0x1f0
> [c3c0bf20] [c00089b4] sys_execve+0x50/0x90
> [c3c0bf40] [c0002a40] ret_from_syscall+0x0/0x38
> Instruction dump:
> 7fe4fb78 4800a0ed 80010014 7fc3f378 7c0803a6 bbc10008 38210010 4e800020
> 3c80ff80 60840fff 7c832008 80a10000 <7c832008> 4bffff7c 7c0802a6 9421ffd0
> 
> The access of memory through r1 seems to corrupt r3, and always with the 
> same value. The problem isn't necessarily here, though. If I modify my 
> remove_vma function to cause and correct the problem (by saving r3 prior 
> to the memory access and restoring it afterwards), I just get the same 
> problem in some other part of the code, but the oops is always caused 
> because the base register for some memory access is set to ff800fff.
> 
> I applied a recent patch I found that corrects the address returned by 
> cpm_dpram_addr and its use in cpu_uart_cpm1.h, and I've created my own 
> platform setup file by copying the mpc866ads setup enough to get the 
> console uart (SMC1) to work.
> 
> If there is any other information I can or need to provide, let me 
> know. Any help would be greatly appreciated.
> 
> Thanks,
> John

-- 
John Tyner
jtyner@cs.ucr.edu
