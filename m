Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40t98Z3sQ9zDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2018 14:27:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: greg@kroah.com
Cc: stable@vger.kernel.org,
	tglx@linutronix.de,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.14 v2 04/23] powerpc/rfi-flush: Move the logic to
 avoid a redo into the debugfs code
Date: Sat, 26 May 2018 14:27:30 +1000
Message-Id: <20180526042749.5324-5-mpe@ellerman.id.au>
In-Reply-To: <20180526042749.5324-1-mpe@ellerman.id.au>
References: <20180526042749.5324-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 1e2a9fc7496955faacbbed49461d611b704a7505 upstream.

rfi_flush_enable() includes a check to see if we're already
enabled (or disabled), and in that case does nothing.

But that means calling setup_rfi_flush() a 2nd time doesn't actually
work, which is a bit confusing.

Move that check into the debugfs code, where it really belongs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 333c64a794eb..cbb3fb1820ce 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -822,9 +822,6 @@ static void do_nothing(void *unused)
 
 void rfi_flush_enable(bool enable)
 {
-	if (rfi_flush == enable)
-		return;
-
 	if (enable) {
 		do_rfi_flush_fixups(enabled_flush_types);
 		on_each_cpu(do_nothing, NULL, 1);
@@ -878,13 +875,19 @@ void __init setup_rfi_flush(enum l1d_flush_type types, bool enable)
 #ifdef CONFIG_DEBUG_FS
 static int rfi_flush_set(void *data, u64 val)
 {
+	bool enable;
+
 	if (val == 1)
-		rfi_flush_enable(true);
+		enable = true;
 	else if (val == 0)
-		rfi_flush_enable(false);
+		enable = false;
 	else
 		return -EINVAL;
 
+	/* Only do anything if we're changing state */
+	if (enable != rfi_flush)
+		rfi_flush_enable(enable);
+
 	return 0;
 }
 
-- 
2.14.1
