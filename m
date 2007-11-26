Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id D2F56DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 02:59:39 +1100 (EST)
Message-ID: <474AED67.4020006@harris.com>
Date: Mon, 26 Nov 2007 10:59:35 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Sequoia EMAC only works if u-boot initializes it?
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have noticed odd behavior on a Sequoia board.  Kernel is built from 
DENX git, ARCH=powerpc, 2.6.23.1.

Sequence that works:
1) In u-boot, do "dhcp" (this initializes the PHY)
2) Boot linux from flash
3) ifconfig eth0 192.168.0.101 netmask 255.255.255.0 up
Ethernet is now functional, and I can ping the Sequoia (and it can ping 
my host)

Sequence that does not work:
1) Boot linux from flash without letting u-boot touch eth0
2) ifconfig eth0 192.168.0.101 netmask 255.255.255.0 up
Ethernet appears to come up, but it is not functional.  I.e. I get 
"eth0: link is up, 100 FDX, pause enabled" but I cannot ping the board, 
and the board cannot ping my host.

So, the kernel appears to be missing some initialization that u-boot 
provides.

However, eth1 is more strange.  U-boot can use it (via "setenv ethact 
ppc_4xx_eth1;dhcp"), however, the kernel cannot use it, whether or not 
u-boot first initializes it.

If anyone has suggestions on where to look, I'd appreciate it.  I'm 
going to look at the PHY register settings and see if there are any 
clues there...

    Steve
