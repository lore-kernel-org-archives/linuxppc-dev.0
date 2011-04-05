Return-Path: <carlos.moratelli@digitel.com.br>
Received: from atena.digitel.com.br (ares.digitel.com.br [200.198.105.40])
	by ozlabs.org (Postfix) with ESMTP id 9862DB6F0B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Apr 2011 04:48:26 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by atena.digitel.com.br (Postfix) with ESMTP id 33C3B32E800D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Apr 2011 15:44:37 -0300 (BRT)
Received: from atena.digitel.com.br ([127.0.0.1])
	by localhost (atena.digitel.com.br [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id n3OpA2W5KF56 for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Apr 2011 15:44:34 -0300 (BRT)
Received: from [192.168.20.131] (unknown [192.168.20.131])
	by atena.digitel.com.br (Postfix) with ESMTP id 2B8EF32E8002
	for <linuxppc-dev@lists.ozlabs.org.>;
	Tue,  5 Apr 2011 15:44:34 -0300 (BRT)
Subject: sdhc/mpc8536 - SDCard always detected like read-only
From: Carlos Roberto Moratelli <carlos.moratelli@digitel.com.br>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Apr 2011 15:39:56 -0300
Message-ID: <1302028796.10112.59.camel@moratelli-host.digitel.com.br>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I am working in a MPC8536e custom board. Our custom board has a slot to 
SDCards conected to the MPC8536e's eSDHC controller. We are using just
4-serial data pins of eSDHC controller.

My kernel is 2.6.35.7 and I am using buildroot to build the root system
with uClib.

I can mount and read the data from SDCards in the slot. But I am facing
errors when I try write something in the card. 

I am testing two SDcards: Kingston and a LG, both with 2GB capacity. I
tryed ext3 and fat32 filesystems with the same results.

When the card is detected the log is (observe the ro flag in the first
line):

mmcblk0: mmc0:57f7 SD02G 1.83 GiB (ro)
mmcblk0:
mmc0: starting CMD18 arg 00000000 flags 000000b5
mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
mmc0:     CMD12 arg 00000000 flags 0000049d
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000a
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
mmc0:     4096 bytes transferred: 0
mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
p1

I am sure the write protection mechanism on SDCard is in the unlock
position, but the kernel drivers detects the card like read-only.

Has someone idea why this happen?

Every idea or tip is apreciated.

Regards,

Moratelli.
