Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.192])
	by ozlabs.org (Postfix) with ESMTP id BEEFF681C6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 11:49:33 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i13so236507wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 18:49:31 -0700 (PDT)
Message-ID: <c3d0340b0508311849654fcdad@mail.gmail.com>
Date: Wed, 31 Aug 2005 18:49:31 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Machine check - D-Cache search parity error occurs on a ppc440 core
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

When the kernel starts /sbin/init, a machine check occurs showing it's
a d-cache search parity error. The CPU is a ppc440 core.

What usually causes this kind of exception? The user's manual of 440
core lists three possible situation where such an exception will
occur.
1) Multi-hit parity error on any instr that does a CAM lookup
2) Tag or data parity errors on load instr
3) Tag parity erros on dcbf, dcbi, dcbst instr

Both 1) and 3) are excluded in this case because the internal cpu core
signals show dcrTagEvenSearchParityError is set. Why did this error
happen? It's a cpu bug?

Anyone has seen this error before? Please share your experience.

RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 72k init
Machine check in kernel mode.
D-Cache Search Parity Error
Oops: machine check, sig: 7 [#1]
NIP: C0000D20 LR: 30001BA8 SP: 7FFFFC80 REGS: c00e5f50 TRAP: 0202    Not ta=
inted
MSR: 00021000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK =3D c016cab0[1] 'init' THREAD: c1fca000
Last syscall: 11=20
GPR00: 00000001 7FFFFC80 00000000 00000000 AAAA0000 30025160 30024B18 00000=
DF8=20
GPR08: 30024B80 0000012A 0000037E 30000AC8 00000254 00000000 02004D00 00000=
000=20
GPR16: 00000000 00000001 FFFFFFFF 01FFDF58 00000000 007FFF00 00000003 7FFFF=
F10=20
GPR24: 00000002 7FFFFC90 300002C4 7FFFFC88 3000195C 30000000 C00011C8 30001=
8C0=20
NIP [c0000d20] DataTLBError+0x0/0xa0
LR [30001ba8] 0x30001ba8
Kernel panic - not syncing: Attempted to kill init!

Best regards,
-Shawn.
