Return-Path: <dgibson@ozlabs.org>
Date: Thu, 28 Feb 2008 20:58:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Use for_each_marker_of_type in asm_emit_data()
Message-ID: <20080228095828.GO24330@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For no good reason, asm_emit_data() open-codes the equivalent of the
for_each_marker_of_type macro.  Use the macro instead.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 flattree.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2008-02-28 20:53:51.000000000 +1100
+++ dtc/flattree.c	2008-02-28 20:56:56.000000000 +1100
@@ -162,14 +162,10 @@
 {
 	FILE *f = e;
 	int off = 0;
-	struct marker *m;
+	struct marker *m = d.markers;
 
-	m = d.markers;
-	while (m) {
-		if (m->type == LABEL)
-			emit_offset_label(f, m->ref, m->offset);
-		m = m->next;
-	}
+	for_each_marker_of_type(m, LABEL)
+		emit_offset_label(f, m->ref, m->offset);
 
 	while ((d.len - off) >= sizeof(u32)) {
 		fprintf(f, "\t.long\t0x%x\n",

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
