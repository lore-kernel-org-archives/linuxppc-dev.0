Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A5C20DDF56
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 07:02:47 +1100 (EST)
Date: Sat, 27 Oct 2007 21:02:32 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] fix breakage in pegasos_eth (fallout from commit
	b45d9147f1582333e180e1023624c003874b7312)
Message-ID: <20071027200232.GS8181@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	buytenh@wantstofly.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/include/linux/mv643xx_eth.h b/include/linux/mv643xx_eth.h
index 3f27239..8df230a 100644
--- a/include/linux/mv643xx_eth.h
+++ b/include/linux/mv643xx_eth.h
@@ -8,6 +8,9 @@
 #define MV643XX_ETH_NAME		"mv643xx_eth"
 #define MV643XX_ETH_SHARED_REGS		0x2000
 #define MV643XX_ETH_SHARED_REGS_SIZE	0x2000
+#define MV643XX_ETH_BAR_4	0x220
+#define MV643XX_ETH_SIZE_REG_4	0x224
+#define MV643XX_ETH_BASE_ADDR_ENABLE_REG	0x0290
 
 struct mv643xx_eth_platform_data {
 	int		port_number;
