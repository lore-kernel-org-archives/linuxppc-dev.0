Return-Path: <weiyj.lk@gmail.com>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 81CF62C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2012 00:00:12 +1100 (EST)
Received: by mail-qa0-f51.google.com with SMTP id i20so749050qad.17
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Dec 2012 05:00:09 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 2 Dec 2012 08:00:09 -0500
Message-ID: <CAPgLHd9vUfwYfd71n17QfSinsQQb5KD1T0KRC7ASq+CEqE_6hA@mail.gmail.com>
Subject: [PATCH] powerpc/windfarm: use for_each_node_by_type() macro
From: Wei Yongjun <weiyj.lk@gmail.com>
To: benh@kernel.crashing.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use for_each_node_by_type() macro instead of open coding it.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/macintosh/windfarm_rm31.c  | 2 +-
 drivers/macintosh/windfarm_pm72.c  | 2 +-
 drivers/macintosh/windfarm_pm112.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/windfarm_rm31.c b/drivers/macintosh/windfarm_rm31.c
index 3eca6d4..4190b27 100644
--- a/drivers/macintosh/windfarm_rm31.c
+++ b/drivers/macintosh/windfarm_rm31.c
@@ -696,7 +696,7 @@ static int __init wf_rm31_init(void)
 
 	/* Count the number of CPU cores */
 	nr_chips = 0;
-	for (cpu = NULL; (cpu = of_find_node_by_type(cpu, "cpu")) != NULL; )
+	for_each_node_by_type(cpu, "cpu")
 		++nr_chips;
 	if (nr_chips > NR_CHIPS)
 		nr_chips = NR_CHIPS;

diff --git a/drivers/macintosh/windfarm_pm72.c b/drivers/macintosh/windfarm_pm72.c
index 84ac913..73f5e24 100644
--- a/drivers/macintosh/windfarm_pm72.c
+++ b/drivers/macintosh/windfarm_pm72.c
@@ -804,7 +804,7 @@ static int __init wf_pm72_init(void)
 
 	/* Count the number of CPU cores */
 	nr_chips = 0;
-	for (cpu = NULL; (cpu = of_find_node_by_type(cpu, "cpu")) != NULL; )
+	for_each_node_by_type(cpu, "cpu")
 		++nr_chips;
 	if (nr_chips > NR_CHIPS)
 		nr_chips = NR_CHIPS;

diff --git a/drivers/macintosh/windfarm_pm112.c b/drivers/macintosh/windfarm_pm112.c
index e0ee807..b479b82 100644
--- a/drivers/macintosh/windfarm_pm112.c
+++ b/drivers/macintosh/windfarm_pm112.c
@@ -681,7 +681,7 @@ static int __init wf_pm112_init(void)
 
 	/* Count the number of CPU cores */
 	nr_cores = 0;
-	for (cpu = NULL; (cpu = of_find_node_by_type(cpu, "cpu")) != NULL; )
+	for_each_node_by_type(cpu, "cpu")
 		++nr_cores;
 
 	printk(KERN_INFO "windfarm: initializing for dual-core desktop G5\n");
