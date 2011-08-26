Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.tip.net.au [IPv6:2402:b800:7003:1::44])
	by ozlabs.org (Postfix) with ESMTP id 43176B6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 11:26:46 +1000 (EST)
Date: Fri, 26 Aug 2011 11:26:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Gibson <dwg@au1.ibm.com>, jdl@jdl.com
Subject: [PATCH] dtc: remove some warnings
Message-Id: <20110826112643.f86132d55edc5d452df3ebd0@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: John Bonesio <bones@secretlab.ca>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I assume that these variables were used in the past but not removed when
their usage was removed.

Fixes these warnings:

scripts/dtc/dtc.c: In function 'main':
scripts/dtc/dtc.c:102:17: warning: variable 'check' set but not used [-Wunused-but-set-variable]
scripts/dtc/flattree.c: In function 'flat_read_mem_reserve':
scripts/dtc/flattree.c:700:14: warning: variable 'p' set but not used [-Wunused-but-set-variable]

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 scripts/dtc/dtc.c      |    5 +----
 scripts/dtc/flattree.c |    2 --
 2 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/scripts/dtc/dtc.c b/scripts/dtc/dtc.c
index cbc0193..fc83355 100644
--- a/scripts/dtc/dtc.c
+++ b/scripts/dtc/dtc.c
@@ -99,7 +99,7 @@ int main(int argc, char *argv[])
 	const char *inform = "dts";
 	const char *outform = "dts";
 	const char *outname = "-";
-	int force = 0, check = 0, sort = 0;
+	int force = 0, sort = 0;
 	const char *arg;
 	int opt;
 	FILE *outf = NULL;
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
diff --git a/scripts/dtc/flattree.c b/scripts/dtc/flattree.c
index ead0332..28d0b23 100644
--- a/scripts/dtc/flattree.c
+++ b/scripts/dtc/flattree.c
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
-- 
1.7.5.4

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
