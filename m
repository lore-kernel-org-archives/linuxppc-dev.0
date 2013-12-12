Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	Ulrich.Weigand@de.ibm.com
Subject: [PATCH 8/8] powerpc: Fix endian issues in crash dump code
Date: Thu, 12 Dec 2013 15:59:41 +1100
Message-Id: <1386824381-14032-9-git-send-email-anton@samba.org>
In-Reply-To: <1386824381-14032-1-git-send-email-anton@samba.org>
References: <1386824381-14032-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A couple more device tree properties that need byte swapping.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/crash_dump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 779a78c..11c1d06 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -124,15 +124,15 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
 {
 	unsigned long addr;
-	const u32 *basep, *sizep;
+	const __be32 *basep, *sizep;
 	unsigned int rtas_start = 0, rtas_end = 0;
 
 	basep = of_get_property(rtas.dev, "linux,rtas-base", NULL);
 	sizep = of_get_property(rtas.dev, "rtas-size", NULL);
 
 	if (basep && sizep) {
-		rtas_start = *basep;
-		rtas_end = *basep + *sizep;
+		rtas_start = be32_to_cpup(basep);
+		rtas_end = rtas_start + be32_to_cpup(sizep);
 	}
 
 	for (addr = begin; addr < end; addr += PAGE_SIZE) {
-- 
1.8.3.2
