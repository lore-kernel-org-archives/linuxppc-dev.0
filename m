Return-Path: <nvbolhuis@aimsys.nl>
Received: from smtp-vbr5.xs4all.nl (smtp-vbr5.xs4all.nl [194.109.24.25])
	by ozlabs.org (Postfix) with ESMTP id 0C9F8DDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jun 2007 01:46:50 +1000 (EST)
Received: from mail3.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	by smtp-vbr5.xs4all.nl (8.13.8/8.13.8) with ESMTP id l5BFffwE004845
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Jun 2007 17:41:41 +0200 (CEST)
	(envelope-from nvbolhuis@aimsys.nl)
Message-ID: <466D6DEB.1030405@aimsys.nl>
Date: Mon, 11 Jun 2007 17:44:43 +0200
From: "N. van Bolhuis" <nvbolhuis@aimsys.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: ioctl on 870 FEC causes "badness in local_bh_enable at
	kernel/softirq.c"
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I found a minor problem for the linux PPC PowerQuic_II FEC driver.

When doing an:

ioctl(.. SIOCGMIIREG ..) or
ioctl(.. SIOCSMIIREG ..)

the following kernel message pops up:

Badness in local_bh_enable at kernel/softirq.c:137
Call Trace:
[C102FC80] [C0008E04]  (unreliable)
[C102FCA0] [C0003608]
[C102FCB0] [C0003EB0]
[C102FCD0] [C000310C]
[C102FD90] [C102FE40]
[C102FDA0] [C010794C]
[C102FDC0] [C01079C0]
[C102FDE0] [C010E7DC]
[C102FE00] [C01316C0]
[C102FE20] [C0132A08]
[C102FEA0] [C0126408]
[C102FEC0] [C0064B10]
[C102FEE0] [C0064F1C]
[C102FF10] [C0064F98]
[C102FF40] [C0002AC4]


This is because drivers/net/fs_enet/fs_enet-main.c:fs_ioctl
disables the interrupts with spin_lock_irqsave after which it calls
phy_mii_ioctl. This leads to drivers/net/phy/phy.c:phy_read
being called which does spin_lock_bh/spin_unlock_bh.
Obviously the spin_unlock_bh enables softirqs and it is correctly
complaining irqs are disabled.

fs_ioctl and phy_read are used by many others so I'm not sure
how to solve this. Therefore I ask this list.

Maybe fs_ioctl can use spin_(un)lock but I'm not sure.

Anybody has a fix or ideas about this ?

---
N. van Bolhuis.

-- 
This message has been scanned for viruses and is believed to be clean
