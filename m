Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 64CA12C010B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 19:30:27 +1000 (EST)
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 16/19] cpufreq: arm_big_little: remove device tree parsing
 for cpu nodes
Date: Tue, 20 Aug 2013 10:30:18 +0100
Message-Id: <1376991021-12160-17-git-send-email-Sudeep.KarkadaNagesha@arm.com>
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

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/arm_big_little_dt.c | 40 +++++++++++++--------------------=
----
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_=
little_dt.c
index fd9e3ea..480c0bd 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -19,12 +19,11 @@
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
-#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/opp.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -34,27 +33,13 @@
 /* get cpu node with valid operating-points */
 static struct device_node *get_cpu_node_with_valid_op(int cpu)
 {
-=09struct device_node *np =3D NULL, *parent;
-=09int count =3D 0;
+=09struct device_node *np =3D of_cpu_device_node_get(cpu);
=20
-=09parent =3D of_find_node_by_path("/cpus");
-=09if (!parent) {
-=09=09pr_err("failed to find OF /cpus\n");
-=09=09return NULL;
+=09if (!of_get_property(np, "operating-points", NULL)) {
+=09=09of_node_put(np);
+=09=09np =3D NULL;
 =09}
=20
-=09for_each_child_of_node(parent, np) {
-=09=09if (count++ !=3D cpu)
-=09=09=09continue;
-=09=09if (!of_get_property(np, "operating-points", NULL)) {
-=09=09=09of_node_put(np);
-=09=09=09np =3D NULL;
-=09=09}
-
-=09=09break;
-=09}
-
-=09of_node_put(parent);
 =09return np;
 }
=20
@@ -63,11 +48,12 @@ static int dt_init_opp_table(struct device *cpu_dev)
 =09struct device_node *np;
 =09int ret;
=20
-=09np =3D get_cpu_node_with_valid_op(cpu_dev->id);
-=09if (!np)
-=09=09return -ENODATA;
+=09np =3D of_node_get(cpu_dev->of_node);
+=09if (!np) {
+=09=09pr_err("failed to find cpu%d node\n", cpu_dev->id);
+=09=09return -ENOENT;
+=09}
=20
-=09cpu_dev->of_node =3D np;
 =09ret =3D of_init_opp_table(cpu_dev);
 =09of_node_put(np);
=20
@@ -79,9 +65,11 @@ static int dt_get_transition_latency(struct device *cpu_=
dev)
 =09struct device_node *np;
 =09u32 transition_latency =3D CPUFREQ_ETERNAL;
=20
-=09np =3D get_cpu_node_with_valid_op(cpu_dev->id);
-=09if (!np)
+=09np =3D of_node_get(cpu_dev->of_node);
+=09if (!np) {
+=09=09pr_info("Failed to find cpu node. Use CPUFREQ_ETERNAL transition lat=
ency\n");
 =09=09return CPUFREQ_ETERNAL;
+=09}
=20
 =09of_property_read_u32(np, "clock-latency", &transition_latency);
 =09of_node_put(np);
--=20
1.8.1.2
