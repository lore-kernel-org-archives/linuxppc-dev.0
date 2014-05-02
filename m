Return-Path: <anton@samba.org>
Date: Fri, 2 May 2014 10:44:18 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/2] powerpc: Move adb symbol exports next to function
 definitions
Message-ID: <20140502104418.4cee8f15@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Index: b/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
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
Index: b/drivers/macintosh/adb.c
===================================================================
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -411,6 +411,7 @@ adb_poll(void)
 		return;
 	adb_controller->poll();
 }
+EXPORT_SYMBOL(adb_poll);
 
 static void adb_sync_req_done(struct adb_request *req)
 {
@@ -460,6 +461,7 @@ adb_request(struct adb_request *req, voi
 
 	return rc;
 }
+EXPORT_SYMBOL(adb_request);
 
  /* Ultimately this should return the number of devices with
     the given default id.
@@ -495,6 +497,7 @@ adb_register(int default_id, int handler
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
@@ -582,6 +586,7 @@ adb_try_handler_change(int address, int
 	mutex_unlock(&adb_handler_mutex);
 	return ret;
 }
+EXPORT_SYMBOL(adb_try_handler_change);
 
 int
 adb_get_infos(int address, int *original_address, int *handler_id)
