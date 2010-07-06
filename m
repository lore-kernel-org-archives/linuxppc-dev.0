Return-Path: <tony@ozlabs.org>
To: <linuxppc-dev@lists.ozlabs.org>, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Message-Id: <f1cea220d59687dcea67ef98b4bf5e774efcded5.1278392169.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH] powerpc: Fix bad include of stdint.h in ptrace.h when
	-D__ASSEMBLY__
Date: Tue,  6 Jul 2010 14:56:19 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 3162d92dfb79a0b5fc03380b8819fa5f870ebf1e (powerpc: Extended
ptrace interface) we #included stdint.h even if __ASSEMBLY__ is defined.
This broke building of libc with modern kernel headers.

---
<snip>
../sysdeps/generic/stdint.h: Assembler messages:
../sysdeps/generic/stdint.h:37: Error: Unrecognized opcode: `typedef'
../sysdeps/generic/stdint.h:38: Error: Unrecognized opcode: `typedef'
../sysdeps/generic/stdint.h:39: Error: Unrecognized opcode: `typedef'
<snip>
---

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/include/asm/ptrace.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 9e2d84c..441179a 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -27,7 +27,9 @@
 #ifdef __KERNEL__
 #include <linux/types.h>
 #else
+#ifndef __ASSEMBLY__
 #include <stdint.h>
+#endif /* __ASSEMBLY__ */
 #endif
 
 #ifndef __ASSEMBLY__
-- 
1.6.6.1
