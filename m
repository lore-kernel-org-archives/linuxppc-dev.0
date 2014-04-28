Return-Path: <joseph.salisbury@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) by ozlabs.org (Postfix) with ESMTP id 147491400DE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 07:11:32 +1000 (EST)
From: Joseph Salisbury <joseph.salisbury@canonical.com>
To: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/3][RFC][v1] powerpc: Change the powerpc architecture to use
 Kconfig to set COMMAND_LINE_SIZE.
Date: Mon, 28 Apr 2014 17:11:24 -0400
Message-Id: <ea6384682cc09ce4dc18a2e8549df59c61faf851.1398287637.git.joseph.salisbury@canonical.com>
In-Reply-To: <cover.1398287636.git.joseph.salisbury@canonical.com>
References: <cover.1398287636.git.joseph.salisbury@canonical.com>
In-Reply-To: <cover.1398287636.git.joseph.salisbury@canonical.com>
References: <cover.1398287636.git.joseph.salisbury@canonical.com>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc architecture currently uses asm-generic to set the value of COMMAND_LINE_SIZE.  This change will allow the value of COMMAND_LINE_SIZE to be set specifically for powerpc without affecting other architectures that may use asm-generic.

Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 arch/powerpc/include/asm/setup.h      | 2 --
 arch/powerpc/include/uapi/asm/setup.h | 1 -
 2 files changed, 3 deletions(-)
 delete mode 100644 arch/powerpc/include/uapi/asm/setup.h

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 11ba86e..c7b62c3 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -1,8 +1,6 @@
 #ifndef _ASM_POWERPC_SETUP_H
 #define _ASM_POWERPC_SETUP_H
 
-#include <uapi/asm/setup.h>
-
 #ifndef __ASSEMBLY__
 extern void ppc_printk_progress(char *s, unsigned short hex);
 
diff --git a/arch/powerpc/include/uapi/asm/setup.h b/arch/powerpc/include/uapi/asm/setup.h
deleted file mode 100644
index 552df83..0000000
--- a/arch/powerpc/include/uapi/asm/setup.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/setup.h>
-- 
1.9.1
