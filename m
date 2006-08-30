Return-Path: <cclo@astri.org>
Received: from asiwss02.astri.org (mail2.astri.org [203.198.202.21])
	by ozlabs.org (Postfix) with ESMTP id B87FC67A3A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 22:17:52 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Subject: 2 Ethernet port operating in a PPC405EP system
Date: Wed, 30 Aug 2006 20:19:24 +0800
Message-ID: <A7B1E4DD46AA7046A4398F745240F29402737D5C@ASPROEXG.astri.local>
From: "Chun Chung Lo" <cclo@astri.org>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

Sorry for such long e-mail.

I am now working on a STB project, and our board is a IBM PPC405EP with
2 ethernet ports. U-Boot 1.0.0 and linux 2.4.20 (from MontaVista) is
used and update is not recommended. Each ethernet port has a RTL8021CP
PHY connected.=0D

Under u-boot environment, only 1 ethernet port is operating. But
sometimes the port is not able to PING other PCs within the same subnet.
Also some modifications are made (under bd_t) to let linux kernel fetch
2 different MAC address when boot into linux kernel.

Error log (U-Boot):

<## snip ##>
Hit any key to stop autoboot:  0
=3D> setenv ipaddr 10.6.64.343
=3D> setenv ipaddr 10.6.64.34
=3D> ping 10.6.64.128
ENET Speed is 100 Mbps - FULL duplex connection

< the board holds here about several seconds >

ping failed; host 10.6.64.128 is not alive
<## snip ##>

Under linux environment, 2 ethernet ports are operating. But sometimes
only ethernet 1 is operating (by running a udhcpc, from
busybox-v1.00-pre8); sometimes both are not operating.=0D

When ethernet 1 is operating (can fetch a IP address from DHCP server,
say 10.6.64.111), then I assigned a static IP address (say,
192.168.1.120) and let the board PING to different subnets at the same
time. But the ethernet 2 cannot PING out while ethernet 1 is operating
...=0D

Error log (Linux):

<## snip ##>
Press CTRL-C to enter shell within 1 sec

~ # udhcpc -i eth0 -s /etc/udhcpc.sh
info, udhcpc (v0.9.9-pre) started
debug, Sending discover...
debug, Sending discover...

< the ethernet port 1 goes wrong and cannot get IP from DHCP server,
until I plug and unplug the ethernet cable several times, it works again
>

debug, Sending discover...
debug, Sending select for 10.6.64.197...
info, Lease of 10.6.64.197 obtained, lease time 691200
deleting routers
SIOCDELRT: No such process
adding dns 10.6.2.11
adding dns 10.6.2.12
~ # ping 10.6.64.128
PING 10.6.64.128 (10.6.64.128): 56 data bytes
64 bytes from 10.6.64.128: icmp_seq=3D0 ttl=3D64 time=3D9.4 ms
64 bytes from 10.6.64.128: icmp_seq=3D1 ttl=3D64 time=3D0.3 ms
64 bytes from 10.6.64.128: icmp_seq=3D2 ttl=3D64 time=3D0.3 ms

--- 10.6.64.128 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max =3D 0.3/3.3/9.4 ms
~ # ifconfig eth1 192.168.1.120
EMAC1 open, with PHY @ 0x13
ibm_ocp_phy.c: cclo - fep->link =3D 1
 ------ phy: RTL8201CP,  mii_parse_anar(0x000001e1), phy=3D0x13 ------
eth1: IBM EMAC: link up, 100 Mbps Full Duplex, auto-negotiation
complete.
eth1: IBM EMAC: MAC cc:0b:20:08:21:b2.
~ # ping 192.168.1.123
PING 192.168.1.123 (192.168.1.123): 56 data bytes

--- 192.168.1.123 ping statistics ---
3 packets transmitted, 0 packets received, 100% packet loss
~ #

<## snip ##>

I also serached something about this issue on internet, I found
something:

http://ozlabs.org/pipermail/linuxppc-embedded/2003-December/012802.html

Are there any updates about this issue? Or my problem is not related to
this?

Please help. Thanks.

Best regards,
Lo Chun Chung

This message (including any attachments) is for the named addressee(s)'s=
 use only. It may contain
sensitive, confidential, private proprietary or legally privileged=
 information intended for a
specific individual and purpose, and is protected by law. If you are not=
 the intended recipient,
please immediately delete it and all copies of it from your system, destroy=
 any hard copies of it
and notify the sender. Any use, disclosure, copying, or distribution of=
 this message and/or any
attachments is strictly prohibited.
