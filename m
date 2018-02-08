Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zcXgc13NFzF10W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 20:18:51 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id g18-v6so1771061plo.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Feb 2018 01:18:51 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/vas: do not set uses_vas for kernel windows
Date: Thu,  8 Feb 2018 19:18:38 +1000
Message-Id: <20180208091838.27992-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cp_abort is only required or user windows, because kernel context
must not be preempted between a copy/paste pair.

Without this patch, the init task gets used_vas set when it runs
the nx842_powernv_init initcall, which opens windows for kernel
usage.

used_vas is then never cleared anywhere, so it gets propagated
into all other tasks. It's a property of the address space, so it
should really be cleared when a new mm is created (or in dup_mmap
if the mmaps are marked as VM_DONTCOPY). For now we seem to have
no such driver, so leave that for another patch.

Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/vas-window.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 2b3eb01ab110..b7c53a51c31b 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -1063,16 +1063,16 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 			rc = PTR_ERR(txwin->paste_kaddr);
 			goto free_window;
 		}
+	} else {
+		/*
+		 * A user mapping must ensure that context switch issues
+		 * CP_ABORT for this thread.
+		 */
+		rc = set_thread_uses_vas();
+		if (rc)
+			goto free_window;
 	}
 
-	/*
-	 * Now that we have a send window, ensure context switch issues
-	 * CP_ABORT for this thread.
-	 */
-	rc = -EINVAL;
-	if (set_thread_uses_vas() < 0)
-		goto free_window;
-
 	set_vinst_win(vinst, txwin);
 
 	return txwin;
-- 
2.15.1
