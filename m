Return-Path: <groeck7@gmail.com>
Received: from mail-pb0-x22a.google.com (mail-pb0-x22a.google.com
 [IPv6:2607:f8b0:400e:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0C9F1A03CB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 02:38:44 +1000 (EST)
Received: by mail-pb0-f42.google.com with SMTP id ma3so2057519pbc.29
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 09:38:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix build warning
Date: Fri, 13 Jun 2014 09:38:19 -0700
Message-Id: <1402677499-28289-1-git-send-email-linux@roeck-us.net>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Vincent Guittot <vincent.guittot@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If compiled with W=1, the following warning is seen in powerpc builds.

arch/powerpc/kernel/smp.c:750:18: warning:
	type qualifiers ignored on function return type
static const int powerpc_smt_flags(void)
                 ^

This is caused by a function returning 'const int', which doesn't
make sense to gcc. Drop 'const' to fix the problem.

Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/powerpc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 10ffffe..49d5d4e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -768,7 +768,7 @@ int setup_profiling_timer(unsigned int multiplier)
 
 #ifdef CONFIG_SCHED_SMT
 /* cpumask of CPUs with asymetric SMT dependancy */
-static const int powerpc_smt_flags(void)
+static int powerpc_smt_flags(void)
 {
 	int flags = SD_SHARE_CPUPOWER | SD_SHARE_PKG_RESOURCES;
 
-- 
1.9.1
