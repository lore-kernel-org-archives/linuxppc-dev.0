Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3BFA8DB6.1050405@oerlikon.ca>
Date: Tue, 20 Nov 2001 12:07:02 -0500
From: "sruel@oerlikon.ca" <sruel@oerlikon.ca>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: eth1 FEC on RPX-CLLF info
References: <D73A25AA6E54D511AD74009027B1110F04F5E1@ORION> <01111314034801.01064@scop.digitel.com.br> <3BF1522D.1010706@embeddededge.com> <01111315384703.01064@scop.digitel.com.br> <3BF164B2.8080000@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Wolfgang,

I'm trying to activate the FEC on my RPX-CLLF board. Everything seems ok
when I do a ifconfig -a, but the FEC eth1 interface seems dead. I wonder
if the base address of the FEC is really 0xe00?

Here is my eth1 config:
ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:10:EC:00:2C:93
          inet addr:172.16.200.10  Bcast:172.16.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:719 errors:0 dropped:0 overruns:0 frame:14
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Base address:0x3c00

eth1      Link encap:Ethernet  HWaddr 00:10:EC:80:2C:93
          inet addr:148.33.216.245  Bcast:148.33.255.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Base address:0xe00

lo        Link encap:Local Loopback
          LOOPBACK  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

Here is the boot screen dump. The eth1 FEC MAC address is correctly read.
...
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC1, 00:10:ec:00:2c:93
eth1: FEC ENET Version 0.2, FEC irq 3, addr 00:10:ec:80:2c:93
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
loop: loaded (max 8 devices)
RPX Lite or CLLF flash device: 1000000 at ff000000
 Amd/Fujitsu Extended Query Table v1.2 at 0x0040
number of CFI chips: 1
...

Would you have any idea of the problem?

By the way, in the file fec.c from kernel 2.4.4 (2001-07-23), it is
mentionned that the FEC PHY for the RPX-CLLF board is a QS6612. I have
an RPX-CLLF board, and it uses an LXT971.

Thank!


Sebastien Ruel, System Engineer.
Oerlikon Contraves
Quebec, Canada


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
