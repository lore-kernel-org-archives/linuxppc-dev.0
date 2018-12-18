Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D39C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 10:21:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BB1217D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 10:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BB1217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JvF312bXzDqWJ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 21:21:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 43Jv311qJ2zDqRh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 21:12:29 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C8E8A78;
 Tue, 18 Dec 2018 02:12:27 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com
 [10.162.41.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 55F803F5C0;
 Tue, 18 Dec 2018 02:12:19 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] Tools: Replace open encodings for NUMA_NO_NODE
Date: Tue, 18 Dec 2018 15:42:13 +0530
Message-Id: <1545127933-10711-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545127933-10711-1-git-send-email-anshuman.khandual@arm.com>
References: <1545127933-10711-1-git-send-email-anshuman.khandual@arm.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org, david@redhat.com,
 dri-devel@lists.freedesktop.org, hverkuil@xs4all.nl,
 sparclinux@vger.kernel.org, sfr@canb.auug.org.au, linux-rdma@vger.kernel.org,
 iommu@lists.linux-foundation.org, dledford@redhat.com,
 intel-wired-lan@lists.osuosl.org, jeffrey.t.kirsher@intel.com,
 jiangqi903@gmail.com, linux-media@vger.kernel.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, netdev@vger.kernel.org, vkoul@kernel.org,
 linux-alpha@vger.kernel.org, dmaengine@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Stephen Rothwell <sfr@canb.auug.org.au>

This replaces all open encodings in tools with NUMA_NO_NODE.
Also linux/numa.h is now needed for the perf build.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 tools/include/linux/numa.h | 16 ++++++++++++++++
 tools/perf/bench/numa.c    |  6 +++---
 2 files changed, 19 insertions(+), 3 deletions(-)
 create mode 100644 tools/include/linux/numa.h

diff --git a/tools/include/linux/numa.h b/tools/include/linux/numa.h
new file mode 100644
index 0000000..110b0e5
--- /dev/null
+++ b/tools/include/linux/numa.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_NUMA_H
+#define _LINUX_NUMA_H
+
+
+#ifdef CONFIG_NODES_SHIFT
+#define NODES_SHIFT     CONFIG_NODES_SHIFT
+#else
+#define NODES_SHIFT     0
+#endif
+
+#define MAX_NUMNODES    (1 << NODES_SHIFT)
+
+#define	NUMA_NO_NODE	(-1)
+
+#endif /* _LINUX_NUMA_H */
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 4419551..e0ad5f1 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -298,7 +298,7 @@ static cpu_set_t bind_to_node(int target_node)
 
 	CPU_ZERO(&mask);
 
-	if (target_node == -1) {
+	if (target_node == NUMA_NO_NODE) {
 		for (cpu = 0; cpu < g->p.nr_cpus; cpu++)
 			CPU_SET(cpu, &mask);
 	} else {
@@ -339,7 +339,7 @@ static void bind_to_memnode(int node)
 	unsigned long nodemask;
 	int ret;
 
-	if (node == -1)
+	if (node == NUMA_NO_NODE)
 		return;
 
 	BUG_ON(g->p.nr_nodes > (int)sizeof(nodemask)*8);
@@ -1363,7 +1363,7 @@ static void init_thread_data(void)
 		int cpu;
 
 		/* Allow all nodes by default: */
-		td->bind_node = -1;
+		td->bind_node = NUMA_NO_NODE;
 
 		/* Allow all CPUs by default: */
 		CPU_ZERO(&td->bind_cpumask);
-- 
2.7.4

