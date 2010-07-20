Return-Path: <crmanik@gmail.com>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172]) by ozlabs.org (Postfix) with ESMTP id F3057B6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Jul 2010 04:15:03 +1000 (EST)
Received: by qyk1 with SMTP id 1so2581574qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Jul 2010 11:15:01 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 20 Jul 2010 11:15:01 -0700
Message-ID: <AANLkTiki-qI2VWFTxEhuUV36h7xlX77CMBuPyhv3qKhO@mail.gmail.com>
Subject: RT Kernel crash in SMP mode on Marvell board
From: Manikandan Ramachandran <crmanik@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=00c09f9b09c7e64ca8048bd5a90b
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00c09f9b09c7e64ca8048bd5a90b
Content-Type: text/plain; charset=ISO-8859-1

Hello All,

   I'm trying to bring up a Marvell board [db644xx] with dual CPU[7447A]
with kernel 2.6.33.5-rt23[Ingo's RT patch]. For conveniance I have
registered IPI interrupt with IRQF_NODELAY flag, all other interrupts are
threaded. I'm able to boot up the system fine, however after few hours I see
random kernel crash in Marvell's PIC module. I understand that the RT kernel
doesn't like the way spinlock is used, I tried to convert to raw_spin_lock,
but the system would get frozen. I can make the system stable by just not
using any locks, but thats not an ideal solution. Can someone please suggest
a better locking mechanism? Crash dump I have given below:

NIP: 00000000 LR: 70030258 CTR: 00000000
REGS: deeebcf0 TRAP: 0400   Tainted: P            (2.6.33.5-rt23)
MSR: 40001032 <ME,IR,DR>  CR: 24004024  XER: 20000004
TASK = df915240[788] 'irq/74-ide0' THREAD: deeea000 CPU: 1
GPR00: 70030390 deeebda0 df915240 72e17ac0 703683f8 00000001 00000000
645d28e8
GPR08: 00000000 00000000 00000000 00000005 46f0b20f 00000000 00fe4600
007fff00
GPR16: 04000000 003d4ba2 007ffeb0 00800000 00ff690c 03000040 00f7eba2
deeebf6c
GPR24: 00000001 00000000 00000000 deeea000 72e17ac0 00000000 703683f8
703683f8
NIP [00000000] (null)
LR [70030258] enqueue_task+0x3c/0x58
Call Trace:
[deeebda0] [0000001e] 0x1e (unreliable)
[deeebdb0] [70030390] activate_task+0x40/0x60
[deeebdc0] [70036850] try_to_wake_up+0x248/0x334
[deeebe00] [70069380] wakeup_next_waiter+0x148/0x14c
[deeebe20] [7029b1d4] rt_spin_lock_slowunlock+0x60/0x84
[deeebe30] [7001a168] marvell_disable_IPI_irq+0xfc/0x110
[deeebe50] [70073934] handle_level_irq+0x40/0x15c
[deeebe70] [70006418] do_IRQ+0xc8/0xf4
[deeebe90] [7001276c] ret_from_except+0x0/0x14
--- Exception: 501 at schedule+0x30/0x50
    LR = schedule+0x24/0x50
[deeebf60] [700717bc] irq_thread+0x98/0x230
[deeebfa0] [7005686c] kthread+0x78/0x7c
[deeebff0] [70011ef4] kernel_thread+0x4c/0x68
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
Kernel panic - not syncing: Fatal exception in interrupt
Call Trace:
[deeebc20
---------------------------------------------------------------------------------------------------------------------

IRQ CONFIGs:

CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
# CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is not set
CONFIG_IRQ_PER_CPU=y
CONFIG_NR_IRQS=512
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

-- 
Thanks,
Manik

Think twice about a tree before you take a printout

--00c09f9b09c7e64ca8048bd5a90b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div><br clear=3D"all">Hello All,</div>
<div>=A0</div>
<div>=A0=A0 I&#39;m trying to bring up a Marvell board [db644xx]=A0with dua=
l CPU[7447A] with=A0kernel 2.6.33.5-rt23[Ingo&#39;s RT patch]. For convenia=
nce I have registered IPI interrupt with IRQF_NODELAY flag, all other inter=
rupts are threaded. I&#39;m able to boot up the system fine, however after =
few hours I see random kernel crash in Marvell&#39;s PIC module. I understa=
nd that the RT kernel doesn&#39;t like the way spinlock is used, I tried to=
=A0convert to raw_spin_lock, but the system would get frozen. I can make th=
e system stable by just not using any locks, but thats not an ideal solutio=
n. Can someone please suggest a better locking mechanism? Crash dump I have=
 given below:</div>

<div>=A0</div>
<div>NIP: 00000000 LR: 70030258 CTR: 00000000<br>REGS: deeebcf0 TRAP: 0400=
=A0=A0 Tainted: P=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (2.6.33.5-rt23)<br>MSR: =
40001032 &lt;ME,IR,DR&gt;=A0 CR: 24004024=A0 XER: 20000004<br>TASK =3D df91=
5240[788] &#39;irq/74-ide0&#39; THREAD: deeea000 CPU: 1<br>
GPR00: 70030390 deeebda0 df915240 72e17ac0 703683f8 00000001 00000000 645d2=
8e8 <br>GPR08: 00000000 00000000 00000000 00000005 46f0b20f 00000000 00fe46=
00 007fff00 <br>GPR16: 04000000 003d4ba2 007ffeb0 00800000 00ff690c 0300004=
0 00f7eba2 deeebf6c <br>
GPR24: 00000001 00000000 00000000 deeea000 72e17ac0 00000000 703683f8 70368=
3f8 <br>NIP [00000000] (null)<br>LR [70030258] enqueue_task+0x3c/0x58<br>Ca=
ll Trace:<br>[deeebda0] [0000001e] 0x1e (unreliable)<br>[deeebdb0] [7003039=
0] activate_task+0x40/0x60<br>
[deeebdc0] [70036850] try_to_wake_up+0x248/0x334<br>[deeebe00] [70069380] w=
akeup_next_waiter+0x148/0x14c<br>[deeebe20] [7029b1d4] rt_spin_lock_slowunl=
ock+0x60/0x84<br>[deeebe30] [7001a168] marvell_disable_IPI_irq+0xfc/0x110<b=
r>
[deeebe50] [70073934] handle_level_irq+0x40/0x15c<br>[deeebe70] [70006418] =
do_IRQ+0xc8/0xf4<br>[deeebe90] [7001276c] ret_from_except+0x0/0x14<br>--- E=
xception: 501 at schedule+0x30/0x50<br>=A0=A0=A0 LR =3D schedule+0x24/0x50<=
br>[deeebf60] [700717bc] irq_thread+0x98/0x230<br>
[deeebfa0] [7005686c] kthread+0x78/0x7c<br>[deeebff0] [70011ef4] kernel_thr=
ead+0x4c/0x68<br>Instruction dump:<br>XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX X=
XXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX <br>XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX =
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX <br>
Kernel panic - not syncing: Fatal exception in interrupt<br>Call Trace:<br>=
[deeebc20</div>
<div>----------------------------------------------------------------------=
-----------------------------------------------</div>
<div>=A0</div>
<div>IRQ CONFIGs:</div>
<div>=A0</div>
<div>CONFIG_GENERIC_CMOS_UPDATE=3Dy<br>CONFIG_GENERIC_TIME=3Dy<br>CONFIG_GE=
NERIC_TIME_VSYSCALL=3Dy<br>CONFIG_GENERIC_CLOCKEVENTS=3Dy<br>CONFIG_GENERIC=
_HARDIRQS=3Dy<br>CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=3Dy<br># CONFIG_HAVE_SE=
TUP_PER_CPU_AREA is not set<br>
# CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is not set<br>CONFIG_IRQ_PER_CPU=3D=
y<br>CONFIG_NR_IRQS=3D512<br>CONFIG_STACKTRACE_SUPPORT=3Dy<br>CONFIG_HAVE_L=
ATENCYTOP_SUPPORT=3Dy<br>CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy</div>
<div><br>-- <br>Thanks,<br>Manik<br><br>Think twice about a tree before you=
 take a printout<br></div>

--00c09f9b09c7e64ca8048bd5a90b--
