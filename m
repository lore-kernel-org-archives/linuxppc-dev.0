Return-Path: <skrishnakar@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DE7A3B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 23:22:51 +1000 (EST)
MIME-Version: 1.0
Date: Thu, 6 Aug 2009 18:46:26 +0530
Message-ID: <6213bc560908060616m540e20e9o17a26e36662f63d8@mail.gmail.com>
Subject: PowerPC kernel linux-2.6.29.6 crashes at mm/slab.c for ipsec
	application
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0016e6471a8e53c286047078ed5c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6471a8e53c286047078ed5c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

Here is kernel bug for linux-2.6.29.6 for PowerPC (ppc440) target, while
running ipsec application it is observed that kernel oops'es oftenly as show
below :

root@powerpc:~# ./ipsec
------------[ cut here ]------------
kernel BUG at mm/slab.c:3002!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT LTT NESTING LEVEL : 0
Xilinx Virtex440
Modules linked in: nls_iso8859_1 nfsd
NIP: c00a1e94 LR: c00a1d3c CTR: 0000000b
REGS: ce8c9d20 TRAP: 0700   Not tainted
(2.6.29.6.xilinx-ml507.0908010910-ipsec)
MSR: 00021000 <ME,CE>  CR: 22024428  XER: 00000005
TASK = cfa2a430[974] 'watchdog' THREAD: ce8c8000
GPR00: 00000028 ce8c9dd0 cfa2a430 cf802ea8 cf9e001c 0000000a cf9e0000 ffffffff
GPR08: 00000d80 00000001 0000000a 00000028 cf802ea0 1002b58c c0547bd0 c0547bd4
GPR16: c0547ba0 c050dd78 c050e60c 000000d0 00000000 00200200 00100100 00000001
GPR24: ce8c8034 ce8c8000 00000000 c0520000 00000000 cf802eb0 cf807560 cf809e00
NIP [c00a1e94] cache_alloc_refill+0x138/0x630
LR [c00a1d3c] kmem_cache_alloc+0x80/0xa0
Call Trace:
[ce8c9dd0] [c050e60c] 0xc050e60c (unreliable)
[ce8c9e30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0
[ce8c9e50] [c00534ec] prepare_creds+0x3c/0xcc
[ce8c9e70] [c005382c] copy_creds+0xa0/0x12c
[ce8c9e80] [c00307dc] copy_process+0x1c0/0xe20
[ce8c9ee0] [c00314b8] do_fork+0x7c/0x338
[ce8c9f20] [c00065b4] sys_clone+0x58/0x88
[ce8c9f40] [c000e164] ret_from_syscall+0x0/0x3c
Instruction dump:
2f8a0000 3bac0010 386c0008 409d0104 80cc0000 7f8c3000 419e00e8 81660010
801e001c 7d205810 39200000 7d294914 <0f090000> 7f8b0040 7d455378 409c0074
---[ end trace b098f3001b420338 ]---
note: watchdog[974] exited with preempt_count 1
BUG: scheduling while atomic: watchdog/974/0x10000002
Modules linked in: nls_iso8859_1 nfsd
Call Trace:
[ce8c99e0] [c0006184] show_stack+0x40/0x15c (unreliable)
[ce8c9a10] [c002bab4] __schedule_bug+0x68/0x6c
[ce8c9a20] [c03d5138] schedule+0x2bc/0x36c
[ce8c9a70] [c002bae0] __cond_resched+0x28/0x54
[ce8c9a80] [c03d5304] _cond_resched+0x50/0x58
[ce8c9a90] [c00925c8] __mlock_vma_pages_range+0x84/0x2c4
[ce8c9b20] [c0094084] exit_mmap+0x60/0x1b0
[ce8c9b50] [c002fe64] mmput+0x50/0x114
[ce8c9b60] [c0034120] exit_mm+0x130/0x14c
[ce8c9b90] [c0035db4] do_exit+0xd0/0x6b8
[ce8c9be0] [c000c234] die+0x1b0/0x1b8
[ce8c9c10] [c000c554] _exception+0x1d4/0x2b4
[ce8c9d10] [c000e78c] ret_from_except_full+0x0/0x4c
[ce8c9dd0] [c050e60c] 0xc050e60c
[ce8c9e30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0
[ce8c9e50] [c00534ec] prepare_creds+0x3c/0xcc
[ce8c9e70] [c005382c] copy_creds+0xa0/0x12c
[ce8c9e80] [c00307dc] copy_process+0x1c0/0xe20
[ce8c9ee0] [c00314b8] do_fork+0x7c/0x338
[ce8c9f20] [c00065b4] sys_clone+0x58/0x88
[ce8c9f40] [c000e164] ret_from_syscall+0x0/0x3c
BUG: scheduling while atomic: watchdog/974/0x10000002
Modules linked in: nls_iso8859_1 nfsd
Call Trace:
[ce8c99e0] [c0006184] show_stack+0x40/0x15c (unreliable)
[ce8c9a10] [c002bab4] __schedule_bug+0x68/0x6c
[ce8c9a20] [c03d5138] schedule+0x2bc/0x36c
[ce8c9a70] [c002bae0] __cond_resched+0x28/0x54
[ce8c9a80] [c03d5304] _cond_resched+0x50/0x58
[ce8c9a90] [c00925c8] __mlock_vma_pages_range+0x84/0x2c4
[ce8c9b20] [c0094084] exit_mmap+0x60/0x1b0
[ce8c9b50] [c002fe64] mmput+0x50/0x114
[ce8c9b60] [c0034120] exit_mm+0x130/0x14c
[ce8c9b90] [c0035db4] do_exit+0xd0/0x6b8
[ce8c9be0] [c000c234] die+0x1b0/0x1b8
[ce8c9c10] [c000c554] _exception+0x1d4/0x2b4
[ce8c9d10] [c000e78c] ret_from_except_full+0x0/0x4c
[ce8c9dd0] [c050e60c] 0xc050e60c
[ce8c9e30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0
[ce8c9e50] [c00534ec] prepare_creds+0x3c/0xcc
[ce8c9e70] [c005382c] copy_creds+0xa0/0x12c
[ce8c9e80] [c00307dc] copy_process+0x1c0/0xe20
[ce8c9ee0] [c00314b8] do_fork+0x7c/0x338
[ce8c9f20] [c00065b4] sys_clone+0x58/0x88
[ce8c9f40] [c000e164] ret_from_syscall+0x0/0x3c

root@inson:~#
root@inson:~# ------------[ cut here ]------------
kernel BUG at mm/slab.c:3002!
Oops: Exception in kernel mode, sig: 5 [#2]
PREEMPT LTT NESTING LEVEL : 0
Xilinx Virtex440
Modules linked in: nls_iso8859_1 nfsd
NIP: c00a1e94 LR: c00a1d3c CTR: 0000000a
REGS: ce9cbd20 TRAP: 0700   Tainted: G      D
(2.6.29.6.xilinx-ml507.0908010910-ipsec)
MSR: 00021000 <ME,CE>  CR: 22424848  XER: 00000001
TASK = ce8fe030[1400] 'mvtsd.py' THREAD: ce9ca000
GPR00: 00000028 ce9cbdd0 ce8fe030 cf802ea8 cf9e001c 00000009 cf9e0000 ffffffff
GPR08: 00000d20 00000001 00000009 00000028 cf802ea0 10018a3c c0547bd0 c0547bd4
GPR16: c0547ba0 c050dd78 c050e60c 000000d0 00000000 00200200 00100100 00000001
GPR24: ce9ca034 ce9ca000 00000000 c0520000 00000000 cf802eb0 cf807560 cf809e00
NIP [c00a1e94] cache_alloc_refill+0x138/0x630
LR [c00a1d3c] kmem_cache_alloc+0x80/0xa0
Call Trace:
[ce9cbdd0] [c050e60c] 0xc050e60c (unreliable)
[ce9cbe30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0
[ce9cbe50] [c00534ec] prepare_creds+0x3c/0xcc
[ce9cbe70] [c005382c] copy_creds+0xa0/0x12c
[ce9cbe80] [c00307dc] copy_process+0x1c0/0xe20
[ce9cbee0] [c00314b8] do_fork+0x7c/0x338
[ce9cbf20] [c00065b4] sys_clone+0x58/0x88
[ce9cbf40] [c000e164] ret_from_syscall+0x0/0x3c
Instruction dump:
2f8a0000 3bac0010 386c0008 409d0104 80cc0000 7f8c3000 419e00e8 81660010
801e001c 7d205810 39200000 7d294914 <0f090000> 7f8b0040 7d455378 409c0074
---[ end trace b098f3001b420339 ]---
note: mvtsd.py[1400] exited with preempt_count 1
BUG: scheduling while atomic: mvtsd.py/1400/0x10000002
Modules linked in: nls_iso8859_1 nfsd
Call Trace:
[ce9cb9e0] [c0006184] show_stack+0x40/0x15c (unreliable)
[ce9cba10] [c002bab4] __schedule_bug+0x68/0x6c
[ce9cba20] [c03d5138] schedule+0x2bc/0x36c
[ce9cba70] [c002bae0] __cond_resched+0x28/0x54
[ce9cba80] [c03d5304] _cond_resched+0x50/0x58
[ce9cba90] [c008f074] unmap_vmas+0x4d0/0x698
[ce9cbb20] [c00940ec] exit_mmap+0xc8/0x1b0
[ce9cbb50] [c002fe64] mmput+0x50/0x114
[ce9cbb60] [c0034120] exit_mm+0x130/0x14c
[ce9cbb90] [c0035db4] do_exit+0xd0/0x6b8
[ce9cbbe0] [c000c234] die+0x1b0/0x1b8
[ce9cbc10] [c000c554] _exception+0x1d4/0x2b4
[ce9cbd10] [c000e78c] ret_from_except_full+0x0/0x4c
[ce9cbdd0] [c050e60c] 0xc050e60c
[ce9cbe30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0
[ce9cbe50] [c00534ec] prepare_creds+0x3c/0xcc
[ce9cbe70] [c005382c] copy_creds+0xa0/0x12c
[ce9cbe80] [c00307dc] copy_process+0x1c0/0xe20
[ce9cbee0] [c00314b8] do_fork+0x7c/0x338
[ce9cbf20] [c00065b4] sys_clone+0x58/0x88
[ce9cbf40] [c000e164] ret_from_syscall+0x0/0x3c
BUG: scheduling while atomic: mvtsd.py/1400/0x10000002
Modules linked in: nls_iso8859_1 nfsd
Call Trace:
[ce9cb9e0] [c0006184] show_stack+0x40/0x15c (unreliable)
[ce9cba10] [c002bab4] __schedule_bug+0x68/0x6c
[ce9cba20] [c03d5138] schedule+0x2bc/0x36c
[ce9cba70] [c002bae0] __cond_resched+0x28/0x54
[ce9cba80] [c03d5304] _cond_resched+0x50/0x58
[ce9cba90] [c008f074] unmap_vmas+0x4d0/0x698
[ce9cbb20] [c00940ec] exit_mmap+0xc8/0x1b0
[ce9cbb50] [c002fe64] mmput+0x50/0x114
[ce9cbb60] [c0034120] exit_mm+0x130/0x14c
[ce9cbb90] [c0035db4] do_exit+0xd0/0x6b8
[ce9cbbe0] [c000c234] die+0x1b0/0x1b8
[ce9cbc10] [c000c554] _exception+0x1d4/0x2b4
[ce9cbd10] [c000e78c] ret_from_except_full+0x0/0x4c
[ce9cbdd0] [c050e60c] 0xc050e60c
[ce9cbe30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0
[ce9cbe50] [c00534ec] prepare_creds+0x3c/0xcc
[ce9cbe70] [c005382c] copy_creds+0xa0/0x12c
[ce9cbe80] [c00307dc] copy_process+0x1c0/0xe20
[ce9cbee0] [c00314b8] do_fork+0x7c/0x338
[ce9cbf20] [c00065b4] sys_clone+0x58/0x88
[ce9cbf40] [c000e164] ret_from_syscall+0x0/0x3c
------------[ cut here ]------------
kernel BUG at mm/slab.c:3002!
Oops: Exception in kernel mode, sig: 5 [#3]
PREEMPT LTT NESTING LEVEL : 0
Xilinx Virtex440
Modules linked in: nls_iso8859_1 nfsd
NIP: c00a1e94 LR: c00a1d3c CTR: 00000009
REGS: ce837d20 TRAP: 0700   Tainted: G      D
(2.6.29.6.xilinx-ml507.0908010910-ipsec)
MSR: 00021000 <ME,CE>  CR: 22424428  XER: 00000005
TASK = cfaf5030[970] 'sshd' THREAD: ce836000
GPR00: 00000028 ce837dd0 cfaf5030 cf802ea8 cf9e001c 00000008 cf9e0000 ffffffff
GPR08: 00000ea0 00000001 00000008 00000028 cf802ea0 100639ac c0547bd0 c0547bd4
GPR16: c0547ba0 c050dd78 c050e60c 000000d0 00000000 00200200 00100100 00000001
GPR24: ce836034 ce836000 00000000 c0520000 00000000 cf802eb0 cf807560 cf809e00
NIP [c00a1e94] cache_alloc_refill+0x138/0x630
LR [c00a1d3c] kmem_cache_alloc+0x80/0xa0
Call Trace:
[ce837dd0] [c050e60c] 0xc050e60c (unreliable)
[ce837e30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0
[ce837e50] [c00534ec] prepare_creds+0x3c/0xcc
[ce837e70] [c005382c] copy_creds+0xa0/0x12c
[ce837e80] [c00307dc] copy_process+0x1c0/0xe20
[ce837ee0] [c00314b8] do_fork+0x7c/0x338
[ce837f20] [c00065b4] sys_clone+0x58/0x88
[ce837f40] [c000e164] ret_from_syscall+0x0/0x3c
Instruction dump:
2f8a0000 3bac0010 386c0008 409d0104 80cc0000 7f8c3000 419e00e8 81660010
801e001c 7d205810 39200000 7d294914 <0f090000> 7f8b0040 7d455378 409c0074
---[ end trace b098f3001b42033a ]---
note: sshd[970] exited with preempt_count 1
------------[ cut here ]------------
Badness at kernel/softirq.c:150
NIP: c0038e30 LR: c039ba74 CTR: c037667c
REGS: ce837a00 TRAP: 0700   Tainted: G      D
(2.6.29.6.ml507.0908010910-ipsec)
MSR: 00021000 <ME,CE>  CR: 22424442  XER: 20000005
TASK = cfaf5030[970] 'sshd' THREAD: ce836000
GPR00: 00000001 ce837ab0 cfaf5030 cf389760 cf3e0ca0 00000000 00000000 00000000
GPR08: 00001b22 c0522ca0 cf4114c8 00000000 82424448 100639ac c0547bd0 c0547bd4
GPR16: c0547ba0 c050dd78 c050e60c 000000d0 00000000 00200200 00100100 00000001
GPR24: ce836034 00000005 cf389760 cf389b80 cf4bfd94 ce836000 00000000 ce836000
NIP [c0038e30] local_bh_enable+0x9c/0xbc
LR [c039ba74] ipv6_sock_mc_close+0x160/0x190
Call Trace:
[ce837ab0] [c0148aa8] __put_nfs_open_context+0xa8/0xc4 (unreliable)
[ce837ac0] [c039ba74] ipv6_sock_mc_close+0x160/0x190
[ce837af0] [c03766a8] inet6_release+0x2c/0x50
[ce837b00] [c02f0be4] sock_release+0x30/0xd0
[ce837b20] [c02f0ca0] sock_close+0x1c/0x40
[ce837b30] [c00a8588] __fput+0xc4/0x204
[ce837b50] [c00a4524] filp_close+0x6c/0xa0
[ce837b70] [c0034364] put_files_struct+0xe0/0xfc
[ce837b90] [c0035e28] do_exit+0x144/0x6b8
[ce837be0] [c000c234] die+0x1b0/0x1b8
[ce837c10] [c000c554] _exception+0x1d4/0x2b4
[ce837d10] [c000e78c] ret_from_except_full+0x0/0x4c
[ce837dd0] [c050e60c] 0xc050e60c
[ce837e30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0
[ce837e50] [c00534ec] prepare_creds+0x3c/0xcc
[ce837e70] [c005382c] copy_creds+0xa0/0x12c
[ce837e80] [c00307dc] copy_process+0x1c0/0xe20
[ce837ee0] [c00314b8] do_fork+0x7c/0x338
[ce837f20] [c00065b4] sys_clone+0x58/0x88
[ce837f40] [c000e164] ret_from_syscall+0x0/0x3c
Instruction dump:
41a20008 4839c591 80010014 83e1000c 38210010 7c0803a6 4e800020 3d20c052
39292ca0 800900c0 7c000034 5400d97e <0f000000> 2f800000 41beff88 38000001
BUG: scheduling while atomic: sshd/970/0x10000002
Modules linked in: nls_iso8859_1 nfsd
Call Trace:
[ce837ac0] [c0006184] show_stack+0x40/0x15c (unreliable)
[ce837af0] [c002bab4] __schedule_bug+0x68/0x6c
[ce837b00] [c03d5138] schedule+0x2bc/0x36c
[ce837b50] [c002bae0] __cond_resched+0x28/0x54
[ce837b60] [c03d5304] _cond_resched+0x50/0x58
[ce837b70] [c0034368] put_files_struct+0xe4/0xfc
[ce837b90] [c0035e28] do_exit+0x144/0x6b8
[ce837be0] [c000c234] die+0x1b0/0x1b8
[ce837c10] [c000c554] _exception+0x1d4/0x2b4
[ce837d10] [c000e78c] ret_from_except_full+0x0/0x4c
[ce837dd0] [c050e60c] 0xc050e60c
[ce837e30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0
[ce837e50] [c00534ec] prepare_creds+0x3c/0xcc
[ce837e70] [c005382c] copy_creds+0xa0/0x12c
[ce837e80] [c00307dc] copy_process+0x1c0/0xe20
[ce837ee0] [c00314b8] do_fork+0x7c/0x338
[ce837f20] [c00065b4] sys_clone+0x58/0x88
[ce837f40] [c000e164] ret_from_syscall+0x0/0x3c

root@inson:~#

Any Clue or any bugs found in mm/slab.c for linux-2.6.29.6 while
running IPSEC applications ?

Thanks in Advance !


Regards
Srikanth Krishnakar
**********************

--0016e6471a8e53c286047078ed5c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>Here is kernel bug for linux-2.6.29.6 for PowerPC (ppc440) t=
arget, while running ipsec application it is observed that kernel oops&#39;=
es oftenly as show below :<br><br><pre>root@powerpc:~# ./ipsec<br>---------=
---[ cut here ]------------<br>
kernel BUG at mm/slab.c:3002!<br>Oops: Exception in kernel mode, sig: 5 [#1=
]<br>PREEMPT LTT NESTING LEVEL : 0<br>Xilinx Virtex440<br>Modules linked in=
: nls_iso8859_1 nfsd<br>NIP: c00a1e94 LR: c00a1d3c CTR: 0000000b<br>REGS: c=
e8c9d20 TRAP: 0700   Not tainted  (2.6.29.6.xilinx-ml507.0908010910-ipsec)<=
br>
MSR: 00021000 &lt;ME,CE&gt;  CR: 22024428  XER: 00000005<br>TASK =3D cfa2a4=
30[974] &#39;watchdog&#39; THREAD: ce8c8000<br>GPR00: 00000028 ce8c9dd0 cfa=
2a430 cf802ea8 cf9e001c 0000000a cf9e0000 ffffffff<br>GPR08: 00000d80 00000=
001 0000000a 00000028 cf802ea0 1002b58c c0547bd0 c0547bd4<br>
GPR16: c0547ba0 c050dd78 c050e60c 000000d0 00000000 00200200 00100100 00000=
001<br>GPR24: ce8c8034 ce8c8000 00000000 c0520000 00000000 cf802eb0 cf80756=
0 cf809e00<br>NIP [c00a1e94] cache_alloc_refill+0x138/0x630<br>LR [c00a1d3c=
] kmem_cache_alloc+0x80/0xa0<br>
Call Trace:<br>[ce8c9dd0] [c050e60c] 0xc050e60c (unreliable)<br>[ce8c9e30] =
[c00a1d3c] kmem_cache_alloc+0x80/0xa0<br>[ce8c9e50] [c00534ec] prepare_cred=
s+0x3c/0xcc<br>[ce8c9e70] [c005382c] copy_creds+0xa0/0x12c<br>[ce8c9e80] [c=
00307dc] copy_process+0x1c0/0xe20<br>
[ce8c9ee0] [c00314b8] do_fork+0x7c/0x338<br>[ce8c9f20] [c00065b4] sys_clone=
+0x58/0x88<br>[ce8c9f40] [c000e164] ret_from_syscall+0x0/0x3c<br>Instructio=
n dump:<br>2f8a0000 3bac0010 386c0008 409d0104 80cc0000 7f8c3000 419e00e8 8=
1660010<br>
801e001c 7d205810 39200000 7d294914 &lt;0f090000&gt; 7f8b0040 7d455378 409c=
0074<br>---[ end trace b098f3001b420338 ]---<br>note: watchdog[974] exited =
with preempt_count 1<br>BUG: scheduling while atomic: watchdog/974/0x100000=
02<br>
Modules linked in: nls_iso8859_1 nfsd<br>Call Trace:<br>[ce8c99e0] [c000618=
4] show_stack+0x40/0x15c (unreliable)<br>[ce8c9a10] [c002bab4] __schedule_b=
ug+0x68/0x6c<br>[ce8c9a20] [c03d5138] schedule+0x2bc/0x36c<br>[ce8c9a70] [c=
002bae0] __cond_resched+0x28/0x54<br>
[ce8c9a80] [c03d5304] _cond_resched+0x50/0x58<br>[ce8c9a90] [c00925c8] __ml=
ock_vma_pages_range+0x84/0x2c4<br>[ce8c9b20] [c0094084] exit_mmap+0x60/0x1b=
0<br>[ce8c9b50] [c002fe64] mmput+0x50/0x114<br>[ce8c9b60] [c0034120] exit_m=
m+0x130/0x14c<br>
[ce8c9b90] [c0035db4] do_exit+0xd0/0x6b8<br>[ce8c9be0] [c000c234] die+0x1b0=
/0x1b8<br>[ce8c9c10] [c000c554] _exception+0x1d4/0x2b4<br>[ce8c9d10] [c000e=
78c] ret_from_except_full+0x0/0x4c<br>[ce8c9dd0] [c050e60c] 0xc050e60c<br>
[ce8c9e30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0<br>[ce8c9e50] [c00534ec] p=
repare_creds+0x3c/0xcc<br>[ce8c9e70] [c005382c] copy_creds+0xa0/0x12c<br>[c=
e8c9e80] [c00307dc] copy_process+0x1c0/0xe20<br>[ce8c9ee0] [c00314b8] do_fo=
rk+0x7c/0x338<br>
[ce8c9f20] [c00065b4] sys_clone+0x58/0x88<br>[ce8c9f40] [c000e164] ret_from=
_syscall+0x0/0x3c<br>BUG: scheduling while atomic: watchdog/974/0x10000002<=
br>Modules linked in: nls_iso8859_1 nfsd<br>Call Trace:<br>[ce8c99e0] [c000=
6184] show_stack+0x40/0x15c (unreliable)<br>
[ce8c9a10] [c002bab4] __schedule_bug+0x68/0x6c<br>[ce8c9a20] [c03d5138] sch=
edule+0x2bc/0x36c<br>[ce8c9a70] [c002bae0] __cond_resched+0x28/0x54<br>[ce8=
c9a80] [c03d5304] _cond_resched+0x50/0x58<br>[ce8c9a90] [c00925c8] __mlock_=
vma_pages_range+0x84/0x2c4<br>
[ce8c9b20] [c0094084] exit_mmap+0x60/0x1b0<br>[ce8c9b50] [c002fe64] mmput+0=
x50/0x114<br>[ce8c9b60] [c0034120] exit_mm+0x130/0x14c<br>[ce8c9b90] [c0035=
db4] do_exit+0xd0/0x6b8<br>[ce8c9be0] [c000c234] die+0x1b0/0x1b8<br>[ce8c9c=
10] [c000c554] _exception+0x1d4/0x2b4<br>
[ce8c9d10] [c000e78c] ret_from_except_full+0x0/0x4c<br>[ce8c9dd0] [c050e60c=
] 0xc050e60c<br>[ce8c9e30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0<br>[ce8c9e=
50] [c00534ec] prepare_creds+0x3c/0xcc<br>[ce8c9e70] [c005382c] copy_creds+=
0xa0/0x12c<br>
[ce8c9e80] [c00307dc] copy_process+0x1c0/0xe20<br>[ce8c9ee0] [c00314b8] do_=
fork+0x7c/0x338<br>[ce8c9f20] [c00065b4] sys_clone+0x58/0x88<br>[ce8c9f40] =
[c000e164] ret_from_syscall+0x0/0x3c<br><br>root@inson:~#<br>root@inson:~# =
------------[ cut here ]------------<br>
kernel BUG at mm/slab.c:3002!<br>Oops: Exception in kernel mode, sig: 5 [#2=
]<br>PREEMPT LTT NESTING LEVEL : 0<br>Xilinx Virtex440<br>Modules linked in=
: nls_iso8859_1 nfsd<br>NIP: c00a1e94 LR: c00a1d3c CTR: 0000000a<br>REGS: c=
e9cbd20 TRAP: 0700   Tainted: G      D     (2.6.29.6.xilinx-ml507.090801091=
0-ipsec)<br>
MSR: 00021000 &lt;ME,CE&gt;  CR: 22424848  XER: 00000001<br>TASK =3D ce8fe0=
30[1400] &#39;mvtsd.py&#39; THREAD: ce9ca000<br>GPR00: 00000028 ce9cbdd0 ce=
8fe030 cf802ea8 cf9e001c 00000009 cf9e0000 ffffffff<br>GPR08: 00000d20 0000=
0001 00000009 00000028 cf802ea0 10018a3c c0547bd0 c0547bd4<br>
GPR16: c0547ba0 c050dd78 c050e60c 000000d0 00000000 00200200 00100100 00000=
001<br>GPR24: ce9ca034 ce9ca000 00000000 c0520000 00000000 cf802eb0 cf80756=
0 cf809e00<br>NIP [c00a1e94] cache_alloc_refill+0x138/0x630<br>LR [c00a1d3c=
] kmem_cache_alloc+0x80/0xa0<br>
Call Trace:<br>[ce9cbdd0] [c050e60c] 0xc050e60c (unreliable)<br>[ce9cbe30] =
[c00a1d3c] kmem_cache_alloc+0x80/0xa0<br>[ce9cbe50] [c00534ec] prepare_cred=
s+0x3c/0xcc<br>[ce9cbe70] [c005382c] copy_creds+0xa0/0x12c<br>[ce9cbe80] [c=
00307dc] copy_process+0x1c0/0xe20<br>
[ce9cbee0] [c00314b8] do_fork+0x7c/0x338<br>[ce9cbf20] [c00065b4] sys_clone=
+0x58/0x88<br>[ce9cbf40] [c000e164] ret_from_syscall+0x0/0x3c<br>Instructio=
n dump:<br>2f8a0000 3bac0010 386c0008 409d0104 80cc0000 7f8c3000 419e00e8 8=
1660010<br>
801e001c 7d205810 39200000 7d294914 &lt;0f090000&gt; 7f8b0040 7d455378 409c=
0074<br>---[ end trace b098f3001b420339 ]---<br>note: mvtsd.py[1400] exited=
 with preempt_count 1<br>BUG: scheduling while atomic: mvtsd.py/1400/0x1000=
0002<br>
Modules linked in: nls_iso8859_1 nfsd<br>Call Trace:<br>[ce9cb9e0] [c000618=
4] show_stack+0x40/0x15c (unreliable)<br>[ce9cba10] [c002bab4] __schedule_b=
ug+0x68/0x6c<br>[ce9cba20] [c03d5138] schedule+0x2bc/0x36c<br>[ce9cba70] [c=
002bae0] __cond_resched+0x28/0x54<br>
[ce9cba80] [c03d5304] _cond_resched+0x50/0x58<br>[ce9cba90] [c008f074] unma=
p_vmas+0x4d0/0x698<br>[ce9cbb20] [c00940ec] exit_mmap+0xc8/0x1b0<br>[ce9cbb=
50] [c002fe64] mmput+0x50/0x114<br>[ce9cbb60] [c0034120] exit_mm+0x130/0x14=
c<br>
[ce9cbb90] [c0035db4] do_exit+0xd0/0x6b8<br>[ce9cbbe0] [c000c234] die+0x1b0=
/0x1b8<br>[ce9cbc10] [c000c554] _exception+0x1d4/0x2b4<br>[ce9cbd10] [c000e=
78c] ret_from_except_full+0x0/0x4c<br>[ce9cbdd0] [c050e60c] 0xc050e60c<br>
[ce9cbe30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0<br>[ce9cbe50] [c00534ec] p=
repare_creds+0x3c/0xcc<br>[ce9cbe70] [c005382c] copy_creds+0xa0/0x12c<br>[c=
e9cbe80] [c00307dc] copy_process+0x1c0/0xe20<br>[ce9cbee0] [c00314b8] do_fo=
rk+0x7c/0x338<br>
[ce9cbf20] [c00065b4] sys_clone+0x58/0x88<br>[ce9cbf40] [c000e164] ret_from=
_syscall+0x0/0x3c<br>BUG: scheduling while atomic: mvtsd.py/1400/0x10000002=
<br>Modules linked in: nls_iso8859_1 nfsd<br>Call Trace:<br>[ce9cb9e0] [c00=
06184] show_stack+0x40/0x15c (unreliable)<br>
[ce9cba10] [c002bab4] __schedule_bug+0x68/0x6c<br>[ce9cba20] [c03d5138] sch=
edule+0x2bc/0x36c<br>[ce9cba70] [c002bae0] __cond_resched+0x28/0x54<br>[ce9=
cba80] [c03d5304] _cond_resched+0x50/0x58<br>[ce9cba90] [c008f074] unmap_vm=
as+0x4d0/0x698<br>
[ce9cbb20] [c00940ec] exit_mmap+0xc8/0x1b0<br>[ce9cbb50] [c002fe64] mmput+0=
x50/0x114<br>[ce9cbb60] [c0034120] exit_mm+0x130/0x14c<br>[ce9cbb90] [c0035=
db4] do_exit+0xd0/0x6b8<br>[ce9cbbe0] [c000c234] die+0x1b0/0x1b8<br>[ce9cbc=
10] [c000c554] _exception+0x1d4/0x2b4<br>
[ce9cbd10] [c000e78c] ret_from_except_full+0x0/0x4c<br>[ce9cbdd0] [c050e60c=
] 0xc050e60c<br>[ce9cbe30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0<br>[ce9cbe=
50] [c00534ec] prepare_creds+0x3c/0xcc<br>[ce9cbe70] [c005382c] copy_creds+=
0xa0/0x12c<br>
[ce9cbe80] [c00307dc] copy_process+0x1c0/0xe20<br>[ce9cbee0] [c00314b8] do_=
fork+0x7c/0x338<br>[ce9cbf20] [c00065b4] sys_clone+0x58/0x88<br>[ce9cbf40] =
[c000e164] ret_from_syscall+0x0/0x3c<br>------------[ cut here ]-----------=
-<br>
kernel BUG at mm/slab.c:3002!<br>Oops: Exception in kernel mode, sig: 5 [#3=
]<br>PREEMPT LTT NESTING LEVEL : 0<br>Xilinx Virtex440<br>Modules linked in=
: nls_iso8859_1 nfsd<br>NIP: c00a1e94 LR: c00a1d3c CTR: 00000009<br>REGS: c=
e837d20 TRAP: 0700   Tainted: G      D     (2.6.29.6.xilinx-ml507.090801091=
0-ipsec)<br>
MSR: 00021000 &lt;ME,CE&gt;  CR: 22424428  XER: 00000005<br>TASK =3D cfaf50=
30[970] &#39;sshd&#39; THREAD: ce836000<br>GPR00: 00000028 ce837dd0 cfaf503=
0 cf802ea8 cf9e001c 00000008 cf9e0000 ffffffff<br>GPR08: 00000ea0 00000001 =
00000008 00000028 cf802ea0 100639ac c0547bd0 c0547bd4<br>
GPR16: c0547ba0 c050dd78 c050e60c 000000d0 00000000 00200200 00100100 00000=
001<br>GPR24: ce836034 ce836000 00000000 c0520000 00000000 cf802eb0 cf80756=
0 cf809e00<br>NIP [c00a1e94] cache_alloc_refill+0x138/0x630<br>LR [c00a1d3c=
] kmem_cache_alloc+0x80/0xa0<br>
Call Trace:<br>[ce837dd0] [c050e60c] 0xc050e60c (unreliable)<br>[ce837e30] =
[c00a1d3c] kmem_cache_alloc+0x80/0xa0<br>[ce837e50] [c00534ec] prepare_cred=
s+0x3c/0xcc<br>[ce837e70] [c005382c] copy_creds+0xa0/0x12c<br>[ce837e80] [c=
00307dc] copy_process+0x1c0/0xe20<br>
[ce837ee0] [c00314b8] do_fork+0x7c/0x338<br>[ce837f20] [c00065b4] sys_clone=
+0x58/0x88<br>[ce837f40] [c000e164] ret_from_syscall+0x0/0x3c<br>Instructio=
n dump:<br>2f8a0000 3bac0010 386c0008 409d0104 80cc0000 7f8c3000 419e00e8 8=
1660010<br>
801e001c 7d205810 39200000 7d294914 &lt;0f090000&gt; 7f8b0040 7d455378 409c=
0074<br>---[ end trace b098f3001b42033a ]---<br>note: sshd[970] exited with=
 preempt_count 1<br>------------[ cut here ]------------<br>Badness at kern=
el/softirq.c:150<br>
NIP: c0038e30 LR: c039ba74 CTR: c037667c<br>REGS: ce837a00 TRAP: 0700   Tai=
nted: G      D     (2.6.29.6.ml507.0908010910-ipsec)<br>MSR: 00021000 &lt;M=
E,CE&gt;  CR: 22424442  XER: 20000005<br>TASK =3D cfaf5030[970] &#39;sshd&#=
39; THREAD: ce836000<br>
GPR00: 00000001 ce837ab0 cfaf5030 cf389760 cf3e0ca0 00000000 00000000 00000=
000<br>GPR08: 00001b22 c0522ca0 cf4114c8 00000000 82424448 100639ac c0547bd=
0 c0547bd4<br>GPR16: c0547ba0 c050dd78 c050e60c 000000d0 00000000 00200200 =
00100100 00000001<br>
GPR24: ce836034 00000005 cf389760 cf389b80 cf4bfd94 ce836000 00000000 ce836=
000<br>NIP [c0038e30] local_bh_enable+0x9c/0xbc<br>LR [c039ba74] ipv6_sock_=
mc_close+0x160/0x190<br>Call Trace:<br>[ce837ab0] [c0148aa8] __put_nfs_open=
_context+0xa8/0xc4 (unreliable)<br>
[ce837ac0] [c039ba74] ipv6_sock_mc_close+0x160/0x190<br>[ce837af0] [c03766a=
8] inet6_release+0x2c/0x50<br>[ce837b00] [c02f0be4] sock_release+0x30/0xd0<=
br>[ce837b20] [c02f0ca0] sock_close+0x1c/0x40<br>[ce837b30] [c00a8588] __fp=
ut+0xc4/0x204<br>
[ce837b50] [c00a4524] filp_close+0x6c/0xa0<br>[ce837b70] [c0034364] put_fil=
es_struct+0xe0/0xfc<br>[ce837b90] [c0035e28] do_exit+0x144/0x6b8<br>[ce837b=
e0] [c000c234] die+0x1b0/0x1b8<br>[ce837c10] [c000c554] _exception+0x1d4/0x=
2b4<br>
[ce837d10] [c000e78c] ret_from_except_full+0x0/0x4c<br>[ce837dd0] [c050e60c=
] 0xc050e60c<br>[ce837e30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0<br>[ce837e=
50] [c00534ec] prepare_creds+0x3c/0xcc<br>[ce837e70] [c005382c] copy_creds+=
0xa0/0x12c<br>
[ce837e80] [c00307dc] copy_process+0x1c0/0xe20<br>[ce837ee0] [c00314b8] do_=
fork+0x7c/0x338<br>[ce837f20] [c00065b4] sys_clone+0x58/0x88<br>[ce837f40] =
[c000e164] ret_from_syscall+0x0/0x3c<br>Instruction dump:<br>41a20008 4839c=
591 80010014 83e1000c 38210010 7c0803a6 4e800020 3d20c052<br>
39292ca0 800900c0 7c000034 5400d97e &lt;0f000000&gt; 2f800000 41beff88 3800=
0001<br>BUG: scheduling while atomic: sshd/970/0x10000002<br>Modules linked=
 in: nls_iso8859_1 nfsd<br>Call Trace:<br>[ce837ac0] [c0006184] show_stack+=
0x40/0x15c (unreliable)<br>
[ce837af0] [c002bab4] __schedule_bug+0x68/0x6c<br>[ce837b00] [c03d5138] sch=
edule+0x2bc/0x36c<br>[ce837b50] [c002bae0] __cond_resched+0x28/0x54<br>[ce8=
37b60] [c03d5304] _cond_resched+0x50/0x58<br>[ce837b70] [c0034368] put_file=
s_struct+0xe4/0xfc<br>
[ce837b90] [c0035e28] do_exit+0x144/0x6b8<br>[ce837be0] [c000c234] die+0x1b=
0/0x1b8<br>[ce837c10] [c000c554] _exception+0x1d4/0x2b4<br>[ce837d10] [c000=
e78c] ret_from_except_full+0x0/0x4c<br>[ce837dd0] [c050e60c] 0xc050e60c<br>
[ce837e30] [c00a1d3c] kmem_cache_alloc+0x80/0xa0<br>[ce837e50] [c00534ec] p=
repare_creds+0x3c/0xcc<br>[ce837e70] [c005382c] copy_creds+0xa0/0x12c<br>[c=
e837e80] [c00307dc] copy_process+0x1c0/0xe20<br>[ce837ee0] [c00314b8] do_fo=
rk+0x7c/0x338<br>
[ce837f20] [c00065b4] sys_clone+0x58/0x88<br>[ce837f40] [c000e164] ret_from=
_syscall+0x0/0x3c<br><br>root@inson:~#<br><br>Any Clue or any bugs found in=
 mm/slab.c for linux-2.6.29.6 while running IPSEC applications ?<br></pre>
Thanks in Advance !<br><br><br>Regards<br>Srikanth Krishnakar<br>**********=
************<br>

--0016e6471a8e53c286047078ed5c--
