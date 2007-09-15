Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id C5633DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Sep 2007 13:39:00 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1261362wag
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Sep 2007 20:38:59 -0700 (PDT)
Message-ID: <9e4733910709142038y1bd88cd5s7c9bb21a668db9f6@mail.gmail.com>
Date: Fri, 14 Sep 2007 23:38:59 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Domen Puncer" <domen.puncer@telargo.com>, linuxppc-embedded@ozlabs.org
Subject: Domen's MPC5200 FEC cleanup patch.
MIME-Version: 1.0
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

This patch doesn't seem to working quite right on my hardware (Phytec
pcm030). At boot I get a long pause.

I have a long pause when Ethernet is initializing

[    0.798529] NET: Registered protocol family 1
[    0.802988] NET: Registered protocol family 17
[    1.313708] net eth0: attached phy 0 to driver Generic PHY
[    2.320013] Sending DHCP requests ...... timed out!
[   81.968863] IP-Config: Retrying forever (NFS root)...
[   82.477527] net eth0: attached phy 0 to driver Generic PHY
[   83.487809] Sending DHCP requests .<6>PHY: f0003000:00 - Link is Up
- 100/Full
[   86.323795] ., OK
[   88.579802] IP-Config: Got DHCP answer from 192.168.1.200, my
address is 192.168.1.5
[   88.587923] IP-Config: Complete:

Reverting back to
0008-drivers-net-Add-support-for-Freescale-MPC5200-SoC-i.patch the
pause goes away.

[    0.793916] TCP cubic registered
[    0.797309] NET: Registered protocol family 1
[    0.801808] NET: Registered protocol family 17
[    1.309611] eth0: config: auto-negotiation on, 100HDX, 10HDX.
[    2.316014] Sending DHCP requests .., OK
[    7.124005] IP-Config: Got DHCP answer from 192.168.1.200, my
address is 192.168.1.5
[    7.132121] IP-Config: Complete:
[    7.135212]       device=eth0, addr=192.168.1.5,
mask=255.255.255.0, gw=192.168.1.200,
[    7.143192]      host=MPC, domain=home, nis-domain=(none),
[    7.148778]      bootserver=192.168.1.200, rootserver=192.168.1.4, rootpath=

Something not quite right with interrupts maybe? I'm trying to debug it.

-- 
Jon Smirl
jonsmirl@gmail.com
