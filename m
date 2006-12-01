Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx024.isp.belgacom.be (outmx024.isp.belgacom.be
	[195.238.4.128])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A4F267B5B
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Dec 2006 00:18:42 +1100 (EST)
Received: from outmx024.isp.belgacom.be (localhost [127.0.0.1])
	by outmx024.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kB1DIakH006097
	for <linuxppc-embedded@ozlabs.org>; Fri, 1 Dec 2006 14:18:36 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade.biz (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx024.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kB1DIVMc006033
	for <linuxppc-embedded@ozlabs.org>; Fri, 1 Dec 2006 14:18:31 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: fs_enet driver "generating" bad interrupts on 2.6.19
Date: Fri, 1 Dec 2006 14:18:26 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200612011418.26201.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

I upgraded to 2.6.19 today, and found a strange issue that seems to be related 
with the fs_enet driver on a MPC8248.

The number of "bad" interrupts, as reported by /proc/interrupts, seems to 
grown with the number of packets received and sent by the FCC ethernet 
controllers.

~ # cat /proc/interrupts && sleep 500 && cat /proc/interrupts
           CPU0
  1:        257   CPM2 SIU  Level     i2c-mpc
  2:       1173   CPM2 SIU  Level     mpc8260_spi
  4:         11   CPM2 SIU  Level     cpm_uart
 23:          0   CPM2 SIU  Edge      TBox cascade
 24:        155   CPM2 SIU  Edge      tbox_spi
 33:        307   CPM2 SIU  Level     fs_enet-mac
 40:          0   CPM2 SIU  Level     sdfe_sdi
 42:          0   CPM2 SIU  Level     sdfe_sdi
 43:        622   CPM2 SIU  Level     sdfe_sci
BAD:       1379

The bad interrupt count is incremented when an interrupt can't be assigned to 
a peripheral, which means cpm2_get_irq() returns -1. I tried printing the SIU 
interrupt pending and interrupt mask registers when this happens:

sipnrh 0xbc120000 sipnrl 0x40000000
simrh  0x00000600 simrl  0x00b0d000

SIPNR_L.1 is the FCC2 interrupt flag. The FCC2 ethernet has no cable plugged 
in, so the interrupt is masked. SIPNR_H.0 to SIPNR_H.15 are port C 
interrupts, and are all masked. As you can see, no peripheral should generate 
an interrupt. Still, do_IRQ() is called, and cpm2_get_irq() reads the SIU 
interrupt vector register (SIVEC) to find out that it is equal to 0. The bad 
interrupts counter is then incremented.

The number of bad interrupts increases faster when there is outbound network 
activity (some non relevant information removed from the following output to 
make it shorter):

~ # while true; do cat /proc/interrupts; ifconfig eth0; sleep 5; done
           CPU0
 33:       2992   CPM2 SIU  Level     fs_enet-mac
BAD:       1523
eth0      Link encap:Ethernet  HWaddr 00:06:E1:80:00:03
          RX packets:2814 errors:0 dropped:0 overruns:0 frame:0
          TX packets:208 errors:0 dropped:0 overruns:0 carrier:0

           CPU0
 33:       3027   CPM2 SIU  Level     fs_enet-mac
BAD:       1532
eth0      Link encap:Ethernet  HWaddr 00:06:E1:80:00:03
          RX packets:2841 errors:0 dropped:0 overruns:0 frame:0
          TX packets:217 errors:0 dropped:0 overruns:0 carrier:0

           CPU0
 33:       3045   CPM2 SIU  Level     fs_enet-mac
BAD:       1533
eth0      Link encap:Ethernet  HWaddr 00:06:E1:80:00:03
          RX packets:2856 errors:0 dropped:0 overruns:0 frame:0
          TX packets:218 errors:0 dropped:0 overruns:0 carrier:0

           CPU0
 33:       3058   CPM2 SIU  Level     fs_enet-mac
BAD:       1534
eth0      Link encap:Ethernet  HWaddr 00:06:E1:80:00:03
          RX packets:2869 errors:0 dropped:0 overruns:0 frame:0
          TX packets:220 errors:0 dropped:0 overruns:0 carrier:0

           CPU0
 33:       3090   CPM2 SIU  Level     fs_enet-mac
BAD:       1543
eth0      Link encap:Ethernet  HWaddr 00:06:E1:80:00:03
          RX packets:2892 errors:0 dropped:0 overruns:0 frame:0
          TX packets:229 errors:0 dropped:0 overruns:0 carrier:0

           CPU0
 33:       3131   CPM2 SIU  Level     fs_enet-mac
BAD:       1553
eth0      Link encap:Ethernet  HWaddr 00:06:E1:80:00:03
          RX packets:2924 errors:0 dropped:0 overruns:0 frame:0
          TX packets:238 errors:0 dropped:0 overruns:0 carrier:0

           CPU0
 33:       3162   CPM2 SIU  Level     fs_enet-mac
BAD:       1562
eth0      Link encap:Ethernet  HWaddr 00:06:E1:80:00:03
          RX packets:2946 errors:0 dropped:0 overruns:0 frame:0
          TX packets:247 errors:0 dropped:0 overruns:0 carrier:0

           CPU0
 33:       3193   CPM2 SIU  Level     fs_enet-mac
BAD:       1571
eth0      Link encap:Ethernet  HWaddr 00:06:E1:80:00:03
          RX packets:2968 errors:0 dropped:0 overruns:0 frame:0
          TX packets:256 errors:0 dropped:0 overruns:0 carrier:0

The problem wasn't visible with the 2.6.18 kernel. The number of bad 
interrupts didn't increase with outbound FCC traffic.

Has anyone noticed the same problem ?

Laurent Pinchart
