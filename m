Return-Path: <clg@fr.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7D2312C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 02:59:50 +1100 (EST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 7 Feb 2014 15:59:47 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 829011B08070
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 15:59:17 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s17FxWX458720256
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 15:59:32 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s17Fxhma000390
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 08:59:44 -0700
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [RFC PATCH 04/18] powerpc/boot: add byteswapping routines in oflib
Date: Fri,  7 Feb 2014 16:59:17 +0100
Message-Id: <1391788771-16405-5-git-send-email-clg@fr.ibm.com>
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

Values will need to be byte-swapped when calling prom (big endian) from
a little endian boot wrapper.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/boot/of.h        |    3 +++
 arch/powerpc/boot/ofconsole.c |    6 ++++--
 arch/powerpc/boot/oflib.c     |   22 +++++++++++-----------
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/boot/of.h b/arch/powerpc/boot/of.h
index 5da03d9b9463..40d95bf7402b 100644
--- a/arch/powerpc/boot/of.h
+++ b/arch/powerpc/boot/of.h
@@ -20,4 +20,7 @@ void of_console_init(void);
 
 typedef u32			__be32;
 
+#define cpu_to_be32(x) (x)
+#define be32_to_cpu(x) (x)
+
 #endif /* _PPC_BOOT_OF_H_ */
diff --git a/arch/powerpc/boot/ofconsole.c b/arch/powerpc/boot/ofconsole.c
index ce0e02424453..8b754702460a 100644
--- a/arch/powerpc/boot/ofconsole.c
+++ b/arch/powerpc/boot/ofconsole.c
@@ -18,7 +18,7 @@
 
 #include "of.h"
 
-static void *of_stdout_handle;
+static unsigned int of_stdout_handle;
 
 static int of_console_open(void)
 {
@@ -27,8 +27,10 @@ static int of_console_open(void)
 	if (((devp = of_finddevice("/chosen")) != NULL)
 	    && (of_getprop(devp, "stdout", &of_stdout_handle,
 			   sizeof(of_stdout_handle))
-		== sizeof(of_stdout_handle)))
+		== sizeof(of_stdout_handle))) {
+		of_stdout_handle = be32_to_cpu(of_stdout_handle);
 		return 0;
+	}
 
 	return -1;
 }
diff --git a/arch/powerpc/boot/oflib.c b/arch/powerpc/boot/oflib.c
index 3b0c9458504f..0f72b1a42133 100644
--- a/arch/powerpc/boot/oflib.c
+++ b/arch/powerpc/boot/oflib.c
@@ -42,13 +42,13 @@ int of_call_prom(const char *service, int nargs, int nret, ...)
 	struct prom_args args;
 	va_list list;
 
-	args.service = ADDR(service);
-	args.nargs = nargs;
-	args.nret = nret;
+	args.service = cpu_to_be32(ADDR(service));
+	args.nargs = cpu_to_be32(nargs);
+	args.nret = cpu_to_be32(nret);
 
 	va_start(list, nret);
 	for (i = 0; i < nargs; i++)
-		args.args[i] = va_arg(list, prom_arg_t);
+		args.args[i] = cpu_to_be32(va_arg(list, prom_arg_t));
 	va_end(list);
 
 	for (i = 0; i < nret; i++)
@@ -57,7 +57,7 @@ int of_call_prom(const char *service, int nargs, int nret, ...)
 	if (prom(&args) < 0)
 		return -1;
 
-	return (nret > 0)? args.args[nargs]: 0;
+	return (nret > 0) ? be32_to_cpu(args.args[nargs]) : 0;
 }
 
 static int of_call_prom_ret(const char *service, int nargs, int nret,
@@ -67,13 +67,13 @@ static int of_call_prom_ret(const char *service, int nargs, int nret,
 	struct prom_args args;
 	va_list list;
 
-	args.service = ADDR(service);
-	args.nargs = nargs;
-	args.nret = nret;
+	args.service = cpu_to_be32(ADDR(service));
+	args.nargs = cpu_to_be32(nargs);
+	args.nret = cpu_to_be32(nret);
 
 	va_start(list, rets);
 	for (i = 0; i < nargs; i++)
-		args.args[i] = va_arg(list, prom_arg_t);
+		args.args[i] = cpu_to_be32(va_arg(list, prom_arg_t));
 	va_end(list);
 
 	for (i = 0; i < nret; i++)
@@ -84,9 +84,9 @@ static int of_call_prom_ret(const char *service, int nargs, int nret,
 
 	if (rets != (void *) 0)
 		for (i = 1; i < nret; ++i)
-			rets[i-1] = args.args[nargs+i];
+			rets[i-1] = be32_to_cpu(args.args[nargs+i]);
 
-	return (nret > 0)? args.args[nargs]: 0;
+	return (nret > 0) ? be32_to_cpu(args.args[nargs]) : 0;
 }
 
 /* returns true if s2 is a prefix of s1 */
-- 
1.7.10.4
