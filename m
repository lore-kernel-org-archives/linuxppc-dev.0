Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 494F5B71A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 16:44:10 +1000 (EST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2C11DDDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 16:44:10 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5M6fSBT018491
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 16:41:28 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5M6hrip299354
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 16:43:53 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5M6hr0h004441
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 16:43:53 +1000
Message-ID: <4A3F281F.9000408@in.ibm.com>
Date: Mon, 22 Jun 2009 12:13:43 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Badness at drivers/char/tty_ldisc.c:210 during shutdown
References: <4A3A2D2B.7070704@in.ibm.com>
In-Reply-To: <4A3A2D2B.7070704@in.ibm.com>
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

Sachin Sant wrote:
> I came across the following badness message during shutdown on a 
> Power6 box.
> This was with 2.6.30-git12(3fe0344faf7fdcb158bd5c1a9aec960a8d70c8e8)
>
> ------------[ cut here ]------------
> Badness at drivers/char/tty_ldisc.c:210
The badness message is still present with git18.

------------[ cut here ]------------
Badness at drivers/char/tty_ldisc.c:210
NIP: c00000000040a3e8 LR: c00000000040a3d0 CTR: 0000000000000000
REGS: c00000003cf6b7f0 TRAP: 0700   Not tainted  (2.6.30-git18)
MSR: 8000000000029032 <EE,ME,CE,IR,DR>  CR: 24000424  XER: 00000001
TASK = c00000003e308660[3846] 'vhangup' THREAD: c00000003cf68000 CPU: 1
<6>GPR00: 0000000000000001 c00000003cf6ba70 c000000000ef48c0 0000000000000001 
<6>GPR04: 0000000000000001 c00000003819f000 c000000000407b60 0000000000000000 
<6>GPR08: 0000000000000000 0000000000000000 0000000000000001 c000000000e1bce8 
<6>GPR12: 0000000044000428 c000000001002600 00000000ffffffff ffffffffffffffff 
<6>GPR16: 0000000021fd8a50 0000000000000002 0000000000000000 0000000021fc03b0 
<6>GPR20: 0000000000000000 0000000000000000 c00000003d04c700 0000000000000001 
<6>GPR24: 0000000000000000 0000000000000000 0000000000000001 c000000040007e20 
<6>GPR28: 0000000000000000 c0000000013ffd38 c000000000e7e860 c00000003cf6ba70 
NIP [c00000000040a3e8] .tty_ldisc_put+0xbc/0xf4
LR [c00000000040a3d0] .tty_ldisc_put+0xa4/0xf4
Call Trace:
[c00000003cf6ba70] [c00000000040a3d0] .tty_ldisc_put+0xa4/0xf4 (unreliable)
[c00000003cf6bb10] [c00000000040a7c8] .tty_ldisc_reinit+0x38/0x80
[c00000003cf6bba0] [c00000000040b1d8] .tty_ldisc_hangup+0x190/0x260
[c00000003cf6bc40] [c000000000401090] .do_tty_hangup+0x188/0x4c0
[c00000003cf6bd20] [c000000000401440] .tty_vhangup_self+0x34/0x54
[c00000003cf6bdb0] [c00000000019236c] .sys_vhangup+0x38/0x58
[c00000003cf6be30] [c000000000008534] syscall_exit+0x0/0x40
Instruction dump:
912b0088 4bcd17bd 60000000 e87e8008 7f44d378 481c04fd 60000000 801b0008 
7c09fe70 7d200278 7c004850 54000ffe <0b000000> 7f63db78 4bd7c98d 60000000 

Let me know if i can provide any other information.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
