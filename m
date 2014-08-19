Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EFF71A03C7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:00:07 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 1/6] powerpc: Move adb symbol exports next to function
 definitions
Date: Wed, 20 Aug 2014 08:00:00 +1000
Message-Id: <1408485605-10490-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/ppc_ksyms.c | 7 -------
 drivers/macintosh/adb.c         | 5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 48d17d6f..351f447 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -128,13 +128,6 @@ EXPORT_SYMBOL(smp_hw_index);
 #endif
 #endif
 
-#ifdef CONFIG_ADB
-EXPORT_SYMBOL(adb_request);
-EXPORT_SYMBOL(adb_register);
-EXPORT_SYMBOL(adb_unregister);
-EXPORT_SYMBOL(adb_poll);
-EXPORT_SYMBOL(adb_try_handler_change);
-#endif /* CONFIG_ADB */
 #ifdef CONFIG_ADB_CUDA
 EXPORT_SYMBOL(cuda_request);
 EXPORT_SYMBOL(cuda_poll);
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 9e9c567..226179b 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -411,6 +411,7 @@ adb_poll(void)
 		return;
 	adb_controller->poll();
 }
+EXPORT_SYMBOL(adb_poll);
 
 static void adb_sync_req_done(struct adb_request *req)
 {
@@ -460,6 +461,7 @@ adb_request(struct adb_request *req, void (*done)(struct adb_request *),
 
 	return rc;
 }
+EXPORT_SYMBOL(adb_request);
 
  /* Ultimately this should return the number of devices with
     the given default id.
@@ -495,6 +497,7 @@ adb_register(int default_id, int handler_id, struct adb_ids *ids,
 	mutex_unlock(&adb_handler_mutex);
 	return ids->nids;
 }
+EXPORT_SYMBOL(adb_register);
 
 int
 adb_unregister(int index)
@@ -516,6 +519,7 @@ adb_unregister(int index)
 	mutex_unlock(&adb_handler_mutex);
 	return ret;
 }
+EXPORT_SYMBOL(adb_unregister);
 
 void
 adb_input(unsigned char *buf, int nb, int autopoll)
@@ -582,6 +586,7 @@ adb_try_handler_change(int address, int new_id)
 	mutex_unlock(&adb_handler_mutex);
 	return ret;
 }
+EXPORT_SYMBOL(adb_try_handler_change);
 
 int
 adb_get_infos(int address, int *original_address, int *handler_id)
-- 
1.9.1
