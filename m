Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0931F1A065A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 10:21:42 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C239D14015A
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 10:21:41 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 09:21:41 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D2BDD2CE8050
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 10:21:36 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2PNLSg349152010
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 10:21:36 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2PNL3At000972
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 10:21:03 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 1/4] powerpc/eeh: Eliminate duplicated PE states
Date: Thu, 26 Mar 2015 10:20:34 +1100
Message-Id: <1427325637-14345-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1427325637-14345-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1427325637-14345-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, alex.williamson@redhat.com,
 agraf@suse.de, kvm@vger.kernel.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are two equivalent sets of constants for PE states, defined
in arch/powerpc/include/asm/eeh.h and include/uapi/linux/vfio.h.
The former is used by EEH core and the latter is used by userspace.
The patch moves those constants from arch/powerpc/include/asm/eeh.h
to arch/powerpc/include/uapi/asm/eeh.h to avoid maintaining two
equivalent sets of constants.

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h      |  7 ++-----
 arch/powerpc/include/uapi/asm/eeh.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/eeh.h

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index d777c0c..08c4042 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -27,6 +27,8 @@
 #include <linux/time.h>
 #include <linux/atomic.h>
 
+#include <uapi/asm/eeh.h>
+
 struct pci_dev;
 struct pci_bus;
 
@@ -184,11 +186,6 @@ enum {
 #define EEH_STATE_DMA_ACTIVE	(1 << 4)	/* Active DMA		*/
 #define EEH_STATE_MMIO_ENABLED	(1 << 5)	/* MMIO enabled		*/
 #define EEH_STATE_DMA_ENABLED	(1 << 6)	/* DMA enabled		*/
-#define EEH_PE_STATE_NORMAL		0	/* Normal state		*/
-#define EEH_PE_STATE_RESET		1	/* PE reset asserted	*/
-#define EEH_PE_STATE_STOPPED_IO_DMA	2	/* Frozen PE		*/
-#define EEH_PE_STATE_STOPPED_DMA	4	/* Stopped DMA, Enabled IO */
-#define EEH_PE_STATE_UNAVAIL		5	/* Unavailable		*/
 #define EEH_RESET_DEACTIVATE	0	/* Deactivate the PE reset	*/
 #define EEH_RESET_HOT		1	/* Hot reset			*/
 #define EEH_RESET_FUNDAMENTAL	3	/* Fundamental reset		*/
diff --git a/arch/powerpc/include/uapi/asm/eeh.h b/arch/powerpc/include/uapi/asm/eeh.h
new file mode 100644
index 0000000..8bb34b0
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/eeh.h
@@ -0,0 +1,30 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright IBM Corp. 2015
+ *
+ * Authors: Gavin Shan <gwshan@linux.vnet.ibm.com>
+ */
+
+#ifndef _ASM_POWERPC_EEH_H
+#define _ASM_POWERPC_EEH_H
+
+/* PE states */
+#define EEH_PE_STATE_NORMAL		0	/* Normal state		*/
+#define EEH_PE_STATE_RESET		1	/* PE reset asserted	*/
+#define EEH_PE_STATE_STOPPED_IO_DMA	2	/* Frozen PE		*/
+#define EEH_PE_STATE_STOPPED_DMA	4	/* Stopped DMA only	*/
+#define EEH_PE_STATE_UNAVAIL		5	/* Unavailable		*/
+
+#endif /* _ASM_POWERPC_EEH_H */
-- 
1.8.3.2
