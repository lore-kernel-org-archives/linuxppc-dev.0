Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nsgG5D9rzF0Pl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 14:36:10 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id e6-v6so5696088plt.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 21:36:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/3] powerpc/64: hard disable irqs in panic_smp_self_stop
Date: Sat, 19 May 2018 14:35:52 +1000
Message-Id: <20180519043554.26640-2-npiggin@gmail.com>
In-Reply-To: <20180519043554.26640-1-npiggin@gmail.com>
References: <20180519043554.26640-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similarly to commit 855bfe0de1 ("powerpc: hard disable irqs in
smp_send_stop loop"), irqs should be hard disabled by
panic_smp_self_stop.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/setup_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index b78f142a4148..d122321ad542 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -380,6 +380,14 @@ void early_setup_secondary(void)
 
 #endif /* CONFIG_SMP */
 
+void panic_smp_self_stop(void)
+{
+	hard_irq_disable();
+	spin_begin();
+	while (1)
+		spin_cpu_relax();
+}
+
 #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC_CORE)
 static bool use_spinloop(void)
 {
-- 
2.17.0
