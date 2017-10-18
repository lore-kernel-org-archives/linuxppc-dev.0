Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHMWC0lnVzDqGj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 06:26:46 +1100 (AEDT)
Subject: [PATCH 4/5] powerpc-pseries: Return directly after a failed
 kzalloc_node() in iommu_pseries_alloc_group()
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
Message-ID: <a824fe65-1708-16ba-68d6-df0f73e0f49a@users.sourceforge.net>
Date: Wed, 18 Oct 2017 21:26:10 +0200
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
Date: Wed, 18 Oct 2017 20:15:32 +0200

Return directly after a call of the function "kzalloc_node" failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/pseries/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index b6c12b8e3ace..207ff8351af1 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -61,7 +61,7 @@ static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 
 	table_group = kzalloc_node(sizeof(*table_group), GFP_KERNEL, node);
 	if (!table_group)
-		goto fail_exit;
+		return NULL;
 
 	tbl = kzalloc_node(sizeof(*tbl), GFP_KERNEL, node);
 	if (!tbl)
-- 
2.14.2
