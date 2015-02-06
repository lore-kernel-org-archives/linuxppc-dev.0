Return-Path: <tom.huynh@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0109.outbound.protection.outlook.com [207.46.100.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC5831A0F20
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Feb 2015 10:00:33 +1100 (AEDT)
From: Tom Huynh <tom.huynh@freescale.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <a.p.zijlstra@chello.nl>, <mingo@redhat.com>, <acme@kernel.org>
Subject: [PATCH 2/3] perf/e6500: Create a sysfs format entry for e6500 events
Date: Fri, 6 Feb 2015 16:43:55 -0600
Message-ID: <1423262636-12053-3-git-send-email-tom.huynh@freescale.com>
In-Reply-To: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
References: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tom Huynh <tom.huynh@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create a sysfs entry, '/sys/bus/event_source/devices/cpu/format/event'
which describes the format of the e6500 PMU events. e6500 has <= 512
events, so use the 9 lsb to specify the raw event code.

	$ cat /sys/devices/cpu/format/event
	config:0-8

Similar to commit 3bf7b07ece6e ("perf/POWER7: Create a sysfs format
entry for Power7 events").

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
Signed-off-by: Tom Huynh <tom.huynh@freescale.com>
---
 arch/powerpc/perf/e6500-pmu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/perf/e6500-pmu.c b/arch/powerpc/perf/e6500-pmu.c
index abaa6d7..4bbdbb0 100644
--- a/arch/powerpc/perf/e6500-pmu.c
+++ b/arch/powerpc/perf/e6500-pmu.c
@@ -133,7 +133,20 @@ static struct attribute_group e6500_pmu_events_group = {
 	.attrs = e6500_events_attr,
 };
 
+PMU_FORMAT_ATTR(event, "config:0-8");
+
+static struct attribute *e6500_pmu_format_attr[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+struct attribute_group e6500_pmu_format_group = {
+	.name = "format",
+	.attrs = e6500_pmu_format_attr,
+};
+
 static const struct attribute_group *e6500_pmu_attr_groups[] = {
+	&e6500_pmu_format_group,
 	&e6500_pmu_events_group,
 	NULL,
 };
-- 
1.9.1
