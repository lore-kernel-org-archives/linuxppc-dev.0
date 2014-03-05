Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 01B5F2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 04:20:16 +1100 (EST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 17:20:11 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 70C1E219004D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 17:20:05 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s25HJvsI5963912
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 17:19:57 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s25HK8BF024507
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 10:20:08 -0700
Subject: [PATCH] powerpc/le: fix endianness of the arguments passed to the
 ppc_rtas() syscall
To: benh@kernel.crashing.org, paulus@samba.org
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Date: Wed, 05 Mar 2014 18:20:06 +0100
Message-ID: <20140305172006.26117.57219.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RTAS manipulates its input and output arguments in big endian order.

I have looked at factoring some lines with rtas_call() but it is not really
worth it because of the variable arguments.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 4cf674d..00dbe36 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1020,6 +1020,7 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
 	char *buff_copy, *errbuf = NULL;
 	int nargs;
 	int rc;
+	int i;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1056,9 +1057,19 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
 
 	flags = lock_rtas();
 
-	rtas.args = args;
+	rtas.args.token = cpu_to_be32(args.token);
+	rtas.args.nargs = cpu_to_be32(args.nargs);
+	rtas.args.nret  = cpu_to_be32(args.nret);
+	for (i = 0; i < nargs; ++i)
+		rtas.args.args[i] = cpu_to_be32(args.args[i]);
+	rtas.args.rets  = &rtas.args.args[nargs];
+	for (i = 0; i < args.nret; ++i)
+		rtas.args.rets[i] = 0;
+
 	enter_rtas(__pa(&rtas.args));
-	args = rtas.args;
+
+	for (i = 0; i < args.nret; ++i)
+		args.rets[i] = be32_to_cpu(rtas.args.rets[i]);
 
 	/* A -1 return code indicates that the last command couldn't
 	   be completed due to a hardware error. */
