Return-Path: <linuxppc-dev+bounces-23186-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640E4C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 10:51:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqKgm02blz2yZ8;
	Tue, 30 Jun 2026 20:51:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782816659;
	cv=none; b=UKmEIjTDj/e4vK9ODpL5bZmlgrkiH2b4d+CSeURKWsRehTf5NlL7QpxUeR9aWd/uUpzB4mlOKKerhGgyMTXOLHK8eGZjEYNmDFSaadXECnscrskJjn5LlUk1Im6NHSaceNeKv0eY2herNpeeCjaeB/9CW4qY74hUIEBux8/7G5ENt6vrBB0G3150axM1vkjO83VmmIYrhFzhFbBbQoXNbMUDo06jxfXJDHkDVH60evUU/VxH97Qd+7KeQ/d5QyBWlfSrKxgmKCzOA2NQlFlRYGkmibB5moHaWGohsOWz+8QlhmkA0Qy6g56tOXyQTLnvkza2igDBUF378rkvyuuopg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782816659; c=relaxed/relaxed;
	bh=Ee+Ji06dGrCCESng4AdxunnQ1fk17gdu6y1uH4h0rlo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WH0M3LBtbbFvoiwBN2zuKjzgAlR4EnJpsXCEFxltYt41ASI8o//LciUH4tzDemWGp/ZDCCMgNgC8DBKzdj821v0kTMkx6RX9/fpuiDBk+dvxsb+eYpiv1vK4x485VZm+wh0gPcLer1M0kjMRubiN30dz9n9zHg5sJtubEFgBTeqKosnaac6V2isldh3PayQBuc7j1rL7pKTyO7Yu4nKsvGwvM5dvnhQb3W/X0GwbzSE6rKQWdW7G9fvZpXXH64tOZ59ItPaDr+mZLhKKqTdFGGgnvtAnai6abD91gWCF7lXJ+OW6DeRV+ZP/3QK7FefNwTsG6J9sXIa784OWXcJxqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rpRSW9O6; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rpRSW9O6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqKgk5fGjz2yYs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 20:50:58 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nAXt1581651;
	Tue, 30 Jun 2026 10:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ee+Ji0
	6dGrCCESng4AdxunnQ1fk17gdu6y1uH4h0rlo=; b=rpRSW9O6e7saQ5O6xsZd5B
	dD+plxvEqNRK/6D7l28MZ5PmaUWre6wNk5Ue1LxLqnF3c3WLHU1ToEdbE94YKqDf
	cJDgvn73BEsRz2WhMPyF02c+Vy+hha32f0CdV0XRcIFVsCLqzlpZaNW3PffVDMEs
	sV8fgrPIQzPMBuEq2nfKy+h2gtOZa24KXWQmI5JyFBah0A/xG0138cDEHXOXoP0e
	E9wqwNgJc8PtE+naqtvbKvaBGNEBs7dayWe46xcBRpUA82Ru22FHdlN/2+gPRhWC
	GryHaNnmkHm2RbY5+KGZvrJ9WOliRDYCdJHPC24FWbCKoFxShdahHDQN2tLTUWCw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26q9wxf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:45:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAYaro024035;
	Tue, 30 Jun 2026 10:45:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq9ww6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:45:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UAjaQs17433088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:45:37 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 984A058059;
	Tue, 30 Jun 2026 10:45:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4338758065;
	Tue, 30 Jun 2026 10:45:29 +0000 (GMT)
Received: from [9.39.22.200] (unknown [9.39.22.200])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:45:28 +0000 (GMT)
Message-ID: <d73ef56f-077e-4995-993b-56b2c58b6b65@linux.ibm.com>
Date: Tue, 30 Jun 2026 16:15:27 +0530
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
From: Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] selftests/mm: fix ksm NUMA merge test for systems
 with memoryless NUMA nodes
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Miaohe Lin <linmiaohe@huawei.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1782811071.git.sayalip@linux.ibm.com>
 <878cbc1dd24921d55049932dcd5fd6ee517557ca.1782811071.git.sayalip@linux.ibm.com>
Content-Language: en-IN
In-Reply-To: <878cbc1dd24921d55049932dcd5fd6ee517557ca.1782811071.git.sayalip@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX08+1j23jFJbp
 kgg+Oy36jCoWVxN3/PFCp38LbUVWg+pmeHIKiCZmtRNJwtCmxFMmqy9GvZKByNcQGLJo0qMNeN8
 ioBsId+nD6QhM4LUCH5a6SkdJWArTP93Ob93ZdtxWlquF2c+5YB1cQN7vDj5ShH3v3cRdS2+jnh
 WNdvFy9ez60imiOSkm4deiupSzaolnze8wW6XnGVSk78O2KhIuim2YX/06elDOxqBHHZEk+uzcq
 jKvmcBiBHWWwUXlxHAXSclCaBzNfXABU7ojsoxgt6MmqiO95+YND0e2f7uvITgd7ePw/3EohOez
 NR6UL1eJNkxRvPrMt9EF4P6fTP/9pJ2tUca2ZgbegqwkJ4OQfTkgmcJl+rr8cNA2QQ0aYyolTBX
 78eArYerL3c/blJP9mfwGlXKe0cD/vLQNvEvhoKvpOA3QpsFZb4KyZb+qmmg8sVJmxcSZSdF+YR
 yDItsyMpaW1HvyU1PaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfXzoQSb9gtu512
 NPtjtxUs/qZtt9Z1vpNlhJkzcday9+cgEKWPXzIQCp0EfLOFgxbStfZc49ksaM34ZO80TmGtYSA
 Scd1IDTFzXSqIXDECfNdM4AqKiI+vkQ=
X-Proofpoint-GUID: g3AXKtMIEBQ8UatMmZsizOFVL3V96WXC
X-Proofpoint-ORIG-GUID: KFNAz82cn_zqOqMr5VgDdiU_vfo5epu_
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a439e52 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=nxO_BTfs3k9z_1X4SBEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300093



On 30/06/26 15:02, Sayali Patil wrote:
> The KSM NUMA merge test allocates identical pages on different NUMA
> nodes and verifies KSM behavior with merge_across_nodes enabled and
> disabled.
> 
> On systems with memoryless NUMA nodes, for example:
>   #numactl  -H
>        available: 2 nodes (0,4)
>        .....
>        node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
>        node 0 size: 14825 MB
>        node 0 free: 1382 MB
>        node 4 cpus:
>        node 4 size: 0 MB
>        node 4 free: 0 MB
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
>         ---------------------------
> 	running ./ksm_tests -N -m 1
>         ---------------------------
>          mbind: Invalid argument
>          ok 1 KSM NUMA merging
> 	Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>          [PASS]
>         ok 1 ksm_tests -N -m 1
>         ---------------------------
>          running ./ksm_tests -N -m 0
>         ---------------------------
>          mbind: Invalid argument
>          not ok 1 KSM NUMA merging
> 	Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
>          [FAIL]
>         not ok 2 ksm_tests -N -m 0 # exit=1
> 
> After patch:
>         ---------------------------
>          running ./ksm_tests -N -m 1
>         ---------------------------
>          At least 2 NUMA nodes with memory must be available
> 	ok 1
> 	SKIP KSM NUMA merging
> 	Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>          [PASS]
>          ok 1 ksm_tests -N -m 1
>         ---------------------------
>          running ./ksm_tests -N -m 0
>         ---------------------------
>          At least 2 NUMA nodes with memory must be available
> 	ok 1
> 	SKIP KSM NUMA merging
> 	Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>          [PASS]
>          ok 2 ksm_tests -N -m 0
> 
> Fixes: e3820ab252dd ("selftest/vm: fix ksm selftest to run with different NUMA topologies")
> Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/ksm_tests.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
> index a050f4840cfa..2ebbb544c671 100644
> --- a/tools/testing/selftests/mm/ksm_tests.c
> +++ b/tools/testing/selftests/mm/ksm_tests.c
> @@ -440,9 +440,9 @@ static int get_next_mem_node(int node)
>   		mem_node = i % (max_node + 1);
>   		node_size = numa_node_size(mem_node, NULL);
>   		if (node_size > 0)
> -			break;
> +			return mem_node;
>   	}
> -	return mem_node;
> +	return -ENODEV;
>   }
>   
>   static int get_first_mem_node(void)
> @@ -455,8 +455,8 @@ static int check_ksm_numa_merge(int merge_type, int mapping, int prot, int timeo
>   {
>   	void *numa1_map_ptr, *numa2_map_ptr;
>   	struct timespec start_time;
> +	int first_node, second_node;
>   	int page_count = 2;
> -	int first_node;
>   
>   	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
>   		ksft_perror("clock_gettime");
> @@ -467,17 +467,19 @@ static int check_ksm_numa_merge(int merge_type, int mapping, int prot, int timeo
>   		ksft_print_msg("NUMA support not enabled\n");
>   		return KSFT_SKIP;
>   	}
> -	if (numa_num_configured_nodes() <= 1) {
> -		ksft_print_msg("At least 2 NUMA nodes must be available\n");
> +	first_node = get_first_mem_node();
> +	second_node = get_next_mem_node(first_node);
> +
> +	if (second_node < 0) {
> +		ksft_print_msg("At least 2 NUMA nodes with memory must be available\n");
>   		return KSFT_SKIP;
>   	}
>   	if (ksm_write_sysfs(KSM_FP("merge_across_nodes"), merge_across_nodes))
>   		return KSFT_FAIL;
>   
>   	/* allocate 2 pages in 2 different NUMA nodes and fill them with the same data */
> -	first_node = get_first_mem_node();
>   	numa1_map_ptr = numa_alloc_onnode(page_size, first_node);
> -	numa2_map_ptr = numa_alloc_onnode(page_size, get_next_mem_node(first_node));
> +	numa2_map_ptr = numa_alloc_onnode(page_size, second_node);
>   	if (!numa1_map_ptr || !numa2_map_ptr) {
>   		ksft_perror("numa_alloc_onnode");
>   		return KSFT_FAIL;

AI review comment:
> If get_first_mem_node() doesn't find a node with memory, will it
> return -ENODEV and pass it directly into get_next_mem_node()?
> Looking at get_next_mem_node() with a negative node parameter:
> tools/testing/selftests/mm/ksm_tests.c:get_next_mem_node() {
>    ...
>    for (i = node + 1; i <= max_node + node; i++) {
>        mem_node = i % (max_node + 1);
>        node_size = numa_node_size(mem_node, NULL);
>    ...
> }
> Because the modulo operator preserves the sign of a negative dividend,
> starting the loop with a negative node value causes mem_node to become
> negative. This means a negative node ID is then passed into libnuma's
> numa_node_size() function.
> Could we check if first_node is valid before attempting to find the
> second node?

The additional check for get_first_mem_node() is not needed. After 
numa_available() succeeds, a running system should always have at least 
one NUMA node with memory, so get_first_mem_node() is expected to return 
a valid node ID. The actual prerequisite for this test is the presence 
of two NUMA nodes with memory, which is already validated by checking 
the return value of get_next_mem_node().

Thanks,
Sayali


