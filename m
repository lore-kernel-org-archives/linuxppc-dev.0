Return-Path: <robherring2@gmail.com>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBtxS6hQrzDrJs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 07:45:16 +1000 (AEST)
Received: by mail-pg0-f67.google.com with SMTP id z1so4354093pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 14:45:16 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] virt: Convert to using %pOF instead of full_name
Date: Tue, 18 Jul 2017 16:43:37 -0500
Message-Id: <20170718214339.7774-57-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/virt/fsl_hypervisor.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index d3eca879a0a8..d993df5586c0 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -841,8 +841,8 @@ static int __init fsl_hypervisor_init(void)
 		handle = of_get_property(np, "interrupts", NULL);
 		irq = irq_of_parse_and_map(np, 0);
 		if (!handle || (irq == NO_IRQ)) {
-			pr_err("fsl-hv: no 'interrupts' property in %s node\n",
-				np->full_name);
+			pr_err("fsl-hv: no 'interrupts' property in %pOF node\n",
+				np);
 			continue;
 		}

@@ -869,8 +869,8 @@ static int __init fsl_hypervisor_init(void)
 			 */
 			dbisr->partition = ret = get_parent_handle(np);
 			if (ret < 0) {
-				pr_err("fsl-hv: node %s has missing or "
-				       "malformed parent\n", np->full_name);
+				pr_err("fsl-hv: node %pOF has missing or "
+				       "malformed parent\n", np);
 				kfree(dbisr);
 				continue;
 			}
@@ -881,8 +881,8 @@ static int __init fsl_hypervisor_init(void)
 			ret = request_irq(irq, fsl_hv_isr, 0, np->name, dbisr);

 		if (ret < 0) {
-			pr_err("fsl-hv: could not request irq %u for node %s\n",
-			       irq, np->full_name);
+			pr_err("fsl-hv: could not request irq %u for node %pOF\n",
+			       irq, np);
 			kfree(dbisr);
 			continue;
 		}
--
2.11.0
