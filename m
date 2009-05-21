Return-Path: <roel.kluin@gmail.com>
Received: from mail-ew0-f167.google.com (mail-ew0-f167.google.com
	[209.85.219.167]) by ozlabs.org (Postfix) with ESMTP id EEBEADE1CD
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 05:44:53 +1000 (EST)
Received: by ewy11 with SMTP id 11so1469781ewy.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 12:44:51 -0700 (PDT)
Message-ID: <4A15AF33.60100@gmail.com>
Date: Thu, 21 May 2009 21:44:51 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: paulmck@linux.vnet.ibm.com
Subject: [PATCH] powerpc:beyond ARRAY_SIZE of args.args
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Do not go beyond ARRAY_SIZE of args.args

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
I'm quite sure the first is correct, but should maybe `args.nret'
and `nargs + args.nret' also be `>= ARRAY_SIZE(args.args)'?

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 1f8505c..c94ab76 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -779,7 +779,7 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
 		return -EFAULT;
 
 	nargs = args.nargs;
-	if (nargs > ARRAY_SIZE(args.args)
+	if (nargs >= ARRAY_SIZE(args.args)
 	    || args.nret > ARRAY_SIZE(args.args)
 	    || nargs + args.nret > ARRAY_SIZE(args.args))
 		return -EINVAL;
