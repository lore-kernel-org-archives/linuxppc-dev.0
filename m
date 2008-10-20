Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6CC4DDDF3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 10:13:45 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m9KNDesC005030
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 18:13:41 -0500
Subject: [Fwd: [PATCH] fix WARN() for PPC]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 10:13:38 +1100
Message-Id: <1224544418.7654.182.camel@pasglop>
Mime-Version: 1.0
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-------- Forwarded Message --------
From: Arjan van de Ven <arjan@infradead.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, johannes@sipsolutions.net,
davem@davemloft.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] fix WARN() for PPC
Date: Mon, 20 Oct 2008 14:50:56 -0700

From: Arjan van de Ven <arjan@linux.intel.com>
Date: Mon, 20 Oct 2008 14:41:03 -0700
Subject: [PATCH] fix WARN() for PPC

powerpc doesn't use the generic WARN_ON infrastructure. The newly introduced WARN()
as a result didn't print the message, this patch adds the printk for this specific case.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/asm-generic/bug.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 0f6dabd..12c07c1 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -41,7 +41,7 @@ extern void warn_slowpath(const char *file, const int line,
 #define __WARN() warn_on_slowpath(__FILE__, __LINE__)
 #define __WARN_printf(arg...) warn_slowpath(__FILE__, __LINE__, arg)
 #else
-#define __WARN_printf(arg...) __WARN()
+#define __WARN_printf(arg...) do { printk(arg); __WARN(); } while (0)
 #endif
 
 #ifndef WARN_ON
-- 
1.5.5.1
