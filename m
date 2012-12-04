Return-Path: <BATV+bfa31428277ec1635a02+3390+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 019122C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 21:15:52 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: dwmw2@infradead.org
Subject: [PATCH 4/4] x86: add CONFIG_X86_MOVBE option
Date: Tue,  4 Dec 2012 10:15:30 +0000
Message-Id: <1354616130-21587-5-git-send-email-dwmw2@infradead.org>
In-Reply-To: <1354616130-21587-1-git-send-email-dwmw2@infradead.org>
References: <1354616130-21587-1-git-send-email-dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Woodhouse <David.Woodhouse@intel.com>

Currently depends only on CONFIG_MATOM. This will change because big-core
CPUs are getting movbe too...

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 arch/x86/Kconfig.cpu | 4 ++++
 arch/x86/Makefile    | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index f3b86d0..969f7a6 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -353,6 +353,10 @@ config X86_BSWAP
 	def_bool y
 	depends on X86_32 && !M386
 
+config X86_MOVBE
+	def_bool y
+	depends on MATOM
+
 config X86_POPAD_OK
 	def_bool y
 	depends on X86_32 && !M386
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 05afcca..0e71d76 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -64,6 +64,7 @@ else
                 $(call cc-option,-march=core2,$(call cc-option,-mtune=generic))
 	cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
 		$(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
+        cflags-$(CONFIG_X86_MOVBE) += $(call cc-option,-mmovbe)
         cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
         KBUILD_CFLAGS += $(cflags-y)
 
-- 
1.8.0
