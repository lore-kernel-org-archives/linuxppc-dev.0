Return-Path: <ctrichet@assystembrime.com>
Received: from relay1.clb.oleane.net (relay1.clb.oleane.net [213.56.31.21])
	by ozlabs.org (Postfix) with ESMTP id B7D6B67B57
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Jun 2005 17:23:13 +1000 (EST)
Message-ID: <003d01c5788e$2572d920$ebd5a8c0@PCCT>
From: "trichec" <ctrichet@assystembrime.com>
To: "Brad Parker" <brad@heeltoe.com>, <weissg@vienna.at>,
	<iluri@fagorautomation.es>, <linuxppc-embedded@ozlabs.org>
Date: Fri, 24 Jun 2005 09:27:15 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: DAVID Claudette <cdavid@assystembrime.com>
Subject: USB host controller on MPC885 FADS board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

could you help me please as i try to use your m8xcxhci.c driver on my
MPC885ADS board.
It seems that no data goes out of the usb data pins.
I have modificated to use on the MPC885 FADS board. This drivers has also
Roman
Weissgaerber changes.

I have done the following modifications:

1.- At the begin of the file I put the following options :
#define USE_BRG3_USB_CLK
#define USE_TIMER2_FOR_SOF

2.-I have loaded the microcode patch

A) What can explain that no data goes out of the MPC885 chip ?


I get the following trace :




SCSI subsystem driver Revision: 1.00
usb.c: registered new driver hub
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
PQRM: Init
PQFEC: Init
m8xxhci: initializing controller
m8xxhci_setup()
usb.c: new USB bus registered, assigned bus number 1
m8xxhci_start_controller()
m8xxhci: USING CLK2 for USB clock!
m8xxhci: ring sizes: rx 60, tx 10
size 0x18 index 0xa00
size 0x1e0 index 0xa38
size 0x50 index 0xc20
USB uCode patch installed
m8xxhci: enable USB controller
m8xxhci_timer_setup()
m8xxhci: timer bytes/count 0.25
m8xxhci: USING TIMER1 FOR SOF!
m8xxhci: timer1 started
m8xxhci: usb bus is NOT idle
Product: USB MPC8xx Root Hub
SerialNumber: ff000a00
hub.c: USB hub found
hub.c: 1 port detected
rh_submit_urb() int pipe
rh_port_power(1)
m8xxhci: initializing done
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 1024)
PQFEC: Open eth0 device
idle_bus() 1; d+ zero, d- one, connect lo-sp
IP-Config: Complete:
      device=eth0, addr=192.168.213.3, mask=255.255.255.0,
gw=255.255.255.255,
     host=192.168.213.3, domain=, nis-domain=(none),
     bootserver=192.168.213.55, rootserver=192.168.213.55, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.213.55
Looking up port of RPC 100005/1 on 192.168.213.55
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 44k init
rh_port_reset(1)
hub.c: new USB device m8xxhci-1, assigned address 2
$%root%

root
%root
%root%
*** Running rc.modules
*** Running rc.serial
*** Attempting to start S05syslog
*** Attempting to start S15inet
Starting inetd
Done
*** Attempting to start S20network
*** Running rc.local

192.168.213.3 login: usb_control/bulk_msg: timeout
unlink_urb(urb=c07f4f50,qtype=2) status -115
unlink_urb(urb=c07f4f50) done
usb.c: USB device not accepting new address=2 (error=-110)
m8xxhci_free_dev(usb_dev=c01b9600)
m8xxhci_free_dev(dev=c01b9600) done
rh_port_reset(1)
hub.c: new USB device m8xxhci-1, assigned address 3
idle_bus() 0; both zero, disconnecting
bus_history 00055000
idle_bus() 1; d+ zero, d- one, connect lo-sp
usb_control/bulk_msg: timeout
unlink_urb(urb=c07f4f50,qtype=2) status -115
unlink_urb(urb=c07f4f50) done
usb.c: USB device not accepting new address=3 (error=-110)
m8xxhci_free_dev(usb_dev=c01b9600)
m8xxhci_free_dev(dev=c01b9600) done
rh_port_enable(0)
rh_port_reset(1)
hub.c: new USB device m8xxhci-1, assigned address 4
idle_bus() 0; both zero, disconnecting
bus_history 05555000
idle_bus() 1; d+ zero, d- one, connect lo-sp
usb_control/bulk_msg: timeout
unlink_urb(urb=c07f4f50,qtype=2) status -115
unlink_urb(urb=c07f4f50) done
usb.c: USB device not accepting new address=4 (error=-110)
m8xxhci_free_dev(usb_dev=c01b9600)
m8xxhci_free_dev(dev=c01b9600) done
rh_port_reset(1)
hub.c: new USB device m8xxhci-1, assigned address 5
usb_control/bulk_msg: timeout
unlink_urb(urb=c07f4f50,qtype=2) status -115
unlink_urb(urb=c07f4f50) done
usb.c: USB device not accepting new address=5 (error=-110)
m8xxhci_free_dev(usb_dev=c01b9600)
m8xxhci_free_dev(dev=c01b9600) done
rh_port_enable(0)
idle_bus() 0; both zero, disconnecting
bus_history 55555000
idle_bus() 1; d+ zero, d- one, connect lo-sp
rh_port_reset(1)
hub.c: new USB device m8xxhci-1, assigned address 6
usb_control/bulk_msg: timeout
unlink_urb(urb=c07f4f50,qtype=2) status -115
unlink_urb(urb=c07f4f50) done
usb.c: USB device not accepting new address=6 (error=-110)
m8xxhci_free_dev(usb_dev=c01b9600)
m8xxhci_free_dev(dev=c01b9600) done
rh_port_reset(1)
hub.c: new USB device m8xxhci-1, assigned address 7
cpm_int 0: tmr_int 31393, isrs 31393
idle 0, rst 0, bsy 0, rxb 0, txb 0
txe0 0, nak 0, stal 0, to 0, un 0, mm 0
rexmit     0
restart tx 0
txfree 0, txlast 0, txnext 0
rstate 0x0, rptr da471327, rbcnt 0x00000126
rx bds:
ff002a38 90000000/001cd000
ff002a40 90000000/001cd044
ff002a48 90000000/001cd088
ff002a50 90000000/001cd0cc
ff002a58 90000000/001cd110
ff002a60 90000000/001cd154
ff002a68 90000000/001cd198
ff002a70 90000000/001cd1dc
ff002a78 90000000/001cd220
ff002a80 90000000/001cd264
ff002a88 90000000/001cd2a8
ff002a90 90000000/001cd2ec
ff002a98 90000000/001cd330
ff002aa0 90000000/001cd374
ff002aa8 90000000/001cd3b8
ff002ab0 90000000/001cd3fc
ff002ab8 90000000/001cd440
ff002ac0 90000000/001cd484
ff002ac8 90000000/001cd4c8
ff002ad0 90000000/001cd50c
ff002ad8 90000000/001cd550
ff002ae0 90000000/001cd594
ff002ae8 90000000/001cd5d8
ff002af0 90000000/001cd61c
ff002af8 90000000/001cd660
ff002b00 90000000/001cd6a4
ff002b08 90000000/001cd6e8
ff002b10 90000000/001cd72c
ff002b18 90000000/001cd770
ff002b20 90000000/001cd7b4
ff002b28 90000000/001cd7f8
ff002b30 90000000/001cd83c
ff002b38 90000000/001cd880
ff002b40 90000000/001cd8c4
ff002b48 90000000/001cd908
ff002b50 90000000/001cd94c
ff002b58 90000000/001cd990
ff002b60 90000000/001cd9d4
ff002b68 90000000/001cda18
ff002b70 90000000/001cda5c
ff002b78 90000000/001cdaa0
ff002b80 90000000/001cdae4
ff002b88 90000000/001cdb28
ff002b90 90000000/001cdb6c
ff002b98 90000000/001cdbb0
ff002ba0 90000000/001cdbf4
ff002ba8 90000000/001cdc38
ff002bb0 90000000/001cdc7c
ff002bb8 90000000/001cdcc0
ff002bc0 90000000/001cdd04
ff002bc8 90000000/001cdd48
ff002bd0 90000000/001cdd8c
ff002bd8 90000000/001cddd0
ff002be0 90000000/001cde14
ff002be8 90000000/001cde58
ff002bf0 90000000/001cde9c
ff002bf8 90000000/001cdee0
ff002c00 90000000/001cdf24
ff002c08 90000000/001cdf68
ff002c10 b0000000/001cdfac
ep0: tstate 0, tbptr c20 tptr ff002a60
tx bds:
ff002c20 89000003/001c21d0 2d 00 10 00
ff002c28 9e800008/001ab820 00 05 07 00
ff002c30 89000003/001c21d0 2d 00 10 00
ff002c38 9e800008/001ab820 00 05 07 00
ff002c40 89000003/001c21d0 2d 00 10 00
ff002c48 9e800008/001ab820 00 05 07 00
ff002c50 89000003/001c21d0 2d 00 10 00
ff002c58 9e800008/001ab820 00 05 07 00
ff002c60 89000003/001c21d0 2d 00 10 00
ff002c68 be800008/001ab820 00 05 07 00
SETUP; no bds!
cpm_int 0: tmr_int 31395, isrs 31395
idle 0, rst 0, bsy 0, rxþ



Best regards



-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.323 / Virus Database: 267.8.0/27 - Release Date: 23/06/2005
