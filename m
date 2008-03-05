Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 60B78DDEEB
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 05:42:45 +1100 (EST)
Date: Wed, 5 Mar 2008 21:38:04 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC 4xx: Add dcri_clrset() for locked read/modify/write
	functionality
Message-ID: <20080305183804.GA21760@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47CEDC6F.6060205@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds dcri_clrset() macro which does read/modify/write
on indirect dcr registers while holding indirect dcr lock.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 include/asm-powerpc/dcr-native.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)

--- linux-2.6.orig/include/asm-powerpc/dcr-native.h	2008-03-05 17:32:31.000000000 +0300
+++ linux-2.6/include/asm-powerpc/dcr-native.h	2008-03-05 17:53:16.000000000 +0300
@@ -82,6 +82,19 @@ static inline void __mtdcri(int base_add
 	spin_unlock_irqrestore(&dcr_ind_lock, flags);
 }
 
+static inline void __dcri_clrset(int base_addr, int base_data, int reg,
+				 unsigned clr, unsigned set)
+{
+	unsigned long flags;
+	unsigned int val;
+
+	spin_lock_irqsave(&dcr_ind_lock, flags);
+	__mtdcr(base_addr, reg);
+	val = (__mfdcr(base_data) & ~clr) | set;
+	__mtdcr(base_data, val);
+	spin_unlock_irqrestore(&dcr_ind_lock, flags);
+}
+
 #define mfdcri(base, reg)	__mfdcri(DCRN_ ## base ## _CONFIG_ADDR,	\
 					 DCRN_ ## base ## _CONFIG_DATA,	\
 					 reg)
@@ -90,6 +103,10 @@ static inline void __mtdcri(int base_add
 					 DCRN_ ## base ## _CONFIG_DATA,	\
 					 reg, data)
 
+#define dcri_clrset(base, reg, clr, set)	__dcri_clrset(DCRN_ ## base ## _CONFIG_ADDR,	\
+							      DCRN_ ## base ## _CONFIG_DATA,	\
+							      reg, clr, set)
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_DCR_NATIVE_H */
