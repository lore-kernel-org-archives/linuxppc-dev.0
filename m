Return-Path: <youngchul@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.197])
	by ozlabs.org (Postfix) with ESMTP id EA39C679E8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 May 2005 12:26:47 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 18so1916501nzp
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 May 2005 19:26:46 -0700 (PDT)
Message-ID: <ae4314c505052319206a37c6ed@mail.gmail.com>
Date: Tue, 24 May 2005 11:20:06 +0900
From: =?EUC-KR?Q?Youngchul_Bang_=28=B9=E6=BF=B5=C3=B6=29?=
	<youngchul@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: swapon swapfile on Bamboo board
Reply-To: =?EUC-KR?Q?Youngchul_Bang_=28=B9=E6=BF=B5=C3=B6=29?=
	<youngchul@gmail.com>
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

I'm tring to use a swapfile on Bamboo reference board.  I got some of
messages.  Is it a kernel BUG?

I'm using kernel 2.6.11.8, which patched [1]"PPC440EP SoC and Bamboo
board support".
[1] http://ozlabs.org/pipermail/linuxppc-embedded/2005-April/017648.html

Commands to use a swapfile are following:
/# dd if=3D/dev/zero of=3Dswapfile bs=3D1024 count=3D65536
65536+0 records in
65536+0 records out
67108864 bytes transferred in 82.371510 seconds (814710 bytes/sec)
/# mkswap swapfile                                               =20
Setting up swapspace version 1, size =3D 67104 kB                          =
      =20
no label, UUID=3Ddaed5412-feb7-42ed-a925-f80e1c7782fb                      =
      =20
/# swapon swapfile                                               =20
kernel BUG in swp_entry_to_pte at include/linux/swapops.h:67!              =
    =20
Oops: Exception in kernel mode, sig: 5 [#1]                                =
    =20
PREEMPT                                                                    =
    =20
NIP: C00562A0 LR: C0056284 SP: C0D59EE0 REGS: c0d59e30 TRAP: 0700    Not ta=
inted
MSR: 00029000 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 00                            =
    =20
TASK =3D c1c30430[928] 'swapon' THREAD: c0d58000                           =
      =20
Last syscall: 87                                                           =
    =20
GPR00: 00000400 C0D59EE0 C1C30430 00000000 00000001 0000000A C021B875 C033A=
C10 =20
GPR08: 00000001 010B6000 C1087258 C02D0000 00004000 1001BAA4 100C0000 100A0=
000 =20
GPR16: 00000000 100DC368 C02E0000 00000000 00000001 C1882000 C0C8EC20 00000=
000 =20
GPR24: C10871B4 C030A7C0 00004000 04000000 FFFFFFEA C10B6000 C02D8ABC C10B6=
FF6 =20
NIP [c00562a0] sys_swapon+0x588/0xa04                                      =
    =20
LR [c0056284] sys_swapon+0x56c/0xa04                                       =
    =20
Call trace:                                                                =
    =20
 [c0001a88] ret_from_syscall+0x0/0x48                                      =
    =20
Trace/breakpoint trap                                                      =
    =20
/# =20

Let me know what problem is.

Thanks in advice,

Youngchul.
