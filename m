Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJm745yJ0zDrcD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 08:57:52 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7NMsC03080952
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 18:57:49 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 250twxbq5b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 18:57:48 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 23 Aug 2016 19:57:46 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id B943D3520068
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 18:57:21 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7NMvhKR21954822
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 19:57:43 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7NMvgEM014661
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 19:57:42 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Fix build of 64 bit little endian with CONFIG_KEXEC=n
Date: Tue, 23 Aug 2016 19:57:39 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1471993059-19239-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On ppc64le, builds with CONFIG_KEXEC=n fail with:

arch/powerpc/platforms/pseries/setup.c: In function ‘pseries_big_endian_exceptions’:
arch/powerpc/platforms/pseries/setup.c:403:13: error: implicit
declaration of function ‘kdump_in_progress’ [-Werror=implicit-function-declaration]
  if (rc && !kdump_in_progress())

This is because pseries/setup.c includes <linux/kexec.h>, but
kdump_in_progress is defined in <asm/kexec.h>. This is a problem because
the former only includes the latter if CONFIG_KEXEC_CORE=y.

Fix by including <asm/kexec.h> directly, as is done in powernv/setup.c.

Fixes: d3cbff1b5a90 ("powerpc: Put exception configuration in a common place")
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 4ffcaa6f8670..a39d20e8623d 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -41,7 +41,6 @@
 #include <linux/root_dev.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
-#include <linux/kexec.h>
 
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -66,6 +65,7 @@
 #include <asm/eeh.h>
 #include <asm/reg.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/kexec.h>
 
 #include "pseries.h"
 
-- 
1.9.1
