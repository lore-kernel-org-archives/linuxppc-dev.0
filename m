Return-Path: <jsperbeck@google.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zG12c07hyzF0RS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 16:31:02 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id b141so18136789wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jan 2018 21:31:02 -0800 (PST)
MIME-Version: 1.0
From: John Sperbeck <jsperbeck@google.com>
Date: Mon, 8 Jan 2018 21:30:59 -0800
Message-ID: <CAFNjLiW4Dc9J_Q6L0zOT1f+AyNYOLWFPk1iXb7JNTPaqpozkCQ@mail.gmail.com>
Subject: Sleep in preempt_disable on powernv with 'cat /proc/cpuinfo' on v4.15
To: Shriya <shriyak@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="94eb2c0c3d5250239e0562513865"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c0c3d5250239e0562513865
Content-Type: text/plain; charset="UTF-8"

The pnv_get_proc_freq() function was recently changed to call
cpufreq_get(), instead of cpufreq_quick_get(), in order to fetch
a more up-to-date value for the CPU frequency:

   cd77b5ce208c153260ed7882d8910f2395bfaabd
   powerpc/powernv/cpufreq: Fix the frequency read by /proc/cpuinfo

Unfortunately, this function is called from show_cpuinfo() in
arch/powerpc/kernel/setup-common.c with preemption disabled.  The
cpufreq_get() function might do a down_read(), which can sleep.

With CONFIG_DEBUG_KERNEL and CONFIG_DEBUG_ATOMIC_SLEEP set, a warning
like the following is generated when running 'cat /proc/cpuinfo':

    BUG: sleeping function called from invalid context at
kernel/locking/rwsem.c:23
    in_atomic(): 1, irqs_disabled(): 0, pid: 16939, name: cat
    CPU: 33 PID: 16939 Comm: cat Tainted: G        W        4.15.0-smp-DEV
#1
    Call Trace:
    [c000000fef07bab0] [c000000000a32c30] dump_stack+0xb0/0xf0 (unreliable)
    [c000000fef07baf0] [c0000000001343a8] ___might_sleep+0x178/0x1b0
    [c000000fef07bb70] [c000000000a50f58] down_read+0x38/0x90
    [c000000fef07bba0] [c0000000008287d0] cpufreq_get+0x50/0xc0
    [c000000fef07bbf0] [c000000000097a08] pnv_get_proc_freq+0x28/0x60
    [c000000fef07bc20] [c00000000002c554] show_cpuinfo+0x194/0x450
    [c000000fef07bcb0] [c00000000039c848] seq_read+0x1f8/0x590
    [c000000fef07bd40] [c00000000040d1d4] proc_reg_read+0xb4/0x180
    [c000000fef07bd90] [c00000000035d6a0] vfs_read+0x100/0x220
    [c000000fef07bde0] [c00000000035dc6c] SyS_read+0x6c/0x110
    [c000000fef07be30] [c00000000000b220] system_call+0x58/0x6c

--94eb2c0c3d5250239e0562513865
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The pnv_get_proc_freq() function was recently changed to c=
all<br>cpufreq_get(), instead of cpufreq_quick_get(), in order to fetch<br>=
a more up-to-date value for the CPU frequency:<br><br>=C2=A0 =C2=A0cd77b5ce=
208c153260ed7882d8910f2395bfaabd<br>=C2=A0 =C2=A0powerpc/powernv/cpufreq: F=
ix the frequency read by /proc/cpuinfo<br><br>Unfortunately, this function =
is called from show_cpuinfo() in<br>arch/powerpc/kernel/setup-common.c with=
 preemption disabled.=C2=A0 The<br>cpufreq_get() function might do a down_r=
ead(), which can sleep.<br><br>With CONFIG_DEBUG_KERNEL and CONFIG_DEBUG_AT=
OMIC_SLEEP set, a warning<br>like the following is generated when running &=
#39;cat /proc/cpuinfo&#39;:<br><br>=C2=A0 =C2=A0 BUG: sleeping function cal=
led from invalid context at kernel/locking/rwsem.c:23<br>=C2=A0 =C2=A0 in_a=
tomic(): 1, irqs_disabled(): 0, pid: 16939, name: cat<br>=C2=A0 =C2=A0 CPU:=
 33 PID: 16939 Comm: cat Tainted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0 =C2=
=A0 =C2=A0 =C2=A04.15.0-smp-DEV #1<br>=C2=A0 =C2=A0 Call Trace:<br>=C2=A0 =
=C2=A0 [c000000fef07bab0] [c000000000a32c30] dump_stack+0xb0/0xf0 (unreliab=
le)<br>=C2=A0 =C2=A0 [c000000fef07baf0] [c0000000001343a8] ___might_sleep+0=
x178/0x1b0<br>=C2=A0 =C2=A0 [c000000fef07bb70] [c000000000a50f58] down_read=
+0x38/0x90<br>=C2=A0 =C2=A0 [c000000fef07bba0] [c0000000008287d0] cpufreq_g=
et+0x50/0xc0<br>=C2=A0 =C2=A0 [c000000fef07bbf0] [c000000000097a08] pnv_get=
_proc_freq+0x28/0x60<br>=C2=A0 =C2=A0 [c000000fef07bc20] [c00000000002c554]=
 show_cpuinfo+0x194/0x450<br>=C2=A0 =C2=A0 [c000000fef07bcb0] [c00000000039=
c848] seq_read+0x1f8/0x590<br>=C2=A0 =C2=A0 [c000000fef07bd40] [c0000000004=
0d1d4] proc_reg_read+0xb4/0x180<br>=C2=A0 =C2=A0 [c000000fef07bd90] [c00000=
000035d6a0] vfs_read+0x100/0x220<br>=C2=A0 =C2=A0 [c000000fef07bde0] [c0000=
0000035dc6c] SyS_read+0x6c/0x110<br>=C2=A0 =C2=A0 [c000000fef07be30] [c0000=
0000000b220] system_call+0x58/0x6c<br><div><br></div></div>

--94eb2c0c3d5250239e0562513865--
