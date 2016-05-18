Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8bsj4X9dzDqCQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 11:17:45 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r8bsj0kBnz9vKX
 for <linuxppc-dev@ozlabs.org>; Wed, 18 May 2016 11:17:45 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id g132so3409199pfb.3
 for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2016 18:17:45 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au,
	Daniel Axtens <dja@axtens.net>
Subject: [PATCH 3/4] powerpc/sparse: Include headers containing prototypes
Date: Wed, 18 May 2016 11:16:51 +1000
Message-Id: <1463534212-4879-3-git-send-email-dja@axtens.net>
In-Reply-To: <1463534212-4879-1-git-send-email-dja@axtens.net>
References: <1463534212-4879-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sometimes headers that provide prototypes for functions are
accidentally omitted from the files that define the functions.

Fix a couple of times that occurs.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/smp.c              | 1 +
 arch/powerpc/platforms/pseries/power.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index f1adc3c4f4ca..1b55c7864291 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -31,6 +31,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/topology.h>
+#include <linux/profile.h>
 
 #include <asm/ptrace.h>
 #include <linux/atomic.h>
diff --git a/arch/powerpc/platforms/pseries/power.c b/arch/powerpc/platforms/pseries/power.c
index c26eadde434c..a4a0b57d1d81 100644
--- a/arch/powerpc/platforms/pseries/power.c
+++ b/arch/powerpc/platforms/pseries/power.c
@@ -27,6 +27,8 @@
 #include <linux/init.h>
 #include <asm/machdep.h>
 
+#include "pseries.h"
+
 unsigned long rtas_poweron_auto; /* default and normal state is 0 */
 
 static ssize_t auto_poweron_show(struct kobject *kobj,
-- 
2.5.0
