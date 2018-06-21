Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BZxx2GKKzF0wq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 07:45:41 +1000 (AEST)
From: Matthew Wilcox <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/26] ppc: Convert vas ID allocation to new IDA API
Date: Thu, 21 Jun 2018 14:28:24 -0700
Message-Id: <20180621212835.5636-16-willy@infradead.org>
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Removes a custom spinlock and simplifies the code.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 arch/powerpc/platforms/powernv/vas-window.c | 26 ++++-----------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index ff9f48812331..2a5e68a2664d 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -515,35 +515,17 @@ int init_winctx_regs(struct vas_window *window, struct vas_winctx *winctx)
 	return 0;
 }
 
-static DEFINE_SPINLOCK(vas_ida_lock);
-
 static void vas_release_window_id(struct ida *ida, int winid)
 {
-	spin_lock(&vas_ida_lock);
-	ida_remove(ida, winid);
-	spin_unlock(&vas_ida_lock);
+	ida_free(ida, winid);
 }
 
 static int vas_assign_window_id(struct ida *ida)
 {
-	int rc, winid;
-
-	do {
-		rc = ida_pre_get(ida, GFP_KERNEL);
-		if (!rc)
-			return -EAGAIN;
-
-		spin_lock(&vas_ida_lock);
-		rc = ida_get_new(ida, &winid);
-		spin_unlock(&vas_ida_lock);
-	} while (rc == -EAGAIN);
-
-	if (rc)
-		return rc;
+	int winid = ida_alloc_max(ida, VAX_WINDOWS_PER_CHIP, GFP_KERNEL);
 
-	if (winid > VAS_WINDOWS_PER_CHIP) {
-		pr_err("Too many (%d) open windows\n", winid);
-		vas_release_window_id(ida, winid);
+	if (winid == -ENOSPC) {
+		pr_err("Too many (%d) open windows\n", VAX_WINDOWS_PER_CHIP);
 		return -EAGAIN;
 	}
 
-- 
2.17.1
