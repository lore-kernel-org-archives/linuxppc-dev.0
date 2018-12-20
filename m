Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FCDC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 10:01:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF0021741
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 10:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ5Sby/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF0021741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L6jV3wDJzDr6t
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 21:01:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZZ5Sby/E";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=kernelfans@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZZ5Sby/E"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43L6Tp51KlzDqyH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 20:51:26 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id g9so634645plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 01:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TzK/offuMiftcp8zdhetLLgTPbF5oMiPcKmIl7aXSqs=;
 b=ZZ5Sby/EbDZxJq5f8tEKiQXeJ3J+mgYGawoOSTjOqgDokHbe87vYBeNjo26rvurFaH
 u3zyMw8brzZW1JMc9FjAOrm4Aj/eCAyMVOZ+o/HrnUx6CdhsglE5aND0oCD2+FCKLRHg
 AMRuF+da/oCmYx8zey98h3O8QieoawwVMlJx8f9LNVqnOOy6Iu4fvIFg/4gmx75BhE61
 fgAlr6TBOTxYrqpZxnaIER6Z+ERYvDmAQ7v6Ar/6dPfQSwRPJepnwqBw/bOO4t8teuvH
 qKy7ibtg29/9AnICPYBinuXDq223N45klFHNLiK7+CQYyaGDGMmJlCB6UlUmOoqT7BX9
 SLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TzK/offuMiftcp8zdhetLLgTPbF5oMiPcKmIl7aXSqs=;
 b=MY78+WACtu6RIKLu8WkYqnE/7AX73iSxdmRx5XlcYzocSqR0DBWjy/a3ZpnHFDmCps
 UbT6wRIoGFa0926s1h5yuR1qtMV+ppEj1uZwQ85q088RdljTvUYMbmiqXohbaU2M0JvN
 gdgLPMbmeAGd4b128EPHFgHUbLnzIF9C8rZWWtU8I5fKWYOz7zDTk0S2XP7/hYowCQ9Z
 u0RTqEOo8MkSMU9HgSIFy3uO7b8kUrG9w+RMSkWSb2E4r++8ZkZ9ME3dK258PXnO4y3K
 h12L6odRRgcuD9klrAWH6OqK7O9L9tYr2NorJjd3WzbUzI5sMm0/JWZo7R6T77TTudXq
 jJwQ==
X-Gm-Message-State: AA+aEWZeX2TgR2G6pBmK2m3GQtS/yp1Owmr3wz+v7XaLDrqr6hXj3CnJ
 gIZUPQI0ETI93NlbJKTTyw==
X-Google-Smtp-Source: AFSGD/W+peKcgU2gsTb6UnoUotPkHL3GAnOzUnutuIhsRU+AXYQggUTAl5j7u1dOBpTeYLPbe+s5fw==
X-Received: by 2002:a17:902:622:: with SMTP id
 31mr23030237plg.171.1545299485120; 
 Thu, 20 Dec 2018 01:51:25 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 125sm33355206pfx.159.2018.12.20.01.51.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 01:51:24 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-mm@kvack.org
Subject: [PATCHv2 3/3] powerpc/numa: make all possible node be instanced
 against NULL reference in node_zonelist()
Date: Thu, 20 Dec 2018 17:50:39 +0800
Message-Id: <1545299439-31370-4-git-send-email-kernelfans@gmail.com>
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

This patch tries to resolve a bug rooted at mm when using nr_cpus. It was
reported at [1]. The root cause is: device->numa_node info is used as
preferred_nid param for __alloc_pages_nodemask(), which causes NULL
reference when ac->zonelist = node_zonelist(preferred_nid, gfp_mask), due to
the preferred_nid is not online and not instanced. Hence the bug affects
all archs if a machine having a memory less numa-node, but a device on the
node is used and provide numa_node info to __alloc_pages_nodemask().
This patch makes all possible node online for ppc.

[1]: https://lore.kernel.org/patchwork/patch/1020838/

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
Note:
[1-2/3] implements one way to fix the bug, while this patch tries another way.
Hence using this patch when [1-2/3] is not acceptable.

 arch/powerpc/mm/numa.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index ce28ae5..31d81a4 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -864,10 +864,19 @@ void __init initmem_init(void)
 
 	memblock_dump_all();
 
-	for_each_online_node(nid) {
+	/* Instance all possible nodes to overcome potential NULL reference
+	 * issue on node_zonelist() when using nr_cpus
+	 */
+	for_each_node(nid) {
 		unsigned long start_pfn, end_pfn;
 
-		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+		if (node_online(nid))
+			get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+		else {
+			start_pfn = end_pfn = 0;
+			/* online it, so later zonelists[] will be built */
+			node_set_online(nid);
+		}
 		setup_node_data(nid, start_pfn, end_pfn);
 		sparse_memory_present_with_active_regions(nid);
 	}
-- 
2.7.4

