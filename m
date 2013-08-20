Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 9EB9A2C016E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 19:30:25 +1000 (EST)
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 17/19] cpufreq: maple-cpufreq: remove device tree parsing
 for cpu nodes
Date: Tue, 20 Aug 2013 10:30:19 +0100
Message-Id: <1376991021-12160-18-git-send-email-Sudeep.KarkadaNagesha@arm.com>
In-Reply-To: <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
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

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/maple-cpufreq.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufre=
q.c
index cdd6291..f071dc4 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -24,7 +24,7 @@
 #include <linux/completion.h>
 #include <linux/mutex.h>
 #include <linux/time.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
=20
 #define DBG(fmt...) pr_debug(fmt)
=20
@@ -201,7 +201,6 @@ static struct cpufreq_driver maple_cpufreq_driver =3D {
=20
 static int __init maple_cpufreq_init(void)
 {
-=09struct device_node *cpus;
 =09struct device_node *cpunode;
 =09unsigned int psize;
 =09unsigned long max_freq;
@@ -217,24 +216,11 @@ static int __init maple_cpufreq_init(void)
 =09    !of_machine_is_compatible("Momentum,Apache"))
 =09=09return 0;
=20
-=09cpus =3D of_find_node_by_path("/cpus");
-=09if (cpus =3D=3D NULL) {
-=09=09DBG("No /cpus node !\n");
-=09=09return -ENODEV;
-=09}
-
 =09/* Get first CPU node */
-=09for (cpunode =3D NULL;
-=09     (cpunode =3D of_get_next_child(cpus, cpunode)) !=3D NULL;) {
-=09=09const u32 *reg =3D of_get_property(cpunode, "reg", NULL);
-=09=09if (reg =3D=3D NULL || (*reg) !=3D 0)
-=09=09=09continue;
-=09=09if (!strcmp(cpunode->type, "cpu"))
-=09=09=09break;
-=09}
+=09cpunode =3D of_cpu_device_node_get(0);
 =09if (cpunode =3D=3D NULL) {
 =09=09printk(KERN_ERR "cpufreq: Can't find any CPU 0 node\n");
-=09=09goto bail_cpus;
+=09=09goto bail_noprops;
 =09}
=20
 =09/* Check 970FX for now */
@@ -290,14 +276,11 @@ static int __init maple_cpufreq_init(void)
 =09rc =3D cpufreq_register_driver(&maple_cpufreq_driver);
=20
 =09of_node_put(cpunode);
-=09of_node_put(cpus);
=20
 =09return rc;
=20
 bail_noprops:
 =09of_node_put(cpunode);
-bail_cpus:
-=09of_node_put(cpus);
=20
 =09return rc;
 }
--=20
1.8.1.2
