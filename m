Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] Only use initrd_end as the limit for alloc_bottom if it's
 inside the RMO.
Date: Wed, 14 Dec 2011 14:54:13 +1100
Message-Id: <1323834853-10174-1-git-send-email-tony@bakeyournoodle.com>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>

As the kernels and initrd's get bigger boot-loaders and possibly
kexec-tools will need to place the initrd outside the RMO.  When this
happens we end up with no lowmem and the boot doesn't get very far.

Only use initrd_end as the limit for alloc_bottom if it's inside the
RMO.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/kernel/prom_init.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index cc58486..940dc0c 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1224,14 +1224,6 @@ static void __init prom_init_mem(void)
 
 	RELOC(alloc_bottom) = PAGE_ALIGN((unsigned long)&RELOC(_end) + 0x4000);
 
-	/* Check if we have an initrd after the kernel, if we do move our bottom
-	 * point to after it
-	 */
-	if (RELOC(prom_initrd_start)) {
-		if (RELOC(prom_initrd_end) > RELOC(alloc_bottom))
-			RELOC(alloc_bottom) = PAGE_ALIGN(RELOC(prom_initrd_end));
-	}
-
 	/*
 	 * If prom_memory_limit is set we reduce the upper limits *except* for
 	 * alloc_top_high. This must be the real top of RAM so we can put
@@ -1269,6 +1261,15 @@ static void __init prom_init_mem(void)
 	RELOC(alloc_top) = RELOC(rmo_top);
 	RELOC(alloc_top_high) = RELOC(ram_top);
 
+	/*
+	 * Check if we have an initrd after the kernel but still inside
+	 * the RMO.  If we do move our bottom point to after it.
+	 */
+	if (RELOC(prom_initrd_start) &&
+	    RELOC(prom_initrd_start) < RELOC(rmo_top) &&
+	    RELOC(prom_initrd_end) > RELOC(alloc_bottom))
+		RELOC(alloc_bottom) = PAGE_ALIGN(RELOC(prom_initrd_end));
+
 	prom_printf("memory layout at init:\n");
 	prom_printf("  memory_limit : %x (16 MB aligned)\n", RELOC(prom_memory_limit));
 	prom_printf("  alloc_bottom : %x\n", RELOC(alloc_bottom));
-- 
1.7.6.4
