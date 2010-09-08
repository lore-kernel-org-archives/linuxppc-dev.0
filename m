Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 6B6F4B7163
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Sep 2010 02:41:37 +1000 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] fsldma: fix missing header include
Date: Wed,  8 Sep 2010 09:41:18 -0700
Message-Id: <1283964082-30133-2-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1283964082-30133-1-git-send-email-iws@ovro.caltech.edu>
References: <1283964082-30133-1-git-send-email-iws@ovro.caltech.edu>
Cc: linux-kernel@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The slab.h header is required to use the kmalloc() family of functions.
Due to recent kernel changes, this header must be directly included by
code that calls into the memory allocator.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 arch/powerpc/include/asm/fsldma.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/fsldma.h b/arch/powerpc/include/asm/fsldma.h
index a67aeed..debc5ed 100644
--- a/arch/powerpc/include/asm/fsldma.h
+++ b/arch/powerpc/include/asm/fsldma.h
@@ -11,6 +11,7 @@
 #ifndef __ARCH_POWERPC_ASM_FSLDMA_H__
 #define __ARCH_POWERPC_ASM_FSLDMA_H__
 
+#include <linux/slab.h>
 #include <linux/dmaengine.h>
 
 /*
-- 
1.7.1
