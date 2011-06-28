Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A3AAB6F5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 23:43:14 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5SDSXRs013911
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 07:28:33 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p5SDguFs135932
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 07:42:56 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5SDgslG026947
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 07:42:55 -0600
Date: Tue, 28 Jun 2011 09:42:53 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: jdl@jdl.com, david@gibson.dropbear.id.au
Subject: [PATCH] dtc: Remove unused variable in flat_read_mem_reserve
Message-ID: <20110628134253.GD10237@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The *p variable is declared and used to save inb->ptr, however p is
later never used.  This has been the case since commit 6c0f3676 and can
lead to build failures with -Werror=unused-but-set-variable:

	flattree.c: In function 'flat_read_mem_reserve':
	flattree.c:700:14: error: variable 'p' set but not used [-Werror=unused-but-set-variable]
	cc1: all warnings being treated as errors
	make: *** [flattree.o] Error 1

Remove the variable.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---

diff --git a/dtc.c b/dtc.c
index cbc0193..15d2fc2 100644
--- a/dtc.c
+++ b/dtc.c
@@ -99,7 +99,7 @@ int main(int argc, char *argv[])
 	const char *inform = "dts";
 	const char *outform = "dts";
 	const char *outname = "-";
-	int force = 0, check = 0, sort = 0;
+	int force = 0, sort = 0;
 	const char *arg;
 	int opt;
 	FILE *outf = NULL;
@@ -111,7 +111,7 @@ int main(int argc, char *argv[])
 	minsize    = 0;
 	padsize    = 0;
 
-	while ((opt = getopt(argc, argv, "hI:O:o:V:R:S:p:fcqb:vH:s")) != EOF) {
+	while ((opt = getopt(argc, argv, "hI:O:o:V:R:S:p:fqb:vH:s")) != EOF) {
 		switch (opt) {
 		case 'I':
 			inform = optarg;
@@ -137,9 +137,6 @@ int main(int argc, char *argv[])
 		case 'f':
 			force = 1;
 			break;
-		case 'c':
-			check = 1;
-			break;
 		case 'q':
 			quiet++;
 			break;
diff --git a/flattree.c b/flattree.c
index ead0332..28d0b23 100644
--- a/flattree.c
+++ b/flattree.c
@@ -697,7 +697,6 @@ static struct reserve_info *flat_read_mem_reserve(struct inbuf *inb)
 {
 	struct reserve_info *reservelist = NULL;
 	struct reserve_info *new;
-	const char *p;
 	struct fdt_reserve_entry re;
 
 	/*
@@ -706,7 +705,6 @@ static struct reserve_info *flat_read_mem_reserve(struct inbuf *inb)
 	 *
 	 * First pass, count entries.
 	 */
-	p = inb->ptr;
 	while (1) {
 		flat_read_chunk(inb, &re, sizeof(re));
 		re.address  = fdt64_to_cpu(re.address);
