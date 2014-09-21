Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0224.hostedemail.com
 [216.40.44.224])
 by lists.ozlabs.org (Postfix) with ESMTP id C870D1A0196
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Sep 2014 04:01:34 +1000 (EST)
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id E893228FE4A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Sep 2014 17:55:13 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc: pci-ioda: Remove unnecessary return value from
 printk
Date: Sun, 21 Sep 2014 10:55:05 -0700
Message-Id: <66c8a7da00628a092e782b7818bf5bdea7408b34.1411320262.git.joe@perches.com>
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

The return value is unnecessary and unused, so make the functions
void instead of int.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index df241b1..16bb93f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -42,12 +42,11 @@
 #include "pci.h"
 
 #define define_pe_printk_level(func, kern_level)		\
-static int func(const struct pnv_ioda_pe *pe, const char *fmt, ...)	\
+static void func(const struct pnv_ioda_pe *pe, const char *fmt, ...)	\
 {								\
 	struct va_format vaf;					\
 	va_list args;						\
 	char pfix[32];						\
-	int r;							\
 								\
 	va_start(args, fmt);					\
 								\
@@ -61,12 +60,10 @@ static int func(const struct pnv_ioda_pe *pe, const char *fmt, ...)	\
 		sprintf(pfix, "%04x:%02x     ",			\
 			pci_domain_nr(pe->pbus),		\
 			pe->pbus->number);			\
-	r = printk(kern_level "pci %s: [PE# %.3d] %pV",		\
-		   pfix, pe->pe_number, &vaf);			\
+	printk(kern_level "pci %s: [PE# %.3d] %pV",		\
+	       pfix, pe->pe_number, &vaf);			\
 								\
 	va_end(args);						\
-								\
-	return r;						\
 }								\
 
 define_pe_printk_level(pe_err, KERN_ERR);
-- 
1.8.1.2.459.gbcd45b4.dirty
