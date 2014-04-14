Return-Path: <clg@fr.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ECFC51400CF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 17:48:15 +1000 (EST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 14 Apr 2014 08:48:11 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id DE67617D806A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 08:49:02 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3E7m75S1245556
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 07:48:08 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3E7m7m9007281
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 01:48:07 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 05/15] powerpc/boot: add PROM_ERROR define in oflib
Date: Mon, 14 Apr 2014 09:47:04 +0200
Message-Id: <1397461634-20949-6-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1397461634-20949-1-git-send-email-clg@fr.ibm.com>
References: <1397461634-20949-1-git-send-email-clg@fr.ibm.com>
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

This is mostly useful to make to the boot wrapper code closer with
the kernel code in prom_init.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---

Changes since v1:

 - moved PROM_ERROR definition in of.h. of_try_claim() will make 
   use of it in the next patch.

 arch/powerpc/boot/of.h    |    2 ++
 arch/powerpc/boot/oflib.c |    6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/of.h b/arch/powerpc/boot/of.h
index 40d95bf7402b..0f058ef69521 100644
--- a/arch/powerpc/boot/of.h
+++ b/arch/powerpc/boot/of.h
@@ -23,4 +23,6 @@ typedef u32			__be32;
 #define cpu_to_be32(x) (x)
 #define be32_to_cpu(x) (x)
 
+#define PROM_ERROR (-1u)
+
 #endif /* _PPC_BOOT_OF_H_ */
diff --git a/arch/powerpc/boot/oflib.c b/arch/powerpc/boot/oflib.c
index 0f72b1a42133..7f61f2eb5653 100644
--- a/arch/powerpc/boot/oflib.c
+++ b/arch/powerpc/boot/oflib.c
@@ -55,7 +55,7 @@ int of_call_prom(const char *service, int nargs, int nret, ...)
 		args.args[nargs+i] = 0;
 
 	if (prom(&args) < 0)
-		return -1;
+		return PROM_ERROR;
 
 	return (nret > 0) ? be32_to_cpu(args.args[nargs]) : 0;
 }
@@ -80,9 +80,9 @@ static int of_call_prom_ret(const char *service, int nargs, int nret,
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
