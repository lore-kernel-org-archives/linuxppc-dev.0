Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id A73382C0107
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 19:30:18 +1000 (EST)
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 10/19] drivers/bus: arm-cci: avoid parsing DT for cpu
 device nodes
Date: Tue, 20 Aug 2013 10:30:12 +0100
Message-Id: <1376991021-12160-11-git-send-email-Sudeep.KarkadaNagesha@arm.com>
In-Reply-To: <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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

Since the CPU device nodes can be retrieved using arch_of_get_cpu_node,
we can use it to avoid parsing the cpus node searching the cpu nodes and
mapping to logical index.

This patch removes parsing DT for cpu nodes by using of_get_cpu_node.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/bus/arm-cci.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 7332889..2009266 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -122,17 +122,8 @@ EXPORT_SYMBOL_GPL(cci_ace_get_port);
=20
 static void __init cci_ace_init_ports(void)
 {
-=09int port, ac, cpu;
-=09u64 hwid;
-=09const u32 *cell;
-=09struct device_node *cpun, *cpus;
-
-=09cpus =3D of_find_node_by_path("/cpus");
-=09if (WARN(!cpus, "Missing cpus node, bailing out\n"))
-=09=09return;
-
-=09if (WARN_ON(of_property_read_u32(cpus, "#address-cells", &ac)))
-=09=09ac =3D of_n_addr_cells(cpus);
+=09int port, cpu;
+=09struct device_node *cpun;
=20
 =09/*
 =09 * Port index look-up speeds up the function disabling ports by CPU,
@@ -141,18 +132,13 @@ static void __init cci_ace_init_ports(void)
 =09 * The stashed index array is initialized for all possible CPUs
 =09 * at probe time.
 =09 */
-=09for_each_child_of_node(cpus, cpun) {
-=09=09if (of_node_cmp(cpun->type, "cpu"))
-=09=09=09continue;
-=09=09cell =3D of_get_property(cpun, "reg", NULL);
-=09=09if (WARN(!cell, "%s: missing reg property\n", cpun->full_name))
-=09=09=09continue;
-
-=09=09hwid =3D of_read_number(cell, ac);
-=09=09cpu =3D get_logical_index(hwid & MPIDR_HWID_BITMASK);
+=09for_each_possible_cpu(cpu) {
+=09=09/* too early to use cpu->of_node */
+=09=09cpun =3D of_get_cpu_node(cpu, NULL);
=20
-=09=09if (cpu < 0 || !cpu_possible(cpu))
+=09=09if (WARN(!cpun, "Missing cpu device node\n"))
 =09=09=09continue;
+
 =09=09port =3D __cci_ace_get_port(cpun, ACE_PORT);
 =09=09if (port < 0)
 =09=09=09continue;
--=20
1.8.1.2
