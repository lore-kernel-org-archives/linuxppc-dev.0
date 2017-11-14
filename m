Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybhzp07vDzDqpq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 20:29:41 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAE9TONn107775
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 04:29:40 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e7utre5by-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 04:29:39 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 14 Nov 2017 09:29:37 -0000
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v4 2/3] powerpc/modules: Don't try to restore r2 after a
 sibling call
Date: Tue, 14 Nov 2017 04:29:09 -0500
In-Reply-To: <20171114092910.20399-1-kamalesh@linux.vnet.ibm.com>
References: <20171114092910.20399-1-kamalesh@linux.vnet.ibm.com>
Message-Id: <20171114092910.20399-3-kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Josh Poimboeuf <jpoimboe@redhat.com>

When attempting to load a livepatch module, I got the following error:

  module_64: patch_module: Expect noop after relocate, got 3c820000

The error was triggered by the following code in
unregister_netdevice_queue():

  14c:   00 00 00 48     b       14c <unregister_netdevice_queue+0x14c>
                         14c: R_PPC64_REL24      net_set_todo
  150:   00 00 82 3c     addis   r4,r2,0

GCC didn't insert a nop after the branch to net_set_todo() because it's
a sibling call, so it never returns.  The nop isn't needed after the
branch in that case.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/module_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 39b01fd..9e5391f 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -489,6 +489,10 @@ static int restore_r2(u32 *instruction, struct module *me)
 	if (is_early_mcount_callsite(instruction - 1))
 		return 1;
 
+	/* Sibling calls don't return, so they don't need to restore r2 */
+	if (instruction[-1] == PPC_INST_BRANCH)
+		return 1;
+
 	if (*instruction != PPC_INST_NOP) {
 		pr_err("%s: Expect noop after relocate, got %08x\n",
 		       me->name, *instruction);
-- 
2.9.3
