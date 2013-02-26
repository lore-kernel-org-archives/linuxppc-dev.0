Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0947C2C0368
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 20:20:01 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <galak@kernel.crashing.org>
Subject: [v1][PATCH 6/7] book3e/kexec/kdump: redefine VIRT_PHYS_OFFSET
Date: Tue, 26 Feb 2013 17:19:41 +0800
Message-ID: <1361870382-743-7-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1361870382-743-1-git-send-email-tiejun.chen@windriver.com>
References: <1361870382-743-1-git-send-email-tiejun.chen@windriver.com>
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
