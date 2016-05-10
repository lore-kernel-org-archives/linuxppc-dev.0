Return-Path: <bsingharora@gmail.com>
Received: from mail-yw0-x236.google.com (mail-yw0-x236.google.com
 [IPv6:2607:f8b0:4002:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r43KK19nvzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 01:37:25 +1000 (AEST)
Received: by mail-yw0-x236.google.com with SMTP id j74so15432414ywg.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 08:37:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <874ma6j6n6.fsf@skywalker.in.ibm.com>
References: <874ma6j6n6.fsf@skywalker.in.ibm.com>
Date: Tue, 10 May 2016 21:07:22 +0530
Message-ID: <CAKTCnz=ZKWHGt8AknXMcrU6GqwE6waJu2B1f9aNey+rDSBsedA@mail.gmail.com>
Subject: Re: softlockup with 4.6.0-rc3-00130-g4d2a14c
From: Balbir Singh <bsingharora@gmail.com>
To: Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, mpe@ellerman.id.au
Content-Type: multipart/alternative; boundary=94eb2c087654807a1405327eb317
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c087654807a1405327eb317
Content-Type: text/plain; charset=UTF-8

On 11 May 2016 01:05, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
wrote:
>
>
> I am finding the below softlockups with kvm guest. This is using the
> same version of kernel for host and guest.
>
> [  323.547841] NMI watchdog: BUG: soft lockup - CPU#7 stuck for 22s!
[systemd-timesyn:3116]
> [  323.548023] Modules linked in:
> [  323.548029] CPU: 7 PID: 3116 Comm: systemd-timesyn Not tainted
4.6.0-rc3-00130-g4d2a14c #2
> [  323.548031] task: c000000038b16d00 ti: c00000003baac000 task.ti:
c00000003baac000
> [  323.548032] NIP: c00000000005b404 LR: c000000000934c68 CTR:
c000000000099650
> [  323.548033] REGS: c00000003baaf9d0 TRAP: 0901   Not tainted
(4.6.0-rc3-00130-g4d2a14c)
> [  323.548034] MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR:
48002844  XER: 00000000
> [  323.548040] CFAR: c000000000934c64 SOFTE: 1
>                GPR00: c000000000934c68 c00000003baafc50 c000000000db3f00
c000000000e7e978
>                GPR04: 0000000000000001 00000000000081d0 000bd4444b0f5a4e
0000000000000000
>                GPR08: c000000000e207b8 0000000000000002 0000000080000001
0000000000000000
>                GPR12: c00000000001cfb0 c00000000fe01c00
> [  323.548055] NIP [c00000000005b404] __spin_yield+0x14/0xa0
> [  323.548059] LR [c000000000934c68] _raw_spin_lock_irqsave+0x118/0x120
> [  323.548060] Call Trace:
> [  323.548062] [c00000003baafc50] [c000000000934c68]
_raw_spin_lock_irqsave+0x118/0x120 (unreliable)
> [  323.548065] [c00000003baafc90] [c000000000139a6c]
do_adjtimex+0x9c/0x1c0
> [  323.548068] [c00000003baafd00] [c00000000013238c]
posix_clock_realtime_adj+0x1c/0x30
> [  323.548070] [c00000003baafd20] [c000000000133920]
SyS_clock_adjtime+0xa0/0x150
> [  323.548073] [c00000003baafe30] [c000000000009260]
system_call+0x38/0x108
> [  323.548074] Instruction dump:
> [  323.548075] eba1ffe8 eb81ffe0 eb61ffd8 4e800020 60000000 60000000
60000000 3c4c00d6
> [  323.548078] 38428b10 81430000 2faa0000 4d9e0020 <79490420> 2b8907ff
79290020 7d101026
>
>
> --------------------
>
> [   21.926941] INFO: rcu_sched self-detected stall on CPU
> [   21.931553]  7-...: (2098 ticks this GP) idle=9b3/140000000000001/0
softirq=204/267 fqs=2097
> [   21.931601]   (t=2100 jiffies g=-249 c=-250 q=23178)
> [   21.931751] Task dump for CPU 7:
> [   21.931755] systemd         R  running task     9872     1      0
0x00040004
> [   21.931763] Call Trace:
> [   21.931773] [c00000003e503630] [c0000000000e783c]
sched_show_task+0xec/0x180 (unreliable)
> [   21.931779] [c00000003e5036a0] [c000000000123504]
rcu_dump_cpu_stacks+0xe4/0x150
> [   21.931783] [c00000003e5036f0] [c000000000128214]
rcu_check_callbacks+0x6b4/0x9c0
> [   21.931804] [c00000003e503810] [c00000000012ec7c]
update_process_times+0x4c/0xa0
> [   21.931809] [c00000003e503840] [c000000000143828]
tick_sched_handle.isra.5+0x28/0xb0
> [   21.931812] [c00000003e503870] [c00000000014390c]
tick_sched_timer+0x5c/0xd0
> [   21.931816] [c00000003e5038b0] [c00000000012f528]
__hrtimer_run_queues+0xf8/0x380
> [   21.931819] [c00000003e503930] [c0000000001303e0]
hrtimer_interrupt+0xe0/0x2b0
> [   21.931823] [c00000003e5039f0] [c00000000001d57c]
__timer_interrupt+0x8c/0x270
> [   21.931826] [c00000003e503a40] [c00000000001dc5c]
timer_interrupt+0x9c/0xe0
> [   21.931830] [c00000003e503a70] [c000000000002750]
decrementer_common+0x150/0x180
> [   21.931834] --- interrupt: 901 at ktime_get_ts64+0xf0/0x150
>                    LR = ktime_get_ts64+0x74/0x150
> [   21.931836] [c00000003e503d60] [0000000000000000]           (null)
(unreliable)
> [   21.931841] [c00000003e503da0] [c00000000029fa38]
poll_select_set_timeout+0x78/0xd0
> [   21.931844] [c00000003e503de0] [c0000000002a1020] SyS_poll+0x80/0x150
> [   21.931847] [c00000003e503e30] [c000000000009260]
system_call+0x38/0x108
> [   24.006941] NMI watchdog: BUG: soft lockup - CPU#7 stuck for 21s!
[systemd:1]
> [   24.007117] Modules linked in:
> [   24.007122] CPU: 7 PID: 1 Comm: systemd Not tainted
4.6.0-rc3-00130-g4d2a14c #1
> [   24.007123] task: c00000003e4c0000 ti: c00000003e500000 task.ti:
c00000003e500000
> [   24.007125] NIP: c000000000137400 LR: c000000000137384 CTR:
c00000000001cfb0
> [   24.007126] REGS: c00000003e503ae0 TRAP: 0901   Not tainted
(4.6.0-rc3-00130-g4d2a14c)
> [   24.007126] MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR:
28424844  XER: 20000000
> [   24.007132] CFAR: c000000000137414 SOFTE: 1
>                GPR00: c00000000029fa38 c00000003e503d60 c000000000db3a00
000000000025ff39
>                GPR04: ffffffffa8ce0e65 ac491cb5c5ec0000 000000005731f19b
0000000000000000
>                GPR08: 000000003b9ac9ff 2af484699eac9820 0000000093054a12
ffffffffffffffff
>                GPR12: c00000000001cfb0 c00000000fe01c00
> [   24.007141] NIP [c000000000137400] ktime_get_ts64+0xf0/0x150
> [   24.007143] LR [c000000000137384] ktime_get_ts64+0x74/0x150
> [   24.007143] Call Trace:
> [   24.007145] [c00000003e503da0] [c00000000029fa38]
poll_select_set_timeout+0x78/0xd0
> [   24.007146] [c00000003e503de0] [c0000000002a1020] SyS_poll+0x80/0x150
> [   24.007148] [c00000003e503e30] [c000000000009260]
system_call+0x38/0x108
> [   24.007149] Instruction dump:
> [   24.007151] 7ce94e34 7ce43214 7d295214 39400000 7fa94040 409d0034
48000018 60000000
> [   24.007154] 60000000 60000000 60000000 60420000 <3d29c465> 394a0001
39293600 794a0020
> [   28.745210] Adding 917440k swap on /dev/vda3.  Priority:-1 extents:1
across:917440k
> [   28.759694] EXT4-fs (vda2): re-mounted. Opts: errors=remount-ro
>
> -aneesh
Do you wasn't to try with lockdep enabled? May be it will narrow it down
further

Balbir

--94eb2c087654807a1405327eb317
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On 11 May 2016 01:05, &quot;Aneesh Kumar K.V&quot; &lt;<a href=3D"mailto:an=
eesh.kumar@linux.vnet.ibm.com">aneesh.kumar@linux.vnet.ibm.com</a>&gt; wrot=
e:<br>
&gt;<br>
&gt;<br>
&gt; I am finding the below softlockups with kvm guest. This is using the<b=
r>
&gt; same version of kernel for host and guest.<br>
&gt;<br>
&gt; [=C2=A0 323.547841] NMI watchdog: BUG: soft lockup - CPU#7 stuck for 2=
2s! [systemd-timesyn:3116]<br>
&gt; [=C2=A0 323.548023] Modules linked in:<br>
&gt; [=C2=A0 323.548029] CPU: 7 PID: 3116 Comm: systemd-timesyn Not tainted=
 4.6.0-rc3-00130-g4d2a14c #2<br>
&gt; [=C2=A0 323.548031] task: c000000038b16d00 ti: c00000003baac000 task.t=
i: c00000003baac000<br>
&gt; [=C2=A0 323.548032] NIP: c00000000005b404 LR: c000000000934c68 CTR: c0=
00000000099650<br>
&gt; [=C2=A0 323.548033] REGS: c00000003baaf9d0 TRAP: 0901=C2=A0 =C2=A0Not =
tainted=C2=A0 (4.6.0-rc3-00130-g4d2a14c)<br>
&gt; [=C2=A0 323.548034] MSR: 8000000000009033 &lt;SF,EE,ME,IR,DR,RI,LE&gt;=
=C2=A0 CR: 48002844=C2=A0 XER: 00000000<br>
&gt; [=C2=A0 323.548040] CFAR: c000000000934c64 SOFTE: 1<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPR00: c0000000=
00934c68 c00000003baafc50 c000000000db3f00 c000000000e7e978<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPR04: 00000000=
00000001 00000000000081d0 000bd4444b0f5a4e 0000000000000000<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPR08: c0000000=
00e207b8 0000000000000002 0000000080000001 0000000000000000<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPR12: c0000000=
0001cfb0 c00000000fe01c00<br>
&gt; [=C2=A0 323.548055] NIP [c00000000005b404] __spin_yield+0x14/0xa0<br>
&gt; [=C2=A0 323.548059] LR [c000000000934c68] _raw_spin_lock_irqsave+0x118=
/0x120<br>
&gt; [=C2=A0 323.548060] Call Trace:<br>
&gt; [=C2=A0 323.548062] [c00000003baafc50] [c000000000934c68] _raw_spin_lo=
ck_irqsave+0x118/0x120 (unreliable)<br>
&gt; [=C2=A0 323.548065] [c00000003baafc90] [c000000000139a6c] do_adjtimex+=
0x9c/0x1c0<br>
&gt; [=C2=A0 323.548068] [c00000003baafd00] [c00000000013238c] posix_clock_=
realtime_adj+0x1c/0x30<br>
&gt; [=C2=A0 323.548070] [c00000003baafd20] [c000000000133920] SyS_clock_ad=
jtime+0xa0/0x150<br>
&gt; [=C2=A0 323.548073] [c00000003baafe30] [c000000000009260] system_call+=
0x38/0x108<br>
&gt; [=C2=A0 323.548074] Instruction dump:<br>
&gt; [=C2=A0 323.548075] eba1ffe8 eb81ffe0 eb61ffd8 4e800020 60000000 60000=
000 60000000 3c4c00d6<br>
&gt; [=C2=A0 323.548078] 38428b10 81430000 2faa0000 4d9e0020 &lt;79490420&g=
t; 2b8907ff 79290020 7d101026<br>
&gt;<br>
&gt;<br>
&gt; --------------------<br>
&gt;<br>
&gt; [=C2=A0 =C2=A021.926941] INFO: rcu_sched self-detected stall on CPU<br=
>
&gt; [=C2=A0 =C2=A021.931553]=C2=A0 7-...: (2098 ticks this GP) idle=3D9b3/=
140000000000001/0 softirq=3D204/267 fqs=3D2097<br>
&gt; [=C2=A0 =C2=A021.931601]=C2=A0 =C2=A0(t=3D2100 jiffies g=3D-249 c=3D-2=
50 q=3D23178)<br>
&gt; [=C2=A0 =C2=A021.931751] Task dump for CPU 7:<br>
&gt; [=C2=A0 =C2=A021.931755] systemd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0R=C2=
=A0 running task=C2=A0 =C2=A0 =C2=A09872=C2=A0 =C2=A0 =C2=A01=C2=A0 =C2=A0 =
=C2=A0 0 0x00040004<br>
&gt; [=C2=A0 =C2=A021.931763] Call Trace:<br>
&gt; [=C2=A0 =C2=A021.931773] [c00000003e503630] [c0000000000e783c] sched_s=
how_task+0xec/0x180 (unreliable)<br>
&gt; [=C2=A0 =C2=A021.931779] [c00000003e5036a0] [c000000000123504] rcu_dum=
p_cpu_stacks+0xe4/0x150<br>
&gt; [=C2=A0 =C2=A021.931783] [c00000003e5036f0] [c000000000128214] rcu_che=
ck_callbacks+0x6b4/0x9c0<br>
&gt; [=C2=A0 =C2=A021.931804] [c00000003e503810] [c00000000012ec7c] update_=
process_times+0x4c/0xa0<br>
&gt; [=C2=A0 =C2=A021.931809] [c00000003e503840] [c000000000143828] tick_sc=
hed_handle.isra.5+0x28/0xb0<br>
&gt; [=C2=A0 =C2=A021.931812] [c00000003e503870] [c00000000014390c] tick_sc=
hed_timer+0x5c/0xd0<br>
&gt; [=C2=A0 =C2=A021.931816] [c00000003e5038b0] [c00000000012f528] __hrtim=
er_run_queues+0xf8/0x380<br>
&gt; [=C2=A0 =C2=A021.931819] [c00000003e503930] [c0000000001303e0] hrtimer=
_interrupt+0xe0/0x2b0<br>
&gt; [=C2=A0 =C2=A021.931823] [c00000003e5039f0] [c00000000001d57c] __timer=
_interrupt+0x8c/0x270<br>
&gt; [=C2=A0 =C2=A021.931826] [c00000003e503a40] [c00000000001dc5c] timer_i=
nterrupt+0x9c/0xe0<br>
&gt; [=C2=A0 =C2=A021.931830] [c00000003e503a70] [c000000000002750] decreme=
nter_common+0x150/0x180<br>
&gt; [=C2=A0 =C2=A021.931834] --- interrupt: 901 at ktime_get_ts64+0xf0/0x1=
50<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0L=
R =3D ktime_get_ts64+0x74/0x150<br>
&gt; [=C2=A0 =C2=A021.931836] [c00000003e503d60] [0000000000000000]=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(null) (unreliable)<br>
&gt; [=C2=A0 =C2=A021.931841] [c00000003e503da0] [c00000000029fa38] poll_se=
lect_set_timeout+0x78/0xd0<br>
&gt; [=C2=A0 =C2=A021.931844] [c00000003e503de0] [c0000000002a1020] SyS_pol=
l+0x80/0x150<br>
&gt; [=C2=A0 =C2=A021.931847] [c00000003e503e30] [c000000000009260] system_=
call+0x38/0x108<br>
&gt; [=C2=A0 =C2=A024.006941] NMI watchdog: BUG: soft lockup - CPU#7 stuck =
for 21s! [systemd:1]<br>
&gt; [=C2=A0 =C2=A024.007117] Modules linked in:<br>
&gt; [=C2=A0 =C2=A024.007122] CPU: 7 PID: 1 Comm: systemd Not tainted 4.6.0=
-rc3-00130-g4d2a14c #1<br>
&gt; [=C2=A0 =C2=A024.007123] task: c00000003e4c0000 ti: c00000003e500000 t=
ask.ti: c00000003e500000<br>
&gt; [=C2=A0 =C2=A024.007125] NIP: c000000000137400 LR: c000000000137384 CT=
R: c00000000001cfb0<br>
&gt; [=C2=A0 =C2=A024.007126] REGS: c00000003e503ae0 TRAP: 0901=C2=A0 =C2=
=A0Not tainted=C2=A0 (4.6.0-rc3-00130-g4d2a14c)<br>
&gt; [=C2=A0 =C2=A024.007126] MSR: 8000000000009033 &lt;SF,EE,ME,IR,DR,RI,L=
E&gt;=C2=A0 CR: 28424844=C2=A0 XER: 20000000<br>
&gt; [=C2=A0 =C2=A024.007132] CFAR: c000000000137414 SOFTE: 1<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPR00: c0000000=
0029fa38 c00000003e503d60 c000000000db3a00 000000000025ff39<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPR04: ffffffff=
a8ce0e65 ac491cb5c5ec0000 000000005731f19b 0000000000000000<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPR08: 00000000=
3b9ac9ff 2af484699eac9820 0000000093054a12 ffffffffffffffff<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPR12: c0000000=
0001cfb0 c00000000fe01c00<br>
&gt; [=C2=A0 =C2=A024.007141] NIP [c000000000137400] ktime_get_ts64+0xf0/0x=
150<br>
&gt; [=C2=A0 =C2=A024.007143] LR [c000000000137384] ktime_get_ts64+0x74/0x1=
50<br>
&gt; [=C2=A0 =C2=A024.007143] Call Trace:<br>
&gt; [=C2=A0 =C2=A024.007145] [c00000003e503da0] [c00000000029fa38] poll_se=
lect_set_timeout+0x78/0xd0<br>
&gt; [=C2=A0 =C2=A024.007146] [c00000003e503de0] [c0000000002a1020] SyS_pol=
l+0x80/0x150<br>
&gt; [=C2=A0 =C2=A024.007148] [c00000003e503e30] [c000000000009260] system_=
call+0x38/0x108<br>
&gt; [=C2=A0 =C2=A024.007149] Instruction dump:<br>
&gt; [=C2=A0 =C2=A024.007151] 7ce94e34 7ce43214 7d295214 39400000 7fa94040 =
409d0034 48000018 60000000<br>
&gt; [=C2=A0 =C2=A024.007154] 60000000 60000000 60000000 60420000 &lt;3d29c=
465&gt; 394a0001 39293600 794a0020<br>
&gt; [=C2=A0 =C2=A028.745210] Adding 917440k swap on /dev/vda3.=C2=A0 Prior=
ity:-1 extents:1 across:917440k<br>
&gt; [=C2=A0 =C2=A028.759694] EXT4-fs (vda2): re-mounted. Opts: errors=3Dre=
mount-ro<br>
&gt;<br>
&gt; -aneesh<br>
Do you wasn&#39;t to try with lockdep enabled? May be it will narrow it dow=
n further</p>
<p dir=3D"ltr">Balbir<br>
</p>

--94eb2c087654807a1405327eb317--
