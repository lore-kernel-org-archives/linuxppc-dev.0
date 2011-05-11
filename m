Return-Path: <nacc@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6117B10087D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 08:25:23 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4BMJS9H032349
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2011 16:19:28 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4BMP8Yu063054
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2011 16:25:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4BGP7eW016664
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2011 10:25:07 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: [PATCH 2/8] pseries/iommu: remove ddw property when destroying window
Date: Wed, 11 May 2011 15:24:58 -0700
Message-Id: <1305152704-4864-3-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1305152704-4864-1-git-send-email-nacc@us.ibm.com>
References: <1305152704-4864-1-git-send-email-nacc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Will Schmidt <will_schmidt@vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Milton Miller <miltonm@bga.com>

If we destroy the window, we need to remove the property recording that
we setup the window.  Otherwise the next kernel we kexec will be
confused.

Also we should remove the property if even if we don't find the
ibm,ddw-applicable window or if one of the property sizes is unexpected;
presumably these came from a prior kernel via kexec, and we will not be
maintaining the window with respect to memory hotplug.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 05c101e..a0421ac 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -665,9 +665,12 @@ static void remove_ddw(struct device_node *np)
 
 	ddr_avail = of_get_property(np, "ibm,ddw-applicable", &len);
 	win64 = of_find_property(np, DIRECT64_PROPNAME, NULL);
-	if (!win64 || !ddr_avail || len < 3 * sizeof(u32))
+	if (!win64)
 		return;
 
+	if (!ddr_avail || len < 3 * sizeof(u32) || win64->length < sizeof(*dwp))
+		goto delprop;
+
 	dwp = win64->value;
 	liobn = (u64)be32_to_cpu(dwp->liobn);
 
@@ -690,8 +693,13 @@ static void remove_ddw(struct device_node *np)
 		pr_debug("%s: successfully removed direct window: rtas returned "
 			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
 			np->full_name, ret, ddr_avail[2], liobn);
-}
 
+delprop:
+	ret = of_remove_property(np, win64);
+	if (ret)
+		pr_warning("%s: failed to remove direct window property: %d\n"
+			np->full_name, ret);
+}
 
 static u64 dupe_ddw_if_already_created(struct pci_dev *dev, struct device_node *pdn)
 {
-- 
1.7.4.1
