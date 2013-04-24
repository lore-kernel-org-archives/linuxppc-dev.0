Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [RFC, PATCH v3] powerpc/prom: Scan reserved-ranges node for memory
 reservations
Message-Id: <1366784790.696247.919883868307.1.gpush@pablo>
To: linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 24 Apr 2013 14:26:30 +0800
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Based on benh's proposal at
https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-September/101237.html,
this change provides support for reserving memory from the
reserved-ranges node at the root of the device tree.

We just call memblock_reserve on these ranges for now.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
v3: Use of_get_flat_dt_root

---
 arch/powerpc/kernel/prom.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 8b6f7a9..9c753bc 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -559,6 +559,33 @@ void __init early_init_dt_setup_initrd_arch(unsigned long start,
 }
 #endif
 
+static bool __init early_reserve_mem_dt(void)
+{
+	unsigned long i, len, dt_root;
+	const __be32 *prop;
+
+	dt_root = of_get_flat_dt_root();
+
+	prop = of_get_flat_dt_prop(dt_root, "reserved-ranges", &len);
+
+	if (!prop)
+		return false;
+
+	/* Each reserved range is an (address,size) pair, 2 cells each,
+	 * totalling 4 cells per range. */
+	for (i = 0; i < len / (sizeof(*prop) * 4); i++) {
+		u64 base, size;
+
+		base = of_read_number(prop + (i * 4) + 0, 2);
+		size = of_read_number(prop + (i * 4) + 2, 2);
+
+		if (size)
+			memblock_reserve(base, size);
+	}
+
+	return true;
+}
+
 static void __init early_reserve_mem(void)
 {
 	u64 base, size;
@@ -574,6 +601,14 @@ static void __init early_reserve_mem(void)
 	self_size = initial_boot_params->totalsize;
 	memblock_reserve(self_base, self_size);
 
+	/*
+	 * Try looking for reserved-regions property in the DT first; if
+	 * it's present, it'll contain all of the necessary reservation
+	 * info
+	 */
+	if (early_reserve_mem_dt())
+		return;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* then reserve the initrd, if any */
 	if (initrd_start && (initrd_end > initrd_start))
