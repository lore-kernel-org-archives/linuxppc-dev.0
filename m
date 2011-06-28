Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA008B6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 00:22:05 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5SDvsKg026627
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 09:57:54 -0400
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5SE6dIl157026
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 10:22:01 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5SCl3Ik026535
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 06:47:03 -0600
Date: Tue, 28 Jun 2011 08:47:09 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] dtc: Remove unused check variable
Message-ID: <20110628124709.GC10237@zod.rchland.ibm.com>
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

Commit 376ab6f2 removed the old style check functionality from DTC,
however the check option and variable were not removed.  This leads to
build failures when -Werror=unused-but-set-variable is specified:

	dtc.c: In function 'main':
	dtc.c:102:17: error: variable 'check' set but not used [-Werror=unused-but-set-variable]
	cc1: all warnings being treated as errors
	make: *** [dtc.o] Error 1
	make: *** Waiting for unfinished jobs....

Remove the check variable.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---

t a/dtc.c b/dtc.c
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
