Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17679.27506.518403.246902@cargo.ozlabs.ibm.com>
Date: Tue, 19 Sep 2006 14:00:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Define of_read_ulong helper
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are various places where we want to extract an unsigned long
value from a device-tree property that can be 1 or 2 cells in length.
This replaces some open-coded calculations, and one place where we
assumed without checking that properties were the length we wanted,
with a little of_read_ulong() helper.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index bf2005b..eb913f8 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -757,24 +757,9 @@ static int __init early_init_dt_scan_roo
 static unsigned long __init dt_mem_next_cell(int s, cell_t **cellp)
 {
 	cell_t *p = *cellp;
-	unsigned long r;
 
-	/* Ignore more than 2 cells */
-	while (s > sizeof(unsigned long) / 4) {
-		p++;
-		s--;
-	}
-	r = *p++;
-#ifdef CONFIG_PPC64
-	if (s > 1) {
-		r <<= 32;
-		r |= *(p++);
-		s--;
-	}
-#endif
-
-	*cellp = p;
-	return r;
+	*cellp = p + s;
+	return of_read_ulong(p, s);
 }
 
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 465e743..0af3fc1 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -304,18 +304,21 @@ struct seq_operations cpuinfo_op = {
 void __init check_for_initrd(void)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
-	const unsigned long *prop;
+	const unsigned int *prop;
+	int len;
 
 	DBG(" -> check_for_initrd()\n");
 
 	if (of_chosen) {
-		prop = get_property(of_chosen, "linux,initrd-start", NULL);
+		prop = get_property(of_chosen, "linux,initrd-start", &len);
 		if (prop != NULL) {
-			initrd_start = (unsigned long)__va(*prop);
+			initrd_start = (unsigned long)
+				__va(of_read_ulong(prop, len / 4));
 			prop = get_property(of_chosen,
-					"linux,initrd-end", NULL);
+					"linux,initrd-end", &len);
 			if (prop != NULL) {
-				initrd_end = (unsigned long)__va(*prop);
+				initrd_end = (unsigned long)
+					__va(of_read_ulong(prop, len / 4));
 				initrd_below_start_ok = 1;
 			} else
 				initrd_start = 0;
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index b9a2061..7a3c3f7 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -870,9 +870,7 @@ static int __init get_freq(char *name, i
 		fp = get_property(cpu, name, NULL);
 		if (fp) {
 			found = 1;
-			*val = 0;
-			while (cells--)
-				*val = (*val << 32) | *fp++;
+			*val = of_read_ulong(fp, cells);
 		}
 
 		of_node_put(cpu);
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index c15e66a..5246297 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -197,7 +197,7 @@ extern int release_OF_resource(struct de
  */
 
 
-/* Helper to read a big number */
+/* Helper to read a big number; size is in cells (not bytes) */
 static inline u64 of_read_number(const u32 *cell, int size)
 {
 	u64 r = 0;
@@ -206,6 +206,16 @@ static inline u64 of_read_number(const u
 	return r;
 }
 
+/* Like of_read_number, but we want an unsigned long result */
+#ifdef CONFIG_PPC32
+static inline unsigned long of_read_ulong(const u32 *cell, int size)
+{
+	return cell[size-1];
+}
+#else
+#define of_read_ulong(cell, size)	of_read_number(cell, size)
+#endif
+
 /* Translate an OF address block into a CPU physical address
  */
 #define OF_BAD_ADDR	((u64)-1)
