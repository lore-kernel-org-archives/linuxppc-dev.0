Return-Path: <BATV+bfa31428277ec1635a02+3390+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B9F152C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 21:15:53 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: dwmw2@infradead.org
Subject: [PATCH 2/4] powerpc: enable ARCH_USE_BUILTIN_BSWAP
Date: Tue,  4 Dec 2012 10:15:28 +0000
Message-Id: <1354616130-21587-3-git-send-email-dwmw2@infradead.org>
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

By using the compiler intrinsics instead of hand-crafted opaque inline
assembler for byte-swapping, we let the compiler see what's actually
happening and it gets to use lwbrx/stwbrx instructions instead of a
normal load/store coupled with a sequence of rlwimi instructions to
move bits around.

Compiled-tested only. It gave a code size reduction of almost 4% for
ext2, and more like 2.5% for ext3/ext4.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 arch/powerpc/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a902a5c..b4ea516 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -78,6 +78,9 @@ config ARCH_HAS_ILOG2_U64
 	bool
 	default y if 64BIT
 
+config ARCH_USE_BUILTIN_BSWAP
+       def_bool y
+
 config GENERIC_HWEIGHT
 	bool
 	default y
-- 
1.8.0
