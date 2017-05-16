Return-Path: <breno.debian@gmail.com>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wS2cd4YVczDqFy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 02:16:01 +1000 (AEST)
Received: by mail-qk0-f193.google.com with SMTP id k74so23559749qke.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 09:16:01 -0700 (PDT)
Date: Tue, 16 May 2017 13:15:55 -0300
From: Breno Leitao <leitao@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, gromero@br.ibm.com
Subject: Re: kernel BUG at mm/usercopy.c:72!
Message-ID: <20170516161554.GA8719@gmail.com>
References: <20170515191949.GA13641@gmail.com>
 <87bmqtoyii.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87bmqtoyii.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 16, 2017 at 09:02:29PM +1000, Michael Ellerman wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
> > Hello,
> >
> > Kernel 4.12-rc1 is showing a bug when I try it on a POWER8 virtual
> > machine. Justing SSHing into the machine causes this issue.
> >
> > 	[23.138124] usercopy: kernel memory overwrite attempt detected to d000000003d80030 (mm_struct) (560 bytes)
> > 	[23.138195] ------------[ cut here ]------------
> > 	[23.138229] kernel BUG at mm/usercopy.c:72!
> > 	[23.138252] Oops: Exception in kernel mode, sig: 5 [#3]
> > 	[23.138280] SMP NR_CPUS=2048 
> > 	[23.138280] NUMA 
> > 	[23.138302] pSeries
> > 	[23.138330] Modules linked in:
> > 	[23.138354] CPU: 4 PID: 2215 Comm: sshd Tainted: G      D         4.12.0-rc1+ #9
> > 	[23.138395] task: c0000001e272dc00 task.stack: c0000001e27b0000
> > 	[23.138430] NIP: c000000000342358 LR: c000000000342354 CTR: c0000000006eb060
> > 	[23.138472] REGS: c0000001e27b3a00 TRAP: 0700   Tainted: G      D          (4.12.0-rc1+)
> > 	[23.138513] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>
> > 	[23.138517]   CR: 28004222  XER: 20000000
> > 	[23.138565] CFAR: c000000000b34500 SOFTE: 1 
> > 	[23.138565] GPR00: c000000000342354 c0000001e27b3c80 c00000000142a000 000000000000005e 
> > 	[23.138565] GPR04: c0000001ffe0ade8 c0000001ffe21bf8 2920283536302062 79746573290d0a74 
> > 	[23.138565] GPR08: 0000000000000007 c000000000f61864 00000001feeb0000 3064206f74206465 
> > 	[23.138565] GPR12: 0000000000004400 c00000000fb42600 0000000000000015 00000000545bdc40 
> > 	[23.138565] GPR16: 00000000545c49c8 000001000b4b8890 00007ffff78c26f0 00000000545cf000 
> > 	[23.138565] GPR20: 00000000546109c8 000000000000c7e8 0000000054610010 00007ffff78c22e8 
> > 	[23.138565] GPR24: 00000000545c8c40 c0000000ff6bcef0 c0000000001e5220 0000000000000230 
> > 	[23.138565] GPR28: d000000003d80260 0000000000000000 0000000000000230 d000000003d80030 
> > 	[23.138920] NIP [c000000000342358] __check_object_size+0x88/0x2d0
> > 	[23.138956] LR [c000000000342354] __check_object_size+0x84/0x2d0
> > 	[23.138990] Call Trace:
> > 	[23.139006] [c0000001e27b3c80] [c000000000342354] __check_object_size+0x84/0x2d0 (unreliable)
> > 	[23.139056] [c0000001e27b3d00] [c0000000009f5ba8] bpf_prog_create_from_user+0xa8/0x1a0
> > 	[23.139099] [c0000001e27b3d60] [c0000000001e5d30] do_seccomp+0x120/0x720
> > 	[23.139136] [c0000001e27b3dd0] [c0000000000fd53c] SyS_prctl+0x2ac/0x6b0
> > 	[23.139172] [c0000001e27b3e30] [c00000000000af84] system_call+0x38/0xe0
> > 	[23.139218] Instruction dump:
> > 	[23.139240] 60000000 60420000 3c82ff94 3ca2ff9d 38841788 38a5e868 3c62ff95 7fc8f378 
> > 	[23.139283] 7fe6fb78 386310c0 487f2169 60000000 <0fe00000> 60420000 2ba30010 409d018c 
> > 	[23.139328] ---[ end trace 1a1dc952a4b7c4af ]---
> 
> Do you have any idea what is calling seccomp() and triggering the bug?

This bug is hit using several path, not only via seccomp. This is
another path, via vfs_read, that triggers the bug:

	[  370.154307] usercopy: kernel memory exposure attempt detected from d000000003d6007c (vm_area_struct) (6 bytes)
	[  370.154373] ------------[ cut here ]------------
	[  370.154402] kernel BUG at mm/usercopy.c:72!                                                                    
	[  370.154425] Oops: Exception in kernel mode, sig: 5 [#4]
	<snip>
	[370.155220] [c0000001d30efab0] [c000000000342354] __check_object_size+0x84/0x2b0 (unreliable)
	[370.155272] [c0000001d30efb30] [c0000000006c96cc] copy_from_read_buf+0xac/0x1e0
	[370.155315] [c0000001d30efba0] [c0000000006ccbc4] n_tty_read+0x324/0x920
	[370.155351] [c0000001d30efcb0] [c0000000006c4c50] tty_read+0xc0/0x180                                          
	[370.155387] [c0000001d30efd00] [c000000000347f64] __vfs_read+0x44/0x1a0
	[370.155424] [c0000001d30efd90] [c0000000003499ac] vfs_read+0xbc/0x1b0
	[370.155460] [c0000001d30efde0] [c00000000034b6f8] SyS_read+0x68/0x110
	[370.155497] [c0000001d30efe30] [c00000000000af84] system_call+0x38/0xe0

Anyway, I see the seccomp() path issue when I log into the system using SSH,
and the issue with tty_read() just during the system boot.

> I run the BPF and seccomp test suites, and I haven't seen this.

Do you have the hardening options enabled? For example, I do not
reproduce this problem if I do not set CONFIG_HARDENED_USERCOPY=y.
