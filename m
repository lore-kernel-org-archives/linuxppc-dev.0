Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7QvH3XSwzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 01:31:07 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JFTHv2103748
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 11:31:02 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29x7453gp4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 11:31:02 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 20 Apr 2017 01:31:00 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JFUnhT5111862
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 01:30:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JFUKLU026976
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 01:30:21 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: kprobes: blacklist exception common handlers
Date: Wed, 19 Apr 2017 20:59:52 +0530
In-Reply-To: <cover.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <f71f8e55d7f5548103c5e0c29abb303db664a894.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Blacklist all the exception common/OOL handlers as the kernel stack is
not yet setup, which means we can't take a trap at this point.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/head-64.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index 5067048daad4..86eb87382031 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -213,6 +213,7 @@ end_##sname:
 	USE_TEXT_SECTION();					\
 	.balign IFETCH_ALIGN_BYTES;				\
 	.global name;						\
+	_ASM_NOKPROBE_SYMBOL(name);				\
 	DEFINE_FIXED_SYMBOL(name);				\
 name:
 
-- 
2.12.1
