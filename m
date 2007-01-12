Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 297ECDDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 11:57:43 +1100 (EST)
Date: Fri, 12 Jan 2007 09:57:37 +0900 (JST)
Message-Id: <200701120057.l0C0vcq0016505@toshiba.co.jp>
Subject: [PATCH 4/19] powerpc: add a field for each specific bus to sturct
	pci_controller
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Struct pci_controller doesn't prepare for the dependent data of each
specific bus. This patch adds private member to struct pci_controller.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linux-powerpc-git/include/asm-powerpc/pci-bridge.h
diff -u linux-powerpc-git/include/asm-powerpc/pci-bridge.h:1.1.1.2 linux-powerpc-git/include/asm-powerpc/pci-bridge.h:1.3
--- linux-powerpc-git/include/asm-powerpc/pci-bridge.h:1.1.1.2	Tue Dec 26 18:06:41 2006
+++ linux-powerpc-git/include/asm-powerpc/pci-bridge.h	Tue Dec 26 19:56:46 2006
@@ -53,6 +53,8 @@
 	unsigned long buid;
 	unsigned long dma_window_base_cur;
 	unsigned long dma_window_size;
+
+	void *private_data;
 };
 
 /*
