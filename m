Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB95167A41
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 11:30:26 +1100 (EST)
Date: Mon, 27 Mar 2006 18:29:33 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'misc' branch of powerpc
Message-ID: <Pine.LNX.4.44.0603271829080.31631-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'misc' branch of
master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git

to receive the following updates:

 arch/powerpc/kernel/prom.c |   14 +-------------
 arch/ppc/lib/strcase.c     |    2 +-
 2 files changed, 2 insertions(+), 14 deletions(-)

Kumar Gala:
      ppc: fix strncasecmp prototype
      powerpc: use memparse() for mem= command line parsing

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 5a24415..95d15eb 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1030,25 +1030,13 @@ static int __init early_init_dt_scan_cho
 
 	if (strstr(cmd_line, "mem=")) {
 		char *p, *q;
-		unsigned long maxmem = 0;
 
 		for (q = cmd_line; (p = strstr(q, "mem=")) != 0; ) {
 			q = p + 4;
 			if (p > cmd_line && p[-1] != ' ')
 				continue;
-			maxmem = simple_strtoul(q, &q, 0);
-			if (*q == 'k' || *q == 'K') {
-				maxmem <<= 10;
-				++q;
-			} else if (*q == 'm' || *q == 'M') {
-				maxmem <<= 20;
-				++q;
-			} else if (*q == 'g' || *q == 'G') {
-				maxmem <<= 30;
-				++q;
-			}
+			memory_limit = memparse(q, &q);
 		}
-		memory_limit = maxmem;
 	}
 
 	/* break now */
diff --git a/arch/ppc/lib/strcase.c b/arch/ppc/lib/strcase.c
index 36b5210..d988578 100644
--- a/arch/ppc/lib/strcase.c
+++ b/arch/ppc/lib/strcase.c
@@ -11,7 +11,7 @@ int strcasecmp(const char *s1, const cha
 	return c1 - c2;
 }
 
-int strncasecmp(const char *s1, const char *s2, int n)
+int strncasecmp(const char *s1, const char *s2, size_t n)
 {
 	int c1, c2;
 
