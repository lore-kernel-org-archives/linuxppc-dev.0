Return-Path: <linuxppc-dev+bounces-19431-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740CDFEEF2E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 12:13:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqlTN6QMcz2yZ3;
	Tue, 07 Apr 2026 22:13:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775563992;
	cv=none; b=PhBttsBnT1NehCAgRGjnC0pnMftvgMcx1aSox6Jh2jKKa0mRrZTnbCrXlRFQHULv8/YOGCq3ikaDzA8C0RVeJN2gQgk/LBPfx3M6Tz2gse8zkkq0rm0uUcEQloUwbiXWsPZKjO+Usa8fDcWGtk7FDhZuMpnqkT2jE/ZMoCmFxgOUoTP+RJ/SyP0VzYZCBRYfCxkRw2CwQTnSO+4lHi4wCTWj5NJP0i7aMskIeFw8i6ex95jmeEdaesMZ6B5t1Omf2pcRo/L3YPaZQJaz4L3v5brr4IlEGaYODbID2dvAovhR7mYhxo5cUb+AQcpfLOkxnSi+RVBVh5ORUTOHQBFAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775563992; c=relaxed/relaxed;
	bh=f9Rjl/2FypYtJRATJktQ2F/Wjw6qbjbKb2kazb+K+eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCO3P97aol/6KXf89enCNXNEMYSv57g2OMbJwyDZ3R+kcvD9IQiBHi5HEMA+Gd/tGdOiK9tHgVhOgQV3tzUg5H2egUMD1xXanGWSQ3yZh56LtcXWF86Fr93lbm4mNLKrXRrb68CNiXOXBX06ym2kjqfEwusKOg6f92At23ylqAn/nMDO0kp49ADp8Od4MyJIgV+SikEu//oR6SjTdG6wfCGJ2CQnVVVdOXhYjIR20zfQb8u2VukWwGqBWyUJJDDtISL+9bNE0AF/Hbx29PGH1Q/Dg6Z3a8nYPYzbnZyWfYfd8ZON9O0Xogmian/RGdPSxLv9QoasGxUZ2FVCliw8wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=glgXtlKx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=glgXtlKx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqlTM4z7Rz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 22:13:10 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636Llk8W2297410;
	Tue, 7 Apr 2026 12:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f9Rjl/
	2FypYtJRATJktQ2F/Wjw6qbjbKb2kazb+K+eA=; b=glgXtlKxuoGJz/svviTcPD
	pxoVSvZtst3jPDE/8bQy+QAhCK39xNXMouvzc5R6Ookfs64iAgTbMepJUXK+r4LT
	cfOXTcyxjRbjGcuvaSl9n5cD1QWcmqCZoZpOtfefjr9DGZuwaazzbeDhr4UKNBFy
	4trRh/RHr1tXKPkSnh7pah1I76+fBSrq1HYq+QH8KE54CQpPh8tBLzBVUBUM3LWb
	9yYx4qeULbZYdGSphzwX5nDVQbd8lnf8QwJiFGbe+CgqG+OdQTP+ubAaHBJOiUdA
	yuF8VrP587Gi8eXYYvc0E1J2FiaWKAiBbsgE73jtXHlpxS6vfWwtJkIU9iHWo7ig
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fthbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:07:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BMXhV019113;
	Tue, 7 Apr 2026 12:07:50 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9b129-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:07:50 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637C7nkI33096362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 12:07:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 975775804B;
	Tue,  7 Apr 2026 12:07:49 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6458158059;
	Tue,  7 Apr 2026 12:07:44 +0000 (GMT)
Received: from [9.39.22.34] (unknown [9.39.22.34])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 12:07:44 +0000 (GMT)
Message-ID: <53758376-14e9-4b52-89de-6d68e8c0c6f8@linux.ibm.com>
Date: Tue, 7 Apr 2026 17:37:42 +0530
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
Subject: Re: [PATCH v4 15/15] selftests/cgroup: extend test_hugetlb_memcg.c to
 support all huge page sizes
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
References: <cover.1775466329.git.sayalip@linux.ibm.com>
 <fcc9eb99566af8f37e63924a77dc633c5f200417.1775466330.git.sayalip@linux.ibm.com>
Content-Language: en-IN
From: Sayali Patil <sayalip@linux.ibm.com>
In-Reply-To: <fcc9eb99566af8f37e63924a77dc633c5f200417.1775466330.git.sayalip@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d4f397 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=OnH-2HpHgaBoKrgXaAgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _Yc1ZjkGqeJWOo5dZWrc8kO9K4BwHWcq
X-Proofpoint-GUID: kPQ1rpvp1ZJu1sNFeEirtjwQFQsrvGUw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExMCBTYWx0ZWRfX4x464uJZ4ocp
 PKH7r0+oe+nLTBo/pizyILwSl9wzhG6FzPbNsBtGIlKS2jvGvKZp1mR5HxBsRR4erpU42GNn3qc
 lb6ilHwf8Q+S0VSXmHW7YJaE9thwnzpHOc2uFklBz0jjHeQ1wLcr2KXon8O9EM5TpHOFk9iMurI
 2v2T6epXGCsAlrJVpfk3QlDbmMc5UfAIuZEvbwHN1ZN1CQx5EIy6csg7E81sJ+/HC+qoOxwSK8j
 lJVzOXQiNc72xmVIejSRiAoj+mTmIL6AkPSYcR3Tyy6wTplckY2DG6UdF2go0hsuVAJzUGsgwU3
 1S3RKUAFXSeOM+AcMcB6cpfux/GaWj+x4xIRuqYQ4vv1gKh9Idh404zst562RsJ4nswfBq3xL1r
 JnC0Q+G5KYN53h9SW7g6nKmkG9nZ6gz/PrvmIScMt5UgAydhuMOPFBoI4UUijv0fiPPkTCR1pNe
 gXdeoiPsiAH78eNwvUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070110



On 06/04/26 14:49, Sayali Patil wrote:
> The hugetlb memcg selftest was previously skipped when the configured
> huge page size was not 2MB, preventing the test from running on systems
> using other default huge page sizes.
> 
> Detect the system's configured huge page size at runtime and use it for
> the allocation instead of assuming a fixed 2MB size. This allows the
> test to run on configurations using non-2MB huge pages and avoids
> unnecessary skips.
> 
> Fixes: c0dddb7aa5f8 ("selftests: add a selftest to verify hugetlb usage in memcg")
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>   .../selftests/cgroup/test_hugetlb_memcg.c     | 90 ++++++++++++++-----
>   1 file changed, 68 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
> index f451aa449be6..e6157a784138 100644
> --- a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
> +++ b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
> @@ -7,15 +7,21 @@
>   #include <stdlib.h>
>   #include <string.h>
>   #include <fcntl.h>
> +#include <stdint.h>
>   #include "kselftest.h"
>   #include "cgroup_util.h"
>   
>   #define ADDR ((void *)(0x0UL))
>   #define FLAGS (MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB)
> -/* mapping 8 MBs == 4 hugepages */
> -#define LENGTH (8UL*1024*1024)
>   #define PROTECTION (PROT_READ | PROT_WRITE)
>   
> +/*
> + * This value matches the kernel's MEMCG_CHARGE_BATCH definition:
> + * see include/linux/memcontrol.h. If the kernel value changes, this
> + * test constant must be updated accordingly to stay consistent.
> + */
> +#define MEMCG_CHARGE_BATCH 64U
> +
>   /* borrowed from mm/hmm-tests.c */
>   static long get_hugepage_size(void)
>   {
> @@ -84,11 +90,11 @@ static unsigned int check_first(char *addr)
>   	return *(unsigned int *)addr;
>   }
>   
> -static void write_data(char *addr)
> +static void write_data(char *addr, size_t length)
>   {
>   	unsigned long i;
>   
> -	for (i = 0; i < LENGTH; i++)
> +	for (i = 0; i < length; i++)
>   		*(addr + i) = (char)i;
>   }
>   
> @@ -96,26 +102,33 @@ static int hugetlb_test_program(const char *cgroup, void *arg)
>   {
>   	char *test_group = (char *)arg;
>   	void *addr;
> +	long hpage_size, batch_bytes;
>   	long old_current, expected_current, current;
>   	int ret = EXIT_FAILURE;
> +	size_t length;
> +	int pagesize, nr_pages;
> +
> +	pagesize = getpagesize();
> +	hpage_size = get_hugepage_size() * 1024;
> +	length = 4 * hpage_size;
> +	batch_bytes = MEMCG_CHARGE_BATCH * pagesize;
>   
>   	old_current = cg_read_long(test_group, "memory.current");
>   	set_nr_hugepages(20);
>   	current = cg_read_long(test_group, "memory.current");
> -	if (current - old_current >= MB(2)) {
> +	if (current - old_current >= hpage_size) {
>   		ksft_print_msg(
>   			"setting nr_hugepages should not increase hugepage usage.\n");
>   		ksft_print_msg("before: %ld, after: %ld\n", old_current, current);
>   		return EXIT_FAILURE;
>   	}
>   
> -	addr = mmap(ADDR, LENGTH, PROTECTION, FLAGS, 0, 0);
> -	if (addr == MAP_FAILED) {
> -		ksft_print_msg("fail to mmap.\n");
> -		return EXIT_FAILURE;
> -	}
> +	addr = mmap(ADDR, length, PROTECTION, FLAGS, 0, 0);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_skip("mmap failed, not enough memory.\n");
> +
>   	current = cg_read_long(test_group, "memory.current");
> -	if (current - old_current >= MB(2)) {
> +	if (current - old_current >= hpage_size) {
>   		ksft_print_msg("mmap should not increase hugepage usage.\n");
>   		ksft_print_msg("before: %ld, after: %ld\n", old_current, current);
>   		goto out_failed_munmap;
> @@ -124,10 +137,34 @@ static int hugetlb_test_program(const char *cgroup, void *arg)
>   
>   	/* read the first page */
>   	check_first(addr);
> -	expected_current = old_current + MB(2);
> +	nr_pages = hpage_size / pagesize;
> +	expected_current = old_current + hpage_size;
>   	current = cg_read_long(test_group, "memory.current");
> -	if (!values_close(expected_current, current, 5)) {
> -		ksft_print_msg("memory usage should increase by around 2MB.\n");
> +	if (nr_pages < MEMCG_CHARGE_BATCH &&
> +	    (current == old_current ||
> +	    values_close(old_current + batch_bytes, current, 5))) {
> +		/*
> +		 * Memory cgroup charging uses per-CPU stocks and batched updates to the
> +		 *  memcg usage counters. For hugetlb allocations, the number of pages
> +		 *  that memcg charges is expressed in base pages (nr_pages), not
> +		 *  in hugepage units. When the charge for an allocation is smaller than
> +		 *  the internal batching threshold  (nr_pages <  MEMCG_CHARGE_BATCH),
> +		 *  it may be fully satisfied from the CPU’s local stock. In such
> +		 *  cases memory.current does not necessarily increase.
> +		 *
> +		 *  If the local stock is insufficient, it may be refilled in batches
> +		 *  of MEMCG_CHARGE_BATCH base pages, causing memory.current to increase
> +		 *  by more than the allocation size.
> +		 *
> +		 * Therefore, Treat both a zero delta and a batched increase as a
> +		 * valid behaviour here.
> +		 */
> +		if (current == old_current)
> +			ksft_print_msg("allocation consumed from local stock.\n");
> +		else
> +			ksft_print_msg("memcg charge batched via stock refill.\n");
> +	} else if (!values_close(expected_current, current, 5)) {
> +		ksft_print_msg("memory usage should increase by ~1 huge page.\n");
>   		ksft_print_msg(
>   			"expected memory: %ld, actual memory: %ld\n",
>   			expected_current, current);
> @@ -135,11 +172,11 @@ static int hugetlb_test_program(const char *cgroup, void *arg)
>   	}
>   
>   	/* write to the whole range */
> -	write_data(addr);
> +	write_data(addr, length);
>   	current = cg_read_long(test_group, "memory.current");
> -	expected_current = old_current + MB(8);
> +	expected_current = old_current + length;
>   	if (!values_close(expected_current, current, 5)) {
> -		ksft_print_msg("memory usage should increase by around 8MB.\n");
> +		ksft_print_msg("memory usage should increase by around 4 huge pages.\n");
>   		ksft_print_msg(
>   			"expected memory: %ld, actual memory: %ld\n",
>   			expected_current, current);
> @@ -147,7 +184,7 @@ static int hugetlb_test_program(const char *cgroup, void *arg)
>   	}
>   
>   	/* unmap the whole range */
> -	munmap(addr, LENGTH);
> +	munmap(addr, length);
>   	current = cg_read_long(test_group, "memory.current");
>   	expected_current = old_current;
>   	if (!values_close(expected_current, current, 5)) {
> @@ -162,14 +199,17 @@ static int hugetlb_test_program(const char *cgroup, void *arg)
>   	return ret;
>   
>   out_failed_munmap:
> -	munmap(addr, LENGTH);
> +	munmap(addr, length);
>   	return ret;
>   }
>   
>   static int test_hugetlb_memcg(char *root)
>   {
>   	int ret = KSFT_FAIL;
> +	int num_pages = 20;
> +	long hpage_size = get_hugepage_size();
>   	char *test_group;
> +	uint64_t limit;
>   
>   	test_group = cg_name(root, "hugetlb_memcg_test");
>   	if (!test_group || cg_create(test_group)) {
> @@ -177,7 +217,9 @@ static int test_hugetlb_memcg(char *root)
>   		goto out;
>   	}
>   
> -	if (cg_write(test_group, "memory.max", "100M")) {
> +	limit = (uint64_t)num_pages * hpage_size * 1024ULL;
> +
> +	if (cg_write_numeric(test_group, "memory.max", limit)) {
>   		ksft_print_msg("fail to set cgroup memory limit.\n");
>   		goto out;
>   	}
> @@ -200,6 +242,7 @@ int main(int argc, char **argv)
>   {
>   	char root[PATH_MAX];
>   	int ret = EXIT_SUCCESS, has_memory_hugetlb_acc;
> +	long val;
>   
>   	has_memory_hugetlb_acc = proc_mount_contains("memory_hugetlb_accounting");
>   	if (has_memory_hugetlb_acc < 0)
> @@ -208,12 +251,15 @@ int main(int argc, char **argv)
>   		ksft_exit_skip("memory hugetlb accounting is disabled\n");
>   
>   	/* Unit is kB! */
> -	if (get_hugepage_size() != 2048) {
> -		ksft_print_msg("test_hugetlb_memcg requires 2MB hugepages\n");
> +	val = get_hugepage_size();
> +	if (val < 0) {
> +		ksft_print_msg("Failed to read hugepage size\n");
>   		ksft_test_result_skip("test_hugetlb_memcg\n");
>   		return ret;
>   	}
>   
> +	ksft_print_msg("Hugepage size: %ld kB\n", val);
> +
>   	if (cg_find_unified_root(root, sizeof(root), NULL))
>   		ksft_exit_skip("cgroup v2 isn't mounted\n");
>   

Observed intermittent failure on some systems, particularly with 1GB 
huge page size, where the memory.current does not reflect the expected 
usage.

I will drop this patch from the series and will take a look at it 
separately.

Thanks,
Sayali

