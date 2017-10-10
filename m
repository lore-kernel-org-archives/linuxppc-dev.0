Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBKhy6XMzzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 01:47:46 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9AEj6MR113119
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 10:47:43 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dgy2fvfsg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 10:47:43 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 10 Oct 2017 15:47:41 +0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9AElbdE15466608
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 14:47:38 GMT
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9AElRWI015802
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 01:47:28 +1100
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/modules: Use WARN_ON() in stub_for_addr()
Date: Tue, 10 Oct 2017 20:17:32 +0530
Message-Id: <1507646852-18642-1-git-send-email-kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use WARN_ON(), while running out of stubs in stub_for_addr()
and abort loading of the module instead of BUG_ON().

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/module_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 0b0f896..759104b 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -429,7 +429,8 @@ static unsigned long stub_for_addr(const Elf64_Shdr *sechdrs,
 	/* Find this stub, or if that fails, the next avail. entry */
 	stubs = (void *)sechdrs[me->arch.stubs_section].sh_addr;
 	for (i = 0; stub_func_addr(stubs[i].funcdata); i++) {
-		BUG_ON(i >= num_stubs);
+		if (WARN_ON(i >= num_stubs))
+			return 0;
 
 		if (stub_func_addr(stubs[i].funcdata) == func_addr(addr))
 			return (unsigned long)&stubs[i];
-- 
2.7.4
