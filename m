Return-Path: <linuxppc-dev+bounces-23031-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20318C43327
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 15:55:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gn0cg2h5Nz2yYd;
	Sat, 27 Jun 2026 01:55:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782489315;
	cv=none; b=h0d8OUlfXNayQ1ig9gZYTD/UZaTqcVcMzjL/3+MSYLCPgjic2GVhIbAkalNlTBWtYYE6mHu4t+BXwql1lj4ZI0WetBwDgj0T/DTJs1qM3o4TeKPQ7/mlD0ZuRmKWCLDuNk0AWsSrvfB+m8FeyLS+61PEeRQX5MBd9Q4LV90XXGr6/FwXd0AhWG6dVfDlsYpoKGMO9Y2VgZN2X/YPA1movevcnwa9OMJWisYIRQh6p/Z1lFVm+nBIMmY6ng4yewhfvddEWzpo/87srzxPZwnkyjQVva10ZMtLtBlydZlhuOHKeDo0wjWCGfLKmu2qvlyVxRrjUdT4MnAvtEFa/Pf/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782489315; c=relaxed/relaxed;
	bh=3Ce1ivL2u+pzFIhU3inz2XhQZgcVJMPkBIHLb8U0NEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYgB9FOjn0KRoHKb5OugoDPI3FfAEZYSjfrmkWB9E5l1gpvWSPLbtffHVNuhOiOjQtzFSDDcIbWInALqYYJVfkESp3HDYXb8Nucr0hPPZOnxZvDLPjS+Tz8JFPcoXn0cK5hNVBFHr/zG8OvY+gGg7WyH4OjC0V1Hcd9pxDke1E9NOGiUErHNPewyOaqKBlyd8DUGasUUaD4svOKm9GSvf1vQbD7KJjcvHy3KNB1FObTUmsU12QbzBFSXUey+U+PL3KEOZfZuoB5XwQ+LmV99j87DogbI9QL51k2VUDfSzaN5Z4kOM14luYGl2kiK24EVhONGGkMFgJ4hPKQe9EoCuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOOon28K; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOOon28K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gn0cf1xZKz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 01:55:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CDB52404C3;
	Fri, 26 Jun 2026 15:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA851F000E9;
	Fri, 26 Jun 2026 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782489311;
	bh=3Ce1ivL2u+pzFIhU3inz2XhQZgcVJMPkBIHLb8U0NEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aOOon28KnbYeL6fq04CX46DrOdtRGnEJBkiX8PyMiZjoOsbGH9ZqaCuHqTkwVEPRP
	 lCUe2dVwynO/Esz6q27hA8xSWwPzuBV8c6lkY2LZ0ReU35zH9rA7M9XhBAmOcwk2/1
	 COtOx5Zvo9YaBeO3usPWhONHEzJ5BXoNnYoGa0FG1d6bSeY91upGpdo1J57UVv01yi
	 HZUwILylvMhxrMC1D/v/lhbDYsjzckHsQ8Y8QP1bNcwm9E3htpmrrR1DEhyq7gY8rX
	 w9TrocZ1Yxyw0M/R118qcw5c61fjn7FLhl7XozKS78Z5ozhH9InEhM5chFMsEkbTT1
	 WoGJvl4ZRCbSQ==
Message-ID: <8663e05b-0e54-4c1a-a7d1-94e49f2ca178@kernel.org>
Date: Fri, 26 Jun 2026 17:55:05 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/mm: fix ksm NUMA merge test for systems
 with memoryless NUMA nodes
To: Sayali Patil <sayalip@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>,
 Liam.Howlett@oracle.com, linuxppc-dev@lists.ozlabs.org,
 Miaohe Lin <linmiaohe@huawei.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1782365671.git.sayalip@linux.ibm.com>
 <8540b58ef1fdbc2e5cb2f9fe28a2d2a54a5bc6a8.1782365671.git.sayalip@linux.ibm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <8540b58ef1fdbc2e5cb2f9fe28a2d2a54a5bc6a8.1782365671.git.sayalip@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>  
> +static int count_mem_nodes(void)
> +{
> +	int node, count = 0;
> +
> +	for (node = 0; node <= numa_max_node(); node++) {
> +		if (numa_node_size(node, NULL) > 0)
> +			count++;
> +	}
> +
> +	return count;
> +}
> +

Can we instead build upon our existing helpers get_first_mem_node() +
get_next_mem_node() ?

From 432774fb50237519c1c041e402fddfdf4b35aa2c Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 26 Jun 2026 17:52:21 +0200
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 tools/testing/selftests/mm/ksm_tests.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index a050f4840cfa3..2ebbb544c6711 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -440,9 +440,9 @@ static int get_next_mem_node(int node)
 		mem_node = i % (max_node + 1);
 		node_size = numa_node_size(mem_node, NULL);
 		if (node_size > 0)
-			break;
+			return mem_node;
 	}
-	return mem_node;
+	return -ENODEV;
 }
 
 static int get_first_mem_node(void)
@@ -455,8 +455,8 @@ static int check_ksm_numa_merge(int merge_type, int mapping, int prot, int timeo
 {
 	void *numa1_map_ptr, *numa2_map_ptr;
 	struct timespec start_time;
+	int first_node, second_node;
 	int page_count = 2;
-	int first_node;
 
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
 		ksft_perror("clock_gettime");
@@ -467,17 +467,19 @@ static int check_ksm_numa_merge(int merge_type, int mapping, int prot, int timeo
 		ksft_print_msg("NUMA support not enabled\n");
 		return KSFT_SKIP;
 	}
-	if (numa_num_configured_nodes() <= 1) {
-		ksft_print_msg("At least 2 NUMA nodes must be available\n");
+	first_node = get_first_mem_node();
+	second_node = get_next_mem_node(first_node);
+
+	if (second_node < 0) {
+		ksft_print_msg("At least 2 NUMA nodes with memory must be available\n");
 		return KSFT_SKIP;
 	}
 	if (ksm_write_sysfs(KSM_FP("merge_across_nodes"), merge_across_nodes))
 		return KSFT_FAIL;
 
 	/* allocate 2 pages in 2 different NUMA nodes and fill them with the same data */
-	first_node = get_first_mem_node();
 	numa1_map_ptr = numa_alloc_onnode(page_size, first_node);
-	numa2_map_ptr = numa_alloc_onnode(page_size, get_next_mem_node(first_node));
+	numa2_map_ptr = numa_alloc_onnode(page_size, second_node);
 	if (!numa1_map_ptr || !numa2_map_ptr) {
 		ksft_perror("numa_alloc_onnode");
 		return KSFT_FAIL;
-- 
2.43.0


-- 
Cheers,

David

