Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 017BF2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Nov 2004 09:17:42 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 2 Nov 2004 15:17:37 -0700
To: Vladimir <vova-ks@yandex.ru>, linuxppc-embedded@ozlabs.org
Message-ID: <20041102221737.GA28292@xyzzy>
References: <200411020354.39610.vova-ks@yandex.ru>
	<200411022224.11540.vova-ks@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200411022224.11540.vova-ks@yandex.ru>
Cc: 
Subject: Re: Problem with user-space programs on 405GP: linux 2.6 oops
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I suspect you're missing this patch, which is in the current tree.

-Dale

===== setup.c 1.59 vs 1.60 =====
--- 1.59/arch/ppc/kernel/setup.c	2004-07-26 15:27:53 -07:00
+++ 1.60/arch/ppc/kernel/setup.c	2004-08-16 09:04:08 -07:00
@@ -744,6 +744,10 @@
 	if ( ppc_md.progress ) ppc_md.progress("ocp: exit", 0x3eab);
 #endif
 
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+
 	ppc_md.setup_arch();
 	if ( ppc_md.progress ) ppc_md.progress("arch: exit", 0x3eab);

 
On Tue, Nov 02, 2004 at 07:24:11PM +0000, Vladimir wrote:
> On Tuesday 02 November 2004 03:54, Vladimir wrote:
> > Hello All !
> > I'm trying to run linux (2.4.22) on embedded PowerPC (405GP). It boots
> > nice, but when it tries to execute /sbin/init it hangs. Last console
> > messages are:
> >
> > VFS: Mounted root (nfs filesystem).
> > Freeing unused kernel memory: 56k init 4k prep
> >
> > I've tried to replace /sbin/init by my own executable - it's definitely
> > have not been executed.
> > I've traced it to the "last point" in kernel-mode (instruction rfi in file
> > arch/ppc/kernel/entry.S:389). Before this point everything is all right.
> > But after this instruction kernel just hangs.
> > After this sysrq-t prints that process init are running at c0007190 (this
> > is in the arch_kernel_thread).
> > sysrq-p does not print any registers, just the line "SysRq : Show Regs".
> >
> > Could someone give me any tips how to fix this trouble ?
> 
> Hello All !
> I've tried linux 2.6.8.1 and it gives me the following oops:
> 
> VFS: Mounted root (nfs filesystem) readonly.
> Freeing unused kernel memory: 68k init
> Oops: kernel access of bad area, sig: 11 [#1]
> NIP: C00C032C LR: C00C0518 SP: C3F87D90 REGS: c3f87ce0 TRAP: 0300    Not 
> tainted
> MSR: 00029230 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 00000000, DSISR: 00000000
> TASK = c3f859c0[1] 'init' THREAD: c3f86000Last syscall: 5
> PLB0: bear= 0x00a2f48e acr=   0x00000000 besr=  0x00000000
> PLB0 to OPB: bear= 0x0a201000 besr0= 0x00000000 besr1= 0x00000000
> 
> GPR00: 00000000 C3F87D90 C3F859C0 00000000 00000001 00000000 C027EF50 C3FED0D0
> GPR08: 00000080 00000000 C027EE00 C027EE00 22000022 1001F0B8 03FE3200 007FFF2B
> GPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDE850 00000000 03F9FE88 00000001
> GPR24: 00000102 10005844 C01D1410 00000001 00000000 C01D1794 00000000 00000000
> NIP [c00c032c] visual_init+0xa0/0x1c4
> LR [c00c0518] vc_allocate+0xc8/0x150
> Call trace:
>  [c00c0518] vc_allocate+0xc8/0x150
>  [c00c42c0] con_open+0x50/0xc0
>  [c00b200c] tty_open+0x2a4/0x548
>  [c0057c44] chrdev_open+0xf0/0x184
>  [c004cc74] dentry_open+0x164/0x26c
>  [c004cb0c] filp_open+0x68/0x6c
>  [c004d030] sys_open+0x68/0xa0
>  [c0004540] ret_from_syscall+0x0/0x48
> Kernel panic: Attempted to kill init!
>  <0>Rebooting in 180 seconds..
