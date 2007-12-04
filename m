Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2FA07DDE42
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 10:37:50 +1100 (EST)
Date: Tue, 4 Dec 2007 17:36:08 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
Subject: [FDT][PATCH] Fix padding options
Message-ID: <Pine.LNX.4.64.0712041734580.1979@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"Add an option to pad the blob that is generated" broke the padding
support.  We were updating the fdt header after writing it.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Better commit message for this, since my commit ID is different.

 flattree.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/flattree.c b/flattree.c
index c860b63..eb9c82c 100644
--- a/flattree.c
+++ b/flattree.c
@@ -399,6 +399,12 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
 	if (padsize > 0)
 		padlen = padsize;

+	if (padlen > 0) {
+		int tsize = be32_to_cpu(fdt.totalsize);
+		tsize += padlen;
+		fdt.totalsize = cpu_to_be32(tsize);
+	}
+
 	/*
 	 * Assemble the blob: start with the header, add with alignment
 	 * the reserve buffer, add the reserve map terminating zeroes,
@@ -414,12 +420,8 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
 	/*
 	 * If the user asked for more space than is used, pad out the blob.
 	 */
-	if (padlen > 0) {
-		int tsize = be32_to_cpu(fdt.totalsize);
-		tsize += padlen;
+	if (padlen > 0)
 		blob = data_append_zeroes(blob, padlen);
-		fdt.totalsize = cpu_to_be32(tsize);
-	}

 	fwrite(blob.val, blob.len, 1, f);

-- 
1.5.3.4
