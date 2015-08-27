Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E87D1A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 16:04:24 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 27 Aug 2015 11:34:21 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0FA88125805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 11:33:44 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7R64CkJ5243128
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 11:34:12 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7R64BA2028591
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 11:34:12 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: j.anaszewski@samsung.com, linux-leds@vger.kernel.org, mpe@ellerman.id.au,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc/configs: Enable LEDS support
Date: Thu, 27 Aug 2015 11:34:10 +0530
Message-Id: <1440655450-6831-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 84ad6e5c added LEDS support for PowerNV platform. Lets
update ppc64_defconfig to pick LEDS driver.

PowerNV LEDS driver looks for "/ibm,opal/leds" node in device
tree and loads if this node exists. Hence added it as 'm'.

Also note that powernv LEDS driver needs NEW_LEDS and LEDS_CLASS
as well. Hence added them to config file.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
---
Changes in v2:
  - As suggested by Stewart updated patch description

Michael,
  This is PowerNV specific config. Hence I've not updated pseries_defconfig.
  Let me know if you want me to update pseries_defconfig config as well.

Vasant

 arch/powerpc/configs/ppc64_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index a97efc2..6bc0ee4 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -355,3 +355,6 @@ CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=m
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=m
+CONFIG_LEDS_POWERNV=m
-- 
2.1.0
