Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ua0-x22d.google.com (mail-ua0-x22d.google.com
 [IPv6:2607:f8b0:400c:c08::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJVdK6cdTzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 19:50:29 +1000 (AEST)
Received: by mail-ua0-x22d.google.com with SMTP id z47so4795565uaz.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 02:50:29 -0700 (PDT)
MIME-Version: 1.0
From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Date: Thu, 4 May 2017 11:50:06 +0200
Message-ID: <CA+7wUsyo5HEVrNFGaH0WGB5WTatX7R7t_s2XhcbZ3kSDsAh2hA@mail.gmail.com>
Subject: WARNING: CPU: 0 PID: 1 at
 /build/linux-dp17Ba/linux-4.9.18/arch/powerpc/lib/feature-fixups.c:208
 check_features+0x38/0x7c
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: "Linux User #330250" <linuxuser330250@gmx.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Does this dmesg output speaks to anyone here (smp kernel):


[    4.767389] ------------[ cut here ]------------
[    4.774668] WARNING: CPU: 0 PID: 1 at
/build/linux-dp17Ba/linux-4.9.18/arch/powerpc/lib/feature-fixups.c:208
check_features+0x38/0x7c
[    4.782256] Modules linked in:
[    4.789766] CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.0-2-powerpc
#1 Debian 4.9.18-1
[    4.797441] task: df4db1a0 task.stack: df4dc000
[    4.805089] NIP: c0776484 LR: c0776484 CTR: 00000000
[    4.812736] REGS: df4dddd0 TRAP: 0700   Not tainted
(4.9.0-2-powerpc Debian 4.9.18-1)
[    4.820485] MSR: 00029032 <EE,ME,IR,DR,RI>
[    4.820622]   CR: 242ff422  XER: 00000000
[ 4.828326]
[    4.828326] GPR00: c0776484 df4dde80 df4db1a0 0000002c 00000004
000000ff ffffffff 000000ff
[    4.828326] GPR08: 000000ff c085271c c085271c 00000000 222ff444
00000000 c00047ec 00000000
[    4.828326] GPR16: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 c0860000
[    4.828326] GPR24: c076ecdc c07d2e80 c0766720 c07b2310 00000000
c085f5b0 c0860000 c07b0000
NIP [c0776484] check_features+0x38/0x7c
[    4.875135] LR [c0776484] check_features+0x38/0x7c
[    4.882958] Call Trace:
[    4.890751] [df4dde80] [c0776484] check_features+0x38/0x7c (unreliable)
[    4.898650] [df4dde90] [c0004154] do_one_initcall+0x4c/0x188
[    4.906477] [df4ddf00] [c076f578] kernel_init_freeable+0x164/0x200
[    4.914269] [df4ddf30] [c0004810] kernel_init+0x24/0x134
[    4.921942] [df4ddf40] [c0016500] ret_from_kernel_thread+0x5c/0x64
[    4.929536] Instruction dump:
[    4.937046] bfc10008 90010014 3fc0c086 811ef028 3fe0c07b 80ff349c
8108000c 7f883800
41be0014 3c60c06b 38632f34 4be5f601 <0fe00000> 815ef028 3bff349c 813f0004
[    4.952413] ---[ end trace de3271b83777a44e ]---


>From a non smp kernel:


[    0.000000] Total memory = 512MB; using 1024kB for hash table (at cff00000)
[    0.000000] Linux version 4.9.0-2-powerpc
(debian-kernel@lists.debian.org) (gcc version 6.3.0 20170321 (Debian
6.3.0-11) ) #1 Debian 4.9.18-1 (2017-03-30)
[    0.000000] Found initrd at 0xc0c40000:0xc19744bc
[    0.000000] Found UniNorth memory controller & host bridge @
0xf8000000 revision: 0x11
[    0.000000] Mapped at 0xff7c0000
[    0.000000] Found a Keylargo mac-io controller, rev: 3, mapped at 0xff740000
[    0.000000] PowerMac motherboard: PowerMac G4 Silver
[    0.000000] Using PowerMac machine description


Thanks
