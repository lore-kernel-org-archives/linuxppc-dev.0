Return-Path: <srs0=5zt0=7f=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNPmW48GxzDrTD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 19:25:31 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xNPmW1kSMz8tVy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 19:25:31 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xNPmV5Kjlz9s8V
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2017 19:25:30 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v739PRRa002158
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2017 05:25:27 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3wyajq9g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 03 Aug 2017 05:25:26 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 3 Aug 2017 19:25:24 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v739PMHX14483592
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2017 19:25:22 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v739PL3b026254
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2017 19:25:21 +1000
Subject: [PATCH 3/4] powerpc/prom: fix early parsing of 'mem=' parameter
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: stable@vger.kernel.org#2.6.32+,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, ben@codiert.org,
 Paul Mackerras <paulus@samba.org>, sjitindarsingh@gmail.com,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 03 Aug 2017 14:55:19 +0530
In-Reply-To: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
References: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <150175231914.9806.17417587831837918447.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Early cmdline parser looks for "mem=" substring in the cmdline
string but it could also succeed when cmdline string contains
parameters like 'fadump_reserve_mem=' or such leading to undesired
results. Add support to skip proceeding in such case.

Fixes: cf68787b68a2 ("powerpc/prom_init: Evaluate mem kernel parameter for early allocation")
Cc: stable@vger.kernel.org # 2.6.32+
Cc: Benjamin Krill <ben@codiert.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 7030145..3057a32 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -649,7 +649,7 @@ static void __init early_cmdline_parse(void)
 	}
 #endif
 	opt = strstr(prom_cmd_line, "mem=");
-	if (opt) {
+	if (opt && is_substring_param(prom_cmd_line, opt)) {
 		opt += 4;
 		prom_memory_limit = prom_memparse(opt, (const char **)&opt);
 #ifdef CONFIG_PPC64
