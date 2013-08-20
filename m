Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 13A8F2C0128
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 19:30:25 +1000 (EST)
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 18/19] cpufreq: pmac64-cpufreq: remove device tree parsing
 for cpu nodes
Date: Tue, 20 Aug 2013 10:30:20 +0100
Message-Id: <1376991021-12160-19-git-send-email-Sudeep.KarkadaNagesha@arm.com>
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

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/pmac64-cpufreq.c | 47 ++++++++++--------------------------=
----
 1 file changed, 11 insertions(+), 36 deletions(-)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpuf=
req.c
index 7ba4234..97b719f 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/completion.h>
 #include <linux/mutex.h>
+#include <linux/of_device.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/irq.h>
@@ -383,9 +384,8 @@ static struct cpufreq_driver g5_cpufreq_driver =3D {
=20
 #ifdef CONFIG_PMAC_SMU
=20
-static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
+static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 {
-=09struct device_node *cpunode;
 =09unsigned int psize, ssize;
 =09unsigned long max_freq;
 =09char *freq_method, *volt_method;
@@ -405,20 +405,6 @@ static int __init g5_neo2_cpufreq_init(struct device_n=
ode *cpus)
 =09else
 =09=09return -ENODEV;
=20
-=09/* Get first CPU node */
-=09for (cpunode =3D NULL;
-=09     (cpunode =3D of_get_next_child(cpus, cpunode)) !=3D NULL;) {
-=09=09const u32 *reg =3D of_get_property(cpunode, "reg", NULL);
-=09=09if (reg =3D=3D NULL || (*reg) !=3D 0)
-=09=09=09continue;
-=09=09if (!strcmp(cpunode->type, "cpu"))
-=09=09=09break;
-=09}
-=09if (cpunode =3D=3D NULL) {
-=09=09printk(KERN_ERR "cpufreq: Can't find any CPU 0 node\n");
-=09=09return -ENODEV;
-=09}
-
 =09/* Check 970FX for now */
 =09valp =3D of_get_property(cpunode, "cpu-version", NULL);
 =09if (!valp) {
@@ -537,9 +523,9 @@ static int __init g5_neo2_cpufreq_init(struct device_no=
de *cpus)
 #endif /* CONFIG_PMAC_SMU */
=20
=20
-static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
+static int __init g5_pm72_cpufreq_init(struct device_node *cpunode)
 {
-=09struct device_node *cpuid =3D NULL, *hwclock =3D NULL, *cpunode =3D NUL=
L;
+=09struct device_node *cpuid =3D NULL, *hwclock =3D NULL;
 =09const u8 *eeprom =3D NULL;
 =09const u32 *valp;
 =09u64 max_freq, min_freq, ih, il;
@@ -548,17 +534,6 @@ static int __init g5_pm72_cpufreq_init(struct device_n=
ode *cpus)
 =09DBG("cpufreq: Initializing for PowerMac7,2, PowerMac7,3 and"
 =09    " RackMac3,1...\n");
=20
-=09/* Get first CPU node */
-=09for (cpunode =3D NULL;
-=09     (cpunode =3D of_get_next_child(cpus, cpunode)) !=3D NULL;) {
-=09=09if (!strcmp(cpunode->type, "cpu"))
-=09=09=09break;
-=09}
-=09if (cpunode =3D=3D NULL) {
-=09=09printk(KERN_ERR "cpufreq: Can't find any CPU node\n");
-=09=09return -ENODEV;
-=09}
-
 =09/* Lookup the cpuid eeprom node */
         cpuid =3D of_find_node_by_path("/u3@0,f8000000/i2c@f8001000/cpuid@=
a0");
 =09if (cpuid !=3D NULL)
@@ -718,25 +693,25 @@ static int __init g5_pm72_cpufreq_init(struct device_=
node *cpus)
=20
 static int __init g5_cpufreq_init(void)
 {
-=09struct device_node *cpus;
+=09struct device_node *cpunode;
 =09int rc =3D 0;
=20
-=09cpus =3D of_find_node_by_path("/cpus");
-=09if (cpus =3D=3D NULL) {
-=09=09DBG("No /cpus node !\n");
+=09/* Get first CPU node */
+=09cpunode =3D of_cpu_device_node_get(0);
+=09if (cpunode =3D=3D NULL) {
+=09=09pr_err("cpufreq: Can't find any CPU node\n");
 =09=09return -ENODEV;
 =09}
=20
 =09if (of_machine_is_compatible("PowerMac7,2") ||
 =09    of_machine_is_compatible("PowerMac7,3") ||
 =09    of_machine_is_compatible("RackMac3,1"))
-=09=09rc =3D g5_pm72_cpufreq_init(cpus);
+=09=09rc =3D g5_pm72_cpufreq_init(cpunode);
 #ifdef CONFIG_PMAC_SMU
 =09else
-=09=09rc =3D g5_neo2_cpufreq_init(cpus);
+=09=09rc =3D g5_neo2_cpufreq_init(cpunode);
 #endif /* CONFIG_PMAC_SMU */
=20
-=09of_node_put(cpus);
 =09return rc;
 }
=20
--=20
1.8.1.2
