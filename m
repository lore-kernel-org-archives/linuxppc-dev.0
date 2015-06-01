Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CA3B1A0037
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 20:50:21 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 1 Jun 2015 16:20:18 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 68FE3125804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 16:22:38 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t51AnvRo2228716
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Jun 2015 16:20:13 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t51A1GQE021028
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Jun 2015 15:31:17 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>, Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: [PATCH v3] powerpc/configs: enable RTC class support
Date: Mon,  1 Jun 2015 16:18:55 +0530
Message-Id: <1433155735-23751-1-git-send-email-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A working rtc kernel driver is needed so that hwclock can synchronize
system clock to rtc during shutdown/boot. We already have a rtc platform
driver for power arch located at drivers/rtc/rtc-opal.c However it
depends on CONFIG_RTC_CLASS which is disabled by default. So this driver
is not compiled with pseries defconfig as rtc class support is missing
from the kernel.

We fix this by enabling rtc class support in pseries defconfig so that
this driver gets enabled and is compiled into the pseries kernel.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: Cyril Bur <cyrilbur@gmail.com>	

---
This patch depends on an earlier patchset by Cyril Bur to merge pseries
'le' and 'be' defconfigs. The patchs are located at
http://patchwork.ozlabs.org/patch/476346/
http://patchwork.ozlabs.org/patch/476345/

 arch/powerpc/configs/pseries_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 4da8260..e55e7c8 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -189,6 +189,7 @@ CONFIG_HVC_RTAS=y
 CONFIG_HVCS=m
 CONFIG_VIRTIO_CONSOLE=m
 CONFIG_IBM_BSR=m
+CONFIG_RTC_CLASS=y
 CONFIG_GEN_RTC=y
 CONFIG_RAW_DRIVER=y
 CONFIG_MAX_RAW_DEVS=1024
-- 
2.2.1
