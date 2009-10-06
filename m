Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E928EB7BAC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 17:28:51 +1100 (EST)
Received: from canb.auug.org.au (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtps.tip.net.au (Postfix) with ESMTPSA id D983A14401C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 17:28:50 +1100 (EST)
Date: Tue, 6 Oct 2009 17:28:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/iseries: remove compiler version dependent hack
Message-Id: <20091006172847.440e8798.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The creation of the flattened device tree depended on the compiler
putting the constant strings for an object in a section with a
particular name.  This was changed with recent compilers.  Do this
explicitly instead.

Without this patch, iseries kernels may silently not boot when built with
some compilers.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/Makefile |   11 +-----
 arch/powerpc/platforms/iseries/dt.c     |   56 +++++++++++++-----------------
 2 files changed, 25 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/Makefile b/arch/powerpc/platforms/iseries/Makefile
index cc7161f..ce01492 100644
--- a/arch/powerpc/platforms/iseries/Makefile
+++ b/arch/powerpc/platforms/iseries/Makefile
@@ -1,18 +1,9 @@
 EXTRA_CFLAGS	+= -mno-minimal-toc
 
-extra-y += dt.o
-
 obj-y += exception.o
-obj-y += hvlog.o hvlpconfig.o lpardata.o setup.o dt_mod.o mf.o lpevents.o \
+obj-y += hvlog.o hvlpconfig.o lpardata.o setup.o dt.o mf.o lpevents.o \
 	hvcall.o proc.o htab.o iommu.o misc.o irq.o
 obj-$(CONFIG_PCI) += pci.o
 obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_VIOPATH) += viopath.o vio.o
 obj-$(CONFIG_MODULES) += ksyms.o
-
-quiet_cmd_dt_strings = DT_STR  $@
-      cmd_dt_strings = $(OBJCOPY) --rename-section .rodata.str1.8=.dt_strings \
-				$< $@
-
-$(obj)/dt_mod.o:	$(obj)/dt.o
-	$(call if_changed,dt_strings)
diff --git a/arch/powerpc/platforms/iseries/dt.c b/arch/powerpc/platforms/iseries/dt.c
index c5a87a7..7f45a51 100644
--- a/arch/powerpc/platforms/iseries/dt.c
+++ b/arch/powerpc/platforms/iseries/dt.c
@@ -51,11 +51,16 @@
 
 /*
  * These are created by the linker script at the start and end
- * of the section containing all the strings from this file.
+ * of the section containing all the strings marked with the DS macro.
  */
 extern char __dt_strings_start[];
 extern char __dt_strings_end[];
 
+#define DS(s)	({	\
+	static const char __s[] __attribute__((section(".dt_strings"))) = s; \
+	__s;		\
+})
+
 struct iseries_flat_dt {
 	struct boot_param_header header;
 	u64 reserve_map[2];
@@ -64,9 +69,8 @@ struct iseries_flat_dt {
 static void * __initdata dt_data;
 
 /*
- * Putting these strings here keeps them out of the section
- * that we rename to .dt_strings using objcopy and capture
- * for the strings blob of the flattened device tree.
+ * Putting these strings here keeps them out of the .dt_strings section
+ * that we capture for the strings blob of the flattened device tree.
  */
 static char __initdata device_type_cpu[] = "cpu";
 static char __initdata device_type_memory[] = "memory";
@@ -173,7 +177,7 @@ static void __init dt_start_node(struct iseries_flat_dt *dt, const char *name)
 
 #define dt_end_node(dt) dt_push_u32(dt, OF_DT_END_NODE)
 
-static void __init dt_prop(struct iseries_flat_dt *dt, const char *name,
+static void __init __dt_prop(struct iseries_flat_dt *dt, const char *name,
 		const void *data, int len)
 {
 	unsigned long offset;
@@ -191,44 +195,32 @@ static void __init dt_prop(struct iseries_flat_dt *dt, const char *name,
 	/* The actual data. */
 	dt_push_bytes(dt, data, len);
 }
+#define dt_prop(dt, name, data, len)	__dt_prop((dt), DS(name), (data), (len))
 
-static void __init dt_prop_str(struct iseries_flat_dt *dt, const char *name,
-		const char *data)
-{
-	dt_prop(dt, name, data, strlen(data) + 1); /* + 1 for NULL */
-}
+#define dt_prop_str(dt, name, data)	\
+	dt_prop((dt), name, (data), strlen((data)) + 1); /* + 1 for NULL */
 
-static void __init dt_prop_u32(struct iseries_flat_dt *dt, const char *name,
+static void __init __dt_prop_u32(struct iseries_flat_dt *dt, const char *name,
 		u32 data)
 {
-	dt_prop(dt, name, &data, sizeof(u32));
+	__dt_prop(dt, name, &data, sizeof(u32));
 }
+#define dt_prop_u32(dt, name, data)	__dt_prop_u32((dt), DS(name), (data))
 
-static void __init __maybe_unused dt_prop_u64(struct iseries_flat_dt *dt,
-					      const char *name,
-		u64 data)
+static void __init __maybe_unused __dt_prop_u64(struct iseries_flat_dt *dt,
+		const char *name, u64 data)
 {
-	dt_prop(dt, name, &data, sizeof(u64));
+	__dt_prop(dt, name, &data, sizeof(u64));
 }
+#define dt_prop_u64(dt, name, data)	__dt_prop_u64((dt), DS(name), (data))
 
-static void __init dt_prop_u64_list(struct iseries_flat_dt *dt,
-		const char *name, u64 *data, int n)
-{
-	dt_prop(dt, name, data, sizeof(u64) * n);
-}
+#define dt_prop_u64_list(dt, name, data, n)	\
+	dt_prop((dt), name, (data), sizeof(u64) * (n))
 
-static void __init dt_prop_u32_list(struct iseries_flat_dt *dt,
-		const char *name, u32 *data, int n)
-{
-	dt_prop(dt, name, data, sizeof(u32) * n);
-}
+#define dt_prop_u32_list(dt, name, data, n)	\
+	dt_prop((dt), name, (data), sizeof(u32) * (n))
 
-#ifdef notyet
-static void __init dt_prop_empty(struct iseries_flat_dt *dt, const char *name)
-{
-	dt_prop(dt, name, NULL, 0);
-}
-#endif
+#define dt_prop_empty(dt, name)		dt_prop((dt), name, NULL, 0)
 
 static void __init dt_cpus(struct iseries_flat_dt *dt)
 {
-- 
1.6.4.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
