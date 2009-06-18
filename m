Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D6E5EB7213
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 22:04:07 +1000 (EST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B923ADDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 22:04:06 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5IM1DTS017551
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 08:01:13 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5IC42qY446964
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 22:04:02 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5IC42Rt007554
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 22:04:02 +1000
Message-ID: <4A3A2D2B.7070704@in.ibm.com>
Date: Thu, 18 Jun 2009 17:33:55 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PowerPC] Badness at drivers/char/tty_ldisc.c:210 during shutdown
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I came across the following badness message during shutdown on a Power6 box.
This was with 2.6.30-git12(3fe0344faf7fdcb158bd5c1a9aec960a8d70c8e8)

------------[ cut here ]------------
Badness at drivers/char/tty_ldisc.c:210
NIP: c000000000409428 LR: c000000000409410 CTR: 0000000000000000
REGS: c0000000374f37f0 TRAP: 0700   Not tainted  (2.6.30-git12)
MSR: 8000000000029032 <EE,ME,CE,IR,DR>  CR: 24000484  XER: 00000001
TASK = c00000003d941ae0[8535] 'vhangup' THREAD: c0000000374f0000 CPU: 1
<6>GPR00: 0000000000000001 c0000000374f3a70 c000000000ef4550 0000000000000001
<6>GPR04: c000000000409410 c00000003e99f000 c000000000406ba0 0000000000000000
<6>GPR08: 0000000000000000 0000000000000000 0000000000000000 c0000000374f3a70
<6>GPR12: 0000000024000488 c000000001002600 00000000ffffffff ffffffffffffffff
<6>GPR16: 00000000320c8a50 0000000000000002 0000000000000000 00000000320b03b0
<6>GPR20: 0000000000000000 0000000000000000 c00000003e1d3d00 0000000000000001
<6>GPR24: 0000000000000000 0000000000000000 0000000000000001 c00000003d4a05e0
<6>GPR28: 0000000000000000 c0000000013ffd38 c000000000e7e610 c0000000374f3a70
NIP [c000000000409428] .tty_ldisc_put+0xbc/0xf4
LR [c000000000409410] .tty_ldisc_put+0xa4/0xf4
Call Trace:
[c0000000374f3a70] [c000000000409410] .tty_ldisc_put+0xa4/0xf4 (unreliable)
[c0000000374f3b10] [c000000000409808] .tty_ldisc_reinit+0x38/0x80
[c0000000374f3ba0] [c00000000040a218] .tty_ldisc_hangup+0x190/0x260
[c0000000374f3c40] [c0000000004000d0] .do_tty_hangup+0x188/0x4c0
[c0000000374f3d20] [c000000000400480] .tty_vhangup_self+0x34/0x54
[c0000000374f3db0] [c0000000001917c8] .sys_vhangup+0x38/0x58
[c0000000374f3e30] [c000000000008534] syscall_exit+0x0/0x40
Instruction dump:
912b0088 4bcd2201 60000000 e87e8008 7f44d378 481c0735 60000000 801b0008
7c09fe70 7d200278 7c004850 54000ffe <0b000000> 7f63db78 4bd7cf0d 60000000

Not sure if this is a new issue. I haven't really paid attention
to messages that are displayed during shutdown.

Line 210 corresponds to the following code.

static void tty_ldisc_put(struct tty_ldisc *ld)
{
......
	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
	WARN_ON(ld->refcount); <<===
.......

Thanks
-Sachin



-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
