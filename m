Return-Path: <a.beregalov@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.235])
	by ozlabs.org (Postfix) with ESMTP id 04B8BDE02F
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 22:18:52 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so126949rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 05:18:50 -0700 (PDT)
From: Alexander Beregalov <a.beregalov@gmail.com>
To: galak@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/ep8248e: phylib needs NET_SCHED to build
Date: Wed, 20 May 2009 16:18:22 +0400
Message-Id: <1242821902-16836-1-git-send-email-a.beregalov@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Beregalov <a.beregalov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix this build error:
drivers/built-in.o: In function `phy_state_machine':
drivers/net/phy/phy.c:893: undefined reference to 'netif_carrier_off'
drivers/net/phy/phy.c:854: undefined reference to 'netif_carrier_on'

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---
 arch/powerpc/platforms/82xx/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 7c7df40..36a3e58 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -31,6 +31,9 @@ config EP8248E
 	select 8260
 	select FSL_SOC
 	select PHYLIB
+	select NET
+	select NETDEVICE
+	select NET_SCHED
 	select MDIO_BITBANG
 	help
 	  This enables support for the Embedded Planet EP8248E board.
-- 
1.6.2.4
