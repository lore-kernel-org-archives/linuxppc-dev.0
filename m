Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5528BC282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 09:42:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C54F222BA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 09:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C54F222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zvhD5nw0zDqML
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 20:42:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.221.67; helo=mail-wr1-f67.google.com;
 envelope-from=mstsxfx@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zvf66d0pzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 20:40:46 +1100 (AEDT)
Received: by mail-wr1-f67.google.com with SMTP id r2so1654249wrv.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 01:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KPQIvusfQffcbSiTMJqq6ntVvlDynZgSpryXWkwTGaM=;
 b=JYJmFp8iRlU9Or4N3l4Zod/dg1JALnFxvw7x2TYiyIK0T9ERxpARsm9apruMc0FqXJ
 EDybgiSC40bAEEL1ouRN1kszBVOSmNSWBzJgzxNFx5KTwEuoGJPKNa7WAGxXNx+LO1C0
 XLkifewkFzVs4vlclwp0iUczLn9+SSCDyuVKTiNt4bXjus+FrUDo+eIZtilWh8jTuPDI
 XPWe6N+GU8O2aB4qlqqjVSW0ZI/hI+zYe8B6uWpnMNOcd+ket+pv2Dn29WCB70lAAl5B
 0W7gmUyWPojXyXpb8Syt2YHrLwWZ4vyNNBXsOZ96/iC398JIdKah/izb2T3s+DH9ODNV
 n+bg==
X-Gm-Message-State: AHQUAuaIW/0IxGjeccUG4BTIpPrXH6tWlTaAThzBiHWnFZGQhlskH+NH
 O8yNhAtwATQCuJKOc/GMlD8=
X-Google-Smtp-Source: AHgI3IZuh4Vbs+i/l3tBIYxc0NPmfUP4uiVUoKfoZUsXIyJmFEXYRFSSKGguAs+YWrr2sqbfmcUeRQ==
X-Received: by 2002:adf:de83:: with SMTP id w3mr6080776wrl.56.1550050843722;
 Wed, 13 Feb 2019 01:40:43 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-151-205.eurotel.cz.
 [37.188.151.205])
 by smtp.gmail.com with ESMTPSA id i13sm20879739wrm.86.2019.02.13.01.40.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 01:40:42 -0800 (PST)
From: Michal Hocko <mhocko@kernel.org>
To: <linux-mm@kvack.org>
Subject: [PATCH v2 2/2] mm: be more verbose about zonelist initialization
Date: Wed, 13 Feb 2019 10:40:34 +0100
Message-Id: <20190213094034.1341-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212095343.23315-3-mhocko@kernel.org>
References: <20190212095343.23315-3-mhocko@kernel.org>
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
 Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Michal Hocko <mhocko@suse.com>

We have seen several bugs where zonelists have not been initialized
properly and it is not really straightforward to track those bugs down.
One way to help a bit at least is to dump zonelists of each node when
they are (re)initialized.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/page_alloc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e097f336126..02c843f0db4f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5234,6 +5234,7 @@ static void build_zonelists(pg_data_t *pgdat)
 	int node, load, nr_nodes = 0;
 	nodemask_t used_mask;
 	int local_node, prev_node;
+	struct zone *zone;
 
 	/* NUMA-aware ordering of nodes */
 	local_node = pgdat->node_id;
@@ -5259,6 +5260,11 @@ static void build_zonelists(pg_data_t *pgdat)
 
 	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
 	build_thisnode_zonelists(pgdat);
+
+	pr_info("node[%d] zonelist: ", pgdat->node_id);
+	for_each_zone_zonelist(zone, z, &pgdat->node_zonelists[ZONELIST_FALLBACK], MAX_NR_ZONES-1)
+		pr_cont("%d:%s ", zone_to_nid(zone), zone->name);
+	pr_cont("\n");
 }
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
-- 
2.20.1

