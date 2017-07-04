Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x20981c8zzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 20:09:32 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id c24so14644251pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 03:09:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/3] powerpc: do not call ppc_md.panic in panic notifier if
 fadump not used
Date: Tue,  4 Jul 2017 20:09:07 +1000
Message-Id: <20170704100909.8738-2-npiggin@gmail.com>
In-Reply-To: <20170704100909.8738-1-npiggin@gmail.com>
References: <20170704100909.8738-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If fadump is not registered, and no other crash or debug handlers are
registered, the powerpc panic handler stops the guest before the generic
panic code can push out debug information to the console.

Without this patch, system reset injection to a guest causes the guest to
silently stop. Afterwards, we get the expected oops trace.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/setup-common.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 94a948207cd2..39ba09965b04 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -707,12 +707,15 @@ EXPORT_SYMBOL(check_legacy_ioport);
 static int ppc_panic_event(struct notifier_block *this,
                              unsigned long event, void *ptr)
 {
-	/*
-	 * If firmware-assisted dump has been registered then trigger
-	 * firmware-assisted dump and let firmware handle everything else.
-	 */
-	crash_fadump(NULL, ptr);
-	ppc_md.panic(ptr);  /* May not return */
+	if (is_fadump_active()) {
+		/*
+		 * If firmware-assisted dump has been registered then trigger
+		 * firmware-assisted dump and let firmware handle everything
+		 * else.
+		 */
+		crash_fadump(NULL, ptr);
+		ppc_md.panic(ptr);  /* May not return */
+	}
 	return NOTIFY_DONE;
 }
 
-- 
2.11.0
