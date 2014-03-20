Return-Path: <clg@fr.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 690E52C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 02:10:46 +1100 (EST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 20 Mar 2014 15:10:41 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id C7BBB219005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:33 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2KFARQo4260260
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:27 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2KFAcsY020468
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 09:10:38 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 03/18] powerpc/boot: use prom_arg_t in oflib
Date: Thu, 20 Mar 2014 16:09:58 +0100
Message-Id: <1395328213-19206-4-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1395328213-19206-1-git-send-email-clg@fr.ibm.com>
References: <1395328213-19206-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1391788771-16405-1-git-send-email-clg@fr.ibm.com>
References: <1391788771-16405-1-git-send-email-clg@fr.ibm.com>
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

This patch updates the wrapper code to converge with the kernel code in
prom_init.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/boot/oflib.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/oflib.c b/arch/powerpc/boot/oflib.c
index c3288a3446b3..3b0c9458504f 100644
--- a/arch/powerpc/boot/oflib.c
+++ b/arch/powerpc/boot/oflib.c
@@ -16,6 +16,8 @@
 
 #include "of.h"
 
+typedef u32 prom_arg_t;
+
 /* The following structure is used to communicate with open firmware.
  * All arguments in and out are in big endian format. */
 struct prom_args {
@@ -46,7 +48,7 @@ int of_call_prom(const char *service, int nargs, int nret, ...)
 
 	va_start(list, nret);
 	for (i = 0; i < nargs; i++)
-		args.args[i] = va_arg(list, unsigned int);
+		args.args[i] = va_arg(list, prom_arg_t);
 	va_end(list);
 
 	for (i = 0; i < nret; i++)
@@ -59,7 +61,7 @@ int of_call_prom(const char *service, int nargs, int nret, ...)
 }
 
 static int of_call_prom_ret(const char *service, int nargs, int nret,
-			    unsigned int *rets, ...)
+			    prom_arg_t *rets, ...)
 {
 	int i;
 	struct prom_args args;
@@ -71,7 +73,7 @@ static int of_call_prom_ret(const char *service, int nargs, int nret,
 
 	va_start(list, rets);
 	for (i = 0; i < nargs; i++)
-		args.args[i] = va_arg(list, unsigned int);
+		args.args[i] = va_arg(list, prom_arg_t);
 	va_end(list);
 
 	for (i = 0; i < nret; i++)
@@ -148,7 +150,7 @@ static int check_of_version(void)
 void *of_claim(unsigned long virt, unsigned long size, unsigned long align)
 {
 	int ret;
-	unsigned int result;
+	prom_arg_t result;
 
 	if (need_map < 0)
 		need_map = check_of_version();
-- 
1.7.10.4
