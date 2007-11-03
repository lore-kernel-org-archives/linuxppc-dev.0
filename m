Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9F455DDF3D
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  4 Nov 2007 06:01:19 +1100 (EST)
Message-ID: <472CC579.6050008@scram.de>
Date: Sat, 03 Nov 2007 20:01:13 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: [PATCH2/2] [POWERPC] fs_enet: select PHYLIB as the driver needs it.
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	netdev <netdev@vger.kernel.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add a select PHYLIB to config FS_ENET as the driver uses functions of
libphy.

LD      .tmp_vmlinux1
drivers/built-in.o: In function `fs_ioctl':
drivers/net/fs_enet/fs_enet-main.c:952: undefined reference to `phy_mii_ioctl'
[...]
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
drivers/net/fs_enet/Kconfig |    1 +
1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/fs_enet/Kconfig b/drivers/net/fs_enet/Kconfig
index 2765e49..24502d2 100644
--- a/drivers/net/fs_enet/Kconfig
+++ b/drivers/net/fs_enet/Kconfig
@@ -2,6 +2,7 @@ config FS_ENET
     tristate "Freescale Ethernet Driver"
     depends on CPM1 || CPM2
     select MII
+       select PHYLIB

config FS_ENET_HAS_SCC
	bool "Chip has an SCC usable for ethernet"
-- 
1.5.3.4
