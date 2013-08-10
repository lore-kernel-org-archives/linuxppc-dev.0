Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E06C02C01B5
 for <linuxppc-dev@ozlabs.org>; Sun, 11 Aug 2013 03:51:53 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 10 Aug 2013 11:51:52 -0600
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4C3C3C90026
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 13:51:47 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7AHpm3n31785082
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 13:51:48 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7AHplJa006343
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 14:51:48 -0300
Date: Sat, 10 Aug 2013 10:51:23 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 4/7] powerpc/perf: Create mem-loads/mem-stores events for
 Power7
Message-ID: <20130810175123.GE15551@us.ibm.com>
References: <20130810174831.GA15551@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130810174831.GA15551@us.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Stephane Eranian <eranian@google.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 4/7] powerpc/perf: Create mem-loads/mem-stores events for Power7

'perf mem' command depends on the support for generic hardware events
'mem-loads' and 'mem-stores'.

Create those events for Power7 and map them both to the event PM_MRK_GRP_CMPL.
While PM_MRK_GRP_CMPL is strictly not restricted to loads and stores, that
seems to be a close/resonable match.

Cc: Stephane Eranian <eranian@google.com>
Cc: Paul Mckerras <paulus@samba.org>
Cc: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power7-pmu.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 56c67bc..161861d 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -58,6 +58,18 @@
 
 enum {
 #include "power7-events-list.h"
+	/*
+	 * Normally, generic events like 'cycles' are aliases for a real
+	 * event PM_CYC. So we want both the event and the alias listed in
+	 * sysfs. But mem-loads and mem-stores are just aliases - they are
+	 * not listed in  power7_generic_events[] for instance. Adding them
+	 * to power7-events-list.h will unnecessariliy create PM_MEM_LOADS
+	 * and PM_MEM_STORES events in sysfs when that file is processed
+	 * again below. To save a couple of sysfs entries, define these
+	 * separately.
+	 */
+	EVENT(PM_MEM_LOADS,	0x40030)
+	EVENT(PM_MEM_STORES,	0x40030)
 };
 #undef EVENT
 
@@ -382,6 +394,8 @@ GENERIC_EVENT_ATTR(cache-references,		PM_LD_REF_L1);
 GENERIC_EVENT_ATTR(cache-misses,		PM_LD_MISS_L1);
 GENERIC_EVENT_ATTR(branch-instructions,		PM_BRU_FIN);
 GENERIC_EVENT_ATTR(branch-misses,		PM_BR_MPRED);
+GENERIC_EVENT_ATTR(mem-loads,			PM_MEM_LOADS);
+GENERIC_EVENT_ATTR(mem-stores,			PM_MEM_STORES);
 
 #define EVENT(_name, _code)     POWER_EVENT_ATTR(_name, _name);
 #include "power7-events-list.h"
@@ -398,6 +412,8 @@ static struct attribute *power7_events_attr[] = {
 	GENERIC_EVENT_PTR(PM_LD_MISS_L1),
 	GENERIC_EVENT_PTR(PM_BRU_FIN),
 	GENERIC_EVENT_PTR(PM_BR_MPRED),
+	GENERIC_EVENT_PTR(PM_MEM_LOADS),
+	GENERIC_EVENT_PTR(PM_MEM_STORES),
 
 	#include "power7-events-list.h"
 	#undef EVENT
-- 
1.7.1
