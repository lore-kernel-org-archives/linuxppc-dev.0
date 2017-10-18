Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHMYG12glzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 06:28:33 +1100 (AEDT)
Subject: [PATCH 5/5] powerpc-pseries: Less function calls in
 iommu_pseries_alloc_group() after error detection
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
Message-ID: <45cdde43-075d-10c0-ab34-1ce1aa4dfa17@users.sourceforge.net>
Date: Wed, 18 Oct 2017 21:27:57 +0200
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
Date: Wed, 18 Oct 2017 20:48:52 +0200

The kfree() function was called in up to two cases by the
iommu_pseries_alloc_group() function during error handling
even if the passed variable contained a null pointer.

* Adjust jump targets according to the Linux coding style convention.

* Delete initialisations for the variables "tbl" and "tgl"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/pseries/iommu.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 207ff8351af1..13b424f34039 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -56,8 +56,8 @@
 static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 {
 	struct iommu_table_group *table_group;
-	struct iommu_table *tbl = NULL;
-	struct iommu_table_group_link *tgl = NULL;
+	struct iommu_table *tbl;
+	struct iommu_table_group_link *tgl;
 
 	table_group = kzalloc_node(sizeof(*table_group), GFP_KERNEL, node);
 	if (!table_group)
@@ -65,11 +65,11 @@ static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 
 	tbl = kzalloc_node(sizeof(*tbl), GFP_KERNEL, node);
 	if (!tbl)
-		goto fail_exit;
+		goto free_group;
 
 	tgl = kzalloc_node(sizeof(*tgl), GFP_KERNEL, node);
 	if (!tgl)
-		goto fail_exit;
+		goto free_table;
 
 	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
 	kref_init(&tbl->it_kref);
@@ -80,11 +80,10 @@ static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 
 	return table_group;
 
-fail_exit:
-	kfree(tgl);
-	kfree(table_group);
+free_table:
 	kfree(tbl);
-
+free_group:
+	kfree(table_group);
 	return NULL;
 }
 
-- 
2.14.2
