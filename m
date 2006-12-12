Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A74D67C6E
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 15:06:50 +1100 (EST)
Date: Tue, 12 Dec 2006 13:06:45 +0900 (JST)
Message-Id: <200612120406.kBC46klg011193@toshiba.co.jp>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 13/15] powerpc: add a field for each specific bus to sturct
	pci_controller
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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

Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
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
