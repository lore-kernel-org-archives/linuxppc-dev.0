Return-Path: <galak@gate.crashing.org>
Date: Wed, 11 Jan 2006 17:57:13 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0601111716090.4407-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] powerpc: Fixed memory reserve map layout
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: Fixed memory reserve map layout

The memory reserve map is suppose to be a pair of 64-bit integers
to represent each region.  On ppc32 the code was treating the
pair as two 32-bit integers.  Additional the prom_init code was
producing the wrong layout on ppc32.

Added a simple check to try to provide backwards compatibility.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit dc15eeb7325279bf9e5b49f79567fa0886cd8c31
tree e724bd9d855d5f2a71720742c7ec279609c1aaaa
parent aa30a75885b935a7f09a1312e792f96cc338e505
author Kumar Gala <galak@kernel.crashing.org> Wed, 11 Jan 2006 18:02:36 -0600
committer Kumar Gala <galak@kernel.crashing.org> Wed, 11 Jan 2006 18:02:36 -0600

 arch/powerpc/kernel/prom.c      |   28 ++++++++++++++++++++++++----
 arch/powerpc/kernel/prom_init.c |    8 ++++----
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 34ab0da..02e2115 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1100,17 +1100,37 @@ static int __init early_init_dt_scan_mem
 
 static void __init early_reserve_mem(void)
 {
-	unsigned long base, size;
-	unsigned long *reserve_map;
+	u64 base, size;
+	u64 *reserve_map;
 
-	reserve_map = (unsigned long *)(((unsigned long)initial_boot_params) +
+	reserve_map = (u64 *)(((unsigned long)initial_boot_params) +
 					initial_boot_params->off_mem_rsvmap);
+#ifdef CONFIG_PPC32
+	/* 
+	 * Handle the case where we might be booting from an old kexec
+	 * image that setup the mem_rsvmap as pairs of 32-bit values
+	 */
+	if (*reserve_map > 0xffffffffull) {
+		u32 base_32, size_32;
+		u32 *reserve_map_32 = (u32 *)reserve_map;
+
+		while (1) {
+			base_32 = *(reserve_map_32++);
+			size_32 = *(reserve_map_32++);
+			if (size_32 == 0)
+				break;
+			DBG("reserving: %lx -> %lx\n", base_32, size_32);
+			lmb_reserve(base_32, size_32);
+		}
+		return;
+	}
+#endif
 	while (1) {
 		base = *(reserve_map++);
 		size = *(reserve_map++);
 		if (size == 0)
 			break;
-		DBG("reserving: %lx -> %lx\n", base, size);
+		DBG("reserving: %llx -> %llx\n", base, size);
 		lmb_reserve(base, size);
 	}
 
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index e381f2f..d963a12 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -137,8 +137,8 @@ struct prom_t {
 };
 
 struct mem_map_entry {
-	unsigned long	base;
-	unsigned long	size;
+	u64	base;
+	u64	size;
 };
 
 typedef u32 cell_t;
@@ -897,9 +897,9 @@ static unsigned long __init prom_next_ce
  * If problems seem to show up, it would be a good start to track
  * them down.
  */
-static void reserve_mem(unsigned long base, unsigned long size)
+static void reserve_mem(u64 base, u64 size)
 {
-	unsigned long top = base + size;
+	u64 top = base + size;
 	unsigned long cnt = RELOC(mem_reserve_cnt);
 
 	if (size == 0)
