Return-Path: <nacc@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3630D1007D7
	for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2011 07:08:07 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4BKtYQH012720
	for <linuxppc-dev@ozlabs.org>; Wed, 11 May 2011 14:55:34 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4BL7wNs122886
	for <linuxppc-dev@ozlabs.org>; Wed, 11 May 2011 15:07:58 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4BL7vrF024429
	for <linuxppc-dev@ozlabs.org>; Wed, 11 May 2011 15:07:58 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] pseries/iommu: use correct return type in
	dupe_ddw_if_already_created
Date: Wed, 11 May 2011 14:07:51 -0700
Message-Id: <1305148071-30824-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Otherwise we get silent truncations.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org

---

 arch/powerpc/platforms/pseries/iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 6d5412a..31e2ac4 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -693,7 +693,7 @@ static void remove_ddw(struct device_node *np)
 }
 
 
-static int dupe_ddw_if_already_created(struct pci_dev *dev, struct device_node *pdn)
+static u64 dupe_ddw_if_already_created(struct pci_dev *dev, struct device_node *pdn)
 {
 	struct device_node *dn;
 	struct pci_dn *pcidn;
-- 
1.7.4.1
