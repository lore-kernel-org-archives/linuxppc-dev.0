Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D31812C0160
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Sep 2013 10:49:25 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 13 Sep 2013 18:49:22 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2482F6E8040
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Sep 2013 20:49:20 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8E0nK9w32833588
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Sep 2013 00:49:20 GMT
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8E0nJFc001488
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Sep 2013 21:49:20 -0300
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8][v4] powerpc/perf: Add PM_MRK_GRP_CMPL event to sysfs.
Date: Fri, 13 Sep 2013 17:49:10 -0700
Message-Id: <1379119755-21025-4-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1379119755-21025-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1379119755-21025-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michaele@au1.ibm.com>, Stephane Eranian <eranian@google.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The perf event PM_MRK_GRP_CMPL is useful in analyzing memory hierarchy
of applications.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-pmu.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index ff98fb8..5c61e59 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -24,6 +24,7 @@
 #define PME_PM_INST_CMPL			0x00002
 #define PME_PM_BRU_FIN				0x10068
 #define PME_PM_BR_MPRED_CMPL			0x400f6
+#define PME_PM_MRK_GRP_CMPL			0x40130
 
 
 /*
@@ -517,6 +518,8 @@ GENERIC_EVENT_ATTR(instructions,		PM_INST_CMPL);
 GENERIC_EVENT_ATTR(branch-instructions,		PM_BRU_FIN);
 GENERIC_EVENT_ATTR(branch-misses,		PM_BR_MPRED_CMPL);
 
+POWER_EVENT_ATTR(PM_MRK_GRP_CMPL,		PM_MRK_GRP_CMPL);
+
 static struct attribute *power8_events_attr[] = {
 	GENERIC_EVENT_PTR(PM_CYC),
 	GENERIC_EVENT_PTR(PM_GCT_NOSLOT_CYC),
@@ -524,6 +527,8 @@ static struct attribute *power8_events_attr[] = {
 	GENERIC_EVENT_PTR(PM_INST_CMPL),
 	GENERIC_EVENT_PTR(PM_BRU_FIN),
 	GENERIC_EVENT_PTR(PM_BR_MPRED_CMPL),
+
+	POWER_EVENT_PTR(PM_MRK_GRP_CMPL),
 	NULL
 };
 
-- 
1.7.9.5
