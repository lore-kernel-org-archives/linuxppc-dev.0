Return-Path: <a.woellert@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.203])
	by ozlabs.org (Postfix) with ESMTP id DD2A467C1F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 18:29:38 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id r28so201102nza
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 01:29:37 -0700 (PDT)
Message-ID: <faba7798050714012370af5e74@mail.gmail.com>
Date: Thu, 14 Jul 2005 10:23:20 +0200
From: =?ISO-8859-1?Q?Anton_W=F6llert?= <a.woellert@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050701101713.GC11121@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_18188_12449091.1121329400389"
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
	<20050701094438.GA11121@logos.cnet>
	<1120229717.21507.9.camel@jmcmullan.timesys>
	<20050701101713.GC11121@logos.cnet>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: ptrace on linux 2.6.12 causes oops
Reply-To: =?ISO-8859-1?Q?Anton_W=F6llert?= <a.woellert@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_18188_12449091.1121329400389
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello

when i try to run strace or gdbserver on a program, the following comes:

Oops: kernel access of bad area, sig: 11 [#2]
NIP: C000543C LR: C000B060 SP: C0F35DF0 REGS: c0f35d40 TRAP: 0300 Not=20
tainted
MSR: 00009022 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 10
DAR: 00000010, DSISR: C2000000
TASK =3D c0ea8430[761] 'gdbserver' THREAD: c0f34000
Last syscall: 26=20
GPR00: 00009022 C0F35DF0 C0EA8430 00F59000 00000100 FFFFFFFF 00F58000=20
00000001=20
GPR08: C021DAEF C0270000 00009032 C0270000 22044024 10025428 01000800=20
00000001=20
GPR16: 007FFF3F 00000001 00000000 7FBC6AC0 00F61022 00000001 C0839300=20
C01E0000=20
GPR24: 00CD0889 C082F568 3000AC18 C02A7A00 C0EA15C8 00F588A9 C02ACB00=20
C02ACB00=20
NIP [c000543c] __flush_dcache_icache_phys+0x38/0x54
LR [c000b060] flush_dcache_icache_page+0x20/0x30
Call trace:
[c000b154] update_mmu_cache+0x7c/0xa4
[c005ae98] do_wp_page+0x460/0x5ec
[c005c8a0] handle_mm_fault+0x7cc/0x91c
[c005ccec] get_user_pages+0x2fc/0x65c
[c0027104] access_process_vm+0x9c/0x1d4
[c00076e0] sys_ptrace+0x240/0x4a4
[c0002bd0] ret_from_syscall+0x0/0x44
mm/memory.c:2054: spin_lock(kernel/fork.c:c0ea1618) already locked by=20
mm/memory.c/1306

and strace or gdbserver of course says segmentation fault. with gdbserver,=
=20
this happens every time. with strace, the first time it works nearly all=20
time, but when i strace a second time program again, it segfaults. i think=
=20
the access_process_vm is accessed trough PEEKDATA and PEEKTEXT in=20
sys_ptrace. so here some more debug :) :

DEBUG: peekdata @ 1006d4ec
DEBUG: peektext @ 1006d4f0
DEBUG: peekdata @ 1006d4f0
DEBUG: peektext @ 1006d4f4
DEBUG: peekdata @ 1006d4f4
DEBUG: peektext @ 1006d4f8
DEBUG: peekdata @ 1006d4f8
DEBUG: peektext @ 1006d4fc
DEBUG: peekdata @ 1006d4fc
DEBUG: peektext @ 1006d500
DEBUG: peekdata @ 1006d500
DEBUG: peektext @ 1006d504
DEBUG: peekdata @ 1006d504
DEBUG: peektext @ 1006d508
DEBUG: peekdata @ 1006d508
DEBUG: peektext @ 1006d50c
DEBUG: peekdata @ 1006d50c
DEBUG: peektext @ 1006d510
DEBUG: peekdata @ 1006d510
DEBUG: peektext @ 1006d514
DEBUG: peekdata @ 1006d514
DEBUG: peektext @ 1006d518
DEBUG: peekdata @ 1006d518
DEBUG: peektext @ 1006d51c
DEBUG: peekdata @ 1006d51c
DEBUG: peektext @ 1006d520
DEBUG: peekdata @ 1006d520
DEBUG: peektext @ 1006d524
DEBUG: peekdata @ 1006d524
DEBUG: peektext @ 1006d528
DEBUG: peekdata @ 1006d528
DEBUG: peektext @ 1006d52c
DEBUG: peekdata @ 1006d52c
DEBUG: peektext @ 00000000
DEBUG: peekdata @ 00000000
DEBUG: peektext @ 3000ac18
DEBUG: peekdata @ 3000ac18
DEBUG: peektext @ 3000ac18
DEBUG: peekdata @ 3000ac18
DEBUG: flush_dcache_icache_page
Oops: kernel access of bad area, sig: 11 [#2]
NIP: C000543C LR: C000B060 SP: C0F35DF0 REGS: c0f35d40 TRAP: 0300 Not=20
tainted
MSR: 00009022 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 10
DAR: 00000010, DSISR: C2000000
TASK =3D c0ea8430[761] 'gdbserver' THREAD: c0f34000
Last syscall: 26=20
GPR00: 00009022 C0F35DF0 C0EA8430 00F59000 00000100 FFFFFFFF 00F58000=20
00000001=20
GPR08: C021DAEF C0270000 00009032 C0270000 22044024 10025428 01000800=20
00000001=20
GPR16: 007FFF3F 00000001 00000000 7FBC6AC0 00F61022 00000001 C0839300=20
C01E0000=20
GPR24: 00CD0889 C082F568 3000AC18 C02A7A00 C0EA15C8 00F588A9 C02ACB00=20
C02ACB00=20
NIP [c000543c] __flush_dcache_icache_phys+0x38/0x54
LR [c000b060] flush_dcache_icache_page+0x20/0x30
Call trace:
[c000b154] update_mmu_cache+0x7c/0xa4
[c005ae98] do_wp_page+0x460/0x5ec
[c005c8a0] handle_mm_fault+0x7cc/0x91c
[c005ccec] get_user_pages+0x2fc/0x65c
[c0027104] access_process_vm+0x9c/0x1d4
[c00076e0] sys_ptrace+0x240/0x4a4
[c0002bd0] ret_from_syscall+0x0/0x44
mm/memory.c:2054: spin_lock(kernel/fork.c:c0ea1618) already locked by=20
mm/memory.c/1306

------=_Part_18188_12449091.1121329400389
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello<br>
<br>
when i try to run strace or gdbserver on a program, the following comes:<br=
>
<br>
Oops: kernel access of bad area, sig: 11 [#2]<br>
NIP: C000543C LR: C000B060 SP: C0F35DF0 REGS: c0f35d40 TRAP: 0300&nbsp;&nbs=
p;&nbsp; Not tainted<br>
MSR: 00009022 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 10<br>
DAR: 00000010, DSISR: C2000000<br>
TASK =3D c0ea8430[761] 'gdbserver' THREAD: c0f34000<br>
Last syscall: 26 <br>
GPR00: 00009022 C0F35DF0 C0EA8430 00F59000 00000100 FFFFFFFF 00F58000 00000=
001 <br>
GPR08: C021DAEF C0270000 00009032 C0270000 22044024 10025428 01000800 00000=
001 <br>
GPR16: 007FFF3F 00000001 00000000 7FBC6AC0 00F61022 00000001 C0839300 C01E0=
000 <br>
GPR24: 00CD0889 C082F568 3000AC18 C02A7A00 C0EA15C8 00F588A9 C02ACB00 C02AC=
B00 <br>
NIP [c000543c] __flush_dcache_icache_phys+0x38/0x54<br>
LR [c000b060] flush_dcache_icache_page+0x20/0x30<br>
Call trace:<br>
&nbsp;[c000b154] update_mmu_cache+0x7c/0xa4<br>
&nbsp;[c005ae98] do_wp_page+0x460/0x5ec<br>
&nbsp;[c005c8a0] handle_mm_fault+0x7cc/0x91c<br>
&nbsp;[c005ccec] get_user_pages+0x2fc/0x65c<br>
&nbsp;[c0027104] access_process_vm+0x9c/0x1d4<br>
&nbsp;[c00076e0] sys_ptrace+0x240/0x4a4<br>
&nbsp;[c0002bd0] ret_from_syscall+0x0/0x44<br>
mm/memory.c:2054: spin_lock(kernel/fork.c:c0ea1618) already locked by mm/me=
mory.c/1306<br>
<br>
and strace or gdbserver of course says segmentation fault. with
gdbserver, this happens every time. with strace, the first time it
works nearly all time, but when i strace a second time program again,
it segfaults. i think the access_process_vm is accessed trough PEEKDATA
and PEEKTEXT in sys_ptrace. so here some more debug :) :<br>
<br>
DEBUG: peekdata @ 1006d4ec<br>
DEBUG: peektext @ 1006d4f0<br>
DEBUG: peekdata @ 1006d4f0<br>
DEBUG: peektext @ 1006d4f4<br>
DEBUG: peekdata @ 1006d4f4<br>
DEBUG: peektext @ 1006d4f8<br>
DEBUG: peekdata @ 1006d4f8<br>
DEBUG: peektext @ 1006d4fc<br>
DEBUG: peekdata @ 1006d4fc<br>
DEBUG: peektext @ 1006d500<br>
DEBUG: peekdata @ 1006d500<br>
DEBUG: peektext @ 1006d504<br>
DEBUG: peekdata @ 1006d504<br>
DEBUG: peektext @ 1006d508<br>
DEBUG: peekdata @ 1006d508<br>
DEBUG: peektext @ 1006d50c<br>
DEBUG: peekdata @ 1006d50c<br>
DEBUG: peektext @ 1006d510<br>
DEBUG: peekdata @ 1006d510<br>
DEBUG: peektext @ 1006d514<br>
DEBUG: peekdata @ 1006d514<br>
DEBUG: peektext @ 1006d518<br>
DEBUG: peekdata @ 1006d518<br>
DEBUG: peektext @ 1006d51c<br>
DEBUG: peekdata @ 1006d51c<br>
DEBUG: peektext @ 1006d520<br>
DEBUG: peekdata @ 1006d520<br>
DEBUG: peektext @ 1006d524<br>
DEBUG: peekdata @ 1006d524<br>
DEBUG: peektext @ 1006d528<br>
DEBUG: peekdata @ 1006d528<br>
DEBUG: peektext @ 1006d52c<br>
DEBUG: peekdata @ 1006d52c<br>
DEBUG: peektext @ 00000000<br>
DEBUG: peekdata @ 00000000<br>
DEBUG: peektext @ 3000ac18<br>
DEBUG: peekdata @ 3000ac18<br>
DEBUG: peektext @ 3000ac18<br>
DEBUG: peekdata @ 3000ac18<br>
DEBUG: flush_dcache_icache_page<br>
Oops: kernel access of bad area, sig: 11 [#2]<br>

NIP: C000543C LR: C000B060 SP: C0F35DF0 REGS: c0f35d40 TRAP: 0300&nbsp;&nbs=
p;&nbsp; Not tainted<br>

MSR: 00009022 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 10<br>

DAR: 00000010, DSISR: C2000000<br>

TASK =3D c0ea8430[761] 'gdbserver' THREAD: c0f34000<br>

Last syscall: 26 <br>

GPR00: 00009022 C0F35DF0 C0EA8430 00F59000 00000100 FFFFFFFF 00F58000 00000=
001 <br>

GPR08: C021DAEF C0270000 00009032 C0270000 22044024 10025428 01000800 00000=
001 <br>

GPR16: 007FFF3F 00000001 00000000 7FBC6AC0 00F61022 00000001 C0839300 C01E0=
000 <br>

GPR24: 00CD0889 C082F568 3000AC18 C02A7A00 C0EA15C8 00F588A9 C02ACB00 C02AC=
B00 <br>

NIP [c000543c] __flush_dcache_icache_phys+0x38/0x54<br>

LR [c000b060] flush_dcache_icache_page+0x20/0x30<br>

Call trace:<br>

&nbsp;[c000b154] update_mmu_cache+0x7c/0xa4<br>

&nbsp;[c005ae98] do_wp_page+0x460/0x5ec<br>

&nbsp;[c005c8a0] handle_mm_fault+0x7cc/0x91c<br>

&nbsp;[c005ccec] get_user_pages+0x2fc/0x65c<br>

&nbsp;[c0027104] access_process_vm+0x9c/0x1d4<br>

&nbsp;[c00076e0] sys_ptrace+0x240/0x4a4<br>

&nbsp;[c0002bd0] ret_from_syscall+0x0/0x44<br>

mm/memory.c:2054: spin_lock(kernel/fork.c:c0ea1618) already locked by mm/me=
mory.c/1306<br>
<br>
<br>

------=_Part_18188_12449091.1121329400389--
