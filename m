Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 22 Nov 2006 18:58:04 +1100
Subject: [PATCH] cell: spu management xmon routines
In-Reply-To: <4563CFED.1020508@am.sony.com>
Message-Id: <20061122075809.4C41467CAE@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
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
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

Fixed to work on top of the changes I sent recently to fixup
sparse warnings in xmon.

---

 arch/powerpc/xmon/xmon.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

Index: cell/arch/powerpc/xmon/xmon.c
===================================================================
--- cell.orig/arch/powerpc/xmon/xmon.c
+++ cell/arch/powerpc/xmon/xmon.c
@@ -2787,8 +2787,6 @@ static void dump_spu_fields(struct spu *
 
 	DUMP_FIELD(spu, "0x%x", number);
 	DUMP_FIELD(spu, "%s", name);
-	DUMP_FIELD(spu, "%s", devnode->full_name);
-	DUMP_FIELD(spu, "0x%x", nid);
 	DUMP_FIELD(spu, "0x%lx", local_store_phys);
 	DUMP_FIELD(spu, "0x%p", local_store);
 	DUMP_FIELD(spu, "0x%lx", ls_size);
@@ -2815,14 +2813,8 @@ static void dump_spu_fields(struct spu *
 			in_be32(&spu->problem->spu_status_R));
 	DUMP_VALUE("0x%x", problem->spu_npc_RW,
 			in_be32(&spu->problem->spu_npc_RW));
-	DUMP_FIELD(spu, "0x%p", priv1);
-
-	if (spu->priv1) {
-		DUMP_VALUE("0x%lx", priv1->mfc_sr1_RW,
-				in_be64(&spu->priv1->mfc_sr1_RW));
-	}
-
 	DUMP_FIELD(spu, "0x%p", priv2);
+	DUMP_FIELD(spu, "0x%p", pdata);
 }
 
 int
