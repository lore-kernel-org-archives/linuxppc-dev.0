Return-Path: <hamishm@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTsyF3SkQzDqD2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 11:52:21 +1100 (AEDT)
From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: chris.packham@alliedtelesis.co.nz, linuxppc-dev@lists.ozlabs.org,
 Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] powerpc: Move THREAD_SHIFT config to KConfig
Date: Fri, 24 Feb 2017 13:52:09 +1300
Message-Id: <20170224005210.1318-2-hamish.martin@alliedtelesis.co.nz>
In-Reply-To: <20170224005210.1318-1-hamish.martin@alliedtelesis.co.nz>
References: <20170224005210.1318-1-hamish.martin@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shift the logic for defining THREAD_SHIFT logic to Kconfig in order to
allow override by users.

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/powerpc/Kconfig                   | 10 ++++++++++
 arch/powerpc/include/asm/thread_info.h | 10 +---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 281f4f1fcd1f..cd4dd9354b3c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -669,6 +669,16 @@ config PPC_256K_PAGES
 
 endchoice
 
+config THREAD_SHIFT
+	int "Thread shift" if EXPERT
+	range 13 15
+	default "15" if PPC_256K_PAGES
+	default "14" if PPC64
+	default "13"
+	help
+	  Used to define the stack size. The default is almost always what you
+	  want. Only change this if you know what you are doing.
+
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	range 8 9 if PPC64 && PPC_64K_PAGES
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 87e4b2d8dcd4..2e17d668c472 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -10,15 +10,7 @@
 
 #ifdef __KERNEL__
 
-/* We have 8k stacks on ppc32 and 16k on ppc64 */
-
-#if defined(CONFIG_PPC64)
-#define THREAD_SHIFT		14
-#elif defined(CONFIG_PPC_256K_PAGES)
-#define THREAD_SHIFT		15
-#else
-#define THREAD_SHIFT		13
-#endif
+#define THREAD_SHIFT		CONFIG_THREAD_SHIFT
 
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
-- 
2.11.0
