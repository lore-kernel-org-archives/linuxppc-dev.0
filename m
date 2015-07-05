Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F8701A04C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 09:43:03 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6344F140DB4
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Jul 2015 09:43:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <dja@axtens.net>;
 Mon, 6 Jul 2015 09:43:00 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3CA13357804F
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Jul 2015 09:42:57 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t65Ngkub35848356
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Jul 2015 09:42:54 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t65NgNp3000576
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Jul 2015 09:42:24 +1000
From: Daniel Axtens <dja@axtens.net>
To: fengguang.wu@intel.com
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH] powerpc/ppc4xx_hsta_msi: Include ppc-pci.h to fix reference
 to hose_list
Date: Mon,  6 Jul 2015 09:40:34 +1000
Message-Id: <1436139634-11787-1-git-send-email-dja@axtens.net>
In-Reply-To: <201507050528.Bzp7B3rV%fengguang.wu@intel.com>
References: <201507050528.Bzp7B3rV%fengguang.wu@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An earlier commit referenced 'hose_list' in sysdev/ppc4xx_hsta_msi.c.
hose_list is defined in ppc-pci.h, which was not included in that
file. Include it, fixing the build for the akebono defconfig used
by the kbuild test robot.

Fixes: f2c800aaceb6 ("powerpc/ppc4xx_hsta_msi: Move MSI-related ops to pci_controller_ops")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
index 2bc3367..87f9623 100644
--- a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/semaphore.h>
 #include <asm/msi_bitmap.h>
+#include <asm/ppc-pci.h>
 
 struct ppc4xx_hsta_msi {
 	struct device *dev;
-- 
2.1.4
