Return-Path: <thomas.besemer@gmail.com>
Received: from mail-ot0-x22a.google.com (mail-ot0-x22a.google.com
 [IPv6:2607:f8b0:4003:c0f::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsgf15v8xzDqjQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 07:17:13 +1000 (AEST)
Received: by mail-ot0-x22a.google.com with SMTP id y47so76903479oty.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 14:17:13 -0700 (PDT)
MIME-Version: 1.0
From: Thomas Besemer <thomas.besemer@gmail.com>
Date: Tue, 20 Jun 2017 14:17:10 -0700
Message-ID: <CAO7m3AnPKavoBjmHJwuQ1y5ctyNk08eYB35M00ZiGgOwN4udvQ@mail.gmail.com>
Subject: Network TX Stall on 440EP Processor
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="001a1134eb4056341005526ac69f"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1134eb4056341005526ac69f
Content-Type: text/plain; charset="UTF-8"

I'm working on a project that is derived from the Yosemite
PPC 440EP board.  It's a legacy project that was running the
2.6.24 Kernel, and network traffic was stalling due to transmission
halting without an understandable error (in this error condition, the
various
status registers of network interface showed no issues), other
than TX stalling due to Buffer Descriptor Ring becoming full.

In order to see if the problem has been resolved, the Kernel
has been updated to 4.9.13, compiled with gcc version 5.4.0
(Buildroot 2017.02.2).  Although the frequency of the
problem is decreased, it still does show up.

The test case is the Linux Target running idle, no application
code.  From a Linux host on a directly connected network, 30
flood pings are started.  After a period of several minutes to
perhaps hours, the transmit aspect of the network controller
ceases to transmit packets (Buffer Descriptor ring becomes full).
RX still works.  In the 2.6.24 Kernel, the problem happens
within seconds, so it has improved with the new Kernel.

Below is the output from the Kernel when this happens.

Has anybody seen this problem before?  I can't find any
errata on it, nor can I find any reports of it.

The orginal problem is rooted in the Embedded Application
running, and after a period of time of heavy network
traffic, the TX side of network stalls.  The flood ping
test is used simply to force the problem to happen.

[ 3127.143572] NETDEV WATCHDOG: eth0 (emac): transmit queue 0 timed out
[ 3127.150172] ------------[ cut here ]------------
[ 3127.154778] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:316
dev_watchdog+0x23c/0x244
[ 3127.162965] Modules linked in:
[ 3127.166013] CPU: 0 PID: 0 Comm: swapper Not tainted 4.9.13 #9
[ 3127.171707] task: c0e67300 task.stack: c0f00000
[ 3127.176192] NIP: c068e734 LR: c068e734 CTR: c04672f4
[ 3127.181107] REGS: c0f01c90 TRAP: 0700   Not tainted  (4.9.13)
[ 3127.186793] MSR: 00029000 <CE,EE,ME>[ 3127.190241]   CR: 28122222  XER:
00000000
[ 3127.194210]
GPR00: c068e734 c0f01d40 c0e67300 00000038 d1006301 000000df c04683e4
000000df
GPR08: 000000df c0eff4b0 c0eff4b0 00000004 24122424 00b960f0 00000000
c0e80000
GPR16: 000ac8c1 c07b8618 c098bddc c0e69000 0000000a c0ee0000 c0e73f20
c0f00000
GPR24: c100e4e8 c0ee0000 c0e77d60 c3128000 c068e4f8 c0e80000 00000000
c3128000
NIP [c068e734] dev_watchdog+0x23c/0x244
[ 3127.227680] LR [c068e734] dev_watchdog+0x23c/0x244
[ 3127.232427] Call Trace:
[ 3127.234857] [c0f01d40] [c068e734] dev_watchdog+0x23c/0x244 (unreliable)
[ 3127.241447] [c0f01d60] [c00805e8] call_timer_fn+0x40/0x118
[ 3127.246889] [c0f01d80] [c00808e8] expire_timers.isra.13+0xbc/0x114
[ 3127.253032] [c0f01db0] [c0080a94] run_timer_softirq+0x90/0xf0
[ 3127.258753] [c0f01e00] [c07b31b4] __do_softirq+0x114/0x2b0
[ 3127.264202] [c0f01e60] [c002a158] irq_exit+0xe8/0xec
[ 3127.269144] [c0f01e70] [c0008c98] timer_interrupt+0x34/0x4c
[ 3127.274684] [c0f01e80] [c000ec94] ret_from_except+0x0/0x18
[ 3127.280151] --- interrupt: 901 at cpm_idle+0x3c/0x70
[ 3127.280151]     LR = arch_cpu_idle+0x30/0x68
[ 3127.289300] [c0f01f40] [c0f058e4] cpu_idle_force_poll+0x0/0x4
(unreliable)
[ 3127.296146] [c0f01f50] [c00073e4] arch_cpu_idle+0x30/0x68
[ 3127.301509] [c0f01f60] [c005bce8] cpu_startup_entry+0x184/0x1bc
[ 3127.307392] [c0f01fb0] [c0a76a1c] start_kernel+0x3d4/0x3e8
[ 3127.312843] [c0f01ff0] [c00000b4] _start+0xb4/0xf8
[ 3127.317599] Instruction dump:
[ 3127.320557] 811f0284 4bffff78 39200001 7fe3fb78 99281966 4bfd9cd5
7c651b78 3c60c0a1
[ 3127.328359] 7fc6f378 7fe4fb78 3863357c 48125319 <0fe00000> 4bffffb8
7c0802a6 90010004
[ 3127.336327] ---[ end trace c31dfe4772ff0e8f ]---

--001a1134eb4056341005526ac69f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>I&#39;m working on a project that is derived fro=
m the Yosemite</div><div>PPC 440EP board.=C2=A0 It&#39;s a legacy project t=
hat was running the</div><div>2.6.24 Kernel, and network traffic was stalli=
ng due to transmission</div><div>halting without an understandable error (i=
n this error condition, the various</div><div>status registers of network i=
nterface showed no issues), other=C2=A0</div><div>than TX stalling due to B=
uffer Descriptor Ring becoming full.</div><div><br></div><div>In order to s=
ee if the problem has been resolved, the Kernel</div><div>has been updated =
to 4.9.13, compiled with gcc version 5.4.0</div><div>(Buildroot 2017.02.2).=
=C2=A0 Although the frequency of the</div><div>problem is decreased, it sti=
ll does show up.</div><div><br></div><div>The test case is the Linux Target=
 running idle, no application</div><div>code.=C2=A0 From a Linux host on a =
directly connected network, 30</div><div>flood pings are started.=C2=A0 Aft=
er a period of several minutes to</div><div>perhaps hours, the transmit asp=
ect of the network controller</div><div>ceases to transmit packets (Buffer =
Descriptor ring becomes full).=C2=A0</div><div>RX still works.=C2=A0 In the=
 2.6.24 Kernel, the problem happens</div><div>within seconds, so it has imp=
roved with the new Kernel.</div><div><br></div><div>Below is the output fro=
m the Kernel when this happens.</div><div><br></div><div>Has anybody seen t=
his problem before?=C2=A0 I can&#39;t find any</div><div>errata on it, nor =
can I find any reports of it.</div><div><br></div><div>The orginal problem =
is rooted in the Embedded Application</div><div>running, and after a period=
 of time of heavy network</div><div>traffic, the TX side of network stalls.=
=C2=A0 The flood ping</div><div>test is used simply to force the problem to=
 happen.</div><div><br></div><div>[ 3127.143572] NETDEV WATCHDOG: eth0 (ema=
c): transmit queue 0 timed out</div><div>[ 3127.150172] ------------[ cut h=
ere ]------------</div><div>[ 3127.154778] WARNING: CPU: 0 PID: 0 at net/sc=
hed/sch_generic.c:316 dev_watchdog+0x23c/0x244</div><div>[ 3127.162965] Mod=
ules linked in:</div><div>[ 3127.166013] CPU: 0 PID: 0 Comm: swapper Not ta=
inted 4.9.13 #9</div><div>[ 3127.171707] task: c0e67300 task.stack: c0f0000=
0</div><div>[ 3127.176192] NIP: c068e734 LR: c068e734 CTR: c04672f4</div><d=
iv>[ 3127.181107] REGS: c0f01c90 TRAP: 0700 =C2=A0 Not tainted =C2=A0(4.9.1=
3)</div><div>[ 3127.186793] MSR: 00029000 &lt;CE,EE,ME&gt;[ 3127.190241] =
=C2=A0 CR: 28122222 =C2=A0XER: 00000000</div><div>[ 3127.194210]</div><div>=
GPR00: c068e734 c0f01d40 c0e67300 00000038 d1006301 000000df c04683e4 00000=
0df</div><div>GPR08: 000000df c0eff4b0 c0eff4b0 00000004 24122424 00b960f0 =
00000000 c0e80000</div><div>GPR16: 000ac8c1 c07b8618 c098bddc c0e69000 0000=
000a c0ee0000 c0e73f20 c0f00000</div><div>GPR24: c100e4e8 c0ee0000 c0e77d60=
 c3128000 c068e4f8 c0e80000 00000000 c3128000</div><div>NIP [c068e734] dev_=
watchdog+0x23c/0x244</div><div>[ 3127.227680] LR [c068e734] dev_watchdog+0x=
23c/0x244</div><div>[ 3127.232427] Call Trace:</div><div>[ 3127.234857] [c0=
f01d40] [c068e734] dev_watchdog+0x23c/0x244 (unreliable)</div><div>[ 3127.2=
41447] [c0f01d60] [c00805e8] call_timer_fn+0x40/0x118</div><div>[ 3127.2468=
89] [c0f01d80] [c00808e8] expire_timers.isra.13+0xbc/0x114</div><div>[ 3127=
.253032] [c0f01db0] [c0080a94] run_timer_softirq+0x90/0xf0</div><div>[ 3127=
.258753] [c0f01e00] [c07b31b4] __do_softirq+0x114/0x2b0</div><div>[ 3127.26=
4202] [c0f01e60] [c002a158] irq_exit+0xe8/0xec</div><div>[ 3127.269144] [c0=
f01e70] [c0008c98] timer_interrupt+0x34/0x4c</div><div>[ 3127.274684] [c0f0=
1e80] [c000ec94] ret_from_except+0x0/0x18</div><div>[ 3127.280151] --- inte=
rrupt: 901 at cpm_idle+0x3c/0x70</div><div>[ 3127.280151] =C2=A0 =C2=A0 LR =
=3D arch_cpu_idle+0x30/0x68</div><div>[ 3127.289300] [c0f01f40] [c0f058e4] =
cpu_idle_force_poll+0x0/0x4 (unreliable)</div><div>[ 3127.296146] [c0f01f50=
] [c00073e4] arch_cpu_idle+0x30/0x68</div><div>[ 3127.301509] [c0f01f60] [c=
005bce8] cpu_startup_entry+0x184/0x1bc</div><div>[ 3127.307392] [c0f01fb0] =
[c0a76a1c] start_kernel+0x3d4/0x3e8</div><div>[ 3127.312843] [c0f01ff0] [c0=
0000b4] _start+0xb4/0xf8</div><div>[ 3127.317599] Instruction dump:</div><d=
iv>[ 3127.320557] 811f0284 4bffff78 39200001 7fe3fb78 99281966 4bfd9cd5 7c6=
51b78 3c60c0a1</div><div>[ 3127.328359] 7fc6f378 7fe4fb78 3863357c 48125319=
 &lt;0fe00000&gt; 4bffffb8 7c0802a6 90010004</div><div>[ 3127.336327] ---[ =
end trace c31dfe4772ff0e8f ]---</div></div><div><br></div></div>

--001a1134eb4056341005526ac69f--
