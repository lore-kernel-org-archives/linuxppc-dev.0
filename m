Return-Path: <anton@samba.org>
Date: Tue, 22 Oct 2013 11:05:25 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Use -mcpu=power7 on ppc64 little endian builds
Message-ID: <20131022110525.4325f071@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Using -mcpu=power7 allows gcc to use a number of new instructions
including 64 bit byte reversed loads.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 6704e2e..c2a566f 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -93,22 +93,23 @@ choice
 
 config GENERIC_CPU
 	bool "Generic"
+	depends on !CPU_LITTLE_ENDIAN
 
 config CELL_CPU
 	bool "Cell Broadband Engine"
-	depends on PPC_BOOK3S_64
+	depends on PPC_BOOK3S_64 && !CPU_LITTLE_ENDIAN
 
 config POWER4_CPU
 	bool "POWER4"
-	depends on PPC_BOOK3S_64
+	depends on PPC_BOOK3S_64 && !CPU_LITTLE_ENDIAN
 
 config POWER5_CPU
 	bool "POWER5"
-	depends on PPC_BOOK3S_64
+	depends on PPC_BOOK3S_64 && !CPU_LITTLE_ENDIAN
 
 config POWER6_CPU
 	bool "POWER6"
-	depends on PPC_BOOK3S_64
+	depends on PPC_BOOK3S_64 && !CPU_LITTLE_ENDIAN
 
 config POWER7_CPU
 	bool "POWER7"
