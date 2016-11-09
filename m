Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDScl27xrzDvRc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 01:05:26 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA9E4baS041403
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2016 09:05:24 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26m39w1m8d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2016 09:05:24 -0500
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 9 Nov 2016 12:05:21 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 56C793520074
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 09:04:50 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA9E5Ikl35520724
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2016 12:05:18 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA9E5HvC010758
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2016 12:05:18 -0200
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: devicetree@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 frowand.list@gmail.com, robh+dt@kernel.org, gpiccoli@linux.vnet.ibm.com
Subject: [PATCH] of/irq: improve error message on irq discovery process failure
Date: Wed,  9 Nov 2016 12:05:08 -0200
Message-Id: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerPC machines some PCI slots might not have Level-triggered
interrupts capability (also know as Level Signaled Interrupts - LSI),
leading of_irq_parse_pci() to complain by presenting error messages
on the kernel log - in this case, the properties "interrupt-map" and
"interrupt-map-mask" are not present on the device's node on device
tree.

This patch introduces a different message for this specific case,
and it also reduces the level of the message from error to warning.
Before this patch, when an adapter was plugged in a slot without Level
interrupts capabilities, we saw generic error messages like this:

    [54.239] pci 002d:70:00.0: of_irq_parse_pci() failed with rc=-22

Now, with this applied, we see the following specific message:

    [19.947] pci 0014:60:00.0: of_irq_parse_pci() gave up. The slot of this
    device has no Level-triggered Interrupts capability.

No functional changes were introduced.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 drivers/of/irq.c        | 5 ++++-
 drivers/of/of_pci_irq.c | 8 +++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 393fea8..1ad6882 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -275,7 +275,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 	of_node_put(ipar);
 	of_node_put(newpar);
 
-	return -EINVAL;
+	/* Positive non-zero return means no Level-triggered Interrupts
+	 * capability was found.
+	 */
+	return ENOENT;
 }
 EXPORT_SYMBOL_GPL(of_irq_parse_raw);
 
diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
index 2306313..9b6f387 100644
--- a/drivers/of/of_pci_irq.c
+++ b/drivers/of/of_pci_irq.c
@@ -89,8 +89,14 @@ int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq
 	laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
 	laddr[1] = laddr[2] = cpu_to_be32(0);
 	rc = of_irq_parse_raw(laddr, out_irq);
-	if (rc)
+
+	if (rc < 0) {
 		goto err;
+	} else if (rc > 0) {
+		dev_warn(&pdev->dev,
+			"of_irq_parse_pci() gave up. The slot of this device has no Level-triggered Interrupts capability.\n");
+		return -rc;
+	}
 	return 0;
 err:
 	dev_err(&pdev->dev, "of_irq_parse_pci() failed with rc=%d\n", rc);
-- 
2.1.0
