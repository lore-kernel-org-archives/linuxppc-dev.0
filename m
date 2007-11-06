Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 893E4DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Nov 2007 14:38:49 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IpFH2-0006d7-Ut
	for linuxppc-embedded@ozlabs.org; Mon, 05 Nov 2007 19:38:44 -0800
Message-ID: <13600333.post@talk.nabble.com>
Date: Mon, 5 Nov 2007 19:38:44 -0800 (PST)
From: usysinc <info@usysinc.com>
To: linuxppc-embedded@ozlabs.org
Subject: No ip addr on the Xilinx ML403
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I have successfully booted the Linux 2.6.23 vertex kernel branch on the ML403
board. The hard_temac 3.00_a was implemented in the MHS file. The kernel was
configured with no Marvel PHY drivers; just the generic 10/100 Ethernet MII,
and 10/100/1000 Ethernet. The Temac configures correctly and I have verified
that DHCP is indeed functional, but no 'ip addr=' is visible with ifconfig
and can't ping anything other than localhost. Can anyone suggest a solution
to this configuration problem?

XTemac: using sgDMA mode.
[    3.079060] XTemac: using TxDRE mode
[    3.121940] XTemac: using RxDRE mode
[    3.164839] XTemac: buffer descriptor size: 32768 (0x8000)
[    3.231800] XTemac: (buffer_descriptor_init) phy: 0x3cb0000, virt:
0xff100000, size: 0x8000
[    3.339873] eth%d: XTemac: PHY detected at address 0.
[    3.400611] eth0: Dropping NETIF_F_SG since no checksum feature.
[    3.475138] eth0: Xilinx TEMAC #0 at 0x81200000 mapped to 0xC5060000,
irq=0
[    3.558779] eth0: XTemac id 1.0f, block id 5, type 8

.
.
.

# ifdown eth0
# ifup eth0
[   20.004852] eth0: XTemac: Options: 0xb8f2
[   32.012102] eth0: XTemac: Not able to set the speed to 1000 (status:
0x7949)
[   34.089874] eth0: XTemac: We renegotiated the speed to: 100
[   34.156549] eth0: XTemac: speed set to 100Mb/s
[   34.209718] eth0: XTemac: Send Threshold = 16, Receive Threshold = 2
[   34.285693] eth0: XTemac: Send Wait bound = 1, Receive Wait bound = 1
udhcpc (v1.7.2) started
udhcpc: script /usr/share/udhcpc/default.script failed: No such file or
directory
Sending discover...
Sending select for 192.168.0.2...
Lease of 192.168.0.2 obtained, lease time 86400
udhcpc: script /usr/share/udhcpc/default.script failed: No such file or
directory
# ifconfig
eth0      Link encap:Ethernet  HWaddr 08:00:3E:26:15:59
          UP BROADCAST RUNNING  MTU:1500  Metric:1
          RX packets:3 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1240 (1.2 KiB)  TX bytes:1180 (1.1 KiB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
  

- Brendan
-- 
View this message in context: http://www.nabble.com/No-ip-addr-on-the-Xilinx-ML403-tf4755897.html#a13600333
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
