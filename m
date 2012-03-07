Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6FA9AB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 14:49:55 +1100 (EST)
Message-ID: <1331092190.3105.3.camel@pasglop>
Subject: Re: [PATCH] spufs raises two exceptions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: masterzorag <masterzorag@gmail.com>
Date: Wed, 07 Mar 2012 14:49:50 +1100
In-Reply-To: <4F55D84B.7030306@gmail.com>
References: <4F55D84B.7030306@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-03-06 at 10:26 +0100, masterzorag wrote:
> I'm running my test program, it uses all available spus to compute via 
> OpenCL
> kernel 3.2.5 on a ps3
> even on testing spu directly, it crashes

I think the patch is not 100% right yet. Looking at the code, we
have a real mess of who gets to clean what up here. This is an
attempt at sorting things by having the mutex and dentry dropped
in spufs_create() always. Can you give it a spin (untested):

Al, I'm not familiar with the vfs, can you take a quick look ?

Thanks !

Cheers,
Ben.


> 
> =====================================
> [ BUG: bad unlock balance detected! ]
> -------------------------------------
> test/1067 is trying to release lock (&sb->s_type->i_mutex_key) at:
> [<d0000000005828a8>] .do_spu_create+0x90/0xd8 [spufs]
> but there are no more locks to release!
> other info that might help us debug this:
> no locks held by test/1067.
> stack backtrace:
> Call Trace:
> [c00000000e9bfa30] [c0000000000110d0] .show_stack+0x6c/0x16c (unreliable)
> [c00000000e9bfae0] [c000000000081f90] .print_unlock_inbalance_bug+0xe8/0x110
> [c00000000e9bfb70] [c0000000000868cc] .lock_release+0xd8/0x200
> [c00000000e9bfc10] [c0000000003efb60] .__mutex_unlock_slowpath+0x11c/0x1d8
> [c00000000e9bfcb0] [d0000000005828a8] .do_spu_create+0x90/0xd8 [spufs]
> [c00000000e9bfd70] [c0000000000346ac] .sys_spu_create+0x164/0x1c0
> [c00000000e9bfe30] [c0000000000097d8] syscall_exit+0x0/0x40
> ------------[ cut here ]------------
> kernel BUG at fs/dcache.c:474!
> Oops: Exception in kernel mode, sig: 5 [#1]
> SMP NR_CPUS=2 NUMA PS3
> Modules linked in: spufs dm_mod btusb bluetooth usb_storage ohci_hcd 
> snd_ps3 ehci_hcd snd_pcm snd_page_alloc snd_timer sg snd usbcore 
> usb_common ps3flash rtc_ps3 soundcore ps3_lpm ps3vram [last unloaded: 
> scsi_wait_scan]
> NIP: c000000000109f94 LR: c000000000109f84 CTR: c0000000000a029c
> REGS: c00000000e9bf930 TRAP: 0700 Not tainted (3.2.5)
> MSR: 8000000000028032 <EE,CE,IR,DR> CR: 22004822 XER: 00000000
> TASK = c0000000062f0ec0[1067] 'test' THREAD: c00000000e9bc000 CPU: 1
> GPR00: 0000000000000001 c00000000e9bfbb0 c0000000006812e8 c00000000543b798
> GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000002
> GPR08: 0000000000000000 0000000000000000 c000000000109f84 c0000000062f0ec0
> GPR12: 0000000082004824 c000000007ffe280 0000000000000004 00000000f7850688
> GPR16: 00000000f7830734 00000000f78517a4 00000000f7852008 00000000f78517a8
> GPR20: 00000000ff805dc0 000000000fd958a0 0000000000000000 000000000000000d
> GPR24: 000000000fd98240 c00000000e101e10 0000000040000010 c00000000616e080
> GPR28: c00000000543b738 c00000000543b798 c0000000006149e8 c00000000543b738
> NIP [c000000000109f94] .dput+0x48/0x214
> LR [c000000000109f84] .dput+0x38/0x214
> Call Trace:
> [c00000000e9bfbb0] [c000000000109f84] .dput+0x38/0x214 (unreliable)
> [c00000000e9bfc50] [c0000000000f1740] .fput+0x24c/0x288
> [c00000000e9bfd00] [c0000000000ed708] .filp_close+0xbc/0xe4
> [c00000000e9bfd90] [c0000000000ed800] .SyS_close+0xd0/0x128
> [c00000000e9bfe30] [c0000000000097d8] syscall_exit+0x0/0x40
> Instruction dump:
> fb61ffd8 fb81ffe0 fba1ffe8 f821ff61 418201c8 3bbf0060 7fa3eb78 482e7f31
> 60000000 813f0058 7d200074 7800d182 <0b000000> 2b890001 409d0010 3809ffff
> ---[ end trace c337aad05d94532f ]---
> ------------[ cut here ]------------
> kernel BUG at fs/dcache.c:474!
> Oops: Exception in kernel mode, sig: 5 [#2]
> SMP NR_CPUS=2 NUMA PS3
> Modules linked in: spufs dm_mod btusb bluetooth usb_storage ohci_hcd 
> snd_ps3 ehci_hcd snd_pcm snd_page_alloc snd_timer sg snd usbcore 
> usb_common ps3flash rtc_ps3 soundcore ps3_lpm ps3vram [last unloaded: 
> scsi_wait_scan]
> NIP: c000000000109f94 LR: c000000000109f84 CTR: c0000000000a029c
> REGS: c00000000e9bec20 TRAP: 0700 Tainted: G D (3.2.5)
> MSR: 8000000000028032 <EE,CE,IR,DR> CR: 22004822 XER: 00000000
> TASK = c0000000062f0ec0[1067] 'test' THREAD: c00000000e9bc000 CPU: 1
> GPR00: 0000000000000001 c00000000e9beea0 c0000000006812e8 c0000000054361c8
> GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000002
> GPR08: 0000000000000000 0000000000000000 c000000000109f84 c0000000062f0ec0
> GPR12: 0000000042004824 c000000007ffe280 0000000000000004 00000000f7850688
> GPR16: 00000000f7830734 00000000f78517a4 00000000f7852008 00000000f78517a8
> GPR20: 00000000ff805dc0 000000000fd958a0 0000000000000000 0000000000000001
> GPR24: 000000000fd98240 c00000000e9b2390 0000000000000008 c0000000062bd010
> GPR28: c000000005436168 c0000000054361c8 c0000000006149e8 c000000005436168
> NIP [c000000000109f94] .dput+0x48/0x214
> LR [c000000000109f84] .dput+0x38/0x214
> Call Trace:
> [c00000000e9beea0] [c000000000109f84] .dput+0x38/0x214 (unreliable)
> [c00000000e9bef40] [c0000000000f1740] .fput+0x24c/0x288
> [c00000000e9beff0] [c0000000000c93a8] .remove_vma+0x68/0xcc
> [c00000000e9bf080] [c0000000000c951c] .exit_mmap+0x110/0x14c
> [c00000000e9bf1a0] [c00000000004b4c8] .mmput+0x5c/0x13c
> [c00000000e9bf230] [d00000000058237c] .spu_forget+0x54/0x7c [spufs]
> [c00000000e9bf2c0] [d00000000057c294] .spufs_dir_close+0x8c/0xc8 [spufs]
> [c00000000e9bf370] [c0000000000f166c] .fput+0x178/0x288
> [c00000000e9bf420] [c0000000000ed708] .filp_close+0xbc/0xe4
> [c00000000e9bf4b0] [c000000000050294] .put_files_struct+0xf4/0x1b8
> [c00000000e9bf560] [c0000000000520bc] .do_exit+0x23c/0x6f4
> [c00000000e9bf660] [c00000000001922c] .die+0x274/0x2a4
> [c00000000e9bf700] [c000000000019640] ._exception+0x88/0x17c
> [c00000000e9bf8c0] [c000000000005314] program_check_common+0x114/0x180
> --- Exception: 700 at .dput+0x48/0x214
> LR = .dput+0x38/0x214
> [c00000000e9bfc50] [c0000000000f1740] .fput+0x24c/0x288
> [c00000000e9bfd00] [c0000000000ed708] .filp_close+0xbc/0xe4
> [c00000000e9bfd90] [c0000000000ed800] .SyS_close+0xd0/0x128
> [c00000000e9bfe30] [c0000000000097d8] syscall_exit+0x0/0x40
> Instruction dump:
> fb61ffd8 fb81ffe0 fba1ffe8 f821ff61 418201c8 3bbf0060 7fa3eb78 482e7f31
> 60000000 813f0058 7d200074 7800d182 <0b000000> 2b890001 409d0010 3809ffff
> ---[ end trace c337aad05d945330 ]---
> Fixing recursive fault but reboot is needed!
> 
> First time, the mutex gets unlocked in spufs_create_context, then the 
> second time in do_spu_create.
> It seems that SPU main directory dentry has invalid d_count.
> 
> 
> This patch fixes all, OpenCL is running fine, testing spe runs without 
> issues.
> 
> --- arch/powerpc/platforms/cell/spufs/syscalls.c
> +++ arch/powerpc/platforms/cell/spufs/syscalls.c.new
> @@ -70,8 +70,8 @@
>       ret = PTR_ERR(dentry);
>       if (!IS_ERR(dentry)) {
>           ret = spufs_create(&path, dentry, flags, mode, neighbor);
> -        mutex_unlock(&path.dentry->d_inode->i_mutex);
> -        dput(dentry);
> +        if (ret < 0)
> +            dput(dentry);
>           path_put(&path);
>       }
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
