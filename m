Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.194])
	by ozlabs.org (Postfix) with ESMTP id CABFB67A8B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 14:14:25 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id 1so5038rny
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 19:14:24 -0800 (PST)
Message-ID: <c3d0340b050222190712ee7dff@mail.gmail.com>
Date: Tue, 22 Feb 2005 19:07:44 -0800
From: Shawn Jin <shawnxjin@gmail.com>
To: uboot <u-boot-users@lists.sourceforge.net>,
	ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Ethernet doesn't work in linux for PPC440GP?
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

First please forgive me for the cross-list post. I do believe this
topic is related to both lists.

I'm playing with UBoot and Linux 2.6.10 on IBM PPC440GP evaluation
board (Ebony) and have some issue with ethernet. With Rom Monitor
linux 2.6.10 was running successfully using default configuration for
Ebony. Here the scree dump for ethernet dection.

emac: IBM EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
zmii0: input 0 in RMII mode
eth0: IBM emac, MAC 00:04:ac:e3:1b:bb
eth0: Found Generic MII PHY (0x08)
zmii0: input 1 in RMII mode
eth1: IBM emac, MAC 00:04:ac:e3:1b:bc
eth1: Found Generic MII PHY (0x09)

However with Uboot, the emac driver cannot read MAC addresses from VPD
correctly. The original 2.6.10 code didn't recognize uboot's bd_info.
After some hack eth0 gets its MAC address from uboot's bd_info and
seems initialized correctly. But somehow booting an NFS root fs
failed. So I suspect it's due to the ethernet driver. BTW, the same
image is used in the two

emac: IBM EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
zmii0: input 0 in SMII mode
eth0: IBM emac, MAC 00:04:ac:e3:1b:bb
eth0: Found Generic MII PHY (0x08)
zmii0: input 1 in RMII mode
eth1: IBM emac, MAC FF:FF:FF:FF:FF:FF
eth1: Found Generic MII PHY (0x09)

I know there was discussion about what a linux ethernet driver should
expect from boot loader. In fact the driver shouldn't expect anything
from a boot loader. Wolfgang has the same opinion in his DULG. What I
don't know is if this EMAC driver expects something configured by boot
loader? It seems to me that Rom Monitor did configure something for
ethernet that the EMAC driver expected.

Anyone has the similar problem before?

Thanks,
-Shawn.
