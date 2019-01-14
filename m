Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51040C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 08:26:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C995020663
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 08:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C995020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dRPn3ZfFzDqT8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 19:26:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.128.65; helo=mail-wm1-f65.google.com;
 envelope-from=mstsxfx@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dRN16VpszDqPd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 19:24:30 +1100 (AEDT)
Received: by mail-wm1-f65.google.com with SMTP id a62so7899741wmh.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 00:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p1cwabWxBmRqiOaivK/gahfjaCYafOC3a8HDbfTXpLE=;
 b=EZH+DPhlkIATvZ9c7KsOqNRb4D8CaKmmphPgJX1g9tToH0erXSSbBaKjEJRgNxIlZs
 gqEe7NFKTCVLYFj9a9pIft7wbdiOKjjCHbCUFCXgq5NuJi3cEMHn8rpH3DiE0GOPH2JV
 fUSHwNbp68ww/yppIa7S7xmbVPO94zdk/re6ikCpL8v/yQ1I8sYjk3lbsKNmsmM+3HZs
 B134dpWOL4WfbGG4yS159hTqCZ3ImONcZ40xq9PzgCCTjDJII+LGvbFL8/uUmJKbDLY/
 zenYeWace3eGFS8jASGdOxDQRQc0yNKcuGAKZQqYRE9C7yugzcsKq7ydOagy0pr7Rj1x
 Da8Q==
X-Gm-Message-State: AJcUukci8L7pt6V1GaZ+MLUZElB9/VK6YvFi0QcYhWFjENth5hbSvKxb
 5HP6m4asDc4qkTmi5kzOy6M=
X-Google-Smtp-Source: ALg8bN5LFk3cdiVrPSANKiBR5M+5ch2uyYwtW/fqgh8nQcBUGoRO2HI1jbNbbD0LhRn1vHgN8KcBYA==
X-Received: by 2002:a1c:b14:: with SMTP id 20mr11146490wml.103.1547454267726; 
 Mon, 14 Jan 2019 00:24:27 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-154-184.eurotel.cz.
 [37.188.154.184])
 by smtp.gmail.com with ESMTPSA id o8sm62327838wrx.15.2019.01.14.00.24.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 00:24:26 -0800 (PST)
From: Michal Hocko <mhocko@kernel.org>
To: <linux-mm@kvack.org>
Subject: [RFC PATCH] x86, numa: always initialize all possible nodes
Date: Mon, 14 Jan 2019 09:24:16 +0100
Message-Id: <20190114082416.30939-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Pingfan Liu <kernelfans@gmail.com>,
 Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Michal Hocko <mhocko@suse.com>

Pingfan Liu has reported the following splat
[    5.772742] BUG: unable to handle kernel paging request at 0000000000002088
[    5.773618] PGD 0 P4D 0
[    5.773618] Oops: 0000 [#1] SMP NOPTI
[    5.773618] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc1+ #3
[    5.773618] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.4.3 06/29/2018
[    5.773618] RIP: 0010:__alloc_pages_nodemask+0xe2/0x2a0
[    5.773618] Code: 00 00 44 89 ea 80 ca 80 41 83 f8 01 44 0f 44 ea 89 da c1 ea 08 83 e2 01 88 54 24 20 48 8b 54 24 08 48 85 d2 0f 85 46 01 00 00 <3b> 77 08 0f 82 3d 01 00 00 48 89 f8 44 89 ea 48 89
e1 44 89 e6 89
[    5.773618] RSP: 0018:ffffaa600005fb20 EFLAGS: 00010246
[    5.773618] RAX: 0000000000000000 RBX: 00000000006012c0 RCX: 0000000000000000
[    5.773618] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000002080
[    5.773618] RBP: 00000000006012c0 R08: 0000000000000000 R09: 0000000000000002
[    5.773618] R10: 00000000006080c0 R11: 0000000000000002 R12: 0000000000000000
[    5.773618] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000002
[    5.773618] FS:  0000000000000000(0000) GS:ffff8c69afe00000(0000) knlGS:0000000000000000
[    5.773618] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.773618] CR2: 0000000000002088 CR3: 000000087e00a000 CR4: 00000000003406e0
[    5.773618] Call Trace:
[    5.773618]  new_slab+0xa9/0x570
[    5.773618]  ___slab_alloc+0x375/0x540
[    5.773618]  ? pinctrl_bind_pins+0x2b/0x2a0
[    5.773618]  __slab_alloc+0x1c/0x38
[    5.773618]  __kmalloc_node_track_caller+0xc8/0x270
[    5.773618]  ? pinctrl_bind_pins+0x2b/0x2a0
[    5.773618]  devm_kmalloc+0x28/0x60
[    5.773618]  pinctrl_bind_pins+0x2b/0x2a0
[    5.773618]  really_probe+0x73/0x420
[    5.773618]  driver_probe_device+0x115/0x130
[    5.773618]  __driver_attach+0x103/0x110
[    5.773618]  ? driver_probe_device+0x130/0x130
[    5.773618]  bus_for_each_dev+0x67/0xc0
[    5.773618]  ? klist_add_tail+0x3b/0x70
[    5.773618]  bus_add_driver+0x41/0x260
[    5.773618]  ? pcie_port_setup+0x4d/0x4d
[    5.773618]  driver_register+0x5b/0xe0
[    5.773618]  ? pcie_port_setup+0x4d/0x4d
[    5.773618]  do_one_initcall+0x4e/0x1d4
[    5.773618]  ? init_setup+0x25/0x28
[    5.773618]  kernel_init_freeable+0x1c1/0x26e
[    5.773618]  ? loglevel+0x5b/0x5b
[    5.773618]  ? rest_init+0xb0/0xb0
[    5.773618]  kernel_init+0xa/0x110
[    5.773618]  ret_from_fork+0x22/0x40
[    5.773618] Modules linked in:
[    5.773618] CR2: 0000000000002088
[    5.773618] ---[ end trace 1030c9120a03d081 ]---

with his AMD machine with the following topology
  NUMA node0 CPU(s):     0,8,16,24
  NUMA node1 CPU(s):     2,10,18,26
  NUMA node2 CPU(s):     4,12,20,28
  NUMA node3 CPU(s):     6,14,22,30
  NUMA node4 CPU(s):     1,9,17,25
  NUMA node5 CPU(s):     3,11,19,27
  NUMA node6 CPU(s):     5,13,21,29
  NUMA node7 CPU(s):     7,15,23,31

[    0.007418] Early memory node ranges
[    0.007419]   node   1: [mem 0x0000000000001000-0x000000000008efff]
[    0.007420]   node   1: [mem 0x0000000000090000-0x000000000009ffff]
[    0.007422]   node   1: [mem 0x0000000000100000-0x000000005c3d6fff]
[    0.007422]   node   1: [mem 0x00000000643df000-0x0000000068ff7fff]
[    0.007423]   node   1: [mem 0x000000006c528000-0x000000006fffffff]
[    0.007424]   node   1: [mem 0x0000000100000000-0x000000047fffffff]
[    0.007425]   node   5: [mem 0x0000000480000000-0x000000087effffff]

and nr_cpus set to 4. The underlying reason is tha the device is bound
to node 2 which doesn't have any memory and init_cpu_to_node only
initializes memory-less nodes for possible cpus which nr_cpus restrics.
This in turn means that proper zonelists are not allocated and the page
allocator blows up.

Fix the issue by reworking how x86 initializes the memory less nodes.
The current implementation is hacked into the workflow and it doesn't
allow any flexibility. There is init_memory_less_node called for each
offline node that has a CPU as already mentioned above. This will make
sure that we will have a new online node without any memory. Much later
on we build a zone list for this node and things seem to work, except
they do not (e.g. due to nr_cpus). Not to mention that it doesn't really
make much sense to consider an empty node as online because we just
consider this node whenever we want to iterate nodes to use and empty
node is obviously not the best candidate. This is all just too fragile.

Reported-by: Pingfan Liu <kernelfans@gmail.com>
Tested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---

Hi,
I am sending this as an RFC because I am not sure this is the proper way
to go myself. I am especially not sure about other architectures
supporting memoryless nodes (ppc and ia64 AFAICS or are there more?).

I would appreciate a help with those architectures because I couldn't
really grasp how the memoryless nodes are really initialized there. E.g.
ppc only seem to call setup_node_data for online nodes but I couldn't
find any special treatment for nodes without any memory.

Any further help, comments are appreaciated!

 arch/x86/mm/numa.c | 27 +++------------------------
 mm/page_alloc.c    | 15 +++++++++------
 2 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 1308f5408bf7..b3621ee4dfe8 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -216,8 +216,6 @@ static void __init alloc_node_data(int nid)
 
 	node_data[nid] = nd;
 	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
-
-	node_set_online(nid);
 }
 
 /**
@@ -570,7 +568,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 		return -EINVAL;
 
 	/* Finally register nodes. */
-	for_each_node_mask(nid, node_possible_map) {
+	for_each_node_mask(nid, numa_nodes_parsed) {
 		u64 start = PFN_PHYS(max_pfn);
 		u64 end = 0;
 
@@ -581,9 +579,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 			end = max(mi->blk[i].end, end);
 		}
 
-		if (start >= end)
-			continue;
-
 		/*
 		 * Don't confuse VM with a node that doesn't have the
 		 * minimum amount of memory:
@@ -592,6 +587,8 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 			continue;
 
 		alloc_node_data(nid);
+		if (end)
+			node_set_online(nid);
 	}
 
 	/* Dump memblock with node info and return. */
@@ -721,21 +718,6 @@ void __init x86_numa_init(void)
 	numa_init(dummy_numa_init);
 }
 
-static void __init init_memory_less_node(int nid)
-{
-	unsigned long zones_size[MAX_NR_ZONES] = {0};
-	unsigned long zholes_size[MAX_NR_ZONES] = {0};
-
-	/* Allocate and initialize node data. Memory-less node is now online.*/
-	alloc_node_data(nid);
-	free_area_init_node(nid, zones_size, 0, zholes_size);
-
-	/*
-	 * All zonelists will be built later in start_kernel() after per cpu
-	 * areas are initialized.
-	 */
-}
-
 /*
  * Setup early cpu_to_node.
  *
@@ -763,9 +745,6 @@ void __init init_cpu_to_node(void)
 		if (node == NUMA_NO_NODE)
 			continue;
 
-		if (!node_online(node))
-			init_memory_less_node(node);
-
 		numa_set_node(cpu, node);
 	}
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ec9cc407216..2e097f336126 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5361,10 +5361,11 @@ static void __build_all_zonelists(void *data)
 	if (self && !node_online(self->node_id)) {
 		build_zonelists(self);
 	} else {
-		for_each_online_node(nid) {
+		for_each_node(nid) {
 			pg_data_t *pgdat = NODE_DATA(nid);
 
-			build_zonelists(pgdat);
+			if (pgdat)
+				build_zonelists(pgdat);
 		}
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
@@ -6644,10 +6645,8 @@ static unsigned long __init find_min_pfn_for_node(int nid)
 	for_each_mem_pfn_range(i, nid, &start_pfn, NULL, NULL)
 		min_pfn = min(min_pfn, start_pfn);
 
-	if (min_pfn == ULONG_MAX) {
-		pr_warn("Could not find start_pfn for node %d\n", nid);
+	if (min_pfn == ULONG_MAX)
 		return 0;
-	}
 
 	return min_pfn;
 }
@@ -6991,8 +6990,12 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
 	mminit_verify_pageflags_layout();
 	setup_nr_node_ids();
 	zero_resv_unavail();
-	for_each_online_node(nid) {
+	for_each_node(nid) {
 		pg_data_t *pgdat = NODE_DATA(nid);
+
+		if (!pgdat)
+			continue;
+
 		free_area_init_node(nid, NULL,
 				find_min_pfn_for_node(nid), NULL);
 
-- 
2.20.1

