Return-Path: <lagrange@fr.oleane.com>
Received: from relay02s.clb.oleane.net (relay02s.clb.oleane.net
	[213.56.31.143]) by ozlabs.org (Postfix) with ESMTP id 4CC5767B73
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 04:02:58 +1000 (EST)
Received: from smtp6.clb.oleane.net (smtp6.clb.oleane.net [213.56.31.26])
	by relay02s.clb.oleane.net with ESMTP id k7VHoYMi009680
	for <linuxppc-embedded@ozlabs.org>; Thu, 31 Aug 2006 19:51:35 +0200
Received: from GEG2400 ([194.3.133.184]) (authenticated)
	by smtp6.clb.oleane.net with ESMTP id k7VHiAQk018484
	for <linuxppc-embedded@ozlabs.org>; Thu, 31 Aug 2006 19:44:11 +0200
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: 82xx fcc_enet problem between Linux 2.4 and 2.6
Date: Thu, 31 Aug 2006 19:46:27 +0200
Message-ID: <002101c6cd25$6945e470$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: 
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

I work on several custom 82xx boards with Linux 2.4 and 2.6.

I have ported Linux 2.6.9 on different boards and I noticed
that I have tx carrier errors on my FCC ports. Almost one
error per xmit.

I reinstalled Linux 2.4.18 on these boards and I have NO ERROR.

The errors arise with PHY configured in 100M full duplex (or autoneg).
The FCC has the same duplex as PHY.

I found on web another mail concerning a problem on PQ2FADS Linux2.6.8
when mounting a NFS. The writer has also noticed that he has
tx carrier errors but the mail focused on mount and not FCC.

> # ifconfig
> eth0      Link encap:Ethernet  HWaddr 08:00:17:40:00:03
>           inet addr:192.168.0.5  Bcast:192.168.0.255  Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:122 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:114 errors:0 dropped:0 overruns:0 carrier:114
>           collisions:0 txqueuelen:1000
>           RX bytes:20747 (20.2 kb)  TX bytes:14320 (13.9 kb)
>           Base address:0x8500

I think this is not a phy or hardware problem but rather a FCC configuration
mismatch in fcc_enet.c.

Thanks for any tips
Laurent
