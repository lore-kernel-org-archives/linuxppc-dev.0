Return-Path: <B29983@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18A8DB6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Aug 2011 16:56:00 +1000 (EST)
From: <b29983@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/mm: fix the call trace when resumed from hibernation
Date: Wed, 17 Aug 2011 13:51:33 +0800
Message-ID: <1313560293-31874-1-git-send-email-b29983@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <b29983@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <B29983@freescale.com>

	In SMP mode, the kernel would produce call trace when resumed
	from hibernation. The reason is when the function destroy_context
	is called to drop the resuming mm context, the mm->context.active
	is 1 which is wrong and should be zero.
	We pass the current->active_mm as previous mm context to function
	switch_mmu_context to decrease the context.active by 1.

	In UP mode, there is no effect.

Signed-off-by: Tang Yuantian <b29983@freescale.com>
---
 arch/powerpc/kernel/swsusp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/swsusp.c b/arch/powerpc/kernel/swsusp.c
index 560c961..7cc81f0 100644
--- a/arch/powerpc/kernel/swsusp.c
+++ b/arch/powerpc/kernel/swsusp.c
@@ -34,6 +34,6 @@ void save_processor_state(void)
 void restore_processor_state(void)
 {
 #ifdef CONFIG_PPC32
-	switch_mmu_context(NULL, current->active_mm);
+	switch_mmu_context(current->active_mm, current->active_mm);
 #endif
 }
-- 
1.6.4
