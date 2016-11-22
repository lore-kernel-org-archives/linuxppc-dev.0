Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNYML6wZHzDvsC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 05:06:53 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAMI4CtC042643
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 13:06:51 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26vnpab2pv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 13:06:50 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 22 Nov 2016 13:06:49 -0500
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] powernv: Clear SPRN_PSSCR when a POWER9 CPU comes online
Date: Tue, 22 Nov 2016 23:36:40 +0530
Message-Id: <1479838000-380-1-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Ensure that PSSCR is set to a safe value corresponding to no
state-loss each time a POWER9 CPU comes online.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/cpu_setup_power.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 52ff3f0..37ad045 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -96,6 +96,7 @@ _GLOBAL(__setup_cpu_power9)
 	mtlr	r11
 	beqlr
 	li	r0,0
+	mtspr	SPRN_PSSCR,r0
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
@@ -116,6 +117,7 @@ _GLOBAL(__restore_cpu_power9)
 	mtlr	r11
 	beqlr
 	li	r0,0
+	mtspr	SPRN_PSSCR,r0
 	mtspr	SPRN_LPID,r0
 	mfspr   r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
-- 
1.9.4
