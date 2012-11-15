Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5C2482C03F6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 20:40:19 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH 6/6] book3e/kexec/kdump: redefine VIRT_PHYS_OFFSET
Date: Thu, 15 Nov 2012 17:39:56 +0800
Message-ID: <1352972396-13489-7-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1352972396-13489-1-git-send-email-tiejun.chen@windriver.com>
References: <1352972396-13489-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Book3e is always aligned 1GB to create TLB so we should
use (KERNELBASE - MEMORY_START) as VIRT_PHYS_OFFSET to
get __pa/__va properly while boot kdump.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/include/asm/page.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index f072e97..2cba08a 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -112,6 +112,8 @@ extern long long virt_phys_offset;
 /* See Description below for VIRT_PHYS_OFFSET */
 #ifdef CONFIG_RELOCATABLE_PPC32
 #define VIRT_PHYS_OFFSET virt_phys_offset
+#elif defined(CONFIG_PPC_BOOK3E_64)
+#define VIRT_PHYS_OFFSET (KERNELBASE - MEMORY_START)
 #else
 #define VIRT_PHYS_OFFSET (KERNELBASE - PHYSICAL_START)
 #endif
-- 
1.7.9.5
