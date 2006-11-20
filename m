Return-Path: <arnd@arndb.de>
Message-Id: <20061120180521.245775000@arndb.de>
References: <20061120174454.067872000@arndb.de>
Date: Mon, 20 Nov 2006 18:44:57 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH 03/22] spufs: Change %llx to 0x%llx.
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Dwayne Grant McConnell <decimal@us.ibm.com>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dwayne Grant McConnell <decimal@us.ibm.com>
This patches changes /npc, /decr, /decr_status, /spu_tag_mask, 
/event_mask, /event_status, and /srr0 files to provide output according to 
the format string "0x%llx" instead of "%llx".

Before this patch some files used "0x%llx" and other used "%llx" which is 
inconsistent and potentially confusing. A user might assume "%llx" numbers 
were decimal if they happened to not contain any a-f digits. This change 
will break any code cannot tolerate a leading 0x in the file contents. The 
only known users of these files are the libspe but there might also be 
some scripts which access these files. This risk is deemed acceptable for 
future consistency.

Signed-off-by: Dwayne Grant McConnell <decimal@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
Dwayne Grant McConnell <decimal@us.ibm.com>
Lotus Notes Mail: Dwayne McConnell [Mail]/Austin/IBM@IBMUS
Lotus Notes Calendar: Dwayne McConnell [Calendar]/Austin/IBM@IBMUS

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -1391,7 +1391,8 @@ static u64 spufs_npc_get(void *data)
 	spu_release(ctx);
 	return ret;
 }
-DEFINE_SIMPLE_ATTRIBUTE(spufs_npc_ops, spufs_npc_get, spufs_npc_set, "%llx\n")
+DEFINE_SIMPLE_ATTRIBUTE(spufs_npc_ops, spufs_npc_get, spufs_npc_set,
+			"0x%llx\n")
 
 static void spufs_decr_set(void *data, u64 val)
 {
@@ -1413,7 +1414,7 @@ static u64 spufs_decr_get(void *data)
 	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_decr_ops, spufs_decr_get, spufs_decr_set,
-			"%llx\n")
+			"0x%llx\n")
 
 static void spufs_decr_status_set(void *data, u64 val)
 {
@@ -1435,7 +1436,7 @@ static u64 spufs_decr_status_get(void *d
 	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_decr_status_ops, spufs_decr_status_get,
-			spufs_decr_status_set, "%llx\n")
+			spufs_decr_status_set, "0x%llx\n")
 
 static void spufs_spu_tag_mask_set(void *data, u64 val)
 {
@@ -1457,7 +1458,7 @@ static u64 spufs_spu_tag_mask_get(void *
 	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_spu_tag_mask_ops, spufs_spu_tag_mask_get,
-			spufs_spu_tag_mask_set, "%llx\n")
+			spufs_spu_tag_mask_set, "0x%llx\n")
 
 static void spufs_event_mask_set(void *data, u64 val)
 {
@@ -1479,7 +1480,7 @@ static u64 spufs_event_mask_get(void *da
 	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_event_mask_ops, spufs_event_mask_get,
-			spufs_event_mask_set, "%llx\n")
+			spufs_event_mask_set, "0x%llx\n")
 
 static void spufs_srr0_set(void *data, u64 val)
 {
@@ -1501,7 +1502,7 @@ static u64 spufs_srr0_get(void *data)
 	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_srr0_ops, spufs_srr0_get, spufs_srr0_set,
-			"%llx\n")
+			"0x%llx\n")
 
 static u64 spufs_id_get(void *data)
 {

--
