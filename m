Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xLCZ1WxMzDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 09:26:49 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7NNNl3j142104
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 19:26:47 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m263092k9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 19:26:47 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Thu, 23 Aug 2018 17:26:46 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, clg@kaod.org, Breno Leitao <leitao@debian.org>
Subject: [PATCH v2] powerpc/xive: Avoid unitialized variable
Date: Thu, 23 Aug 2018 20:26:39 -0300
In-Reply-To: <3b8841ac-ebbb-523e-0d65-ebe27a702d3c@kaod.org>
References: <3b8841ac-ebbb-523e-0d65-ebe27a702d3c@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Message-Id: <1535066799-8493-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Breno Leitao <breno.leitao@gmail.com>

Function xive_native_get_ipi() might uses chip_id without it being
initialized.

This gives the following error on 'smatch' tool:

	error: uninitialized symbol 'chip_id'

The suggestion is using xc->chip_id instead of consulting the OF for chip id,
which is safe since xive_prepare_cpu() should have initialized ->chip_id by
the time xive_native_get_ipi() is called.

CC: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/sysdev/xive/native.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 311185b9960a..bd90fd464a3a 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -238,20 +238,11 @@ static bool xive_native_match(struct device_node *node)
 #ifdef CONFIG_SMP
 static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
 {
-	struct device_node *np;
-	unsigned int chip_id;
 	s64 irq;
 
-	/* Find the chip ID */
-	np = of_get_cpu_node(cpu, NULL);
-	if (np) {
-		if (of_property_read_u32(np, "ibm,chip-id", &chip_id) < 0)
-			chip_id = 0;
-	}
-
 	/* Allocate an IPI and populate info about it */
 	for (;;) {
-		irq = opal_xive_allocate_irq(chip_id);
+		irq = opal_xive_allocate_irq(xc->chip_id);
 		if (irq == OPAL_BUSY) {
 			msleep(1);
 			continue;
-- 
2.17.1
