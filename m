Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E88C667CB2
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 13:24:13 +1100 (EST)
Date: Thu, 14 Dec 2006 11:24:08 +0900 (JST)
Message-Id: <200612140224.kBE2OAs7009514@toshiba.co.jp>
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

struct pci_controller doesn't prepare for the dependent data of each
specific bus. This patch adds private member to struct pci_controller.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linux-powerpc-git/include/asm-powerpc/pci-bridge.h
diff -u linux-powerpc-git/include/asm-powerpc/pci-bridge.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/pci-bridge.h:1.2
--- linux-powerpc-git/include/asm-powerpc/pci-bridge.h:1.1.1.1	Wed Dec  6 08:24:04 2006
+++ linux-powerpc-git/include/asm-powerpc/pci-bridge.h	Fri Dec  8 14:01:27 2006
@@ -53,6 +53,8 @@
 	unsigned long buid;
 	unsigned long dma_window_base_cur;
 	unsigned long dma_window_size;
+
+	void *private_data;
 };
 
 /*
