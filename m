Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425DWT4CrczF3G1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 05:37:57 +1000 (AEST)
Received: by mail-oi0-f65.google.com with SMTP id y207-v6so15870655oie.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 12:37:57 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vitaly Bordug <vitb@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/21] powerpc: 8xx: get cpu node with of_get_cpu_node
Date: Wed,  5 Sep 2018 14:37:30 -0500
Message-Id: <20180905193738.19325-14-robh@kernel.org>
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"device_type" use is deprecated for FDT though it has continued to be used
for nodes like cpu nodes. Use of_get_cpu_node() instead which works using
node names by default. This will allow the eventually removal of cpu
device_type properties.

Also, fix a leaked reference and add a missing of_node_put.

Cc: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/powerpc/platforms/8xx/m8xx_setup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index 027c42d8966c..f1c805c8adbc 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -66,7 +66,7 @@ static int __init get_freq(char *name, unsigned long *val)
 	int found = 0;

 	/* The cpu node should have timebase and clock frequency properties */
-	cpu = of_find_node_by_type(NULL, "cpu");
+	cpu = of_get_cpu_node(0, NULL);

 	if (cpu) {
 		fp = of_get_property(cpu, name, NULL);
@@ -147,8 +147,9 @@ void __init mpc8xx_calibrate_decr(void)
 	 * we have to enable the timebase).  The decrementer interrupt
 	 * is wired into the vector table, nothing to do here for that.
 	 */
-	cpu = of_find_node_by_type(NULL, "cpu");
+	cpu = of_get_cpu_node(0, NULL);
 	virq= irq_of_parse_and_map(cpu, 0);
+	of_node_put(cpu);
 	irq = virq_to_hw(virq);

 	sys_tmr2 = immr_map(im_sit);
--
2.17.1
