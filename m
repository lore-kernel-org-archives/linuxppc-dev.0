Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09553C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 09:58:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A9821741
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 09:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGC0CLRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A9821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L6f90yCZzDqLj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 20:58:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hGC0CLRd";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=kernelfans@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hGC0CLRd"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43L6Tg5P3VzDqyH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 20:51:19 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id b5so631149plr.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 01:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sOIHUE42+0sViIuMaJHTMI5OzKaY6mxVEUe/nrLXhqU=;
 b=hGC0CLRdy4EzFTWMV+LuCLwimeL9k1TKGDdAFza+twjRTdCx9rrynOQTHDPefhM3Z7
 iLaIZ9Fufgcaa9y2LmUewXgQL1TsNv/st6XbYFLnt20gjFxDX9m84BKfoSXVCXil69wD
 TllkxbM2JwzMlSx4THvVfF+HUhPHUmhNrBLMLKPqmgJ42s5j2I/5i1qaWqJdA+ayRRIf
 p/93OW9w9+qXYny7kb5rzHKMiG/JWuazuIIhBBAf8mchWAE5Gd32mm4fZ5W0jRJo2gol
 pLtnNkjrK63ZO91Ja6YFr1l9NLL8a+6ej1ct9hb64AbsBko/iK7Miv2B9bWwDVnhHmpm
 WswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sOIHUE42+0sViIuMaJHTMI5OzKaY6mxVEUe/nrLXhqU=;
 b=R/G+jlKvUhHrNIp0/KJEOM0YoirGE4xuxiQos2c7M+u7xQtcbIg0B+28rW7P74njMm
 Ta91pdy7mK7xiSpETfnc0yQ6NGULO2vNEJQbczOQngqX1y63XcvNmzRGTbdz1j/rLbyJ
 j3B1aJr2IYk1DVaEaBMkq4FdtHu7vfSYsIlVOo2KbcMUb8XnaF1D502xt9038V8jTVtW
 94nX4zNrR9/2tc6Oa6RoTwmqZ/KX5YU8+TOX05Y15/pN1Uw4k5ZumsxTB5l1tKo3OE55
 JsIaj1pVo4QVLZqd5vmy6vi/6t7U7+Fvig094Ufyemg7sWnF1Op9ITm3MkpubbfzIco6
 kvdg==
X-Gm-Message-State: AA+aEWZ2izXh8eQ49n6mU57db3tDZmbOXmZgO2OwWt4Mv/+6ABJQvGYY
 8rHqYCL6q4k1RWe3jyfs4g==
X-Google-Smtp-Source: AFSGD/UHe6RcX8ECuJ34w2PG6qPwczv0gjjsg1Ix99b3GCEmf0EuINpCnZFUtlvM+fSTq9bqbIPAXw==
X-Received: by 2002:a17:902:bd0a:: with SMTP id
 p10mr22744246pls.322.1545299477786; 
 Thu, 20 Dec 2018 01:51:17 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 125sm33355206pfx.159.2018.12.20.01.51.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 01:51:17 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-mm@kvack.org
Subject: [PATCHv2 2/3] mm/numa: build zonelist when alloc for device on
 offline node
Date: Thu, 20 Dec 2018 17:50:38 +0800
Message-Id: <1545299439-31370-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
References: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
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
Cc: Michal Hocko <mhocko@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 Pingfan Liu <kernelfans@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I hit a bug on an AMD machine, with kexec -l nr_cpus=4 option. It is due to
some pgdat is not instanced when specifying nr_cpus, e.g, on x86, not
initialized by init_cpu_to_node()->init_memory_less_node(). But
device->numa_node info is used as preferred_nid param for
__alloc_pages_nodemask(), which causes NULL reference
  ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
Although this bug is detected on x86, it should affect all archs, where
a machine with a numa-node having no memory, if nr_cpus prevents the
instance of the node, and the device on the node tries to allocate memory
with device->numa_node info.
There are two alternative methods to fix the bug.
-1. Make all possible numa nodes be instanced. This should be done for all
archs
-2. Using zonelist instead of pgdat when encountering un-instanced node,
and only do this when needed.
This patch adopts the 2nd method, uses possible_zonelist[] to mirror
node_zonelists[], and tries to build zonelist for the offline node when needed.

Notes about the crashing info:
-1. kexec -l with nr_cpus=4
-2. system info
  NUMA node0 CPU(s):     0,8,16,24
  NUMA node1 CPU(s):     2,10,18,26
  NUMA node2 CPU(s):     4,12,20,28
  NUMA node3 CPU(s):     6,14,22,30
  NUMA node4 CPU(s):     1,9,17,25
  NUMA node5 CPU(s):     3,11,19,27
  NUMA node6 CPU(s):     5,13,21,29
  NUMA node7 CPU(s):     7,15,23,31
-3. panic stack
[...]
[    5.721547] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    5.729187] pcieport 0000:00:01.1: Signaling PME with IRQ 34
[    5.735187] pcieport 0000:00:01.2: Signaling PME with IRQ 35
[    5.741168] pcieport 0000:00:01.3: Signaling PME with IRQ 36
[    5.747189] pcieport 0000:00:07.1: Signaling PME with IRQ 37
[    5.754061] pcieport 0000:00:08.1: Signaling PME with IRQ 39
[    5.760727] pcieport 0000:20:07.1: Signaling PME with IRQ 40
[    5.766955] pcieport 0000:20:08.1: Signaling PME with IRQ 42
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
[...]

Other notes about the reproduction of this bug:
After appling the following patch:
'commit 0d76bcc960e6 ("Revert "ACPI/PCI: Pay attention to device-specific
_PXM node values"")'
This bug is covered and not triggered on my test AMD machine.
But it should still exist since dev->numa_node info can be set by other
method on other archs when using nr_cpus param

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 include/linux/gfp.h | 10 +++++++++-
 mm/page_alloc.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 0705164..0ddf809 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -442,6 +442,9 @@ static inline int gfp_zonelist(gfp_t flags)
 	return ZONELIST_FALLBACK;
 }
 
+extern struct zonelist *possible_zonelists[];
+extern int build_fallback_zonelists(int node);
+
 /*
  * We get the zone list from the current node and the gfp_mask.
  * This zone list contains a maximum of MAXNODES*MAX_NR_ZONES zones.
@@ -453,7 +456,12 @@ static inline int gfp_zonelist(gfp_t flags)
  */
 static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 {
-	return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
+	if (unlikely(!possible_zonelists[nid])) {
+		WARN_ONCE(1, "alloc from offline node: %d\n", nid);
+		if (unlikely(build_fallback_zonelists(nid)))
+			nid = first_online_node;
+	}
+	return possible_zonelists[nid] + gfp_zonelist(flags);
 }
 
 #ifndef HAVE_ARCH_FREE_PAGE
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 17dbf6e..608b51d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -121,6 +121,8 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 };
 EXPORT_SYMBOL(node_states);
 
+struct zonelist *possible_zonelists[MAX_NUMNODES] __read_mostly;
+
 /* Protect totalram_pages and zone->managed_pages */
 static DEFINE_SPINLOCK(managed_page_count_lock);
 
@@ -5180,7 +5182,6 @@ static int find_next_best_node(int node, nodemask_t *used_node_mask)
 	return best_node;
 }
 
-
 /*
  * Build zonelists ordered by node and zones within node.
  * This results in maximum locality--normal zone overflows into local
@@ -5222,6 +5223,7 @@ static void build_thisnode_zonelists(struct zonelist *node_zonelists,
 	zonerefs->zone_idx = 0;
 }
 
+
 /*
  * Build zonelists ordered by zone and nodes within zones.
  * This results in conserving DMA zone[s] until all Normal memory is
@@ -5229,7 +5231,8 @@ static void build_thisnode_zonelists(struct zonelist *node_zonelists,
  * may still exist in local DMA zone.
  */
 
-static void build_zonelists(struct zonelist *node_zonelists, int local_node)
+static void build_zonelists(struct zonelist *node_zonelists,
+	int local_node, bool exclude_self)
 {
 	static int node_order[MAX_NUMNODES];
 	int node, load, nr_nodes = 0;
@@ -5240,6 +5243,8 @@ static void build_zonelists(struct zonelist *node_zonelists, int local_node)
 	load = nr_online_nodes;
 	prev_node = local_node;
 	nodes_clear(used_mask);
+	if (exclude_self)
+		node_set(local_node, used_mask);
 
 	memset(node_order, 0, sizeof(node_order));
 	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
@@ -5258,7 +5263,40 @@ static void build_zonelists(struct zonelist *node_zonelists, int local_node)
 	}
 
 	build_zonelists_in_node_order(node_zonelists, node_order, nr_nodes);
-	build_thisnode_zonelists(node_zonelists, local_node);
+	if (!exclude_self)
+		build_thisnode_zonelists(node_zonelists, local_node);
+	possible_zonelists[local_node] = node_zonelists;
+}
+
+/* this is rare case in which building zonelists for offline node, but
+ * there is dev used on it
+ */
+int build_fallback_zonelists(int node)
+{
+	static DEFINE_SPINLOCK(lock);
+	nodemask_t *used_mask;
+	struct zonelist *zl;
+	int ret = 0;
+
+	spin_lock(&lock);
+	if (unlikely(possible_zonelists[node] != NULL))
+		goto unlock;
+
+	used_mask = kmalloc(sizeof(nodemask_t), GFP_ATOMIC);
+	zl = kmalloc(sizeof(struct zonelist)*MAX_ZONELISTS, GFP_ATOMIC);
+	if (unlikely(!used_mask || !zl)) {
+		ret = -ENOMEM;
+		kfree(used_mask);
+		kfree(zl);
+		goto unlock;
+	}
+
+	__nodes_complement(used_mask, &node_online_map, MAX_NUMNODES);
+	build_zonelists(zl, node, true);
+	kfree(used_mask);
+unlock:
+	spin_unlock(&lock);
+	return ret;
 }
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
@@ -5283,7 +5321,8 @@ static void setup_min_unmapped_ratio(void);
 static void setup_min_slab_ratio(void);
 #else	/* CONFIG_NUMA */
 
-static void build_zonelists(struct zonelist *node_zonelists, int local_node)
+static void build_zonelists(struct zonelist *node_zonelists,
+	int local_node, bool _unused)
 {
 	int node, local_node;
 	struct zoneref *zonerefs;
@@ -5357,12 +5396,13 @@ static void __build_all_zonelists(void *data)
 	 * building zonelists is fine - no need to touch other nodes.
 	 */
 	if (self && !node_online(self->node_id)) {
-		build_zonelists(self->node_zonelists, self->node_id);
+		build_zonelists(self->node_zonelists, self->node_id, false);
 	} else {
 		for_each_online_node(nid) {
 			pg_data_t *pgdat = NODE_DATA(nid);
 
-			build_zonelists(pgdat->node_zonelists, pgdat->node_id);
+			build_zonelists(pgdat->node_zonelists, pgdat->node_id,
+				false);
 		}
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
-- 
2.7.4

