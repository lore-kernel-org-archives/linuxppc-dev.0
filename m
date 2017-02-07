Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHQNw2b7BzDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 11:35:44 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vHQNv4ZJQz9s2P
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Feb 2017 11:35:43 +1100 (AEDT)
Message-ID: <1486427736.4850.103.camel@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/powernv: Properly set "host-ipi" on IPIs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Cc: Paul Mackerras <pmac@au1.ibm.com>
Date: Tue, 07 Feb 2017 11:35:36 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Otherwise KVM will fail to pass them through to the host

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/xics/icp-opal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/xics/icp-opal.c b/arch/powerpc/sysdev/xics/icp-opal.c
index c96c0cb..f9670ea 100644
--- a/arch/powerpc/sysdev/xics/icp-opal.c
+++ b/arch/powerpc/sysdev/xics/icp-opal.c
@@ -120,14 +120,16 @@ static void icp_opal_cause_ipi(int cpu, unsigned long data)
 {
 	int hw_cpu = get_hard_smp_processor_id(cpu);
 
+	kvmppc_set_host_ipi(cpu, 1);
 	opal_int_set_mfrr(hw_cpu, IPI_PRIORITY);
 }
 
 static irqreturn_t icp_opal_ipi_action(int irq, void *dev_id)
 {
-	int hw_cpu = hard_smp_processor_id();
+	int cpu = smp_processor_id();
 
-	opal_int_set_mfrr(hw_cpu, 0xff);
+	kvmppc_set_host_ipi(cpu, 0);
+	opal_int_set_mfrr(get_hard_smp_processor_id(cpu), 0xff);
 
 	return smp_ipi_demux();
 }
