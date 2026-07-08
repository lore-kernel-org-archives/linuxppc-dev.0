Return-Path: <linuxppc-dev+bounces-23820-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8819C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 13:55:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwKPF1RN1z2xpn;
	Wed, 08 Jul 2026 23:55:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783518945;
	cv=none; b=dv8KS/QpM/kEGQRYrwsbtflOFMqbpzkCpw51ysjZF6AbQ3Ab3Onzm+58YdfQwMIolJv67Stc2PoY0a3YGhDx6cajOso+ydaejmnUt1xQuRkM8YgoI82wjDRSAkglvV56hy1rqF0RYWkn2q8dk+BIPY5PuY92PoVR5Y8Zi41QQSFkF7NikV+QMO/pO2UF2qYJnIEK+xVkn84DHzCQsWCQSRO+F/WQH0SJkWpu3Z+CE1AxGsU2gu4wATyyP4/mZBvtOZRYr/Xnr9OAfeQghH82hCxBG6kH7Qy8sOLlP0ke42f0SrCA7Xs1VOt7ekDHt+cNn7u4LTog1k22AocGISRLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783518945; c=relaxed/relaxed;
	bh=DumeYOm4RAsOVh0uQBPFbd4lfQ35Js58LdeDgME4iC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTMMhnT6H5AL7r+pk3qtXSbbC73sXetTc5daUVdUeho57MMqamE8DezyHeapfbfL9C5hPbQp54TGlmHmNoVF7AUsVCOl846bPmUq9TUyuU6aF1tvBO/JMWgI9TMwQPuwAFzH16YhKP7ZWPtQ5T18L2MGALqRQxTJCc1wvji/YXS3vmRjsbaxXTdw2rHSmLcVx+zuzs9pAkR5kzp5U1WO/uwqC7jF8fN0gsB0DP2OckKUbRoJlgoHnnWboriNRBGHKPKhGYr14EG2xEci8DqAR234PXplCeV3G+JZt1MZgmmE2EnM7A4mAK/6RTB9/nkevNB1GR41XN+tuAOqr6rOoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ApkfZAPe; dkim-atps=neutral; spf=pass (client-ip=95.215.58.171; helo=out-171.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ApkfZAPe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.171; helo=out-171.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwKPD1GtFz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 23:55:43 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783518924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DumeYOm4RAsOVh0uQBPFbd4lfQ35Js58LdeDgME4iC8=;
	b=ApkfZAPexPaSLNtsfl42DBx1qyChc5EO2KpX8eeuck2SebANu8tOXOMCQ1T+/zOIgmk5bY
	4ee5xmFvzYgajiV3YeMtkSbdFKoo1DTlJed8IyOX2toProdSQ1KS5WwncTjvJLWvf3O0wz
	lP4gXygReDf/aARZ4m/KTneai1EYZ3A=
From: Usama Arif <usama.arif@linux.dev>
To: Sayali Patil <sayalip@linux.ibm.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Michal Hocko <mhocko@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Dev Jain <dev.jain@arm.com>,
	Liam.Howlett@oracle.com,
	linuxppc-dev@lists.ozlabs.org,
	Miaohe Lin <linmiaohe@huawei.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] selftests/mm: fix ksm NUMA merge test for systems with memoryless NUMA nodes
Date: Wed,  8 Jul 2026 06:55:02 -0700
Message-ID: <20260708135503.180169-1-usama.arif@linux.dev>
In-Reply-To: <78a3b0e3fb94004c0710872c5bab6f7381b7d63c.1783446924.git.sayalip@linux.ibm.com>
References: 
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
X-Migadu-Flow: FLOW_OUT

On Wed,  8 Jul 2026 12:29:06 +0530 Sayali Patil <sayalip@linux.ibm.com> wrote:

> The KSM NUMA merge test allocates identical pages on different NUMA
> nodes and verifies KSM behavior with merge_across_nodes enabled and
> disabled.
> 
> On systems with memoryless NUMA nodes, for example:
>  #numactl  -H
>       available: 2 nodes (0,4)
>       .....
>       node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
>       node 0 size: 14825 MB
>       node 0 free: 1382 MB
>       node 4 cpus:
>       node 4 size: 0 MB
>       node 4 free: 0 MB
> 
> the test may attempt to allocate memory on a node without memory,
> causing numa_alloc_onnode() to fail and resulting in a spurious test
> failure.
> 
> The test currently checks numa_num_configured_nodes() to determine
> whether sufficient NUMA nodes are available. However, configured nodes
> do not necessarily have memory.
> 
> Reuse the existing get_first_mem_node() and get_next_mem_node()
> helpers to locate NUMA nodes that actually contain memory, and skip
> the test when fewer than two such nodes are available.
> 
> Before patch:
>        ---------------------------
> 	running ./ksm_tests -N -m 1
>        ---------------------------
>         mbind: Invalid argument
>         ok 1 KSM NUMA merging
> 	Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>         [PASS]
>        ok 1 ksm_tests -N -m 1
>        ---------------------------
>         running ./ksm_tests -N -m 0
>        ---------------------------
>         mbind: Invalid argument
>         not ok 1 KSM NUMA merging
> 	Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
>         [FAIL]
>        not ok 2 ksm_tests -N -m 0 # exit=1
> 
> After patch:
>        ---------------------------
>         running ./ksm_tests -N -m 1
>        ---------------------------
>         At least 2 NUMA nodes with memory must be available
> 	ok 1
> 	SKIP KSM NUMA merging
> 	Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>         [PASS]
>         ok 1 ksm_tests -N -m 1
>        ---------------------------
>         running ./ksm_tests -N -m 0
>        ---------------------------
>         At least 2 NUMA nodes with memory must be available
> 	ok 1
> 	SKIP KSM NUMA merging
> 	Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>         [PASS]
>         ok 2 ksm_tests -N -m 0
> 
> Fixes: e3820ab252dd ("selftest/vm: fix ksm selftest to run with different NUMA topologies")
> Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>  tools/testing/selftests/mm/ksm_tests.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 

Acked-by: Usama Arif <usama.arif@linux.dev> 

