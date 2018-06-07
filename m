Return-Path: <pedromfc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411qBD1YFwzF34F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 01:25:49 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w57FOGU3057597
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 11:25:47 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jf5nhwjx2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jun 2018 11:25:47 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pedromfc@linux.vnet.ibm.com>;
 Thu, 7 Jun 2018 11:25:46 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w57FPikr9371934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 15:25:44 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE0B7112062
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 11:25:43 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C27C9112061
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 11:25:43 -0400 (EDT)
Received: from pedro.localdomain (unknown [9.18.235.95])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 11:25:43 -0400 (EDT)
From: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 4/5] powerpc: Add VSX regset to compat_regsets
Date: Thu,  7 Jun 2018 12:25:33 -0300
In-Reply-To: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
References: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
Message-Id: <20180607152534.29427-5-pedromfc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch copies the the missing VSX regset to the compat_regsets
array.

Not having this regset can cause issues in fs/binfmt_elf.c in the
fill_thread_core_info function, which iterates over all the regsets
defined in compat_regsets to fill note info for a core dump of a
32-bit thread. However, the number of regset notes allocated for
writing is the number of regsets with core_note_type != 0. If the
regset array has an entry with core_note_type == 0, which is the case
for the missing VSX element, this can cause later regsets to be
written outside the bounds of the allocated notes.

The compat_regset is also missing entries for REGSET_PMR and
REGSET_PKEY, but because these are at the end of the powerpc_regset
enum, the designated initializers for the compat_regset array don't
cause implicit elements to be created, like they did for REGSET_VSX.
---
 arch/powerpc/kernel/ptrace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 69123feaef9e..2da0668a96dc 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -2237,6 +2237,13 @@ static const struct user_regset compat_regsets[] = {
 		.active = vr_active, .get = vr_get, .set = vr_set
 	},
 #endif
+#ifdef CONFIG_VSX
+	[REGSET_VSX] = {
+		.core_note_type = NT_PPC_VSX, .n = 32,
+		.size = sizeof(double), .align = sizeof(double),
+		.active = vsr_active, .get = vsr_get, .set = vsr_set
+	},
+#endif
 #ifdef CONFIG_SPE
 	[REGSET_SPE] = {
 		.core_note_type = NT_PPC_SPE, .n = 35,
-- 
2.13.6
