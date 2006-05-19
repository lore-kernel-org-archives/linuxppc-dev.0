Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BC2346841C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 17:11:37 +1000 (EST)
Date: Fri, 19 May 2006 17:04:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 12/14] powerpc: make iSeries flattened device tree dynamic
Message-Id: <20060519170448.235a4aea.sfr@canb.auug.org.au>
In-Reply-To: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
References: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

First we capture all the strings from dt.c statically by noting that gcc
puts them in a special section of their own.  Idea from Michael Ellerman.

Then we move the flattened device tree to klimit.

Still to come, making the values blob grow as needed.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/vmlinux.lds.S       |    5 ++
 arch/powerpc/platforms/iseries/Makefile |    5 +-
 arch/powerpc/platforms/iseries/dt.c     |   96 ++++++++++++++++++-------------
 3 files changed, 66 insertions(+), 40 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

0f75701d8ac409a5e5c9e1de1d414129a435b267
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index fe79c25..8b25953 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -93,6 +93,11 @@ #endif /* CONFIG_PPC32 */
 		__ptov_table_begin = .;
 		*(.ptov_fixup);
 		__ptov_table_end = .;
+#ifdef CONFIG_PPC_ISERIES
+		__dt_strings_start = .;
+		*(.dt_strings);
+		__dt_strings_end = .;
+#endif
 	}
 
 	. = ALIGN(16);
diff --git a/arch/powerpc/platforms/iseries/Makefile b/arch/powerpc/platforms/iseries/Makefile
index 3230621..dee4eb4 100644
--- a/arch/powerpc/platforms/iseries/Makefile
+++ b/arch/powerpc/platforms/iseries/Makefile
@@ -1,8 +1,11 @@
 EXTRA_CFLAGS	+= -mno-minimal-toc
 
-obj-y += hvlog.o hvlpconfig.o lpardata.o setup.o dt.o mf.o lpevents.o \
+obj-y += hvlog.o hvlpconfig.o lpardata.o setup.o dt_mod.o mf.o lpevents.o \
 	hvcall.o proc.o htab.o iommu.o misc.o irq.o
 obj-$(CONFIG_PCI) += pci.o vpdinfo.o
 obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_VIOPATH) += viopath.o
 obj-$(CONFIG_MODULES) += ksyms.o
+
+$(obj)/dt_mod.o:	$(obj)/dt.o
+	@$(OBJCOPY) --rename-section .rodata.str1.8=.dt_strings $(obj)/dt.o $(obj)/dt_mod.o
diff --git a/arch/powerpc/platforms/iseries/dt.c b/arch/powerpc/platforms/iseries/dt.c
index 93d4233..0371329 100644
--- a/arch/powerpc/platforms/iseries/dt.c
+++ b/arch/powerpc/platforms/iseries/dt.c
@@ -30,6 +30,7 @@ #include <asm/lppaca.h>
 #include <asm/page.h>
 #include <asm/cputable.h>
 #include <asm/abs_addr.h>
+#include <asm/system.h>
 #include <asm/iseries/hv_types.h>
 #include <asm/iseries/hv_lp_config.h>
 #include <asm/iseries/hv_call_xm.h>
@@ -47,6 +48,9 @@ #else
 #define DBG(fmt...)
 #endif
 
+extern char __dt_strings_start[];
+extern char __dt_strings_end[];
+
 struct blob {
 	unsigned char data[PAGE_SIZE * 2];
 	unsigned long next;
@@ -55,26 +59,34 @@ struct blob {
 struct iseries_flat_dt {
 	struct boot_param_header header;
 	u64 reserve_map[2];
-	struct blob dt;
-	struct blob strings;
+	struct blob *dt;
 };
 
-static struct iseries_flat_dt iseries_dt;
+static struct iseries_flat_dt *iseries_dt;
 
-static void __init dt_init(struct iseries_flat_dt *dt)
+static struct iseries_flat_dt * __init dt_init(void)
 {
+	struct iseries_flat_dt *dt;
+	unsigned long str_len;
+
+	str_len = __dt_strings_end - __dt_strings_start;
+	dt = (struct iseries_flat_dt *)ALIGN(klimit, 8);
 	dt->header.off_mem_rsvmap =
 		offsetof(struct iseries_flat_dt, reserve_map);
-	dt->header.off_dt_struct = offsetof(struct iseries_flat_dt, dt);
-	dt->header.off_dt_strings = offsetof(struct iseries_flat_dt, strings);
-	dt->header.totalsize = sizeof(struct iseries_flat_dt);
-	dt->header.dt_strings_size = sizeof(struct blob);
+	dt->header.off_dt_strings = ALIGN(sizeof(*dt), 8);
+	dt->header.off_dt_struct = dt->header.off_dt_strings
+		+ ALIGN(str_len, 8);
+	dt->dt = (struct blob *)((unsigned long)dt + dt->header.off_dt_struct);
+	klimit = ALIGN((unsigned long)(dt->dt) + sizeof(struct blob), 8);
+	dt->header.totalsize = klimit - (unsigned long)dt;
+	dt->header.dt_strings_size = str_len;
 
 	/* There is no notion of hardware cpu id on iSeries */
 	dt->header.boot_cpuid_phys = smp_processor_id();
 
-	dt->dt.next = (unsigned long)&dt->dt.data;
-	dt->strings.next = (unsigned long)&dt->strings.data;
+	dt->dt->next = (unsigned long)&dt->dt->data;
+	memcpy((char *)dt + dt->header.off_dt_strings, __dt_strings_start,
+			str_len);
 
 	dt->header.magic = OF_DT_HEADER;
 	dt->header.version = 0x10;
@@ -82,6 +94,8 @@ static void __init dt_init(struct iserie
 
 	dt->reserve_map[0] = 0;
 	dt->reserve_map[1] = 0;
+
+	return dt;
 }
 
 static void __init dt_check_blob(struct blob *b)
@@ -94,19 +108,19 @@ static void __init dt_check_blob(struct 
 
 static void __init dt_push_u32(struct iseries_flat_dt *dt, u32 value)
 {
-	*((u32*)dt->dt.next) = value;
-	dt->dt.next += sizeof(u32);
+	*((u32*)dt->dt->next) = value;
+	dt->dt->next += sizeof(u32);
 
-	dt_check_blob(&dt->dt);
+	dt_check_blob(dt->dt);
 }
 
 #ifdef notyet
 static void __init dt_push_u64(struct iseries_flat_dt *dt, u64 value)
 {
-	*((u64*)dt->dt.next) = value;
-	dt->dt.next += sizeof(u64);
+	*((u64*)dt->dt->next) = value;
+	dt->dt->next += sizeof(u64);
 
-	dt_check_blob(&dt->dt);
+	dt_check_blob(dt->dt);
 }
 #endif
 
@@ -125,7 +139,7 @@ static unsigned long __init dt_push_byte
 static void __init dt_start_node(struct iseries_flat_dt *dt, char *name)
 {
 	dt_push_u32(dt, OF_DT_BEGIN_NODE);
-	dt_push_bytes(&dt->dt, name, strlen(name) + 1);
+	dt_push_bytes(dt->dt, name, strlen(name) + 1);
 }
 
 #define dt_end_node(dt) dt_push_u32(dt, OF_DT_END_NODE)
@@ -140,14 +154,13 @@ static void __init dt_prop(struct iserie
 	/* Length of the data */
 	dt_push_u32(dt, len);
 
-	/* Put the property name in the string blob. */
-	offset = dt_push_bytes(&dt->strings, name, strlen(name) + 1);
+	offset = name - __dt_strings_start;
 
 	/* The offset of the properties name in the string blob. */
 	dt_push_u32(dt, (u32)offset);
 
 	/* The actual data. */
-	dt_push_bytes(&dt->dt, data, len);
+	dt_push_bytes(dt->dt, data, len);
 }
 
 static void __init dt_prop_str(struct iseries_flat_dt *dt, char *name,
@@ -579,40 +592,45 @@ static void __init dt_pci_devices(struct
 	}
 }
 
+static void dt_finish(struct iseries_flat_dt *dt)
+{
+	dt_push_u32(dt, OF_DT_END);
+}
+
 void * __init build_flat_dt(unsigned long phys_mem_size)
 {
 	u64 tmp[2];
 
-	dt_init(&iseries_dt);
+	iseries_dt = dt_init();
 
-	dt_start_node(&iseries_dt, "");
+	dt_start_node(iseries_dt, "");
 
-	dt_prop_u32(&iseries_dt, "#address-cells", 2);
-	dt_prop_u32(&iseries_dt, "#size-cells", 2);
-	dt_model(&iseries_dt);
+	dt_prop_u32(iseries_dt, "#address-cells", 2);
+	dt_prop_u32(iseries_dt, "#size-cells", 2);
+	dt_model(iseries_dt);
 
 	/* /memory */
-	dt_start_node(&iseries_dt, "memory@0");
-	dt_prop_str(&iseries_dt, "name", "memory");
-	dt_prop_str(&iseries_dt, "device_type", "memory");
+	dt_start_node(iseries_dt, "memory@0");
+	dt_prop_str(iseries_dt, "name", "memory");
+	dt_prop_str(iseries_dt, "device_type", "memory");
 	tmp[0] = 0;
 	tmp[1] = phys_mem_size;
-	dt_prop_u64_list(&iseries_dt, "reg", tmp, 2);
-	dt_end_node(&iseries_dt);
+	dt_prop_u64_list(iseries_dt, "reg", tmp, 2);
+	dt_end_node(iseries_dt);
 
 	/* /chosen */
-	dt_start_node(&iseries_dt, "chosen");
-	dt_prop_str(&iseries_dt, "bootargs", cmd_line);
-	dt_end_node(&iseries_dt);
+	dt_start_node(iseries_dt, "chosen");
+	dt_prop_str(iseries_dt, "bootargs", cmd_line);
+	dt_end_node(iseries_dt);
 
-	dt_cpus(&iseries_dt);
+	dt_cpus(iseries_dt);
 
-	dt_vdevices(&iseries_dt);
-	dt_pci_devices(&iseries_dt);
+	dt_vdevices(iseries_dt);
+	dt_pci_devices(iseries_dt);
 
-	dt_end_node(&iseries_dt);
+	dt_end_node(iseries_dt);
 
-	dt_push_u32(&iseries_dt, OF_DT_END);
+	dt_finish(iseries_dt);
 
-	return &iseries_dt;
+	return iseries_dt;
 }
-- 
1.3.1.ge923
