Return-Path: <clg@fr.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5FEA3140120
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:23:57 +1000 (EST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 24 Apr 2014 08:23:53 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id B37A01B08051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 08:23:56 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7NpCY60489890
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 07:23:51 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O8NoeM010700
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 02:23:50 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 07/15] powerpc/boot: define typedef ihandle as u32
Date: Thu, 24 Apr 2014 09:23:31 +0200
Message-Id: <1398324219-8919-8-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1398324219-8919-1-git-send-email-clg@fr.ibm.com>
References: <1398324219-8919-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1395651884.30488.10.camel@pasglop>
References: <1395651884.30488.10.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes ihandle 64bit friendly.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/boot/of.h    |    2 +-
 arch/powerpc/boot/oflib.c |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/of.h b/arch/powerpc/boot/of.h
index 504a0a31b685..e1ef620082f7 100644
--- a/arch/powerpc/boot/of.h
+++ b/arch/powerpc/boot/of.h
@@ -2,7 +2,7 @@
 #define _PPC_BOOT_OF_H_
 
 typedef void *phandle;
-typedef void *ihandle;
+typedef u32 ihandle;
 
 void of_init(void *promptr);
 int of_call_prom(const char *service, int nargs, int nret, ...);
diff --git a/arch/powerpc/boot/oflib.c b/arch/powerpc/boot/oflib.c
index 329437d0e943..956443fb9f65 100644
--- a/arch/powerpc/boot/oflib.c
+++ b/arch/powerpc/boot/oflib.c
@@ -106,7 +106,7 @@ static int string_match(const char *s1, const char *s2)
  */
 static int need_map = -1;
 static ihandle chosen_mmu;
-static phandle memory;
+static ihandle memory;
 
 static int check_of_version(void)
 {
@@ -135,10 +135,10 @@ static int check_of_version(void)
 		printf("no mmu\n");
 		return 0;
 	}
-	memory = (ihandle) of_call_prom("open", 1, 1, "/memory");
-	if (memory == (ihandle) -1) {
-		memory = (ihandle) of_call_prom("open", 1, 1, "/memory@0");
-		if (memory == (ihandle) -1) {
+	memory = of_call_prom("open", 1, 1, "/memory");
+	if (memory == PROM_ERROR) {
+		memory = of_call_prom("open", 1, 1, "/memory@0");
+		if (memory == PROM_ERROR) {
 			printf("no memory node\n");
 			return 0;
 		}
-- 
1.7.10.4
