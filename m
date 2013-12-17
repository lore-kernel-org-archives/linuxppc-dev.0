Return-Path: <clg@fr.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 10D432C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 04:33:04 +1100 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Tue, 17 Dec 2013 17:33:00 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 02BC51B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2013 17:32:05 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBHHWhqk42008686
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2013 17:32:44 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBHHWtlD006788
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2013 10:32:55 -0700
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: grant.likely@linaro.org
Subject: [PATCH] of/irq: Fix device_node refcount in of_irq_parse_raw()
Date: Tue, 17 Dec 2013 18:32:53 +0100
Message-Id: <1387301573-30502-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 2361613206e6, "of/irq: Refactor interrupt-map parsing" changed
the refcount on the device_node causing an error in of_node_put():

ERROR: Bad of_node_put() on /pci@800000020000000
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.13.0-rc3-dirty #2
Call Trace:
[c00000003e403500] [c0000000000144fc] .show_stack+0x7c/0x1f0 (unreliable)
[c00000003e4035d0] [c00000000070f250] .dump_stack+0x88/0xb4
[c00000003e403650] [c0000000005e8768] .of_node_release+0xd8/0xf0
[c00000003e4036e0] [c0000000005eeafc] .of_irq_parse_one+0x10c/0x280
[c00000003e4037a0] [c0000000005efd4c] .of_irq_parse_pci+0x3c/0x1d0
[c00000003e403840] [c000000000038240] .pcibios_setup_device+0xa0/0x2e0
[c00000003e403910] [c0000000000398f0] .pcibios_setup_bus_devices+0x60/0xd0
[c00000003e403990] [c00000000003b3a4] .__of_scan_bus+0x1a4/0x2b0
[c00000003e403a80] [c00000000003a62c] .pcibios_scan_phb+0x30c/0x410
[c00000003e403b60] [c0000000009fe430] .pcibios_init+0x7c/0xd4

This patch adjusts the refcount in the walk of the interrupt tree.
When a match is found, there is no need to increase the refcount 
on 'out_irq->np' as 'newpar' is already holding a ref. The refcount
balance between 'ipar' and 'newpar' is maintained in the skiplevel:
goto label.

This patch also removes the usage of the device_node variable 'old' 
which seems useless after the latest changes.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---

This patch was tested on powerpc, pseries and powernv. This is a 
new area for me so I might have missed a path. Please take a look.

We could now introduce an helper routine to look for #address-cells in
of_irq_parse_raw(). This can be the subject of another patch.

Thanks,

C.

 drivers/of/irq.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 786b0b47fae4..27212402c532 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -165,7 +165,6 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		if (of_get_property(ipar, "interrupt-controller", NULL) !=
 				NULL) {
 			pr_debug(" -> got it !\n");
-			of_node_put(old);
 			return 0;
 		}
 
@@ -250,8 +249,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		 * Successfully parsed an interrrupt-map translation; copy new
 		 * interrupt specifier into the out_irq structure
 		 */
-		of_node_put(out_irq->np);
-		out_irq->np = of_node_get(newpar);
+		out_irq->np = newpar;
 
 		match_array = imap - newaddrsize - newintsize;
 		for (i = 0; i < newintsize; i++)
@@ -268,7 +266,6 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 	}
  fail:
 	of_node_put(ipar);
-	of_node_put(out_irq->np);
 	of_node_put(newpar);
 
 	return -EINVAL;
-- 
1.7.10.4
