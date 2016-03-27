Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYCDQ344VzDq71
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 10:00:06 +1100 (AEDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Krafft <krafft@de.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul
 Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-pm@vger.kernel.org>
Subject: [PATCH 3/3] drivers/cpufreq: make ppc_cbe_cpufreq_pmi driver
 explicitly non-modular
Date: Sun, 27 Mar 2016 18:08:17 -0400
Message-ID: <1459116497-19991-4-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1459116497-19991-1-git-send-email-paul.gortmaker@windriver.com>
References: <1459116497-19991-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Kconfig for this driver is currently:

config CPU_FREQ_CBE_PMI
    bool "CBE frequency scaling using PMI interface"

...meaning that it currently is not being built as a module by
anyone.  Lets remove the modular and unused code here, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Christian Krafft <krafft@de.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
index 7969f7690498..7c4cd5c634f2 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
@@ -23,7 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/timer.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_platform.h>
 
 #include <asm/processor.h>
@@ -142,15 +142,4 @@ static int __init cbe_cpufreq_pmi_init(void)
 
 	return 0;
 }
-
-static void __exit cbe_cpufreq_pmi_exit(void)
-{
-	cpufreq_unregister_notifier(&pmi_notifier_block, CPUFREQ_POLICY_NOTIFIER);
-	pmi_unregister_handler(&cbe_pmi_handler);
-}
-
-module_init(cbe_cpufreq_pmi_init);
-module_exit(cbe_cpufreq_pmi_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Christian Krafft <krafft@de.ibm.com>");
+device_initcall(cbe_cpufreq_pmi_init);
-- 
2.6.1
