Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D24A5688F7
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Dec 2005 00:39:54 +1100 (EST)
Date: Mon, 19 Dec 2005 14:39:44 +0100
From: Olaf Hering <olh@suse.de>
To: Manish_Lachwani@pmc-sierra.com, netdev@vger.kernel.org
Message-ID: <20051219133944.GA10567@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
Subject: mv643xx_eth,
	sleeping function called from invalid context at mm/slab.c:2472
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I get this with 2.6.15-rc6 on a pegasos2 board:


MV-643xx 10/100/1000 Ethernet Driver
eth1: port 1 with MAC address 00:2b:2f:de:ad:01
eth1: Scatter Gather Enabled
eth1: TX TCP/IP Checksumming Supported
eth1: RX TCP/UDP Checksum Offload ON 
eth1: RX NAPI Enabled 
eth1: Using SRAM
Debug: sleeping function called from invalid context at mm/slab.c:2472
in_atomic():0, irqs_disabled():1
Call Trace:
[CB32DCF0] [C000AFCC] show_stack+0x54/0x180 (unreliable)
[CB32DD10] [C0027CD4] __might_sleep+0xbc/0xd0
[CB32DD20] [C005E50C] kmem_cache_alloc+0x34/0x108
[CB32DD40] [C01C5F40] rand_initialize_irq+0x40/0x6c
[CB32DD60] [C0054104] setup_irq+0x5c/0x154
[CB32DD90] [C0054284] request_irq+0x88/0xb8
[CB32DDC0] [D22820A0] mv643xx_eth_open+0x44/0xb4 [mv643xx_eth]
[CB32DDE0] [C0257394] dev_open+0x70/0xd8
[CB32DE00] [C02554F0] dev_change_flags+0x6c/0x13c
[CB32DE20] [C02A2818] devinet_ioctl+0x280/0x708
[CB32DE80] [C02A319C] inet_ioctl+0xb4/0x100
[CB32DE90] [C02C0078] packet_ioctl+0x15c/0x188
[CB32DEB0] [C024B998] sock_ioctl+0x30c/0x334
[CB32DED0] [C00922F4] do_ioctl+0x3c/0x88
[CB32DEE0] [C0092728] vfs_ioctl+0x3e8/0x424
[CB32DF10] [C00927CC] sys_ioctl+0x68/0x98
[CB32DF40] [C000FAEC] ret_from_syscall+0x0/0x4c
--- Exception: c01 at 0x7f6be80
    LR = 0x7fec9d0
eth1: no IPv6 routers present


00:00.0 Host bridge: Marvell Technology Group Ltd. MV64360/64361/64362 System Controller (rev 03)
00:01.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
00:0c.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge] (rev 10)
00:0c.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:0c.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1e)
00:0c.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1e)
00:0c.4 Bridge: VIA Technologies, Inc. VT8235 ACPI (rev 10)
00:0c.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 40)
00:0c.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Controller (rev 20)
00:0d.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 51)
0001:01:00.0 Host bridge: Marvell Technology Group Ltd. MV64360/64361/64362 System Controller (rev 03)
0001:01:08.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)
0001:01:08.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)



-- 
short story of a lazy sysadmin:
 alias appserv=wotan
