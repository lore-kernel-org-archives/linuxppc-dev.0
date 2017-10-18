Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHMRq4sgNzDrSt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 06:23:51 +1100 (AEDT)
Subject: [PATCH 2/5] powerpc-pseries: Improve nine size determinations
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Doug Ledford <dledford@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johan Hovold <johan@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, Rob Herring <robh@kernel.org>,
 Sahil Mehta <sahilmehta17@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <0d221be4-1402-0499-d95e-afa4a30e1f33@users.sourceforge.net>
Message-ID: <7a16a571-2087-7926-3ff7-e6252cf34734@users.sourceforge.net>
Date: Wed, 18 Oct 2017 21:23:12 +0200
MIME-Version: 1.0
In-Reply-To: <0d221be4-1402-0499-d95e-afa4a30e1f33@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Oct 2017 18:18:11 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/pseries/dlpar.c     |  5 ++---
 arch/powerpc/platforms/pseries/hvcserver.c |  5 ++---
 arch/powerpc/platforms/pseries/iommu.c     | 10 ++++------
 arch/powerpc/platforms/pseries/vio.c       |  5 ++---
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 6e35780c5962..dca88997cb4b 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -389,11 +389,10 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
 	struct pseries_hp_work *work;
 	struct pseries_hp_errorlog *hp_errlog_copy;
 
-	hp_errlog_copy = kmalloc(sizeof(struct pseries_hp_errorlog),
-				 GFP_KERNEL);
+	hp_errlog_copy = kmalloc(sizeof(*hp_errlog_copy), GFP_KERNEL);
 	memcpy(hp_errlog_copy, hp_errlog, sizeof(struct pseries_hp_errorlog));
 
-	work = kmalloc(sizeof(struct pseries_hp_work), GFP_KERNEL);
+	work = kmalloc(sizeof(*work), GFP_KERNEL);
 	if (work) {
 		INIT_WORK((struct work_struct *)work, pseries_hp_work_fn);
 		work->errlog = hp_errlog_copy;
diff --git a/arch/powerpc/platforms/pseries/hvcserver.c b/arch/powerpc/platforms/pseries/hvcserver.c
index db2c20e65a58..b85cca04dd7d 100644
--- a/arch/powerpc/platforms/pseries/hvcserver.c
+++ b/arch/powerpc/platforms/pseries/hvcserver.c
@@ -173,9 +173,8 @@ int hvcs_get_partner_info(uint32_t unit_address, struct list_head *head,
 
 		/* This is a very small struct and will be freed soon in
 		 * hvcs_free_partner_info(). */
-		next_partner_info = kmalloc(sizeof(struct hvcs_partner_info),
-				GFP_ATOMIC);
-
+		next_partner_info = kmalloc(sizeof(*next_partner_info),
+					    GFP_ATOMIC);
 		if (!next_partner_info) {
 			hvcs_free_partner_info(head);
 			return -ENOMEM;
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index c92822fdf269..b37d4fb20d1c 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -59,17 +59,15 @@ static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 	struct iommu_table *tbl = NULL;
 	struct iommu_table_group_link *tgl = NULL;
 
-	table_group = kzalloc_node(sizeof(struct iommu_table_group), GFP_KERNEL,
-			   node);
+	table_group = kzalloc_node(sizeof(*table_group), GFP_KERNEL, node);
 	if (!table_group)
 		goto fail_exit;
 
-	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, node);
+	tbl = kzalloc_node(sizeof(*tbl), GFP_KERNEL, node);
 	if (!tbl)
 		goto fail_exit;
 
-	tgl = kzalloc_node(sizeof(struct iommu_table_group_link), GFP_KERNEL,
-			node);
+	tgl = kzalloc_node(sizeof(*tgl), GFP_KERNEL, node);
 	if (!tgl)
 		goto fail_exit;
 
@@ -1062,7 +1060,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		goto out_failed;
 	}
 	len = order_base_2(max_addr);
-	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
+	win64 = kzalloc(sizeof(*win64), GFP_KERNEL);
 	if (!win64)
 		goto out_failed;
 
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 74b919040e68..cf0939eb3aee 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -754,8 +754,7 @@ static int vio_cmo_bus_probe(struct vio_dev *viodev)
 			viodev->cmo.desired = VIO_CMO_MIN_ENT;
 		size = VIO_CMO_MIN_ENT;
 
-		dev_ent = kmalloc(sizeof(struct vio_cmo_dev_entry),
-		                  GFP_KERNEL);
+		dev_ent = kmalloc(sizeof(*dev_ent), GFP_KERNEL);
 		if (!dev_ent)
 			return -ENOMEM;
 
@@ -1385,7 +1384,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	}
 
 	/* allocate a vio_dev for this node */
-	viodev = kzalloc(sizeof(struct vio_dev), GFP_KERNEL);
+	viodev = kzalloc(sizeof(*viodev), GFP_KERNEL);
 	if (!viodev)
 		return NULL;
 
-- 
2.14.2
