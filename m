Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E9CC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 18:57:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301C0205C9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 18:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vjiDppZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301C0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ty1b6vzwzDqHZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 05:57:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="vjiDppZe"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Tx4L4ZknzDqP7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 05:15:14 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 91BF42082F;
 Wed, 27 Mar 2019 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553710512;
 bh=PwXP4l4jyhQRtvic7B7IR2O0WllvPBfLwbN6ufrYSj0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vjiDppZeQFuSxdK8AnTdr503ahAW+aAy1YMP1TT56URm+ET9/QfQlIwDVadzBExXc
 qDqSvTOl3miUTvDX6BhR95ihrmhI6smhMdbd3Wvpwp6s1z7o0XAVLRo+jWwh5fhnIx
 leNpIlzvMi4ZGVakYWiWRPqFWB7XpMup4ngiJzA8=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 152/192] powerpc/pseries: Perform full re-add of
 CPU for topology update post-migration
Date: Wed, 27 Mar 2019 14:09:44 -0400
Message-Id: <20190327181025.13507-152-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
Cc: Sasha Levin <sashal@kernel.org>, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 "Michael W . Bringmann" <mwb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Nathan Fontenot <nfont@linux.vnet.ibm.com>

[ Upstream commit 81b61324922c67f73813d8a9c175f3c153f6a1c6 ]

On pseries systems, performing a partition migration can result in
altering the nodes a CPU is assigned to on the destination system. For
exampl, pre-migration on the source system CPUs are in node 1 and 3,
post-migration on the destination system CPUs are in nodes 2 and 3.

Handling the node change for a CPU can cause corruption in the slab
cache if we hit a timing where a CPUs node is changed while cache_reap()
is invoked. The corruption occurs because the slab cache code appears
to rely on the CPU and slab cache pages being on the same node.

The current dynamic updating of a CPUs node done in arch/powerpc/mm/numa.c
does not prevent us from hitting this scenario.

Changing the device tree property update notification handler that
recognizes an affinity change for a CPU to do a full DLPAR remove and
add of the CPU instead of dynamically changing its node resolves this
issue.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: Michael W. Bringmann <mwb@linux.vnet.ibm.com>
Tested-by: Michael W. Bringmann <mwb@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/topology.h          |  2 ++
 arch/powerpc/mm/numa.c                       |  9 +--------
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index a4a718dbfec6..f85e2b01c3df 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -132,6 +132,8 @@ static inline void shared_proc_topology_init(void) {}
 #define topology_sibling_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
 #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
 #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
+
+int dlpar_cpu_readd(int cpu);
 #endif
 #endif
 
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 5500e4edabc6..10fb43efef50 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1461,13 +1461,6 @@ static void reset_topology_timer(void)
 
 #ifdef CONFIG_SMP
 
-static void stage_topology_update(int core_id)
-{
-	cpumask_or(&cpu_associativity_changes_mask,
-		&cpu_associativity_changes_mask, cpu_sibling_mask(core_id));
-	reset_topology_timer();
-}
-
 static int dt_update_callback(struct notifier_block *nb,
 				unsigned long action, void *data)
 {
@@ -1480,7 +1473,7 @@ static int dt_update_callback(struct notifier_block *nb,
 		    !of_prop_cmp(update->prop->name, "ibm,associativity")) {
 			u32 core_id;
 			of_property_read_u32(update->dn, "reg", &core_id);
-			stage_topology_update(core_id);
+			rc = dlpar_cpu_readd(core_id);
 			rc = NOTIFY_OK;
 		}
 		break;
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 6ef77caf7bcf..1d3f9313c02f 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -802,6 +802,25 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
 	return rc;
 }
 
+int dlpar_cpu_readd(int cpu)
+{
+	struct device_node *dn;
+	struct device *dev;
+	u32 drc_index;
+	int rc;
+
+	dev = get_cpu_device(cpu);
+	dn = dev->of_node;
+
+	rc = of_property_read_u32(dn, "ibm,my-drc-index", &drc_index);
+
+	rc = dlpar_cpu_remove_by_index(drc_index);
+	if (!rc)
+		rc = dlpar_cpu_add(drc_index);
+
+	return rc;
+}
+
 int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 {
 	u32 count, drc_index;
-- 
2.19.1

