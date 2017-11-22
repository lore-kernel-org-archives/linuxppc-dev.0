Return-Path: <okaya@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhyMl0xGpzDrJK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 09:50:10 +1100 (AEDT)
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sinan Kaya <okaya@codeaurora.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWER MACINTOSH),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 13/29] powerpc/powermac: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 17:49:08 -0500
Message-Id: <1511390964-9979-14-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Hard-code the domain number as 0 to match the previous behavior.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/macintosh/via-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index c4c2b3b..3e8b3b6 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1799,7 +1799,7 @@ static int powerbook_sleep_grackle(void)
 	struct adb_request req;
 	struct pci_dev *grackle;
 
-	grackle = pci_get_bus_and_slot(0, 0);
+	grackle = pci_get_domain_bus_and_slot(0, 0, 0);
 	if (!grackle)
 		return -ENODEV;
 
-- 
1.9.1
