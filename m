Return-Path: <clg@fr.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0D1982C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 02:59:49 +1100 (EST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 7 Feb 2014 15:59:46 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id B09541B08061
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 15:59:15 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s17FxVfh56885268
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 15:59:31 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s17Gxhxb009119
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 09:59:43 -0700
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [RFC PATCH 02/18] powerpc/boot: use a common prom_args struct in oflib
Date: Fri,  7 Feb 2014 16:59:15 +0100
Message-Id: <1391788771-16405-3-git-send-email-clg@fr.ibm.com>
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

This patch fixes warnings when the wrapper is compiled in 64bit and
updates the boot wrapper code related to prom to converge with the
kernel code in prom_init. This should make the review of changes easier.

The kernel has a different number of possible arguments (10) when
entering prom. There does not seem to be any good reason to have
12 in the wrapper, so the patch changes this value to args[10] in
the prom_args struct.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/boot/of.h    |    2 ++
 arch/powerpc/boot/oflib.c |   29 +++++++++++++++--------------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/boot/of.h b/arch/powerpc/boot/of.h
index e4c68f7391c5..5da03d9b9463 100644
--- a/arch/powerpc/boot/of.h
+++ b/arch/powerpc/boot/of.h
@@ -18,4 +18,6 @@ int of_setprop(const void *phandle, const char *name, const void *buf,
 /* Console functions */
 void of_console_init(void);
 
+typedef u32			__be32;
+
 #endif /* _PPC_BOOT_OF_H_ */
diff --git a/arch/powerpc/boot/oflib.c b/arch/powerpc/boot/oflib.c
index b0ec9cf3eaaf..c3288a3446b3 100644
--- a/arch/powerpc/boot/oflib.c
+++ b/arch/powerpc/boot/oflib.c
@@ -16,6 +16,15 @@
 
 #include "of.h"
 
+/* The following structure is used to communicate with open firmware.
+ * All arguments in and out are in big endian format. */
+struct prom_args {
+	__be32 service;	/* Address of service name string. */
+	__be32 nargs;	/* Number of input arguments. */
+	__be32 nret;	/* Number of output arguments. */
+	__be32 args[10];	/* Input/output arguments. */
+};
+
 static int (*prom) (void *);
 
 void of_init(void *promptr)
@@ -23,18 +32,15 @@ void of_init(void *promptr)
 	prom = (int (*)(void *))promptr;
 }
 
+#define ADDR(x)		(u32)(unsigned long)(x)
+
 int of_call_prom(const char *service, int nargs, int nret, ...)
 {
 	int i;
-	struct prom_args {
-		const char *service;
-		int nargs;
-		int nret;
-		unsigned int args[12];
-	} args;
+	struct prom_args args;
 	va_list list;
 
-	args.service = service;
+	args.service = ADDR(service);
 	args.nargs = nargs;
 	args.nret = nret;
 
@@ -56,15 +62,10 @@ static int of_call_prom_ret(const char *service, int nargs, int nret,
 			    unsigned int *rets, ...)
 {
 	int i;
-	struct prom_args {
-		const char *service;
-		int nargs;
-		int nret;
-		unsigned int args[12];
-	} args;
+	struct prom_args args;
 	va_list list;
 
-	args.service = service;
+	args.service = ADDR(service);
 	args.nargs = nargs;
 	args.nret = nret;
 
-- 
1.7.10.4
