Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tg0Qk6z5bzDwB1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 17:14:54 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBG6DhkJ043337
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 01:14:52 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27c81eu660-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 01:14:52 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Fri, 16 Dec 2016 16:14:49 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B08FB2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 17:14:47 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBG6Elur32309440
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 17:14:47 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBG6EkqD029893
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 17:14:47 +1100
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Jessica Yu <jeyu@redhat.com>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org,
 linux-kernel@vger.kernel.org, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH] powerpc/livepatch: Remove klp_write_module_reloc() stub
Date: Fri, 16 Dec 2016 11:44:24 +0530
Message-Id: <1481868864-27283-1-git-send-email-kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 425595a7fc20 ("livepatch: reuse module loader code
to write relocations") offloads livepatch module relocation
write to arch specific module loader code.

Remove unused klp_write_module_reloc() function stub.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/livepatch.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
index a402f7f..47a03b9 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -28,13 +28,6 @@ static inline int klp_check_compiler_support(void)
 	return 0;
 }
 
-static inline int klp_write_module_reloc(struct module *mod, unsigned long
-		type, unsigned long loc, unsigned long value)
-{
-	/* This requires infrastructure changes; we need the loadinfos. */
-	return -ENOSYS;
-}
-
 static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 {
 	regs->nip = ip;
-- 
2.7.4
