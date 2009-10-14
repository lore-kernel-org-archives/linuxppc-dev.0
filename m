Return-Path: <roel.kluin@gmail.com>
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com
	[209.85.219.214]) by ozlabs.org (Postfix) with ESMTP id 262EBB7B74
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 23:02:52 +1100 (EST)
Received: by ewy10 with SMTP id 10so11160382ewy.9
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 05:02:50 -0700 (PDT)
Message-ID: <4AD5C01E.8000600@gmail.com>
Date: Wed, 14 Oct 2009 14:12:14 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: paulus@samba.org, benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Prevent unsigned wrap in htab_dt_scan_page_sizes()
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check to prevent unsigned wrap of size before subtraction.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Is this maybe better or are we certain that size can't wrap?

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 1ade7eb..dd2d263 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -287,7 +287,7 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 		DBG("Page sizes from device-tree:\n");
 		size /= 4;
 		cur_cpu_spec->cpu_features &= ~(CPU_FTR_16M_PAGE);
-		while(size > 0) {
+		while(size >= 3) {
 			unsigned int shift = prop[0];
 			unsigned int slbenc = prop[1];
 			unsigned int lpnum = prop[2];
@@ -296,7 +296,7 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 			int idx = -1;
 
 			size -= 3; prop += 3;
-			while(size > 0 && lpnum) {
+			while(size >= 2 && lpnum) {
 				if (prop[0] == shift)
 					lpenc = prop[1];
 				prop += 2; size -= 2;
