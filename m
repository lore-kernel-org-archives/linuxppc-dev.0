Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Nov 2007 11:17:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: [3/3] dtc: -Odts produces v1 output
Message-ID: <20071107001737.GD553@localhost.localdomain>
References: <20071107001303.GA553@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071107001303.GA553@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch alters the -Odts mode output so that it uses dts-v1 format.
This means that dtc -Idts -Odts used on a v0 dts file will convert
that file to v1.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 treesource.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: dtc/treesource.c
===================================================================
--- dtc.orig/treesource.c	2007-11-07 11:16:45.000000000 +1100
+++ dtc/treesource.c	2007-11-07 11:16:55.000000000 +1100
@@ -141,7 +141,7 @@
 			l = l->next;
 		}
 
-		fprintf(f, "%x", be32_to_cpu(*cp++));
+		fprintf(f, "0x%x", be32_to_cpu(*cp++));
 		if ((void *)cp >= propend)
 			break;
 		fprintf(f, " ");
@@ -258,12 +258,14 @@
 {
 	struct reserve_info *re;
 
+	fprintf(f, "/dts-v1/;\n\n");
+
 	for (re = bi->reservelist; re; re = re->next) {
 		if (re->label)
 			fprintf(f, "%s: ", re->label);
-		fprintf(f, "/memreserve/\t%016llx-%016llx;\n",
+		fprintf(f, "/memreserve/\t0x%016llx 0x%016llx;\n",
 			(unsigned long long)re->re.address,
-			(unsigned long long)(re->re.address + re->re.size - 1));
+			(unsigned long long)re->re.size);
 	}
 
 	write_tree_source_node(f, bi->dt, 0);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
