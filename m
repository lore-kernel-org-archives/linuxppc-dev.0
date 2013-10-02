Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 56AA32C008E
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Oct 2013 10:15:36 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 1 Oct 2013 18:15:31 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 03B9919D803E
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Oct 2013 18:15:27 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r920FSgq305062
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Oct 2013 18:15:28 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r920IXXw028100
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Oct 2013 18:18:33 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH 3/9][v5] powerpc/perf: Add Power8 event PM_MRK_GRP_CMPL to
 sysfs.
Date: Tue,  1 Oct 2013 17:15:04 -0700
Message-Id: <1380672911-12812-4-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
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
Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-pmu.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index b991b2e..fc7ba38 100644
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
