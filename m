Date: Wed, 7 Aug 2002 18:02:32 +0200
From: Gunnar Larisch <la@softing.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Oops during initializing ip-stack and receiving ethernet packets
Message-ID: <20020807180232.A15922@w-la.dhcp.softing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

on a PPC 855T with fec-ethernet and Linux 2.4.4 (version of denx) I get
sometimes an oops message in ip_route_input() because of accessing
rt_hash_table, when an ethernet package is received and just before
the structure rt_hash_table in function ip_rt_init() is half initialized.

On the console there is the following output:

...
eth0: FEC ENET Version 0.2, FEC irq 3, MII irq 6, addr 00:06:71:01:02:03
RAMDISK: Compressed image found at block 0
eth0: Phy @ 0x1f, type AM79C874 (0x0022561b)
...
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
Oops: kernel access of bad area, sig: 11
...

This can be reproduced easier with "arp -s .." and "ping -f".

The problem is that interrupts of ethernet are enabled before IP-stack
is initialized. What is the best way to fix this?

Thanks,
Gunnar

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
