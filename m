Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D7B63682F3
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 17:11:26 +1000 (EST)
Date: Fri, 19 May 2006 17:04:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 13/14] powerpc: make iSeries flattened device tree dynamic -
	part 2
Message-Id: <20060519170412.5cbd8dc6.sfr@canb.auug.org.au>
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

This actually simplies things as we just figure out how much space we
used at the end and adjust klimit then.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/dt.c |   62 +++++++++++------------------------
 1 files changed, 19 insertions(+), 43 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

0496bb52c33374b4f014df39c0e8a1b53325e93b
diff --git a/arch/powerpc/platforms/iseries/dt.c b/arch/powerpc/platforms/iseries/dt.c
index 0371329..2a51ec1 100644
--- a/arch/powerpc/platforms/iseries/dt.c
+++ b/arch/powerpc/platforms/iseries/dt.c
@@ -27,7 +27,6 @@ #include <linux/if_ether.h>	/* ETH_ALEN 
 #include <asm/machdep.h>
 #include <asm/prom.h>
 #include <asm/lppaca.h>
-#include <asm/page.h>
 #include <asm/cputable.h>
 #include <asm/abs_addr.h>
 #include <asm/system.h>
@@ -51,15 +50,10 @@ #endif
 extern char __dt_strings_start[];
 extern char __dt_strings_end[];
 
-struct blob {
-	unsigned char data[PAGE_SIZE * 2];
-	unsigned long next;
-};
-
 struct iseries_flat_dt {
 	struct boot_param_header header;
 	u64 reserve_map[2];
-	struct blob *dt;
+	void *data;
 };
 
 static struct iseries_flat_dt *iseries_dt;
@@ -76,15 +70,12 @@ static struct iseries_flat_dt * __init d
 	dt->header.off_dt_strings = ALIGN(sizeof(*dt), 8);
 	dt->header.off_dt_struct = dt->header.off_dt_strings
 		+ ALIGN(str_len, 8);
-	dt->dt = (struct blob *)((unsigned long)dt + dt->header.off_dt_struct);
-	klimit = ALIGN((unsigned long)(dt->dt) + sizeof(struct blob), 8);
-	dt->header.totalsize = klimit - (unsigned long)dt;
+	dt->data = (void *)((unsigned long)dt + dt->header.off_dt_struct);
 	dt->header.dt_strings_size = str_len;
 
 	/* There is no notion of hardware cpu id on iSeries */
 	dt->header.boot_cpuid_phys = smp_processor_id();
 
-	dt->dt->next = (unsigned long)&dt->dt->data;
 	memcpy((char *)dt + dt->header.off_dt_strings, __dt_strings_start,
 			str_len);
 
@@ -98,54 +89,37 @@ static struct iseries_flat_dt * __init d
 	return dt;
 }
 
-static void __init dt_check_blob(struct blob *b)
-{
-	if (b->next >= (unsigned long)&b->next) {
-		DBG("Ran out of space in flat device tree blob!\n");
-		BUG();
-	}
-}
-
 static void __init dt_push_u32(struct iseries_flat_dt *dt, u32 value)
 {
-	*((u32*)dt->dt->next) = value;
-	dt->dt->next += sizeof(u32);
-
-	dt_check_blob(dt->dt);
+	*((u32 *)dt->data) = value;
+	dt->data += sizeof(u32);
 }
 
 #ifdef notyet
 static void __init dt_push_u64(struct iseries_flat_dt *dt, u64 value)
 {
-	*((u64*)dt->dt->next) = value;
-	dt->dt->next += sizeof(u64);
-
-	dt_check_blob(dt->dt);
+	*((u64 *)dt->data) = value;
+	dt->data += sizeof(u64);
 }
 #endif
 
-static unsigned long __init dt_push_bytes(struct blob *blob, char *data, int len)
+static void __init dt_push_bytes(struct iseries_flat_dt *dt, char *data,
+		int len)
 {
-	unsigned long start = blob->next - (unsigned long)blob->data;
-
-	memcpy((char *)blob->next, data, len);
-	blob->next = _ALIGN(blob->next + len, 4);
-
-	dt_check_blob(blob);
-
-	return start;
+	memcpy(dt->data, data, len);
+	dt->data += ALIGN(len, 4);
 }
 
 static void __init dt_start_node(struct iseries_flat_dt *dt, char *name)
 {
 	dt_push_u32(dt, OF_DT_BEGIN_NODE);
-	dt_push_bytes(dt->dt, name, strlen(name) + 1);
+	dt_push_bytes(dt, name, strlen(name) + 1);
 }
 
 #define dt_end_node(dt) dt_push_u32(dt, OF_DT_END_NODE)
 
 static void __init dt_prop(struct iseries_flat_dt *dt, char *name,
-		char *data, int len)
+		void *data, int len)
 {
 	unsigned long offset;
 
@@ -160,7 +134,7 @@ static void __init dt_prop(struct iserie
 	dt_push_u32(dt, (u32)offset);
 
 	/* The actual data. */
-	dt_push_bytes(dt->dt, data, len);
+	dt_push_bytes(dt, data, len);
 }
 
 static void __init dt_prop_str(struct iseries_flat_dt *dt, char *name,
@@ -171,24 +145,24 @@ static void __init dt_prop_str(struct is
 
 static void __init dt_prop_u32(struct iseries_flat_dt *dt, char *name, u32 data)
 {
-	dt_prop(dt, name, (char *)&data, sizeof(u32));
+	dt_prop(dt, name, &data, sizeof(u32));
 }
 
 static void __init dt_prop_u64(struct iseries_flat_dt *dt, char *name, u64 data)
 {
-	dt_prop(dt, name, (char *)&data, sizeof(u64));
+	dt_prop(dt, name, &data, sizeof(u64));
 }
 
 static void __init dt_prop_u64_list(struct iseries_flat_dt *dt, char *name,
 		u64 *data, int n)
 {
-	dt_prop(dt, name, (char *)data, sizeof(u64) * n);
+	dt_prop(dt, name, data, sizeof(u64) * n);
 }
 
 static void __init dt_prop_u32_list(struct iseries_flat_dt *dt, char *name,
 		u32 *data, int n)
 {
-	dt_prop(dt, name, (char *)data, sizeof(u32) * n);
+	dt_prop(dt, name, data, sizeof(u32) * n);
 }
 
 #ifdef notyet
@@ -595,6 +569,8 @@ static void __init dt_pci_devices(struct
 static void dt_finish(struct iseries_flat_dt *dt)
 {
 	dt_push_u32(dt, OF_DT_END);
+	dt->header.totalsize = (unsigned long)dt->data - (unsigned long)dt;
+	klimit = ALIGN((unsigned long)dt->data, 8);
 }
 
 void * __init build_flat_dt(unsigned long phys_mem_size)
-- 
1.3.1.ge923
