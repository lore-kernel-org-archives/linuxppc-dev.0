Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 23CF22C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 02:10:44 +1100 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 20 Mar 2014 15:10:40 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 994561B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:29 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2KFARqJ1507704
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:27 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2KFAcAw016347
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 09:10:38 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 05/18] powerpc/boot: add PROM_ERROR define in oflib
Date: Thu, 20 Mar 2014 16:10:00 +0100
Message-Id: <1395328213-19206-6-git-send-email-clg@fr.ibm.com>
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

This is mostly useful to make to the boot wrapper code closer with
the kernel code in prom_init.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/boot/oflib.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/oflib.c b/arch/powerpc/boot/oflib.c
index 0f72b1a42133..96fe4d225abe 100644
--- a/arch/powerpc/boot/oflib.c
+++ b/arch/powerpc/boot/oflib.c
@@ -27,6 +27,8 @@ struct prom_args {
 	__be32 args[10];	/* Input/output arguments. */
 };
 
+#define PROM_ERROR (-1u)
+
 static int (*prom) (void *);
 
 void of_init(void *promptr)
@@ -55,7 +57,7 @@ int of_call_prom(const char *service, int nargs, int nret, ...)
 		args.args[nargs+i] = 0;
 
 	if (prom(&args) < 0)
-		return -1;
+		return PROM_ERROR;
 
 	return (nret > 0) ? be32_to_cpu(args.args[nargs]) : 0;
 }
@@ -80,9 +82,9 @@ static int of_call_prom_ret(const char *service, int nargs, int nret,
 		args.args[nargs+i] = 0;
 
 	if (prom(&args) < 0)
-		return -1;
+		return PROM_ERROR;
 
-	if (rets != (void *) 0)
+	if (rets != NULL)
 		for (i = 1; i < nret; ++i)
 			rets[i-1] = be32_to_cpu(args.args[nargs+i]);
 
-- 
1.7.10.4
