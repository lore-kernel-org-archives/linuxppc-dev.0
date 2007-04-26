Return-Path: <matvejchikov@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id 9984CDDF61
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 05:04:38 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id p76so615066pyb
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Apr 2007 12:04:36 -0700 (PDT)
Message-ID: <8496f91a0704261204t3896a388g7718c2213cf90895@mail.gmail.com>
Date: Thu, 26 Apr 2007 23:04:36 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: "Clemens Koller" <clemens.koller@anagramm.de>
Subject: Re: BUG: NETDEV WATCHDOG -> Badness in gianfar driver?
In-Reply-To: <4630E0F3.10100@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4630E0F3.10100@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Good Day!

> The system was running fine for many days and weeks without any problems.
> However, just a few minutes ago I noticed a single clicking sound of the harddisk
> (like a head recalibration), so I checked the system.
> I couldn't connect to it via ssh anymore, but via a serial console I got
> at least endless messages as shown below...
> After a reboot, everything looks fine again but the kernel log grew up
> to several MBytes. I pasted the hopefully interesting part below.
>
> Any ideas of what could be wrong there? I think there could be a problem
> in the gianfar network driver. Or is there a physical problem with the PHY
> (a Marvell MV88E1111)?
>
> Any recommendations of how to debug that thingy?
>
> Jan  1 03:43:23 ecam kernel: ------------[ cut here ]------------
> Jan  1 03:43:23 ecam kernel: Badness at c003d3d8 [verbose debug info unavailable]
> Jan  1 03:43:23 ecam kernel: Call Trace:
> Jan  1 03:43:23 ecam kernel: [C0355C70] [C0008FE0] show_stack+0x3c/0x194 (unreliable)
> Jan  1 03:43:23 ecam kernel: [C0355CA0] [C0135594] report_bug+0xa4/0xac
> Jan  1 03:43:23 ecam kernel: [C0355CB0] [C0003784] program_check_exception+0x2b8/0x460
> Jan  1 03:43:23 ecam kernel: [C0355CD0] [C0002908] ret_from_except_full+0x0/0x4c
> Jan  1 03:43:23 ecam kernel: [C0355D90] [C017B3CC] marvell_ack_interrupt+0x14/0x38
> Jan  1 03:43:23 ecam kernel: [C0355DB0] [C01764A8] stop_gfar+0x54/0xd0
> Jan  1 03:43:23 ecam kernel: [C0355DD0] [C01773D0] gfar_timeout+0x5c/0x68
> Jan  1 03:43:23 ecam kernel: [C0355DE0] [C020A060] dev_watchdog+0x110/0x118
> Jan  1 03:43:23 ecam kernel: [C0355E00] [C0024228] run_timer_softirq+0x148/0x1a8
> Jan  1 03:43:23 ecam kernel: [C0355E40] [C002006C] __do_softirq+0x78/0xe4
> Jan  1 03:43:23 ecam kernel: [C0355E70] [C0007054] do_softirq+0x54/0x58
> Jan  1 03:43:23 ecam kernel: [C0355E80] [C001FE4C] irq_exit+0x48/0x58
> Jan  1 03:43:23 ecam kernel: [C0355E90] [C0004000] timer_interrupt+0x17c/0x224
> Jan  1 03:43:23 ecam kernel: [C0355ED0] [C0002954] ret_from_except+0x0/0x18
> Jan  1 03:43:23 ecam kernel: [C0355F90] [C0009FB8] cpu_idle+0xc0/0xd0
> Jan  1 03:43:23 ecam kernel: [C0355FB0] [C0001A7C] rest_init+0x28/0x38
> Jan  1 03:43:23 ecam kernel: [C0355FC0] [C03568E4] start_kernel+0x220/0x29c
> Jan  1 03:43:23 ecam kernel: [C0355FF0] [C0000388] skpinv+0x2b8/0x2f4
> Jan  1 03:43:23 ecam kernel: ------------[ cut here ]------------
> Jan  1 03:43:23 ecam kernel: Badness at c003d3d8 [verbose debug info unavailable]
> Jan  1 03:43:23 ecam kernel: Call Trace:
> Jan  1 03:43:23 ecam kernel: [C0355C70] [C0008FE0] show_stack+0x3c/0x194 (unreliable)
> [...repeating forever...]
> ----- 8< ----- cut here

This is because gfar_timeout() calls stop_gfar() that calls
phy_write() that must not be called from interrupt context. See
comments to this function.

Best regards,
Matvejchikov Ilya.
