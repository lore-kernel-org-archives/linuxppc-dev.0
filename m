Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRFvX0N75zDqWX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 17:39:52 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 18 Mar 2016 16:39:50 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A8089357805C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 17:39:43 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2I6dZqw28115028
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 17:39:43 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2I6chc8015195
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 17:38:43 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u2I6cgEe013960
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 17:38:42 +1100
Received: from ajd.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 by ozlabs.au.ibm.com (Postfix) with ESMTP id EEA5BA0129
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 17:36:47 +1100 (AEDT)
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/rtas: fix array overrun in ppc_rtas() syscall
Date: Fri, 18 Mar 2016 17:36:33 +1100
Message-Id: <1458282993-6371-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If ppc_rtas() is called with args.nargs == 16 and args.nret == 0, args.rets
is set to point to &args.args[16], which is beyond the end of the args.args
array. This results in a minor read overrun of the array when we check the
first return code (which, per PAPR, is a required output of all RTAS calls)
to see if there's been a hardware error.

Change the nargs/nret check to ensure nargs is <= 15, allowing room for the
status code. Users shouldn't be calling with nret == 0, but there's no real
harm if they do, so we don't stop them.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Found with the assistance of Coverity Scan.

The dodgy read doesn't currently leak anything at all to userspace, as
args.rets isn't copied back to userspace.
---
 arch/powerpc/kernel/rtas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 28736ff..8da209f 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1070,7 +1070,7 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
 	nret  = be32_to_cpu(args.nret);
 	token = be32_to_cpu(args.token);
 
-	if (nargs > ARRAY_SIZE(args.args)
+	if (nargs >= ARRAY_SIZE(args.args)
 	    || nret > ARRAY_SIZE(args.args)
 	    || nargs + nret > ARRAY_SIZE(args.args))
 		return -EINVAL;
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
