Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBC5C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 09:44:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24194222BA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 09:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24194222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zvkv1d2gzDqVh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 20:44:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.221.66; helo=mail-wr1-f66.google.com;
 envelope-from=mstsxfx@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zvjC0QXjzDq8D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 20:43:26 +1100 (AEDT)
Received: by mail-wr1-f66.google.com with SMTP id q1so1683402wrp.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 01:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kk/GG3OgbzX8YIM46cZBNoZxrXJT1E5EGBKwMDd7vXI=;
 b=YDu8H8BagU48wafGcwJSiJd69aJDdrl//U0b3Ew6wCtn+FKbkaMUOPV2x7UGX7XUfu
 McSIVP41yrycUxPPv+ngLyd9J/dHXKG6gN6WpEG5u8aV/7dOOw4xSZRR5RNaAbrvFGq/
 BcJrfKZgwoqCmVoe6Aa9URcKcHDnJWKUyW8sgpb410XCsi7fO9HimQ/wL+BOH4213Exw
 YsuG6ZpaPgiM/D8YiTHUmU5dTK0F/6YwNDkpvaBdB+2+Yq1j6plfba0AzQMqZkuMaVwV
 PSdo6o4q23PiEziC1JNd+rRxv1OTxR2dTAXVPx1c7Fc9wtSSJiUcxqlZaNLmW5Q0YGNa
 H0Bg==
X-Gm-Message-State: AHQUAuaaNETB0Cxt5F3aGFujMhnXUquyvqkZqBLWB+lgP8nhkQizo3GS
 FOb+ttj74PuH/n6iA4jYQ+o=
X-Google-Smtp-Source: AHgI3IZGZGyJI5vbywvzsWNw+C5pG4oYQrFxR54toXy/PK1qWoOPyoC6Bgzg4NOhsQ5CAtgQdn/loQ==
X-Received: by 2002:a5d:4b07:: with SMTP id v7mr6179697wrq.281.1550051004381; 
 Wed, 13 Feb 2019 01:43:24 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-151-205.eurotel.cz.
 [37.188.151.205])
 by smtp.gmail.com with ESMTPSA id x21sm6111396wmi.28.2019.02.13.01.43.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 01:43:23 -0800 (PST)
From: Michal Hocko <mhocko@kernel.org>
To: <linux-mm@kvack.org>
Subject: [PATCH v3 2/2] mm: be more verbose about zonelist initialization
Date: Wed, 13 Feb 2019 10:43:15 +0100
Message-Id: <20190213094315.3504-1-mhocko@kernel.org>
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

Sorry for spamming. I have screwed up ammending the previous version.

 mm/page_alloc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e097f336126..52e54d16662a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5234,6 +5234,8 @@ static void build_zonelists(pg_data_t *pgdat)
 	int node, load, nr_nodes = 0;
 	nodemask_t used_mask;
 	int local_node, prev_node;
+	struct zone *zone;
+	struct zoneref *z;
 
 	/* NUMA-aware ordering of nodes */
 	local_node = pgdat->node_id;
@@ -5259,6 +5261,11 @@ static void build_zonelists(pg_data_t *pgdat)
 
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

