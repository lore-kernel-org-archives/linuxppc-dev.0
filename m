Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr11.xs4all.nl (smtp-vbr11.xs4all.nl [194.109.24.31])
	by ozlabs.org (Postfix) with ESMTP id 93203DDF7F
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 01:06:52 +1000 (EST)
Received: from mail3.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id n47F6n4D031639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 7 May 2009 17:06:50 +0200 (CEST)
	(envelope-from nvbolhuis@aimvalley.nl)
Message-ID: <4A02F905.6080904@aimvalley.nl>
Date: Thu, 07 May 2009 17:06:45 +0200
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: howto disable dcache (on a MPC8313)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We have a network-switch connected via PCI which comes with 3rd
party (kernel) software.
The frames trapped by the switch and sent to CPU (with DMA)
are corrupt.
To rule out any data cache problems (which probably isn't causing
our problem) I thought I "quickly" disable the data cache.

we use a pretty standard linux-2.6.28 kernel (on our custom MPC8313E
board).

I first tried to mark the one BAT entry that the kernel setups as
cache_inhibit. I replaced setbat(..., _PAGE_RAM) by
setbat(..., _PAGE_IO) (in mmu_mapin_ram). This results in the
kernel not booting at all.

I also tried to not set DCE in HID0 in u-boot, this results in
the board not booting up at all.
I couldn't find the kernel source for setting HID0. It's not
op_powerpc_cpu_setup since CONFIG_OPROFILE isn't set (but
CONFIG_HAVE_OPROFILE is ?)

Is there a way to (simply) disable dcache for MPC8313 ?

Btw. some other architecturs (e.g. blackfin) have a kernel config option
to disable DCACHE.


---
N. van Bolhuis.
