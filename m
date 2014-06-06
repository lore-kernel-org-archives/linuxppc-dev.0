Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 963261A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 20:22:34 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Fri, 6 Jun 2014 15:52:30 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1CCCEE004B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 15:53:22 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s56AMdxS10682846
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 15:52:39 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s56AMPN9012797
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 15:52:26 +0530
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCHv2 1/2] powerpc/powernv: include asm/smp.h to fix UP build
 failure
Date: Fri,  6 Jun 2014 15:51:05 +0530
Message-Id: <1402050065-18007-1-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
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
Changes is v2:
Commit message improved based on suggestion.

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
