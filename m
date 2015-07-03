Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 954781A0456
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 15:12:47 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 3 Jul 2015 15:12:47 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1EEED2BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 15:12:42 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t635CXVj51249400
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2015 15:12:42 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t635C9Ns008535
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2015 15:12:09 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, Michael Ellerman <mpe@ellerman.id.au>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: [RESEND PATCH] powerpc/configs: enable RTC class support
Date: Fri,  3 Jul 2015 10:41:20 +0530
Message-Id: <1435900280-12947-1-git-send-email-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A working rtc kernel driver is needed so that hwclock can synchronize
system clock to rtc during shutdown/boot. We already have a powernv
platform rtc driver located at drivers/rtc/rtc-opal.c. However it depends
on CONFIG_RTC_CLASS which is disabled by default. Hence the driver isn't
enabled and not compiled for the powernv kernel.

We fix this by enabling rtc class support in pseries defconfig which
enables this driver and compiles it into the pseries kernel. In case
CONFIG_PPC_POWERNV is not enabled we fallback to 'Generic RTC support'
driver which emulates the legacy 'PC RTC driver'.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 arch/powerpc/configs/pseries_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 0d9efce..2404271e 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -190,7 +190,8 @@ CONFIG_HVC_RTAS=y
 CONFIG_HVCS=m
 CONFIG_VIRTIO_CONSOLE=m
 CONFIG_IBM_BSR=m
-CONFIG_GEN_RTC=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_GENERIC=y
 CONFIG_RAW_DRIVER=y
 CONFIG_MAX_RAW_DEVS=1024
 CONFIG_FB=y
-- 
2.2.1
