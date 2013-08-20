Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 2A5A12C0108
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 19:30:12 +1000 (EST)
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 03/19] powerpc: refactor of_get_cpu_node to support other
 architectures
Date: Tue, 20 Aug 2013 10:30:05 +0100
Message-Id: <1376991021-12160-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
In-Reply-To: <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Currently different drivers requiring to access cpu device node are
parsing the device tree themselves. Since the ordering in the DT need
not match the logical cpu ordering, the parsing logic needs to consider
that. However, this has resulted in lots of code duplication and in some
cases even incorrect logic.

It's better to consolidate them by adding support for getting cpu
device node for a given logical cpu index in DT core library. However
logical to physical index mapping can be architecture specific.

PowerPC has it's own implementation to get the cpu node for a given
logical index.

This patch refactors the current implementation of of_get_cpu_node.
This in preparation to move the implementation to DT core library.
It separates out the logical to physical mapping so that a default
matching of the physical id to the logical cpu index can be added
when moved to common code. Architecture specific code can override it.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/powerpc/kernel/prom.c | 76 ++++++++++++++++++++++++++++--------------=
----
 1 file changed, 47 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index eb23ac9..f7b8c0b 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -865,45 +865,63 @@ static int __init prom_reconfig_setup(void)
 __initcall(prom_reconfig_setup);
 #endif
=20
+bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+=09return (int)phys_id =3D=3D get_hard_smp_processor_id(cpu);
+}
+
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
+=09=09cell +=3D ac;
+=09}
+=09return false;
+}
+
 /* Find the device node for a given logical cpu number, also returns the c=
pu
  * local thread number (index in ibm,interrupt-server#s) if relevant and
  * asked for (non NULL)
  */
 struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
 {
-=09int hardid;
-=09struct device_node *np;
+=09struct device_node *cpun, *cpus;
=20
-=09hardid =3D get_hard_smp_processor_id(cpu);
+=09cpus =3D of_find_node_by_path("/cpus");
+=09if (!cpus) {
+=09=09pr_warn("Missing cpus node, bailing out\n");
+=09=09return NULL;
+=09}
=20
-=09for_each_node_by_type(np, "cpu") {
-=09=09const u32 *intserv;
-=09=09unsigned int plen, t;
+=09for_each_child_of_node(cpus, cpun) {
+=09=09if (of_node_cmp(cpun->type, "cpu"))
+=09=09=09continue;
=20
-=09=09/* Check for ibm,ppc-interrupt-server#s. If it doesn't exist
-=09=09 * fallback to "reg" property and assume no threads
+=09=09/* Check for non-standard "ibm,ppc-interrupt-server#s" property
+=09=09 * for thread ids on PowerPC. If it doesn't exist fallback to
+=09=09 * standard "reg" property.
 =09=09 */
-=09=09intserv =3D of_get_property(np, "ibm,ppc-interrupt-server#s",
-=09=09=09=09&plen);
-=09=09if (intserv =3D=3D NULL) {
-=09=09=09const u32 *reg =3D of_get_property(np, "reg", NULL);
-=09=09=09if (reg =3D=3D NULL)
-=09=09=09=09continue;
-=09=09=09if (*reg =3D=3D hardid) {
-=09=09=09=09if (thread)
-=09=09=09=09=09*thread =3D 0;
-=09=09=09=09return np;
-=09=09=09}
-=09=09} else {
-=09=09=09plen /=3D sizeof(u32);
-=09=09=09for (t =3D 0; t < plen; t++) {
-=09=09=09=09if (hardid =3D=3D intserv[t]) {
-=09=09=09=09=09if (thread)
-=09=09=09=09=09=09*thread =3D t;
-=09=09=09=09=09return np;
-=09=09=09=09}
-=09=09=09}
-=09=09}
+=09=09if (__of_find_n_match_cpu_property(cpun,
+=09=09=09=09"ibm,ppc-interrupt-server#s", cpu, thread))
+=09=09=09return cpun;
+
+=09=09if (__of_find_n_match_cpu_property(cpun, "reg", cpu, thread))
+=09=09=09return cpun;
 =09}
 =09return NULL;
 }
--=20
1.8.1.2
