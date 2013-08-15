Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 25F952C025A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 03:10:05 +1000 (EST)
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 microblaze-uclinux@itee.uq.edu.au, linux@lists.openrisc.net,
 linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 4/4] of: move of_get_cpu_node implementation to DT core
 library
Date: Thu, 15 Aug 2013 18:09:40 +0100
Message-Id: <1376586580-5409-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
In-Reply-To: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>,
 Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>,
 Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
 Grant Likely <grant.likely@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

This patch moves the generalized implementation of of_get_cpu_node from
PowerPC to DT core library, thereby adding support for retrieving cpu
node for a given logical cpu index on any architecture.

The CPU subsystem can now use this function to assign of_node in the
cpu device while registering CPUs.

It is recommended to use these helper function only in pre-SMP/early
initialisation stages to retrieve CPU device node pointers in logical
ordering. Once the cpu devices are registered, it can be retrieved easily
from cpu device of_node which avoids unnecessary parsing and matching.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/powerpc/include/asm/prom.h |  3 --
 arch/powerpc/kernel/prom.c      | 55 ------------------------
 drivers/of/base.c               | 94 +++++++++++++++++++++++++++++++++++++=
++++
 include/linux/cpu.h             |  1 +
 include/linux/of.h              |  7 +++
 5 files changed, 102 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/pro=
m.h
index bc2da15..ac204e0 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -43,9 +43,6 @@ void of_parse_dma_window(struct device_node *dn, const vo=
id *dma_window_prop,
=20
 extern void kdump_move_device_tree(void);
=20
-/* CPU OF node matching */
-struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
-
 /* cache lookup */
 struct device_node *of_find_next_cache_node(struct device_node *np);
=20
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 594c9f9..1c14cd4 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -870,61 +870,6 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 =09return (int)phys_id =3D=3D get_hard_smp_processor_id(cpu);
 }
=20
-static bool __of_find_n_match_cpu_property(struct device_node *cpun,
-=09=09=09const char *prop_name, int cpu, unsigned int *thread)
-{
-=09const __be32 *cell;
-=09int ac, prop_len, tid;
-=09u64 hwid;
-
-=09ac =3D of_n_addr_cells(cpun);
-=09cell =3D of_get_property(cpun, prop_name, &prop_len);
-=09if (!cell)
-=09=09return false;
-=09prop_len /=3D sizeof(*cell);
-=09for (tid =3D 0; tid < prop_len; tid++) {
-=09=09hwid =3D of_read_number(cell, ac);
-=09=09if (arch_match_cpu_phys_id(cpu, hwid)) {
-=09=09=09if (thread)
-=09=09=09=09*thread =3D tid;
-=09=09=09return true;
-=09=09}
-=09}
-=09return false;
-}
-
-/* Find the device node for a given logical cpu number, also returns the c=
pu
- * local thread number (index in ibm,interrupt-server#s) if relevant and
- * asked for (non NULL)
- */
-struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
-{
-=09struct device_node *cpun, *cpus;
-
-=09cpus =3D of_find_node_by_path("/cpus");
-=09if (!cpus) {
-=09=09pr_warn("Missing cpus node, bailing out\n");
-=09=09return NULL;
-=09}
-
-=09for_each_child_of_node(cpus, cpun) {
-=09=09if (of_node_cmp(cpun->type, "cpu"))
-=09=09=09continue;
-
-=09=09/* Check for ibm,ppc-interrupt-server#s. If it doesn't exist
-=09=09 * fallback to "reg" property and assume no threads
-=09=09 */
-=09=09if (__of_find_n_match_cpu_property(cpun,
-=09=09=09=09"ibm,ppc-interrupt-server#s", cpu, thread))
-=09=09=09return cpun;
-
-=09=09if (__of_find_n_match_cpu_property(cpun, "reg", cpu, thread))
-=09=09=09return cpun;
-=09}
-=09return NULL;
-}
-EXPORT_SYMBOL(of_get_cpu_node);
-
 #if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
 static struct debugfs_blob_wrapper flat_dt_blob;
=20
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5c54279..d088e45 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -18,6 +18,7 @@
  *      2 of the License, or (at your option) any later version.
  */
 #include <linux/ctype.h>
+#include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/spinlock.h>
@@ -230,6 +231,99 @@ const void *of_get_property(const struct device_node *=
np, const char *name,
 }
 EXPORT_SYMBOL(of_get_property);
=20
+/*
+ * arch_match_cpu_phys_id - Match the given logical CPU and physical id
+ *
+ * @cpu: logical index of a cpu
+ * @phys_id: physical identifier of a cpu
+ *
+ * CPU logical to physical index mapping is architecture specific.
+ * However this __weak function provides a default match of physical
+ * id to logical cpu index.
+ *
+ * Returns true if the physical identifier and the logical index correspon=
d
+ * to the same cpu, false otherwise.
+ */
+bool __weak arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+=09return (u32)phys_id =3D=3D cpu;
+}
+
+/**
+ * Checks if the given "prop_name" property holds the physical id of the
+ * core/thread corresponding to the logical cpu 'cpu'. If 'thread' is not
+ * NULL, local thread number within the core is returned in it.
+ */
+static bool __of_find_n_match_cpu_property(struct device_node *cpun,
+=09=09=09const char *prop_name, int cpu, unsigned int *thread)
+{
+=09const __be32 *cell;
+=09int ac, prop_len, tid;
+=09u64 hwid;
+
+=09ac =3D of_n_addr_cells(cpun);
+=09cell =3D of_get_property(cpun, prop_name, &prop_len);
+=09if (!cell)
+=09=09return false;
+=09prop_len /=3D sizeof(*cell);
+=09for (tid =3D 0; tid < prop_len; tid++) {
+=09=09hwid =3D of_read_number(cell, ac);
+=09=09if (arch_match_cpu_phys_id(cpu, hwid)) {
+=09=09=09if (thread)
+=09=09=09=09*thread =3D tid;
+=09=09=09return true;
+=09=09}
+=09}
+=09return false;
+}
+
+/**
+ * of_get_cpu_node - Get device node associated with the given logical CPU
+ *
+ * @cpu: CPU number(logical index) for which device node is required
+ * @thread: if not NULL, local thread number within the physical core is
+ *          returned
+ *
+ * The main purpose of this function is to retrieve the device node for th=
e
+ * given logical CPU index. It should be used to initialize the of_node in
+ * cpu device. Once of_node in cpu device is populated, all the further
+ * references can use that instead.
+ *
+ * CPU logical to physical index mapping is architecture specific and is b=
uilt
+ * before booting secondary cores. This function uses arch_match_cpu_phys_=
id
+ * which can be overridden by architecture specific implementation.
+ *
+ * Returns a node pointer for the logical cpu if found, else NULL.
+ */
+struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
+{
+=09struct device_node *cpun, *cpus;
+
+=09cpus =3D of_find_node_by_path("/cpus");
+=09if (!cpus) {
+=09=09pr_warn("Missing cpus node, bailing out\n");
+=09=09return NULL;
+=09}
+
+=09for_each_child_of_node(cpus, cpun) {
+=09=09if (of_node_cmp(cpun->type, "cpu"))
+=09=09=09continue;
+#ifdef CONFIG_PPC
+=09=09/* Check for historical "ibm,ppc-interrupt-server#s" property
+=09=09 * for thread ids on PowerPC. If it doesn't exist fallback to
+=09=09 * standard "reg" property.
+=09=09 */
+=09=09if (__of_find_n_match_cpu_property(cpun,
+=09=09=09=09"ibm,ppc-interrupt-server#s", cpu, thread))
+=09=09=09return cpun;
+#endif
+=09=09if (__of_find_n_match_cpu_property(cpun, "reg", cpu, thread))
+=09=09=09return cpun;
+=09}
+=09return NULL;
+}
+EXPORT_SYMBOL(of_get_cpu_node);
+
 /** Checks if the given "compat" string matches one of the strings in
  * the device's "compatible" property
  */
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index ab0eade..3dfed2b 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -28,6 +28,7 @@ struct cpu {
 extern int register_cpu(struct cpu *cpu, int num);
 extern struct device *get_cpu_device(unsigned cpu);
 extern bool cpu_is_hotpluggable(unsigned cpu);
+extern bool arch_match_cpu_phys_id(int cpu, u64 phys_id);
=20
 extern int cpu_add_dev_attr(struct device_attribute *attr);
 extern void cpu_remove_dev_attr(struct device_attribute *attr);
diff --git a/include/linux/of.h b/include/linux/of.h
index 1fd08ca..c0bb2f1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -266,6 +266,7 @@ extern int of_device_is_available(const struct device_n=
ode *device);
 extern const void *of_get_property(const struct device_node *node,
 =09=09=09=09const char *name,
 =09=09=09=09int *lenp);
+extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
 #define for_each_property_of_node(dn, pp) \
 =09for (pp =3D dn->properties; pp !=3D NULL; pp =3D pp->next)
=20
@@ -459,6 +460,12 @@ static inline const void *of_get_property(const struct=
 device_node *node,
 =09return NULL;
 }
=20
+static inline struct device_node *of_get_cpu_node(int cpu,
+=09=09=09=09=09unsigned int *thread)
+{
+=09return NULL;
+}
+
 static inline int of_property_read_u64(const struct device_node *np,
 =09=09=09=09       const char *propname, u64 *out_value)
 {
--=20
1.8.1.2
