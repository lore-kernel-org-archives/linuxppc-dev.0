Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E17532C013F
 for <linuxppc-dev@ozlabs.org>; Sun, 11 Aug 2013 03:51:12 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 10 Aug 2013 11:51:10 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 68A2119D8045
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 11:50:56 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7AHp8PI191690
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 11:51:08 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7AHp7KV009230
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 11:51:08 -0600
Date: Sat, 10 Aug 2013 10:50:43 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 3/7] powerpc/perf: Create mem-loads/mem-stores events for
 Power8
Message-ID: <20130810175042.GD15551@us.ibm.com>
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


[PATCH 3/7] powerpc/perf: Create mem-loads/mem-stores events for Power8

'perf mem' command depends on the support for generic hardware events
'mem-loads' and 'mem-stores'.

Create those events for Power8 and map them both to the event PM_MRK_GRP_CMPL.
While PM_MRK_GRP_CMPL is strictly not restricted to loads and stores, that
seems to be a close/resonable match.

Cc: Stephane Eranian <eranian@google.com>
Cc: Paul Mckerras <paulus@samba.org>
Cc: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-pmu.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index ff98fb8..0a7b632 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -24,6 +24,8 @@
 #define PME_PM_INST_CMPL			0x00002
 #define PME_PM_BRU_FIN				0x10068
 #define PME_PM_BR_MPRED_CMPL			0x400f6
+#define PME_PM_MEM_LOADS			0x40130
+#define PME_PM_MEM_STORES			0x40130
 
 
 /*
@@ -516,6 +518,8 @@ GENERIC_EVENT_ATTR(stalled-cycles-backend,	PM_CMPLU_STALL);
 GENERIC_EVENT_ATTR(instructions,		PM_INST_CMPL);
 GENERIC_EVENT_ATTR(branch-instructions,		PM_BRU_FIN);
 GENERIC_EVENT_ATTR(branch-misses,		PM_BR_MPRED_CMPL);
+GENERIC_EVENT_ATTR(mem-loads,			PM_MEM_LOADS);
+GENERIC_EVENT_ATTR(mem-stores,			PM_MEM_STORES);
 
 static struct attribute *power8_events_attr[] = {
 	GENERIC_EVENT_PTR(PM_CYC),
@@ -524,6 +528,8 @@ static struct attribute *power8_events_attr[] = {
 	GENERIC_EVENT_PTR(PM_INST_CMPL),
 	GENERIC_EVENT_PTR(PM_BRU_FIN),
 	GENERIC_EVENT_PTR(PM_BR_MPRED_CMPL),
+	GENERIC_EVENT_PTR(PM_MEM_LOADS),
+	GENERIC_EVENT_PTR(PM_MEM_STORES),
 	NULL
 };
 
-- 
1.7.1
