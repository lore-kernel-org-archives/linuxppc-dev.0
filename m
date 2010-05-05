Return-Path: <Matthias.Dunda@de.thalesgroup.com>
Received: from ns.de.thalesgroup.com (ns.de.thalesgroup.com [62.225.145.226])
	by ozlabs.org (Postfix) with ESMTP id 1431BB6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 May 2010 18:36:04 +1000 (EST)
Received: from ns.de.thalesgroup.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 842AD6F0039
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 May 2010 09:23:17 +0200 (CEST)
Received: from sv017.mail.de.thalesgroup.com (sv017 [172.26.41.66])
	by ns.de.thalesgroup.com (Postfix) with ESMTP id E0F7B6F011F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 May 2010 09:23:16 +0200 (CEST)
Received: from TNDKI007.kiel.thales-naval.de (unknown [10.169.2.7])
	by sv017.mail.de.thalesgroup.com (Postfix) with ESMTP id 546922BC180
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 May 2010 10:27:44 +0200 (CEST)
Message-ID: <569685F045B85741820D0265E0D2999D019CFE8B@tddhh01.hh.thales-naval.de>
From: "Dunda, Matthias" <Matthias.Dunda@de.thalesgroup.com>
To: "'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
Subject: Kernel errors at very early stage
Date: Wed, 5 May 2010 10:27:42 +0200 
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_000_01CAEC2C.D4B8D6C0"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01CAEC2C.D4B8D6C0
Content-Type: text/plain

Hi all-

we've built a custom board with a FSL MPC8568EMDS CPU.

U-Boot works so far - at least it is able to load a Linux kernel and a
flattened device tree via network and launch the kernel.

I get no output on the serial console from the kernel, so my only chance is
to read out the __log_buf while in memory with my Abatron BDI 3000 debugger.

The thing is, I cannot break into the code really, because it never stops
reliable at my break points... :-(

Can anyone of you see a usual suspect in the attached log?

Is there something wrong with the timing, maybe? Maybe a hardware issue?

How can I check this?

Cheers
Matthias



------_=_NextPart_000_01CAEC2C.D4B8D6C0
Content-Type: application/octet-stream;
	name="kernel-log.008"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="kernel-log.008"

<4>Invalid tag 0 scanning flattened device tree !=0A=
<4>Invalid tag 0 scanning flattened device tree !=0A=
<4>Invalid tag 0 scanning flattened device tree !=0A=
<4>PHYSICAL_START=3D0x00000000 =0A=
<4>klimit=3D0xc0442000 =0A=
<4>__pa(klimit)=3D0x00442000 =0A=
<4>First lmb_reserved passed!=0A=
<0>------------[ cut here ]------------=0A=
<2>Kernel BUG at c039b3ec [verbose debug info unavailable]=0A=
<4>Oops: Exception in kernel mode, sig: 5 [#1]=0A=
<4>PREEMPT =0A=
<4>Modules linked in:=0A=
<4>NIP: c039b3ec LR: c038a308 CTR: c02e14ac=0A=
<4>REGS: c03ddef0 TRAP: 0700   Not tainted  (2.6.29.6-rt23-svn20)=0A=
<4>MSR: 00021000 <ME,CE>  CR: 28044024  XER: 00000000=0A=
<4>TASK =3D c03b1508[0] 'swapper' THREAD: c03dc000=0A=
<6>GPR00: 00000001 c03ddfa0 c03b1508 00000000 00400000 00000000 =
00400000 00000000 =0A=
<6>GPR08: 00000000 c0400000 00000104 c03ddfb0 28044022 00000000 =
7ff78e00 00000000 =0A=
<6>GPR16: 7ff494ec 7ff6d648 00000000 00000000 00000000 00000000 =
00000000 00000000 =0A=
<6>GPR24: 00000000 00000000 c03e0000 00000000 00400000 c03e0000 =
c0400000 c03ddfa0 =0A=
<4>NIP [c039b3ec] lmb_reserve+0x30/0x5c=0A=
<4>LR [c038a308] early_init_devtree+0x104/0x2e8=0A=
<4>Call Trace:=0A=
<4>[c03ddfa0] [000000e6] 0xe6 (unreliable)=0A=
<4>[c03ddfb0] [c038a308] early_init_devtree+0x104/0x2e8=0A=
<4>[c03ddfd0] [c038b1dc] machine_init+0x24/0x64=0A=
<4>[c03ddff0] [c000039c] skpinv+0x2c4/0x304=0A=
<4>Instruction dump:=0A=
<4>9421fff0 7c0802a6 93e1000c 90010014 7c3f0b78 7ca03379 7cc83378 =
7ca72b78 =0A=
<4>7c862378 7c651b78 7c000026 54001ffe <0f000000> 3c60c043 38635698 =
38630830 =0A=
<4>---[ end trace 31fd0ba7d8756001 ]---=0A=
<0>Kernel panic - not syncing: Attempted to kill the idle task!=0A=
<1>Unable to handle kernel paging request for data at address =
0x00000010=0A=
<1>Faulting instruction address: 0xc0068824=0A=
<4>Oops: Kernel access of bad area, sig: 11 [#2]=0A=
<4>PREEMPT =0A=
<4>Modules linked in:=0A=
<4>NIP: c0068824 LR: c006d9e8 CTR: c00687c0=0A=
<4>REGS: c03ddad0 TRAP: 0300   Tainted: G      D     =
(2.6.29.6-rt23-svn20)=0A=
<4>MSR: 00021000 <ME,CE>  CR: 28044024  XER: 00000000=0A=
<4>DEAR: 00000010, ESR: 00000000=0A=
<4>TASK =3D c03b1508[0] 'swapper' THREAD: c03dc000=0A=
<6>GPR00: 00000000 c03ddb80 c03b1508 c03ddbd8 00000000 00000000 =
00000000 00000000 =0A=
<6>GPR08: 59bbe120 00000000 00000000 00000000 00000000 00000000 =
7ff78e00 00000000 =0A=
<6>GPR16: 7ff494ec c03ddbd8 c03e31a0 c03e3190 c03e0000 c03e0000 =
00021000 c03ddbd8 =0A=
<6>GPR24: c03e0000 c03e0000 c03ddef0 00000000 00000000 c03b24c8 =
00000000 c03ddb80 =0A=
<4>NIP [c0068824] ktime_get+0x70/0x15c=0A=
<4>LR [c006d9e8] tick_nohz_stop_sched_tick+0x40/0x414=0A=
<4>Call Trace:=0A=
<4>[c03ddb80] [c033282d] 0xc033282d (unreliable)=0A=
<4>[c03ddbd0] [c006d9e8] tick_nohz_stop_sched_tick+0x40/0x414=0A=
<4>[c03ddc20] [c0048000] irq_exit+0x80/0xac=0A=
<4>[c03ddc30] [c000d760] timer_interrupt+0xb8/0x110=0A=
<4>[c03ddc50] [c0011c88] ret_from_except+0x0/0x18=0A=
<4>[c03ddd10] [c0041148] panic+0xb8/0x178=0A=
<4>[c03ddd60] [c004571c] do_exit+0x63c/0x6f8=0A=
<4>[c03ddda0] [c000e65c] die+0x1c0/0x1fc=0A=
<4>[c03dddd0] [c000ea08] _exception+0x168/0x194=0A=
<4>[c03ddec0] [c000efb4] program_check_exception+0x94/0x630=0A=
<4>[c03ddee0] [c0011c3c] ret_from_except_full+0x0/0x4c=0A=
<4>[c03ddfa0] [000000e6] 0xe6=0A=
<4>[c03ddfb0] [c038a308] early_init_devtree+0x104/0x2e8=0A=
<4>[c03ddfd0] [c038b1dc] machine_init+0x24/0x64=0A=
<4>[c03ddff0] [c000039c] skpinv+0x2c4/0x304=0A=
<4>Instruction dump:=0A=
<4>3f20c03e 3e80c03e 3ea0c03e 83d93180 3a5431a0 3a753190 3f00c03e =
73db0001 =0A=
<4>408200bc 813831a8 815431a0 81753190 <81290010> 80130004 83920004 =
7f4a5a14 =0A=
<4>---[ end trace 31fd0ba7d8756002 ]---=0A=
<0>Kernel panic - not syncing: Attempted to kill the idle task!=0A=

------_=_NextPart_000_01CAEC2C.D4B8D6C0--
