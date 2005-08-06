Return-Path: <aris@cathedrallabs.org>
Received: from panda.sul.com.br (panda.sul.com.br [200.219.150.4])
	by ozlabs.org (Postfix) with ESMTP id 8E7C667F03
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  7 Aug 2005 04:00:18 +1000 (EST)
Date: Sat, 6 Aug 2005 15:00:17 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050806180017.GT5210@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] 8xx: restrict ENET_BIG_BUFFERS option
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

8xx: restrict ENET_BIG_BUFFERS option to drivers which actually uses it

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

Index: 8xx/arch/ppc/8xx_io/Kconfig
===================================================================
--- 8xx.orig/arch/ppc/8xx_io/Kconfig	2005-08-04 08:38:10.000000000 -0300
+++ 8xx/arch/ppc/8xx_io/Kconfig	2005-08-04 08:48:10.000000000 -0300
@@ -69,7 +69,7 @@
 	
 config ENET_BIG_BUFFERS
 	bool "Use Big CPM Ethernet Buffers"
-	depends on NET_ETHERNET
+	depends on SCC_ENET || FEC_ENET
 	help
 	  Allocate large buffers for MPC8xx Ethernet. Increases throughput
 	  and decreases the likelihood of dropped packets, but costs memory.
