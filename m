Return-Path: <linuxppc-dev+bounces-27137-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2669C88E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 13:37:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhFwN4jB4z2ypW;
	Fri, 11 Sep 2026 23:37:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789130077;
	cv=none; b=Jsr+lI9JdJe/n0EzQy/kj3iOyfYjdsibvMfIOEuFhNNq4ossIf/ZjG/r7yUsDUNoc5jrHdPXq0VuJDYJy5b++mrp/gD/YP/ShpcHg6QfQKkdVYwenMk953dEnHVQLyWbEj1zjSMBQigu8OgVTwDITmctHXCbR3QpLRCcOi39k872qFYXilO5DH1/Sv9CtetejcSMqxq1eWF8lYTkW2uJzQpFRzjVqB1Ss5XDF+y7F4U2o+GyOx0IESyRLEnq3gLwdyU5Tj8xVmikbNLX9TY3Y2fqY2iFfMkhMd2GcYr9xaLhpBT43YLrqhaA2HQ8vZ4fYV2FSBZsMLiE60ACeD0Vjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789130077; c=relaxed/relaxed;
	bh=TtB3+ZqqigKPMCEU3NIGj/FC5xLnLRZnxg1hSDBeBgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPxQPyZyxwPZW4OMj/dCKA/Td6RweCUBZ94hq+x9sY/2ZbSfWNS8r6VTkwd4ysA9ZgElP3lME9K6GHYPoIZTuDxlrsGsAWU9mgEVn5lZhfDh1jecKlJfYf8eyAXdien6eJrwImicp8+JM71KoD96jSw28LCtPD+9vvQBxZ0mWWHSrz6eQdIvcbfstigVI1338ALT0bdsD3F3g/FpfIv9B4DxI1RADpVtx+8vduojnV093RKemxz+IBtPjwGuejbhr0oQLVuxzF/fiSuaC4TYtf/7oteP7hn+l67rjqD6WvTz+ZTatbL3ZtbMr5Qggp3Duj1g2uFjEf/nDNRf1enKBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; dkim=pass (2048-bit key; unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Ryy4nLM2; dkim-atps=neutral; spf=pass (client-ip=52.12.53.23; helo=pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=707927bfc=sakacpav@amazon.de; receiver=lists.ozlabs.org) smtp.mailfrom=amazon.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Ryy4nLM2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amazon.de (client-ip=52.12.53.23; helo=pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=707927bfc=sakacpav@amazon.de; receiver=lists.ozlabs.org)
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhDWc37hbz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 22:34:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789130076; x=1820666076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TtB3+ZqqigKPMCEU3NIGj/FC5xLnLRZnxg1hSDBeBgU=;
  b=Ryy4nLM2zKk9DjsT94RTG2edA1Uzkyyo7NAIGmgz96k0NGh3+Q7vJKDk
   ENAzmhAQp4fiijNQ+a+DLaylXjuAodYFR1Wq87XGOH/BrNQQ/1ygYUp/q
   BLQnpsxjaMPZezMj1caV9hgapLIpMAyaJ3iID6sUVHzJm9rwXKp6fDz20
   3YWo1r0+vzI0DgDHfEyJ+HuqJqS4QEXgNkKJ0RxcPFSj04tuG4JO1WRyC
   0bcDoUQR1yRQmpQYje4Y0TxJAnvZDf6Zc51spHJZ4E9pSWMGPD7867KGA
   Ysumo9voZiOtxgYenCI2QrvAxFzy/sCjppmmII3zIBsd8BUKC/9fMd96S
   w==;
X-CSE-ConnectionGUID: V8kWbUZpS0uhb04BY/Kk5g==
X-CSE-MsgGUID: ZOhDAvsiSRaGYYP42HgeRg==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28294073"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:34:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:3959]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.93:2525] with esmtp (Farcaster)
 id 48290a84-2435-4cd0-b88c-3197c072d08d; Fri, 11 Sep 2026 12:34:34 +0000 (UTC)
X-Farcaster-Flow-ID: 48290a84-2435-4cd0-b88c-3197c072d08d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:34:33 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:34:31 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Matlack
	<dmatlack@google.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Kees Cook <kees@kernel.org>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, "Ionut
 Nechita" <ionut.nechita@windriver.com>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 8/8] PCI: Probe inline from node-local workqueue workers
Date: Fri, 11 Sep 2026 14:34:29 +0200
Message-ID: <20260911123429.11491-1-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
References: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.96.155]
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

pci_call_probe() dispatches each probe with queue_work_on() to a
housekeeping CPU of the device's node, except where it already probes
inline. A VF added by one of the preceding node-placed async VF-add
workers already executes on its device's node, so the dispatch buys it no
locality: it funnels every VF probe through the single CPU
cpumask_any_and() elects and re-serializes the parallel enable at the
probe step.

Call local_pci_probe() directly when the caller is a workqueue worker
(PF_WQ_WORKER) whose current CPU is on the device's node and in the same
HK_TYPE_DOMAIN housekeeping mask the dispatch elects from. The gate is
not VF-specific: any probe already running in a node-local housekeeping
kworker takes it, while a probe from a task that is not a worker keeps
the dispatch.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/pci/pci-driver.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e16aa59dd7ac..f5e12a5044cf 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -392,6 +392,22 @@ static bool pci_physfn_is_probed(struct pci_dev *dev)
 #endif
 }
 
+static bool pci_probe_inline(int node)
+{
+	/* The CPU is a placement hint; an unstable raw read is fine. */
+	int cpu = raw_smp_processor_id();
+	bool ret;
+
+	if (!(current->flags & PF_WQ_WORKER) || cpu_to_node(cpu) != node)
+		return false;
+
+	rcu_read_lock();
+	ret = housekeeping_cpu(cpu, HK_TYPE_DOMAIN);
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 			  const struct pci_device_id *id)
 {
@@ -412,7 +428,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	 * device is probed from work_on_cpu() of the Physical device.
 	 */
 	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
-	    pci_physfn_is_probed(dev)) {
+	    pci_physfn_is_probed(dev) || pci_probe_inline(node)) {
 		error = local_pci_probe(&ddi);
 	} else {
 		struct pci_probe_arg arg = { .ddi = &ddi };
-- 
2.47.3


