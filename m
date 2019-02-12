Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC44C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 09:58:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE1E2184A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 09:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE1E2184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zJ5L2ZcWzDqNj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 20:58:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.208.67; helo=mail-ed1-f67.google.com;
 envelope-from=mstsxfx@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zHzr2fWrzDqNk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 20:54:00 +1100 (AEDT)
Received: by mail-ed1-f67.google.com with SMTP id d9so1596714edh.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 01:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VWzlY1PPQ+/67pm+/z2QkBDdCvOyUHPQEXMFpI7S4nM=;
 b=tpwRmfyNRA/Bks2cLmIxp+Im3OBhAqNA6QpeAeW8nzLjcNz2dODKE/WcJkJaNtGHc4
 N4xb0GGixUxTbujsYPD5OvkHvavpuf1cq59gFsUS7KZfm4dabxTDCuooEcLMJHym2Lv8
 glMbd6RXBrQ3QKHE4nhYb5JIiFigg/lBKQBcheXM7nFtPT5YFTcTxwKiAs+kKCbXf23B
 rHKxzr2h3uVDBGqYkUgB5RMyi6+fqUeCS8qmV01oxtcc3s6pO58q07Ub48uT5xciON6t
 r+QkEQ+VWKEpO1Iwv69DRzIrTA97u+WG8pdsGLCQ4JBCaMqxa/LXzSSMMKh82rwEwvZh
 O8Vg==
X-Gm-Message-State: AHQUAubRGrCi6HocqIV+U/LzhK+CkLm150yOC6m1K2l9s90We344TWTz
 8K9oMADsu60eQGdr1qyM6Zc=
X-Google-Smtp-Source: AHgI3IaDbQaoXUddyxRvptd1P3Q3Dkjw68Kopy2TfOs74h07Sehg+Np/NzTW4ul6z23IsVehH0xtyg==
X-Received: by 2002:a17:906:18f1:: with SMTP id
 e17mr2093489ejf.82.1549965237531; 
 Tue, 12 Feb 2019 01:53:57 -0800 (PST)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com.
 [213.151.95.130])
 by smtp.gmail.com with ESMTPSA id i14sm2876791ejy.25.2019.02.12.01.53.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 01:53:56 -0800 (PST)
From: Michal Hocko <mhocko@kernel.org>
To: <linux-mm@kvack.org>
Subject: [PATCH 2/2] mm: be more verbose about zonelist initialization
Date: Tue, 12 Feb 2019 10:53:43 +0100
Message-Id: <20190212095343.23315-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212095343.23315-1-mhocko@kernel.org>
References: <20190212095343.23315-1-mhocko@kernel.org>
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
 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e097f336126..c30d59f803fb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5259,6 +5259,11 @@ static void build_zonelists(pg_data_t *pgdat)
 
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

