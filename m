Return-Path: <bunk@kernel.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by ozlabs.org (Postfix) with ESMTP id 84F73DE523
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 03:50:17 +1000 (EST)
Date: Mon, 23 Jun 2008 20:48:21 +0300
From: Adrian Bunk <bunk@kernel.org>
To: paulus@samba.org
Subject: [RFC: 2.6 patch] powerpc: don't export asm/asm-compat.h to userspace
Message-ID: <20080623174821.GF4756@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

asm/asm-compat.h doesn't seem to be intended for userspace usage.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/asm-powerpc/Kbuild     |    1 -
 include/asm-powerpc/cputable.h |    5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

4c78f2fc562d3aae525c8f62706a80479228c50e diff --git a/include/asm-powerpc/Kbuild b/include/asm-powerpc/Kbuild
index 6920904..90cb216 100644
--- a/include/asm-powerpc/Kbuild
+++ b/include/asm-powerpc/Kbuild
@@ -24,7 +24,6 @@ header-y += sigcontext.h
 header-y += statfs.h
 header-y += ps3fb.h
 
-unifdef-y += asm-compat.h
 unifdef-y += bootx.h
 unifdef-y += byteorder.h
 unifdef-y += cputable.h
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 1e79673..08b594a 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_POWERPC_CPUTABLE_H
 #define __ASM_POWERPC_CPUTABLE_H
 
-#include <asm/asm-compat.h>
-
 #define PPC_FEATURE_32			0x80000000
 #define PPC_FEATURE_64			0x40000000
 #define PPC_FEATURE_601_INSTR		0x20000000
@@ -31,6 +29,9 @@
 #define PPC_FEATURE_PPC_LE		0x00000001
 
 #ifdef __KERNEL__
+
+#include <asm/asm-compat.h>
+
 #ifndef __ASSEMBLY__
 
 /* This structure can grow, it's real size is used by head.S code
