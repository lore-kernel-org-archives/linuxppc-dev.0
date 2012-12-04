Return-Path: <BATV+bfa31428277ec1635a02+3390+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E5C4B2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 21:15:52 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: dwmw2@infradead.org
Subject: [PATCH 3/4] x86: enable ARCH_USE_BUILTIN_BSWAP
Date: Tue,  4 Dec 2012 10:15:29 +0000
Message-Id: <1354616130-21587-4-git-send-email-dwmw2@infradead.org>
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

With -mmovbe enabled (implicit with -march=atom), this allows the
compiler to use the movbe instruction. This doesn't have a significant
effect on code size (unlike on PowerPC), because the movbe instruction
actually takes as many bytes to encode as a simple mov and a bswap. But
for Atom in particular I believe it should give a performance win over
the mov+bswap alternative. That was kind of why movbe was invented in
the first place, after all...

I've done basic functionality testing with IPv6 and Legacy IP, but no
performance testing. The EFI firmware on my test box unfortunately no
longer starts up.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 arch/x86/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 46c3bff..238f2ea 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -194,6 +194,9 @@ config ARCH_HAS_CACHE_LINE_SIZE
 config ARCH_HAS_CPU_AUTOPROBE
 	def_bool y
 
+config ARCH_USE_BUILTIN_BSWAP
+	def_bool y
+
 config HAVE_SETUP_PER_CPU_AREA
 	def_bool y
 
-- 
1.8.0
