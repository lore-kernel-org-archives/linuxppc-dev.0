Return-Path: <vova-ks@yandex.ru>
Received: from dgap-gw.mipt.ru (dgap-gw.mipt.ru [194.85.81.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.dgap.mipt.ru",
	Issuer "DGAP Root Certificate" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 114192BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Nov 2004 06:23:49 +1100 (EST)
Received: from unknown (HELO localhost) ([127.0.0.1])
	(envelope-sender <vova-ks@yandex.ru>)
	by 127.0.0.1 (qmail-ldap-1.03) with SMTP
	for <linuxppc-embedded@ozlabs.org>; 2 Nov 2004 19:23:44 -0000
Received: from dgap-gw.mipt.ru ([127.0.0.1])
	by localhost (dgap-gw.mipt.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27593-03 for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Nov 2004 22:23:44 +0300 (MSK)
From: Vladimir <vova-ks@yandex.ru>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 2 Nov 2004 22:24:11 +0300
References: <200411020354.39610.vova-ks@yandex.ru>
In-Reply-To: <200411020354.39610.vova-ks@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411022224.11540.vova-ks@yandex.ru>
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

On Tuesday 02 November 2004 03:54, Vladimir wrote:
> Hello All !
> I'm trying to run linux (2.4.22) on embedded PowerPC (405GP). It boots
> nice, but when it tries to execute /sbin/init it hangs. Last console
> messages are:
>
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 56k init 4k prep
>
> I've tried to replace /sbin/init by my own executable - it's definitely
> have not been executed.
> I've traced it to the "last point" in kernel-mode (instruction rfi in file
> arch/ppc/kernel/entry.S:389). Before this point everything is all right.
> But after this instruction kernel just hangs.
> After this sysrq-t prints that process init are running at c0007190 (this
> is in the arch_kernel_thread).
> sysrq-p does not print any registers, just the line "SysRq : Show Regs".
>
> Could someone give me any tips how to fix this trouble ?

Hello All !
I've tried linux 2.6.8.1 and it gives me the following oops:

VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 68k init
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C00C032C LR: C00C0518 SP: C3F87D90 REGS: c3f87ce0 TRAP: 0300    Not 
tainted
MSR: 00029230 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 00000000
TASK = c3f859c0[1] 'init' THREAD: c3f86000Last syscall: 5
PLB0: bear= 0x00a2f48e acr=   0x00000000 besr=  0x00000000
PLB0 to OPB: bear= 0x0a201000 besr0= 0x00000000 besr1= 0x00000000

GPR00: 00000000 C3F87D90 C3F859C0 00000000 00000001 00000000 C027EF50 C3FED0D0
GPR08: 00000080 00000000 C027EE00 C027EE00 22000022 1001F0B8 03FE3200 007FFF2B
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDE850 00000000 03F9FE88 00000001
GPR24: 00000102 10005844 C01D1410 00000001 00000000 C01D1794 00000000 00000000
NIP [c00c032c] visual_init+0xa0/0x1c4
LR [c00c0518] vc_allocate+0xc8/0x150
Call trace:
 [c00c0518] vc_allocate+0xc8/0x150
 [c00c42c0] con_open+0x50/0xc0
 [c00b200c] tty_open+0x2a4/0x548
 [c0057c44] chrdev_open+0xf0/0x184
 [c004cc74] dentry_open+0x164/0x26c
 [c004cb0c] filp_open+0x68/0x6c
 [c004d030] sys_open+0x68/0xa0
 [c0004540] ret_from_syscall+0x0/0x48
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..

-- 
         Vladimir
