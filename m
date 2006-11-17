Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id E48D467D5F
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 14:42:26 +1100 (EST)
Received: from mail7.sony.co.jp (localhost [127.0.0.1])
	by mail7.sony.co.jp (R8/Sony) with ESMTP id kAH3gOmD016287
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:42:24 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail7.sony.co.jp (R8/Sony) with SMTP id kAH3gO0l016273
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:42:24 +0900 (JST)
Message-ID: <455D2F9A.7050603@am.sony.com>
Date: Thu, 16 Nov 2006 19:42:18 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/16] cell: spu management xmon routines
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes the xmon support to be compatable with the
split spu platform code.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

Michael,

I split this out so we can discuss it if needed.

-Geoff

 arch/powerpc/xmon/xmon.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

Index: cell--common--6/arch/powerpc/xmon/xmon.c
===================================================================
--- cell--common--6.orig/arch/powerpc/xmon/xmon.c
+++ cell--common--6/arch/powerpc/xmon/xmon.c
@@ -2769,8 +2769,6 @@
 
 	DUMP_FIELD(spu, "0x%x", number);
 	DUMP_FIELD(spu, "%s", name);
-	DUMP_FIELD(spu, "%s", devnode->full_name);
-	DUMP_FIELD(spu, "0x%x", nid);
 	DUMP_FIELD(spu, "0x%lx", local_store_phys);
 	DUMP_FIELD(spu, "0x%p", local_store);
 	DUMP_FIELD(spu, "0x%lx", ls_size);
@@ -2794,12 +2792,8 @@
 	DUMP_FIELD(spu, "0x%x", problem->spu_runcntl_RW);
 	DUMP_FIELD(spu, "0x%x", problem->spu_status_R);
 	DUMP_FIELD(spu, "0x%x", problem->spu_npc_RW);
-	DUMP_FIELD(spu, "0x%p", priv1);
-
-	if (spu->priv1)
-		DUMP_FIELD(spu, "0x%lx", priv1->mfc_sr1_RW);
-
 	DUMP_FIELD(spu, "0x%p", priv2);
+	DUMP_FIELD(spu, "0x%p", pdata);
 }
 
 static int do_spu_cmd(void)
