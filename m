Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0030.hostedemail.com
 [216.40.44.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 45DFB1A011F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Sep 2014 04:04:39 +1000 (EST)
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id D0C7B1728CE
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Sep 2014 17:55:15 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc: pci-ioda: Use a single function to emit logging
 messages
Date: Sun, 21 Sep 2014 10:55:06 -0700
Message-Id: <39e19ff7a164c674d94c31ce2650374f0b191ff3.1411320262.git.joe@perches.com>
In-Reply-To: <cover.1411320262.git.joe@perches.com>
References: <cover.1411320262.git.joe@perches.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No need for 3 functions when a single one will do.

Modify the function declaring macros to call the single function.

Reduces object code size a little:

$ size arch/powerpc/platforms/powernv/pci-ioda.o*
   text	   data	    bss	    dec	    hex	filename
  22303	   1073	   6680	  30056	   7568	arch/powerpc/platforms/powernv/pci-ioda.o.new
  22840	   1121	   6776	  30737	   7811	arch/powerpc/platforms/powernv/pci-ioda.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 58 ++++++++++++++++---------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 16bb93f..b0d31083 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -41,34 +41,36 @@
 #include "powernv.h"
 #include "pci.h"
 
-#define define_pe_printk_level(func, kern_level)		\
-static void func(const struct pnv_ioda_pe *pe, const char *fmt, ...)	\
-{								\
-	struct va_format vaf;					\
-	va_list args;						\
-	char pfix[32];						\
-								\
-	va_start(args, fmt);					\
-								\
-	vaf.fmt = fmt;						\
-	vaf.va = &args;						\
-								\
-	if (pe->pdev)						\
-		strlcpy(pfix, dev_name(&pe->pdev->dev),		\
-			sizeof(pfix));				\
-	else							\
-		sprintf(pfix, "%04x:%02x     ",			\
-			pci_domain_nr(pe->pbus),		\
-			pe->pbus->number);			\
-	printk(kern_level "pci %s: [PE# %.3d] %pV",		\
-	       pfix, pe->pe_number, &vaf);			\
-								\
-	va_end(args);						\
-}								\
-
-define_pe_printk_level(pe_err, KERN_ERR);
-define_pe_printk_level(pe_warn, KERN_WARNING);
-define_pe_printk_level(pe_info, KERN_INFO);
+static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
+			    const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+	char pfix[32];
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	if (pe->pdev)
+		strlcpy(pfix, dev_name(&pe->pdev->dev), sizeof(pfix));
+	else
+		sprintf(pfix, "%04x:%02x     ",
+			pci_domain_nr(pe->pbus), pe->pbus->number);
+
+	printk("%spci %s: [PE# %.3d] %pV",
+	       level, pfix, pe->pe_number, &vaf);
+
+	va_end(args);
+}
+
+#define pe_err(pe, fmt, ...)					\
+	pe_level_printk(pe, KERN_ERR, fmt, ##__VA_ARGS__)
+#define pe_warn(pe, fmt, ...)					\
+	pe_level_printk(pe, KERN_WARNING, fmt, ##__VA_ARGS__)
+#define pe_info(pe, fmt, ...)					\
+	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
 
 /*
  * stdcix is only supposed to be used in hypervisor real mode as per
-- 
1.8.1.2.459.gbcd45b4.dirty
