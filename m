Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6BA222C0138
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 17:22:29 +1000 (EST)
Received: by mail-pd0-f176.google.com with SMTP id x10so1861168pdj.35
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2013 00:22:27 -0700 (PDT)
From: aik@ozlabs.ru
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] iommu: Move initialization earlier
Date: Mon,  6 May 2013 17:21:57 +1000
Message-Id: <51875a31.25ac440a.50d9.ffffe8fd@mx.google.com>
In-Reply-To: <1367824921-27151-1-git-send-email-y>
References: <1367824921-27151-1-git-send-email-y>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The iommu_init() call initializes IOMMU internal structures and data
required for the API to function such as iommu_group_alloc().
It is registered as a subsys_initcall.

One of the IOMMU users is a PCI subsystem on POWER which discovers new
IOMMU tables during the PCI scan so the most logical place to call
iommu_group_alloc() is when a new group is just discovered. However
PCI scan is done from subsys_initcall hook as well, which makes
use of the IOMMU API impossible.

This moves IOMMU subsystem initialization one step earlier.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 drivers/iommu/iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5514dfa..0de83eb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -890,7 +890,7 @@ static int __init iommu_init(void)
 
 	return 0;
 }
-subsys_initcall(iommu_init);
+arch_initcall(iommu_init);
 
 int iommu_domain_get_attr(struct iommu_domain *domain,
 			  enum iommu_attr attr, void *data)
-- 
1.7.10.4
