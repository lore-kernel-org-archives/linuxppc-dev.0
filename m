Message-ID: <607BF0A2B4F3D411A09500508BC225427E8349@mailctx.datum.com>
From: Geoff Wyche <GWyche@DATUM.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: linuxppc kernel crash -- suggestions?
Date: Thu, 8 Nov 2001 13:35:31 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I've got a linuxppc_2_4 (rather current) kernel running on an MPC860T with
16MB ram.

While attempting to boot with a rootfs via NFS, I received this oops:

Oops: kernel access of bad area, sig: 11
NIP: C0028A18 XER: 00000000 LR: C00289C8 SP: C0FADEE0 REGS: c0fade30 TRAP:
0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: C0FAE030, DSISR: 82000000
TASK = c0fac000[1] 'swapper' Last syscall: -1
last math 00000000 last altivec 00000000
GPR00: 00000000 C0FADEE0 C0FAC000 C0FAE020 00001032 C011F524 00000001
00000FAE
GPR08: 00000000 C0FAE0B0 000000F8 00000000 22008042 100D7944 00FE3100
007FFF30
GPR16: 00000001 00000000 FFFFFFFF 007FFF00 00FDD6BC 00000000 00F9FE90
00000002
GPR24: 00000000 00FE40A4 00000001 C0FADEE8 000001F0 000000B0 C0FAE000
C015C270
Call backtrace:
C00289C8 C0028EA8 C00529F4 C0052C40 C0015954 C00159A0 C012B394
C01297A0 C000259C C0004E50
Kernel panic: Attempted to kill init!

I've tracked down some of the backtrace:

(crash) <- kmem_cache_grow <- kmem_cache_free \
<- kmalloc <- proc_create <- register_proc_table <- uid_cache_init <-
do_basic_setup <- init

What typical problem would cause this... Is this what happens when the
kernel runs out of memory during init?

--Geoff
gwyche@datum.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
