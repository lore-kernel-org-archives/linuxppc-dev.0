Return-Path: <tobias.netzel@t-online.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id 44B7067B43
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 06:34:26 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <3426ac53fe29bd5e395310d5d49a0d80@t-online.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linuxppc-dev@ozlabs.org
From: Tobias Netzel <tobias.netzel@t-online.de>
Subject: 2.4 kernel scheduling (?) problems
Date: Tue, 6 Jun 2006 20:29:35 +0200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,

I'm new to this list - hoping you will help me with the 2.4 kernel, 
although it's old now.
I'm improving hardware support for the NuBus PMacs. The NuBus Pmacs are 
68k Macs with a PPC CPU and a different bus bridge/memory controller.
The NuBus PMac port is something like a hack to the PPC architecture 
using some things from the PMac platform.
An open firmware device tree is emulated as far as needed. We use the 
same PMU driver (although I hacked it a bit because we directly route 
the PMU interrupts), ADB and RTC driver and the same functions to 
calibrate the decrementer using the VIA timer.

The problem I got is that for example during SCSI transfers (I'm using 
an old scanner) neither the X screen gets updated nor does the system 
respond to any interrupts but the NMI.
Debugging messages through the serial port are still sent. So I have to 
wait until the whole transfer is done. The kernel only receives 
interrupts after a SCSI command has finished and before a new one is 
sent. The data from the scanner is transfered in blocks of 32 kB.
The behaviour is similar when I do an performance test using "dd" or 
"hdparm" on the IDE CD-ROM drive. Burning CDs using that IDE drive 
works but causes the same problem as when scanning with the SCSI 
scanner.
With the IDE hard disk I don't get this problem.
When I run "top" during those problem transfers the CPU utilization by 
the system is higher than 95% ("top" hardly gets updated) - I doubt 
that this is necessary as on the NuBus PMacs the PPC CPUs (and 
especially the 217 MHz G3 with 512 kB L2 cache I'm using) should be 
idle most of the time waiting for the slow 33 MHz system bus.
The strange thing is that the CPU misses all interrupts (except the 
NMI) although interrupts aren't turned off in the CPU (otherwise the 
PMU would shut us down and the NMI wouldn't work). I also tried to use 
a timer to poll the interrupt controllers but the interrupt handling 
routines also only find one pending interrupt in 10 seconds even when I 
constantly move the mouse and hit keys.
At first I thought this was something caused by the hardware but in 
MacOS 9 the SCSI driver doesn't block anything.

But is it possible that this is because of something like scheduling 
problems of the kernel?
And if so might updating to the 2.6 kernel fix that issue?

Tobias
