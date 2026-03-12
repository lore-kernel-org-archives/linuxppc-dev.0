Return-Path: <linuxppc-dev+bounces-18109-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DD8105A594
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 12:27:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWn1G2GkCz3cH0;
	Thu, 12 Mar 2026 23:26:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773318418;
	cv=none; b=n0S/MEnHg8pWzuBvkt56/jJ5euoQ35fuCWVoXkQPSiNU4MoozXJ3F1GRbg1oVLIvPRLveut2ZPm2mOI72En5C+T+6bJrp3FDsiE4yWJ76V+fX1QJplxNILLutume6H0uNojYNOEyNYK4xbnTg4zeT6myV/HxJZgWy/A99tS2CNfwSy8jIIwK7sSAc7AZEQepta8cE/k2cc1pLtPrjfemrPka2nMJmeTGNSvmj80guEg+HmX/eu3ZR6DX0mXAqS3dLX/1McYa6QPy28yR8Vk0Gnc+9/QJBTeAr0HJWNFBkifhQO8aXxsiG5C155MUg2FaRzbf5Q1rNZqovV0XRzSgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773318418; c=relaxed/relaxed;
	bh=CCXEgYVNSLIHqttIpjBfM4opFxQVGZY/tJEQ2JpOh0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJPPjuvua00Yq0/9NUxaxm1XQxpkupUm4DSQAKaICO3mVSYS3SrYntikKlfnvTzkuzNhG9fNlxjzG7QChkUx+mHwfXcm99Gc8wOEHsZ/K5A8AN1xGoQozeNLOlt6I1bZlaf/YmiEtTE++/g8bsfuJ5bk5esfndRDZ8iwNjflWyG8AHsxuDwqAiF+pjNNQj1TeUpaoA+w+T3IrgEjaO2L+HOhSg416xzILjobaUorp0baICgvrP5dYzwHMtmcujErtVVGO1htkm0N5EeiTNKjmqb2r03ps9PTSNhDaX0DoB8PZ0gjzSHGzvleiHf3yMcfq7qPlZ+3tLcY/lJDHDWsjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Fl3btm5S; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Fl3btm5S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWn1F3Zp3z3cGc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 23:26:57 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMWS8D2303504;
	Thu, 12 Mar 2026 12:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CCXEgY
	VNSLIHqttIpjBfM4opFxQVGZY/tJEQ2JpOh0w=; b=Fl3btm5SyTcNAJ9jz0sv4d
	avSz4xAhbep4z+91pxBcJ8LttDGSo1s1eBQ0+xwmO/srERQ6NvxX6waJm3VlEelv
	XJNYvtKENfo90WRD/dvIMYqjvU8YFB493VRehdw4RIjnwnR1tELBhHLKa68lb/mt
	l7Bx/q5SDzEiTgooQYOL2+excBh5FA3xzxur/fumrY199DhjU6d56jbdaykToRPg
	HqEvxYrwk7aHe2W6MaqtBQ2zswowJ6suS8jdef3PqIxCOBJ2ZxyzYlIvuVGgOIUp
	qu0YeAeBget7FpG5L3Pz/XIYPHse4PM4xcGszMUQxnm6kl7aA9zEpYYkEnHxYs3A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh95tgbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C9l53a008855;
	Thu, 12 Mar 2026 12:26:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha7299x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CCQj2A51118346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 12:26:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C17720063;
	Thu, 12 Mar 2026 12:26:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C0D520043;
	Thu, 12 Mar 2026 12:26:42 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.in.ibm.com (unknown [9.109.243.201])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 12:26:42 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: [PATCH v2 13/13] selftests/cgroup: extend test_hugetlb_memcg.c to support all huge page sizes
Date: Thu, 12 Mar 2026 17:55:40 +0530
Message-ID: <e4e655c7d7c4e24b90d51530157d024854bff1cb.1773305678.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773305677.git.sayalip@linux.ibm.com>
References: <cover.1773305677.git.sayalip@linux.ibm.com>
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
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5NSBTYWx0ZWRfX8U0cah5I1gEZ
 gCoPInp7xEpFUY/rjZ+x5SJf8dR+zPmVuUAgfIokJgc5sEY8yi4OVjP18sZeDl/Br753vKbDO4n
 LDMWzLkDkjOaK1LwRe9hc4lnk6Vi2YD+BHhSJfDiR2w6o8xptBB4YUPUiJ2XzGK3jD8d+HW0sKP
 mWJRf4eWA6SPWcjH5E6N5ZjfTTudzA12W5ih8ziq/nvgkHtz4t7sGGSZlVou5Nw9xzQkX9Wgbpv
 7Hg1n7GTbp0fmvhFiAmDVYyiwyZDL0IaZcc54Gg9EQ9pIhhgwy7xuZucduJmgFX2rITQF81IGx/
 KhxRIPYA9OXClb/U1cx9QbajymP8X6x/LTT63xi1cq5hLXmapgk3HpIpJlURCPkaEMHNZjxu4k5
 LJMYhScRVV8rjaTy1NAXakM4Jy3ae5J4PcHzcFogemqAU23NPkoc7K6t6flF3Au4nYALF5+UEg6
 lgX9V6TyibgKF0ESyBA==
X-Authority-Analysis: v=2.4 cv=FowIPmrq c=1 sm=1 tr=0 ts=69b2b108 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=qf4gfuq51q0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=sc5eBBQPW9lzBnlyZiYA:9 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
X-Proofpoint-GUID: S7u7ySpNuoOBDd_WKEOPJ6KHeX3C_gKv
X-Proofpoint-ORIG-GUID: rHrZOcz20czFcoivGztbqc8OTsgqXS4O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120095

The hugetlb memcg selftest was previously skipped when the configured
huge page size was not 2MB, preventing the test from running on systems
using other default huge page sizes.

Detect the system's configured huge page size at runtime and use it for
the allocation instead of assuming a fixed 2MB size. This allows the
test to run on configurations using non-2MB huge pages and avoids
unnecessary skips.

Fixes: c0dddb7aa5f8 ("selftests: add a selftest to verify hugetlb usage in memcg")
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 .../selftests/cgroup/test_hugetlb_memcg.c     | 66 ++++++++++++++-----
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
index f451aa449be6..a449dbec16a8 100644
--- a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
+++ b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
@@ -12,10 +12,15 @@
 
 #define ADDR ((void *)(0x0UL))
 #define FLAGS (MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB)
-/* mapping 8 MBs == 4 hugepages */
-#define LENGTH (8UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
 
+/*
+ * This value matches the kernel's MEMCG_CHARGE_BATCH definition:
+ * see include/linux/memcontrol.h. If the kernel value changes, this
+ * test constant must be updated accordingly to stay consistent.
+ */
+#define MEMCG_CHARGE_BATCH 64U
+
 /* borrowed from mm/hmm-tests.c */
 static long get_hugepage_size(void)
 {
@@ -84,11 +89,11 @@ static unsigned int check_first(char *addr)
 	return *(unsigned int *)addr;
 }
 
-static void write_data(char *addr)
+static void write_data(char *addr, size_t length)
 {
 	unsigned long i;
 
-	for (i = 0; i < LENGTH; i++)
+	for (i = 0; i < length; i++)
 		*(addr + i) = (char)i;
 }
 
@@ -96,26 +101,31 @@ static int hugetlb_test_program(const char *cgroup, void *arg)
 {
 	char *test_group = (char *)arg;
 	void *addr;
+	long hpage_size = get_hugepage_size() * 1024;
 	long old_current, expected_current, current;
 	int ret = EXIT_FAILURE;
+	size_t length = 4 * hpage_size;
+	int pagesize, nr_pages;
+
+	pagesize = getpagesize();
 
 	old_current = cg_read_long(test_group, "memory.current");
 	set_nr_hugepages(20);
 	current = cg_read_long(test_group, "memory.current");
-	if (current - old_current >= MB(2)) {
+	if (current - old_current >= hpage_size) {
 		ksft_print_msg(
 			"setting nr_hugepages should not increase hugepage usage.\n");
 		ksft_print_msg("before: %ld, after: %ld\n", old_current, current);
 		return EXIT_FAILURE;
 	}
 
-	addr = mmap(ADDR, LENGTH, PROTECTION, FLAGS, 0, 0);
+	addr = mmap(ADDR, length, PROTECTION, FLAGS, 0, 0);
 	if (addr == MAP_FAILED) {
 		ksft_print_msg("fail to mmap.\n");
 		return EXIT_FAILURE;
 	}
 	current = cg_read_long(test_group, "memory.current");
-	if (current - old_current >= MB(2)) {
+	if (current - old_current >= hpage_size) {
 		ksft_print_msg("mmap should not increase hugepage usage.\n");
 		ksft_print_msg("before: %ld, after: %ld\n", old_current, current);
 		goto out_failed_munmap;
@@ -124,10 +134,24 @@ static int hugetlb_test_program(const char *cgroup, void *arg)
 
 	/* read the first page */
 	check_first(addr);
-	expected_current = old_current + MB(2);
+	nr_pages = hpage_size / pagesize;
+	expected_current = old_current + hpage_size;
 	current = cg_read_long(test_group, "memory.current");
-	if (!values_close(expected_current, current, 5)) {
-		ksft_print_msg("memory usage should increase by around 2MB.\n");
+	if (nr_pages < MEMCG_CHARGE_BATCH && current == old_current) {
+		/*
+		 * Memory cgroup charging uses per-CPU stocks and batched updates to the
+		 *  memcg usage counters. For hugetlb allocations, the number of pages
+		 *  that memcg charges is expressed in base pages (nr_pages), not
+		 *  in hugepage units. When the charge for an allocation is smaller than
+		 *  the internal batching threshold  (nr_pages <  MEMCG_CHARGE_BATCH),
+		 *  it may be fully satisfied from the CPU’s local stock. In such
+		 *  cases memory.current does not necessarily
+		 *  increase.
+		 *  Therefore, Treat a zero delta as valid behaviour here.
+		 */
+		ksft_print_msg("no visible memcg charge, allocation consumed from local stock.\n");
+	} else if (!values_close(expected_current, current, 5)) {
+		ksft_print_msg("memory usage should increase by ~1 huge page.\n");
 		ksft_print_msg(
 			"expected memory: %ld, actual memory: %ld\n",
 			expected_current, current);
@@ -135,11 +159,11 @@ static int hugetlb_test_program(const char *cgroup, void *arg)
 	}
 
 	/* write to the whole range */
-	write_data(addr);
+	write_data(addr, length);
 	current = cg_read_long(test_group, "memory.current");
-	expected_current = old_current + MB(8);
+	expected_current = old_current + length;
 	if (!values_close(expected_current, current, 5)) {
-		ksft_print_msg("memory usage should increase by around 8MB.\n");
+		ksft_print_msg("memory usage should increase by around 4 huge pages.\n");
 		ksft_print_msg(
 			"expected memory: %ld, actual memory: %ld\n",
 			expected_current, current);
@@ -147,7 +171,7 @@ static int hugetlb_test_program(const char *cgroup, void *arg)
 	}
 
 	/* unmap the whole range */
-	munmap(addr, LENGTH);
+	munmap(addr, length);
 	current = cg_read_long(test_group, "memory.current");
 	expected_current = old_current;
 	if (!values_close(expected_current, current, 5)) {
@@ -162,13 +186,15 @@ static int hugetlb_test_program(const char *cgroup, void *arg)
 	return ret;
 
 out_failed_munmap:
-	munmap(addr, LENGTH);
+	munmap(addr, length);
 	return ret;
 }
 
 static int test_hugetlb_memcg(char *root)
 {
 	int ret = KSFT_FAIL;
+	int num_pages = 20;
+	long hpage_size = get_hugepage_size();
 	char *test_group;
 
 	test_group = cg_name(root, "hugetlb_memcg_test");
@@ -177,7 +203,7 @@ static int test_hugetlb_memcg(char *root)
 		goto out;
 	}
 
-	if (cg_write(test_group, "memory.max", "100M")) {
+	if (cg_write_numeric(test_group, "memory.max", num_pages * hpage_size * 1024)) {
 		ksft_print_msg("fail to set cgroup memory limit.\n");
 		goto out;
 	}
@@ -200,6 +226,7 @@ int main(int argc, char **argv)
 {
 	char root[PATH_MAX];
 	int ret = EXIT_SUCCESS, has_memory_hugetlb_acc;
+	long val;
 
 	has_memory_hugetlb_acc = proc_mount_contains("memory_hugetlb_accounting");
 	if (has_memory_hugetlb_acc < 0)
@@ -208,12 +235,15 @@ int main(int argc, char **argv)
 		ksft_exit_skip("memory hugetlb accounting is disabled\n");
 
 	/* Unit is kB! */
-	if (get_hugepage_size() != 2048) {
-		ksft_print_msg("test_hugetlb_memcg requires 2MB hugepages\n");
+	val = get_hugepage_size();
+	if (val < 0) {
+		ksft_print_msg("Failed to read hugepage size\n");
 		ksft_test_result_skip("test_hugetlb_memcg\n");
 		return ret;
 	}
 
+	ksft_print_msg("Hugepage size: %ld kB\n", val);
+
 	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
-- 
2.52.0


