Return-Path: <adgospod@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 60DE1DDF1C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 03:51:01 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b21so391696ana
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Apr 2007 10:51:00 -0700 (PDT)
Message-ID: <bdfc5d6e0704261051o481dae90t8bd8e25700fbfae0@mail.gmail.com>
Date: Thu, 26 Apr 2007 13:51:00 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
To: "Clemens Koller" <clemens.koller@anagramm.de>
Subject: Re: BUG: NETDEV WATCHDOG -> Badness in gianfar driver?
In-Reply-To: <4630E0F3.10100@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4630E0F3.10100@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/26/07, Clemens Koller <clemens.koller@anagramm.de> wrote:
> Hi There!
>
> I am currently using
> Linux ecam.anagramm.de 2.6.21-rc5-g9a5ee4cc #4 Mon Apr 2 21:31:53 CEST 20=
07 ppc e500 GNU/Linux
> on an mpc8540 embedded powerpc system.
>
> The system was running fine for many days and weeks without any problems.
> However, just a few minutes ago I noticed a single clicking sound of the =
harddisk
> (like a head recalibration), so I checked the system.
> I couldn't connect to it via ssh anymore, but via a serial console I got
> at least endless messages as shown below...
> After a reboot, everything looks fine again but the kernel log grew up
> to several MBytes. I pasted the hopefully interesting part below.
>
> Any ideas of what could be wrong there? I think there could be a problem
> in the gianfar network driver. Or is there a physical problem with the PH=
Y
> (a Marvell MV88E1111)?
>
> Any recommendations of how to debug that thingy?

There were some workarounds in the e1000 driver to address some issues
with some Marvell 88E parts, so you might want to check those out.

>
> ----- 8< ----- cut here
> Jan  1 01:00:38 ecam kernel: PHY: 0:00 - Link is Up - 100/Full
> Jan  1 01:00:35 ecam network: Bringing up loopback interface:  succeeded
> Jan  1 01:00:47 ecam mount: mount: RPC: Remote system error - No route to=
 host
> Jan  1 01:00:47 ecam netfs: Mounting NFS filesystems:  failed
> Jan  1 01:00:47 ecam netfs: Mounting other filesystems:  succeeded
> Jan  1 01:00:47 ecam xinetd[665]: xinetd Version 2.3.11 started with libw=
rap options compiled in.
> Jan  1 01:00:47 ecam xinetd[665]: Started working: 1 available service
> Jan  1 01:00:50 ecam xinetd: xinetd startup succeeded
> Jan  1 01:00:50 ecam rc: Starting sshd:  succeeded
> Jan  1 01:00:51 ecam rc: Starting samba:  succeeded
> Jan  1 03:43:23 ecam kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Jan  1 03:43:23 ecam kernel: ------------[ cut here ]------------
> Jan  1 03:43:23 ecam kernel: Badness at c003d3d8 [verbose debug info unav=
ailable]
> Jan  1 03:43:23 ecam kernel: Call Trace:
> Jan  1 03:43:23 ecam kernel: [C0355C70] [C0008FE0] show_stack+0x3c/0x194 =
(unreliable)
> Jan  1 03:43:23 ecam kernel: [C0355CA0] [C0135594] report_bug+0xa4/0xac
> Jan  1 03:43:23 ecam kernel: [C0355CB0] [C0003784] program_check_exceptio=
n+0x2b8/0x460
> Jan  1 03:43:23 ecam kernel: [C0355CD0] [C0002908] ret_from_except_full+0=
x0/0x4c
> Jan  1 03:43:23 ecam kernel: [C0355D90] [C017B3CC] marvell_ack_interrupt+=
0x14/0x38
> Jan  1 03:43:23 ecam kernel: [C0355DB0] [C01764A8] stop_gfar+0x54/0xd0
> Jan  1 03:43:23 ecam kernel: [C0355DD0] [C01773D0] gfar_timeout+0x5c/0x68
> Jan  1 03:43:23 ecam kernel: [C0355DE0] [C020A060] dev_watchdog+0x110/0x1=
18
> Jan  1 03:43:23 ecam kernel: [C0355E00] [C0024228] run_timer_softirq+0x14=
8/0x1a8
> Jan  1 03:43:23 ecam kernel: [C0355E40] [C002006C] __do_softirq+0x78/0xe4
> Jan  1 03:43:23 ecam kernel: [C0355E70] [C0007054] do_softirq+0x54/0x58
> Jan  1 03:43:23 ecam kernel: [C0355E80] [C001FE4C] irq_exit+0x48/0x58
> Jan  1 03:43:23 ecam kernel: [C0355E90] [C0004000] timer_interrupt+0x17c/=
0x224
> Jan  1 03:43:23 ecam kernel: [C0355ED0] [C0002954] ret_from_except+0x0/0x=
18
> Jan  1 03:43:23 ecam kernel: [C0355F90] [C0009FB8] cpu_idle+0xc0/0xd0
> Jan  1 03:43:23 ecam kernel: [C0355FB0] [C0001A7C] rest_init+0x28/0x38
> Jan  1 03:43:23 ecam kernel: [C0355FC0] [C03568E4] start_kernel+0x220/0x2=
9c
> Jan  1 03:43:23 ecam kernel: [C0355FF0] [C0000388] skpinv+0x2b8/0x2f4
> Jan  1 03:43:23 ecam kernel: ------------[ cut here ]------------
> Jan  1 03:43:23 ecam kernel: Badness at c003d3d8 [verbose debug info unav=
ailable]
> Jan  1 03:43:23 ecam kernel: Call Trace:
> Jan  1 03:43:23 ecam kernel: [C0355C70] [C0008FE0] show_stack+0x3c/0x194 =
(unreliable)
> [...repeating forever...]
> ----- 8< ----- cut here
>
> The system time is wrong, because the I2C realtime clock cannot be read
> on this system due to some kernel misconfiguration which I didn't care ab=
out.
>
> Thank you in advance,
> --
> Clemens Koller
> __________________________________
> R&D Imaging Devices
> Anagramm GmbH
> Rupert-Mayer-Stra=DFe 45/1
> Linhof Werksgel=E4nde
> D-81379 M=FCnchen
> Tel.089-741518-50
> Fax 089-741518-19
> http://www.anagramm-technology.com
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
