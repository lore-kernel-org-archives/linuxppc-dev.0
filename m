Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id E6D052C0106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 19:30:17 +1000 (EST)
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 09/19] ARM: mvebu: remove device tree parsing for cpu nodes
Date: Tue, 20 Aug 2013 10:30:11 +0100
Message-Id: <1376991021-12160-10-git-send-email-Sudeep.KarkadaNagesha@arm.com>
In-Reply-To: <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Jonas Bonn <jonas@southpole.se>, Andrew Lunn <andrew@lunn.ch>,
 Michal Simek <monstr@monstr.eu>, Jason Cooper <jason@lakedaemon.net>,
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

Currently set_secondary_cpus_clock assume the CPU logical ordering
and the MPDIR in DT are same, which is incorrect.

Since the CPU device nodes can be retrieved in the logical ordering
using the DT helper, we can remove the devices tree parsing.

This patch removes DT parsing by making use of of_get_cpu_node.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Acked-by: Gregory Clement <gregory.clement@free-electrons.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm/mach-mvebu/platsmp.c | 51 +++++++++++++++++++--------------------=
----
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index ce81d30..594b63d 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -29,45 +29,40 @@
 #include "pmsu.h"
 #include "coherency.h"
=20
+static struct clk *__init get_cpu_clk(int cpu)
+{
+=09struct clk *cpu_clk;
+=09struct device_node *np =3D of_get_cpu_node(cpu, NULL);
+
+=09if (WARN(!np, "missing cpu node\n"))
+=09=09return NULL;
+=09cpu_clk =3D of_clk_get(np, 0);
+=09if (WARN_ON(IS_ERR(cpu_clk)))
+=09=09return NULL;
+=09return cpu_clk;
+}
+
 void __init set_secondary_cpus_clock(void)
 {
-=09int thiscpu;
+=09int thiscpu, cpu;
 =09unsigned long rate;
-=09struct clk *cpu_clk =3D NULL;
-=09struct device_node *np =3D NULL;
+=09struct clk *cpu_clk;
=20
 =09thiscpu =3D smp_processor_id();
-=09for_each_node_by_type(np, "cpu") {
-=09=09int err;
-=09=09int cpu;
-
-=09=09err =3D of_property_read_u32(np, "reg", &cpu);
-=09=09if (WARN_ON(err))
-=09=09=09return;
-
-=09=09if (cpu =3D=3D thiscpu) {
-=09=09=09cpu_clk =3D of_clk_get(np, 0);
-=09=09=09break;
-=09=09}
-=09}
-=09if (WARN_ON(IS_ERR(cpu_clk)))
+=09cpu_clk =3D get_cpu_clk(thiscpu);
+=09if (!cpu_clk)
 =09=09return;
 =09clk_prepare_enable(cpu_clk);
 =09rate =3D clk_get_rate(cpu_clk);
=20
 =09/* set all the other CPU clk to the same rate than the boot CPU */
-=09for_each_node_by_type(np, "cpu") {
-=09=09int err;
-=09=09int cpu;
-
-=09=09err =3D of_property_read_u32(np, "reg", &cpu);
-=09=09if (WARN_ON(err))
+=09for_each_possible_cpu(cpu) {
+=09=09if (cpu =3D=3D thiscpu)
+=09=09=09continue;
+=09=09cpu_clk =3D get_cpu_clk(cpu);
+=09=09if (!cpu_clk)
 =09=09=09return;
-
-=09=09if (cpu !=3D thiscpu) {
-=09=09=09cpu_clk =3D of_clk_get(np, 0);
-=09=09=09clk_set_rate(cpu_clk, rate);
-=09=09}
+=09=09clk_set_rate(cpu_clk, rate);
 =09}
 }
=20
--=20
1.8.1.2
