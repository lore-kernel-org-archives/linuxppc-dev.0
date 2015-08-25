Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CE301A0138
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 17:55:18 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 25 Aug 2015 17:55:17 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D93552CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 17:55:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7P7t40E6881418
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 17:55:12 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7P7sgQC018609
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 17:54:42 +1000
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-leds@vger.kernel.org, j.anaszewski@samsung.com, mpe@ellerman.id.au,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/configs: Enable LEDS support
Date: Tue, 25 Aug 2015 13:24:14 +0530
Message-Id: <1440489254-8162-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
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

Presently PowerNV LEDS driver is specific to FSP based PowerNV
platform. Hence added it as 'm'. So that we will be loaded only
if we have required device tree support.

Also note that powernv LEDS driver needs NEW_LEDS and LEDS_CLASS
as well. Hence added them to config file.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
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
