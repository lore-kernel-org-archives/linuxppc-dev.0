Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail79-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 158BA67CC0
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 15:20:04 +1100 (EST)
Message-ID: <4563CFED.1020508@am.sony.com>
Date: Tue, 21 Nov 2006 20:19:57 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/14] cell: spu management xmon routines
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

This fixes the xmon support for the cell spu to be compatable with the split
spu platform code.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Acked-by: Michael Ellerman <michael@ellerman.id.au>

---
 arch/powerpc/xmon/xmon.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)

Index: cell--common--6/arch/powerpc/xmon/xmon.c
===================================================================
--- cell--common--6.orig/arch/powerpc/xmon/xmon.c
+++ cell--common--6/arch/powerpc/xmon/xmon.c
@@ -2771,8 +2771,6 @@
 
 	DUMP_FIELD(spu, "0x%x", number);
 	DUMP_FIELD(spu, "%s", name);
-	DUMP_FIELD(spu, "%s", devnode->full_name);
-	DUMP_FIELD(spu, "0x%x", nid);
 	DUMP_FIELD(spu, "0x%lx", local_store_phys);
 	DUMP_FIELD(spu, "0x%p", local_store);
 	DUMP_FIELD(spu, "0x%lx", ls_size);
@@ -2796,12 +2794,8 @@
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
