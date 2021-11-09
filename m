Return-Path: <SRS0=LC5L=P4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B17C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Nov 2021 06:49:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D4061075
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Nov 2021 06:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5D4061075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpJWM2BnHz301k
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Nov 2021 17:49:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=DkNEr8Ce;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634;
 helo=mail-pl1-x634.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=DkNEr8Ce; dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpJVc4G98z2xMw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Nov 2021 17:49:10 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id b11so5949203pld.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Nov 2021 22:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZLl1f9SDVtb244CMHgxSAOixJujtFCPCkC93h+WkT2E=;
 b=DkNEr8Ce6ObvZ9WxowOIMchyoiZcc1FgUlCpleIJxSwLomVpdmriZYvgahKHk6X2Z1
 ZABFR1GTqBuwdNF8xDFeELZvoPQXwvCY3GEFhUdXfYRzKDIkYhAXtPUsU985aEQkhBec
 PN3srIKTfEeoX8cQ4xOwGlLbtvzfwsRINN1+4XL/ZIWCtN9UTMnw3zyZvJ9te6sXNZmF
 xj4jhMfh60OuoAcsX7haJn6pz+ybfIb5psXuV9JDC7WQyJLRhQ+oYD9SQ4nSJ/KYU6SG
 wvV36BPJjxoE1xj+ckFb2OXZzwKVYCSnuUj3xGgnwhTkY1W90pXRtKuyJoM/KIAL2ev9
 gVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZLl1f9SDVtb244CMHgxSAOixJujtFCPCkC93h+WkT2E=;
 b=FcPDvahh9wFAufDWw1+od+BPSoCKcGM3zsGK4OHqN0PmSJiwvEauz0vpo1WQIZw/HN
 YFu5i/ot97JwlSyhgh53o6L9RvRbg1kBu7XZpgHNFbJ+D2kIAscGTgJlj3C/mfRUebJ/
 ccrR9fCpVJE7zV+hGPHwxHYRo5JRsU12hxzmo+fWaXe/LMVMkXf9WYynh2gfYi5xnY3G
 HeJ/7HORWhiSJpd8bO2wCuyRFY0vu9vF+X9VwV3DsED4VmWbWrmwmqNf0thqFRZKEl26
 NONr8VYVrrotJLISyc+QHzHrohNDqv9z4R94EAUSnrT+NVr54ac++3FfRwZOvNWM802d
 u3Iw==
X-Gm-Message-State: AOAM533BIne7AvAvf5GxaqQooIDPnUwD9YfhAd1ogujTjVzvObboxoyS
 VsxkA7udjyBj6bIKOcEBBFRVjh5mEgo=
X-Google-Smtp-Source: ABdhPJyh9+6DiCkoE98YJzJZ7bJs2wGMknzbp1tuhtNI0YahIIrOUZ/vrqo/eWvcAphWjB5My7hEng==
X-Received: by 2002:a17:902:778a:b0:13f:672c:103a with SMTP id
 o10-20020a170902778a00b0013f672c103amr4759803pll.55.1636440548029; 
 Mon, 08 Nov 2021 22:49:08 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-241-46-56.tpgi.com.au. [60.241.46.56])
 by smtp.gmail.com with ESMTPSA id
 17sm18227188pfp.14.2021.11.08.22.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Nov 2021 22:49:07 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] powerpc/pseries: rename numa_dist_table to
 form2_distances
Date: Tue,  9 Nov 2021 16:48:59 +1000
Message-Id: <20211109064900.2041386-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The name of the local variable holding the "form2" property address
conflicts with the numa_distance_table global.

This patch does 's/numa_dist_table/form2_distances/g' over the function,
which also renames numa_dist_table_length to form2_distances_length.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/numa.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 6f14c8fb6359..53e990140916 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -376,9 +376,9 @@ static void initialize_form2_numa_distance_lookup_table(void)
 {
 	int i, j;
 	struct device_node *root;
-	const __u8 *numa_dist_table;
+	const __u8 *form2_distances;
 	const __be32 *numa_lookup_index;
-	int numa_dist_table_length;
+	int form2_distances_length;
 	int max_numa_index, distance_index;
 
 	if (firmware_has_feature(FW_FEATURE_OPAL))
@@ -392,20 +392,20 @@ static void initialize_form2_numa_distance_lookup_table(void)
 	max_numa_index = of_read_number(&numa_lookup_index[0], 1);
 
 	/* first element of the array is the size and is encode-int */
-	numa_dist_table = of_get_property(root, "ibm,numa-distance-table", NULL);
-	numa_dist_table_length = of_read_number((const __be32 *)&numa_dist_table[0], 1);
+	form2_distances = of_get_property(root, "ibm,numa-distance-table", NULL);
+	form2_distances_length = of_read_number((const __be32 *)&form2_distances[0], 1);
 	/* Skip the size which is encoded int */
-	numa_dist_table += sizeof(__be32);
+	form2_distances += sizeof(__be32);
 
-	pr_debug("numa_dist_table_len = %d, numa_dist_indexes_len = %d\n",
-		 numa_dist_table_length, max_numa_index);
+	pr_debug("form2_distances_len = %d, numa_dist_indexes_len = %d\n",
+		 form2_distances_length, max_numa_index);
 
 	for (i = 0; i < max_numa_index; i++)
 		/* +1 skip the max_numa_index in the property */
 		numa_id_index_table[i] = of_read_number(&numa_lookup_index[i + 1], 1);
 
 
-	if (numa_dist_table_length != max_numa_index * max_numa_index) {
+	if (form2_distances_length != max_numa_index * max_numa_index) {
 		WARN(1, "Wrong NUMA distance information\n");
 		/* consider everybody else just remote. */
 		for (i = 0;  i < max_numa_index; i++) {
@@ -427,7 +427,7 @@ static void initialize_form2_numa_distance_lookup_table(void)
 			int nodeA = numa_id_index_table[i];
 			int nodeB = numa_id_index_table[j];
 
-			numa_distance_table[nodeA][nodeB] = numa_dist_table[distance_index++];
+			numa_distance_table[nodeA][nodeB] = form2_distances[distance_index++];
 			pr_debug("dist[%d][%d]=%d ", nodeA, nodeB, numa_distance_table[nodeA][nodeB]);
 		}
 	}
-- 
2.23.0

