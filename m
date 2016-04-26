Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvFxr4kjLzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 18:05:04 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 26 Apr 2016 18:05:02 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 627A42BB005C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 18:04:48 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3Q84Tci15925398
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 18:04:37 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3Q8453g008662
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 18:04:05 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u3Q845AF007562
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 18:04:05 +1000
Received: from ajd.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id D8593A0268
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 17:55:19 +1000 (AEST)
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mpic: handle subsys_system_register() failure
Date: Tue, 26 Apr 2016 17:55:04 +1000
Message-Id: <1461657304-22011-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpic_init_sys() currently doesn't check whether
subsys_system_register() succeeded or not. Check the return code of
subsys_system_register() and clean up if there's an error.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Found by Coverity Scan. Build-tested only.
---
 arch/powerpc/sysdev/mpic.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index afe3c7c..7de45b2 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -2004,8 +2004,15 @@ static struct syscore_ops mpic_syscore_ops = {
 
 static int mpic_init_sys(void)
 {
+	int rc;
+
 	register_syscore_ops(&mpic_syscore_ops);
-	subsys_system_register(&mpic_subsys, NULL);
+	rc = subsys_system_register(&mpic_subsys, NULL);
+	if (rc) {
+		unregister_syscore_ops(&mpic_syscore_ops);
+		pr_err("mpic: Failed to register subsystem!\n");
+		return rc;
+	}
 
 	return 0;
 }
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
