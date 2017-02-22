Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSlq61LxLzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 16:12:18 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1M5A6is055499
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 00:12:16 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28rq6yyn7f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 00:12:16 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 22:12:14 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/hash: Always clear UPRT and Host Radix bits when
 setting up CPU
Date: Wed, 22 Feb 2017 10:42:02 +0530
Message-Id: <1487740322-17755-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will set LPCR with correct value for radix during int. This make sure we
start with a sanitized value of LPCR. In case of kexec, cpus can have LPCR
value based on the previous translation mode we were running.

Fixes: fe036a0605d60 ("powerpc/64/kexec: Fix MMU cleanup on radix")
Cc: stable@vger.kernel.org # v4.9+
Acked-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/cpu_setup_power.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 917188615bf5..7fe8c79e6937 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -101,6 +101,8 @@ _GLOBAL(__setup_cpu_power9)
 	mfspr	r3,SPRN_LPCR
 	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE)
 	or	r3, r3, r4
+	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT | LPCR_HR)
+	andc	r3, r3, r4
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
@@ -122,6 +124,8 @@ _GLOBAL(__restore_cpu_power9)
 	mfspr   r3,SPRN_LPCR
 	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE)
 	or	r3, r3, r4
+	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT | LPCR_HR)
+	andc	r3, r3, r4
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
-- 
2.7.4
