Return-Path: <srs0=5zt0=7f=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNPmd1rJXzDr5F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 19:25:37 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xNPmc6LFdz8vlH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 19:25:36 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xNPmb16xPz9s7v
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2017 19:25:34 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v739O4Rr112050
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2017 05:25:33 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3vcb77wc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 03 Aug 2017 05:25:33 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 3 Aug 2017 19:25:30 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v739PTB133226778
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2017 19:25:29 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v739PS9t013134
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2017 19:25:28 +1000
Subject: [PATCH 4/4] powerpc/prom: fix early parsing of 'disable_radix'
 parameter
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: sjitindarsingh@gmail.com, Michael Ellerman <mpe@ellerman.id.au>,
 stable@vger.kernel.org#4.11+, Paul Mackerras <paulus@samba.org>,
 ben@codiert.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 03 Aug 2017 14:55:26 +0530
In-Reply-To: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
References: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <150175232638.9806.1165424950551046958.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Early cmdline parser looks for "disable_radix" substring in the cmdline
string but it could also succeed when cmdline string contains parameters
like 'x_disable_radix' or disable_radix_type=' or such causing undesired
actions. Add support to skip proceeding in such cases.

Fixes: 014d02cbf16b ("powerpc: Update to new option-vector-5 format for CAS")
Cc: stable@vger.kernel.org # 4.11+
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 3057a32..169e32c 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -660,8 +660,16 @@ static void __init early_cmdline_parse(void)
 
 	opt = strstr(prom_cmd_line, "disable_radix");
 	if (opt) {
-		prom_debug("Radix disabled from cmdline\n");
-		prom_radix_disable = true;
+		/*
+		 * Check if this is prefix or suffix of some other parameter
+		 * before proceeding.
+		 */
+		p = (char *)(opt + 13);
+		if ((*p == ' ' || *p == '"' || *p == '\0') &&
+		    is_substring_param(prom_cmd_line, opt)) {
+			prom_debug("Radix disabled from cmdline\n");
+			prom_radix_disable = true;
+		}
 	}
 }
 
