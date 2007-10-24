Return-Path: <michael@ozlabs.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <2576ec47fb43bd1f4464beb8b78adfa70bdde418.1193199877.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Use of_get_next_child() in k2_sata_proc_info()
Date: Wed, 24 Oct 2007 14:25:16 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

k2_sata_proc_info() uses its own hand-rolled loop to check a nodes
children for a property, this is not safe WRT refcounting, so fix it
to use of_get_next_child().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/ata/sata_svw.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 12d613c..64c3812 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -289,7 +289,10 @@ static int k2_sata_proc_info(struct Scsi_Host *shost, char *page, char **start,
 
 	/* Match it to a port node */
 	index = (ap == ap->host->ports[0]) ? 0 : 1;
-	for (np = np->child; np != NULL; np = np->sibling) {
+
+	for (np = of_get_next_child(np, NULL);
+	     np != NULL;
+	     np = of_get_next_child(np, np)) {
 		const u32 *reg = of_get_property(np, "reg", NULL);
 		if (!reg)
 			continue;
-- 
1.5.1.3.g7a33b
