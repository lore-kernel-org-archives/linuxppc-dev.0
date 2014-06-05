Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83B3B1A0039
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 01:24:08 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 5 Jun 2014 20:54:03 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1E6221258056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 20:53:18 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s55FOj6O61669378
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 20:54:45 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s55FNw7P017274
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 20:53:59 +0530
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/2] powerpc/powernv: include asm/smp.h to handle UP config
Date: Thu,  5 Jun 2014 20:51:35 +0530
Message-Id: <1401981695-3682-1-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Build throws following errors when CONFIG_SMP=n
arch/powerpc/platforms/powernv/setup.c: In function ‘pnv_kexec_wait_secondaries_down’:
arch/powerpc/platforms/powernv/setup.c:179:4: error: implicit declaration of function ‘get_hard_smp_processor_id’
    rc = opal_query_cpu_status(get_hard_smp_processor_id(i),

The usage of get_hard_smp_processor_id() needs the declaration from
<asm/smp.h>. The file setup.c includes <linux/sched.h>, which in-turn
includes <linux/smp.h>. However, <linux/smp.h> includes <asm/smp.h>
only on SMP configs and hence UP builds fail.

Fix this by directly including <asm/smp.h> in setup.c unconditionally.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 8c16a5f..678573c 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -35,6 +35,7 @@
 #include <asm/rtas.h>
 #include <asm/opal.h>
 #include <asm/kexec.h>
+#include <asm/smp.h>
 
 #include "powernv.h"
 
-- 
1.9.0
