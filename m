Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 18/20] [powerpc,sata_svw] Constify & voidify get_property()
Message-ID: 1151993427.2210.19@pokey
Date: Tue,  4 Jul 2006 16:47:17 +1000 (EST)
Cc: linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that get_property() returns a void *, there's no need to cast its
return value. Also, treat the return value as const, so we can
constify get_property later.

sata_svw changes

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 sata_svw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/scsi/sata_svw.c
===================================================================
--- linux-2.6.orig/drivers/scsi/sata_svw.c
+++ linux-2.6/drivers/scsi/sata_svw.c
@@ -268,7 +268,7 @@ static int k2_sata_proc_info(struct Scsi
 	/* Match it to a port node */
 	index = (ap == ap->host_set->ports[0]) ? 0 : 1;
 	for (np = np->child; np != NULL; np = np->sibling) {
-		u32 *reg = (u32 *)get_property(np, "reg", NULL);
+		const u32 *reg = get_property(np, "reg", NULL);
 		if (!reg)
 			continue;
 		if (index == *reg)
