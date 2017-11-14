Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybj2X2ZN1zDqlS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 20:32:04 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAE9VOR0025455
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 04:32:01 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e7wbrsruu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 04:31:30 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 14 Nov 2017 09:29:38 -0000
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v4 3/3] powerpc/modules: Improve restore_r2() error message
Date: Tue, 14 Nov 2017 04:29:10 -0500
In-Reply-To: <20171114092910.20399-1-kamalesh@linux.vnet.ibm.com>
References: <20171114092910.20399-1-kamalesh@linux.vnet.ibm.com>
Message-Id: <20171114092910.20399-4-kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Josh Poimboeuf <jpoimboe@redhat.com>

Print the function address associated with the restore_r2() error to
make it easier to debug the problem.

Also clarify the wording a bit.

Before:

  module_64: patch_foo: Expect noop after relocate, got 3c820000

After:

  module_64: patch_foo: Expected noop after call, got 7c630034 at netdev_has_upper_dev+0x54/0xb0 [patch_foo]

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/module_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 9e5391f..dad3ea5 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -494,8 +494,8 @@ static int restore_r2(u32 *instruction, struct module *me)
 		return 1;
 
 	if (*instruction != PPC_INST_NOP) {
-		pr_err("%s: Expect noop after relocate, got %08x\n",
-		       me->name, *instruction);
+		pr_err("%s: Expected noop after call, got %08x at %pS\n",
+			me->name, *instruction, instruction);
 		return 0;
 	}
 	/* ld r2,R2_STACK_OFFSET(r1) */
-- 
2.9.3
