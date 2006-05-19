Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 803C367DBC
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 17:10:33 +1000 (EST)
Date: Fri, 19 May 2006 16:55:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 09/14] powerpc: make iSeries flat device tree stuff static
Message-Id: <20060519165553.147f39aa.sfr@canb.auug.org.au>
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


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/setup.c |   40 ++++++++++++++++++--------------
 1 files changed, 22 insertions(+), 18 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

ef5523ad5d01ff256b792ef5a44719c4a56771d9
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 0f49412..9586414 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -723,9 +723,9 @@ struct iseries_flat_dt {
 	struct blob strings;
 };
 
-struct iseries_flat_dt iseries_dt;
+static struct iseries_flat_dt iseries_dt;
 
-void dt_init(struct iseries_flat_dt *dt)
+static void dt_init(struct iseries_flat_dt *dt)
 {
 	dt->header.off_mem_rsvmap =
 		offsetof(struct iseries_flat_dt, reserve_map);
@@ -748,7 +748,7 @@ void dt_init(struct iseries_flat_dt *dt)
 	dt->reserve_map[1] = 0;
 }
 
-void dt_check_blob(struct blob *b)
+static void dt_check_blob(struct blob *b)
 {
 	if (b->next >= (unsigned long)&b->next) {
 		DBG("Ran out of space in flat device tree blob!\n");
@@ -756,7 +756,7 @@ void dt_check_blob(struct blob *b)
 	}
 }
 
-void dt_push_u32(struct iseries_flat_dt *dt, u32 value)
+static void dt_push_u32(struct iseries_flat_dt *dt, u32 value)
 {
 	*((u32*)dt->dt.next) = value;
 	dt->dt.next += sizeof(u32);
@@ -764,15 +764,17 @@ void dt_push_u32(struct iseries_flat_dt 
 	dt_check_blob(&dt->dt);
 }
 
-void dt_push_u64(struct iseries_flat_dt *dt, u64 value)
+#ifdef notyet
+static void dt_push_u64(struct iseries_flat_dt *dt, u64 value)
 {
 	*((u64*)dt->dt.next) = value;
 	dt->dt.next += sizeof(u64);
 
 	dt_check_blob(&dt->dt);
 }
+#endif
 
-unsigned long dt_push_bytes(struct blob *blob, char *data, int len)
+static unsigned long dt_push_bytes(struct blob *blob, char *data, int len)
 {
 	unsigned long start = blob->next - (unsigned long)blob->data;
 
@@ -784,7 +786,7 @@ unsigned long dt_push_bytes(struct blob 
 	return start;
 }
 
-void dt_start_node(struct iseries_flat_dt *dt, char *name)
+static void dt_start_node(struct iseries_flat_dt *dt, char *name)
 {
 	dt_push_u32(dt, OF_DT_BEGIN_NODE);
 	dt_push_bytes(&dt->dt, name, strlen(name) + 1);
@@ -792,7 +794,7 @@ void dt_start_node(struct iseries_flat_d
 
 #define dt_end_node(dt) dt_push_u32(dt, OF_DT_END_NODE)
 
-void dt_prop(struct iseries_flat_dt *dt, char *name, char *data, int len)
+static void dt_prop(struct iseries_flat_dt *dt, char *name, char *data, int len)
 {
 	unsigned long offset;
 
@@ -811,37 +813,39 @@ void dt_prop(struct iseries_flat_dt *dt,
 	dt_push_bytes(&dt->dt, data, len);
 }
 
-void dt_prop_str(struct iseries_flat_dt *dt, char *name, char *data)
+static void dt_prop_str(struct iseries_flat_dt *dt, char *name, char *data)
 {
 	dt_prop(dt, name, data, strlen(data) + 1); /* + 1 for NULL */
 }
 
-void dt_prop_u32(struct iseries_flat_dt *dt, char *name, u32 data)
+static void dt_prop_u32(struct iseries_flat_dt *dt, char *name, u32 data)
 {
 	dt_prop(dt, name, (char *)&data, sizeof(u32));
 }
 
-void dt_prop_u64(struct iseries_flat_dt *dt, char *name, u64 data)
+static void dt_prop_u64(struct iseries_flat_dt *dt, char *name, u64 data)
 {
 	dt_prop(dt, name, (char *)&data, sizeof(u64));
 }
 
-void dt_prop_u64_list(struct iseries_flat_dt *dt, char *name, u64 *data, int n)
+static void dt_prop_u64_list(struct iseries_flat_dt *dt, char *name, u64 *data, int n)
 {
 	dt_prop(dt, name, (char *)data, sizeof(u64) * n);
 }
 
-void dt_prop_u32_list(struct iseries_flat_dt *dt, char *name, u32 *data, int n)
+static void dt_prop_u32_list(struct iseries_flat_dt *dt, char *name, u32 *data, int n)
 {
 	dt_prop(dt, name, (char *)data, sizeof(u32) * n);
 }
 
-void dt_prop_empty(struct iseries_flat_dt *dt, char *name)
+#ifdef notyet
+static void dt_prop_empty(struct iseries_flat_dt *dt, char *name)
 {
 	dt_prop(dt, name, NULL, 0);
 }
+#endif
 
-void dt_cpus(struct iseries_flat_dt *dt)
+static void dt_cpus(struct iseries_flat_dt *dt)
 {
 	unsigned char buf[32];
 	unsigned char *p;
@@ -895,7 +899,7 @@ void dt_cpus(struct iseries_flat_dt *dt)
 	dt_end_node(dt);
 }
 
-void dt_model(struct iseries_flat_dt *dt)
+static void dt_model(struct iseries_flat_dt *dt)
 {
 	char buf[16] = "IBM,";
 
@@ -913,7 +917,7 @@ void dt_model(struct iseries_flat_dt *dt
 	dt_prop_str(dt, "compatible", "IBM,iSeries");
 }
 
-void dt_vdevices(struct iseries_flat_dt *dt)
+static void dt_vdevices(struct iseries_flat_dt *dt)
 {
 	u32 reg = 0;
 	HvLpIndexMap vlan_map;
@@ -1203,7 +1207,7 @@ static void dt_pci_devices(struct iserie
 	}
 }
 
-void build_flat_dt(struct iseries_flat_dt *dt, unsigned long phys_mem_size)
+static void build_flat_dt(struct iseries_flat_dt *dt, unsigned long phys_mem_size)
 {
 	u64 tmp[2];
 
-- 
1.3.1.ge923
