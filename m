Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D874DDF39
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 03:35:58 +1100 (EST)
Date: Tue, 4 Dec 2007 10:33:20 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
Subject: [FDT][PATCH] Print out the total size as part of ftdump
Message-ID: <Pine.LNX.4.64.0712041032580.29317@blarg.am.freescale.net>
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

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 ftdump.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/ftdump.c b/ftdump.c
index 577c2cf..53343d7 100644
--- a/ftdump.c
+++ b/ftdump.c
@@ -87,6 +87,7 @@ static void dump_blob(void *blob)
 	char *p_struct = blob + be32_to_cpu(bph->off_dt_struct);
 	char *p_strings = blob + be32_to_cpu(bph->off_dt_strings);
 	uint32_t version = be32_to_cpu(bph->version);
+	uint32_t totalsize = be32_to_cpu(bph->totalsize);
 	uint32_t tag;
 	char *p;
 	char *s, *t;
@@ -98,6 +99,7 @@ static void dump_blob(void *blob)
 	shift = 4;

 	printf("// Version 0x%x tree\n", version);
+	printf("// Totalsize 0x%x(%d)\n", totalsize, totalsize);
 	for (i = 0; ; i++) {
 		addr = be64_to_cpu(p_rsvmap[i].address);
 		size = be64_to_cpu(p_rsvmap[i].size);
-- 
1.5.3.4
