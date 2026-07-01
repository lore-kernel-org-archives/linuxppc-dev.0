Return-Path: <linuxppc-dev+bounces-23291-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C212C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:42:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqtmT0TnHz2ydQ;
	Wed, 01 Jul 2026 18:42:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895321;
	cv=none; b=KcpcuiL89yy2BImPmo7w7cAQix715VXzmAoX8g1Hzrp7jOGN2SnAnTBoFqj+ShbBWUadwGlTo2Y8jgkxw0ZujGs0aUQjsv8zZQPh+iFSmRgq/b6qY67toHFD4s7KCdV67IsU0etHW+MmeTCU2kcec+e8umkoBsfJSciUOkZKxv3DwJ6bT1JHEZswxBvptd4qfn7GnlZlClYEiDIopHGZUXF9nuvqEmmHg+AZnnaT8zwKj6MC+i1LFNnHgAt+Yk3CNjWhUm7Z4cJYiJCTf6CE+YP9IeWguEecgYScavF77bZcb7/Rd2FFLsOlj9nNFJ7E8S6t/GBTCUi4CDXfGXC6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895321; c=relaxed/relaxed;
	bh=vqYsIOmjjTVoUGH2lNK7VOIrBTJDduBxnE5HtopYgag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6CN+Qw3CNc/WbZJ2K5WaA9iLirQd23z2+UeLNIxgHXCFW+FeiV4/PiBUPNtqaJSbXLt/wFJqG4ur3bTs+7uYbIZffjQ9IhvhvHemJNlo/n6RD2JI4YRgFGHC+u/Pp4hYPxwG8O4NcL66A0H1zUmkaig/0mMUZ6oeDPNY+aRFynJBZQ+x3XKz837BUwc45ypIkBMr3qcaoh//gd646t49rL6dnPzcKErCj16+WotYmt8vmiVMxSr54EmOZBgCg2S16XsFOekjqtvoCWIhfVroyyHd9lf6Ev1/N/ByoUUf/XtKmcaRacM5JnfQoILSmDo9drwnrAyzm27pRQLYt1ncQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dnk2fztL; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dnk2fztL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqtmR6g0Jz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:41:59 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618J6JP236961;
	Wed, 1 Jul 2026 08:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vqYsIOmjjTVoUGH2l
	NK7VOIrBTJDduBxnE5HtopYgag=; b=dnk2fztLqrdRX8TNSV6dyFIYsJZcnnpse
	lxuDhvulRo7VB5UwukUbm4Ps1ccyP4Jglqohluj2G4mXtHmkrwPikRAg4HO/8Xec
	YPn37xQXgG+31Ixg0ujwGRmAaprha5yDsIdM1dpKbQ2sWDC77dmuwjRwUbeUdxVW
	FPJRUnS7T0Eeo5Qd7Alobh61c1JBGgV5IQLCheknuWkVFnQ1rSJuBX+WaLF4IgOW
	u06cEYl6T1+cRY84ixujuYM6LtCZnwbwJ4+MkZRZgHMTeTxyskUuRlzTiBUSEYip
	VEfNWTf8SU5HpdddelTy/KxcD+tgWuN3DXEncumXF7lP6x1/dI9KA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa35bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618YhqF017226;
	Wed, 1 Jul 2026 08:41:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqemnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618fnMK33292644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:41:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6ECE20040;
	Wed,  1 Jul 2026 08:41:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A455120043;
	Wed,  1 Jul 2026 08:41:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:41:46 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com
Subject: [PATCH 7/9] perf tools powerpc: Add physical to logical address mapping for HTM traces
Date: Wed,  1 Jul 2026 14:11:13 +0530
Message-Id: <20260701084115.80383-8-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260701084115.80383-1-atrajeev@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX39JtDrH2y9U/
 oRdSDhY03PU+7e8WKlbtRnHQFq44Qb41lNoV0+tDKzci2zGkqi1N+6KcfAvpPcf6H9kibtrki5d
 gbhRc/BgPunL8lSro2hQQuWEIW+GCS5J+hvtR0PGEalpqzXoGPhcygHjE3auUeHw/DfuYsAu0ZH
 qGxu+fTRPLvo7IKUcRiQ9nuP1l51cfPuCQthVZ/yNbkpJK69cnaylEPuVkx00mXyFC7Gy1SQFnV
 /nrtQPnqmnsy4niZhRCw0HxUZVrLzOVpiRLFv4724cgOETyQ9gleOtmUEgmnicL+AWNwsyccBgL
 4HscaKvMDQUJRXF0+H4m19B6BJlyZxOv7JYzolyDNq/WxcZiCK5dET6Kz4+BQwPxURgLNV5ZIoA
 rvHxw3OkGZNy1oSJIGfKYXRKBgl7Rwgjt3jURG15d/I9tBgEtiO3zO+H4VA1X6m+DZda4jcB3kR
 9bhPha7nhXD6QEDou/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX9P6OWIdxV6/q
 5BfRU7OCwiOH1ZZMlBThSpPJv8JZceTYjkuvh+JZawVORroRo0C+j48+KaFtPPdUmNB1pFCFszz
 uy4DsBruS/wX5PGqPPNg9YG8ut4UHHY=
X-Proofpoint-GUID: c1FceN8q2jUFRMdqEr1ab5jqX-hwszlq
X-Proofpoint-ORIG-GUID: -H8IEsG1izbREsVYz7jcYkBSlV4WUgFm
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a44d2d2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=wVc-TFLcMaW-Y6FDIlAA:9
 a=FW1flZ6vOz1sRHNC:21 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010084

From: Tanushree Shah <tshah@linux.ibm.com>

Add support for mapping physical addresses from HTM (Hardware Trace Macro)
traces to logical addresses within the current LPAR (Logical Partition).
This enables correlation of HTM trace data with the logical address space
visible to applications and the kernel.

HTM traces capture physical memory addresses from the transactions, but for
meaningful analysis, these need to be mapped to the logical addresses used
by the partition. This patch implements the mapping by:

1. Reading the current partition ID from /proc/powerpc/lparcfg to identify
   which LPAR the trace belongs to

2. Extracting memory map entries from the HTM system memory configuration
   data, which contains:

3. Parsing the decoded HTM trace file using regex patterns to extract
   physical addresses and their associated event labels from each trace
   entry

4. For each physical address in the trace, finding the matching memory
   map entry by:
   - Checking if the address falls within the entry's physical range
   - Verifying the entry belongs to the current partition (LP index match)
   - Computing the offset from the physical range start
   - Adding the offset to the logical range start to get the logical address

The implementation uses dynamic memory allocation to handle variable numbers
of trace entries and memory map entries.

Data structures:
- struct mem_entries: Stores memory map metadata (physical start, logical
  start, LP index, size) extracted from HTM system memory configuration

- struct addr_map: Stores the mapping results (physical address,
  logical address) for each trace entry

The mapping results are output via pr_debug() for verification during
development and debugging. This information is essential for subsequent
patches that will use the logical addresses to generate synthetic perf
samples.

Error handling includes:
- NULL checks for all memory allocations
- Validation of file operations (fopen, fstat, mmap)
- Proper resource cleanup on all error paths
- Consistent error return codes using negative errno values
- Descriptive error messages using perf's pr_err() infrastructure

This patch is part of the HTM trace processing pipeline and works in
conjunction with:
- HTM trace collection (kernel driver)
- HTM trace decoding (htmdecode tool)
- Synthetic sample generation (subsequent patch)

This patch incorporates the following changes:
Store HTM memory map entries (start physical, start logical,
LP index) into a dedicated struct.

Parse HTM decoded trace file and extract the "addr" and
"label" fields and store it in a struct.

For each address in the trace, the code checks for a matching
memory map entry with the same LP index. If the address falls
within the entry's range, the offset is computed and added to
the logical start address (got from the memory map entry) to
get the logical address of the given address.

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/powerpc-htm.c | 264 ++++++++++++++++++++++++++++++++++
 1 file changed, 264 insertions(+)

diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
index 487989ca4fc7..83253850870c 100644
--- a/tools/perf/util/powerpc-htm.c
+++ b/tools/perf/util/powerpc-htm.c
@@ -20,6 +20,13 @@
 #include "sample.h"
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <regex.h>
+#include <ctype.h>
+#include <errno.h>
+
+/* mask the 64th bit of a physical address */
+#define PHYS_ADDR_MASK        0x7FFFFFFFFFFFFFFFUL
+const char *lpar_cfg = "/proc/powerpc/lparcfg";
 
 struct perf_session;
 
@@ -47,6 +54,19 @@ struct htm_mem {
 	uint64_t size;
 };
 
+struct mem_entries {
+	unsigned long long phy_addr;
+	unsigned long logical_addr;
+	u32 lp_index;
+	u64 size;
+};
+
+struct addr_map {
+	char event[64];
+	unsigned long long phys_addr;
+	unsigned long logical_addr;
+};
+
 static int run_htmdecode(const char *input_file, const char *output_file)
 {
 	pid_t pid;
@@ -108,6 +128,187 @@ static int run_htmdecode(const char *input_file, const char *output_file)
 	return 0;
 }
 
+static void *safe_realloc(void *ptr, size_t new_size)
+{
+	void *tmp = realloc(ptr, new_size);
+
+	if (!tmp) {
+		pr_err("realloc failed: %s\n", strerror(errno));
+		return NULL;
+	}
+
+	return tmp;
+}
+
+static int add_map_entry(struct addr_map **arr, size_t *count, size_t *cap, struct addr_map entry)
+{
+	if (*count >= *cap) {
+		size_t new_cap = (*cap == 0) ? 1024 : (*cap * 2);
+		void *tmp = safe_realloc(*arr, new_cap * sizeof(struct addr_map));
+
+		if (!tmp)
+			return -1;  // allocation failed
+		*arr = tmp;
+		*cap = new_cap;
+
+	}
+
+	(*arr)[(*count)++] = entry;
+	return 0;
+}
+
+/*
+ * This effectively maps a physical address to its logical address
+ * within the selected LP partition.
+ */
+static unsigned long find_logical_addr(unsigned long long given_addr,
+				struct mem_entries *mem_entries_array,
+				size_t n_entries,
+				u32 lp_filter)
+{
+	for (size_t i = 0; i < n_entries; i++) {
+		unsigned long long start = mem_entries_array[i].phy_addr & PHYS_ADDR_MASK;
+		unsigned long long end   = start + mem_entries_array[i].size;
+
+		/* Skip entries with invalid logical_start sentinel */
+		if (mem_entries_array[i].logical_addr == UINT64_MAX) {
+			pr_debug("  SKIP i=%zu: logical_start sentinel=0x%016llx\n",
+			i, (unsigned long long)mem_entries_array[i].logical_addr);
+			continue;
+		}
+
+		/*
+		 * Check if 'given_addr' falls within the physical memory range of this entry
+		 * and belongs to the LP partition indicated by 'lp_filter'.
+		 * If so, calculate:
+		 * 'offset' and the 'logical address
+		 */
+		if (start <= given_addr && given_addr < end &&
+			mem_entries_array[i].lp_index == lp_filter) {
+			unsigned long long offset = given_addr - start;
+			unsigned long logical = mem_entries_array[i].logical_addr + offset;
+
+			pr_debug("DEBUG: Condition hit at i=%zu given_addr=0x%llx start=0x%llx end=0x%llx lp_index=%u\n",
+				i, given_addr,
+				start, end,
+				(unsigned int)mem_entries_array[i].lp_index);
+			pr_debug("logical = 0x%016lx\n", logical);
+			return logical;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Parse the HTM trace file line by line, extracting memory addresses and labels.
+ * Map each memory addresses to a corresponding logical address for a given
+ * lp_filter. Store the results in a dynamically growing map of entries.
+ */
+static struct addr_map *process_trace_file(const char *trace_file,
+				struct mem_entries *mem_entries_array,
+				size_t n_entries,
+				u32 lp_filter,
+				size_t *count_out)
+{
+	regex_t addr_regex, label_regex;
+	struct addr_map *maps;
+	size_t count, cap;
+	char *line = NULL;
+	size_t len;
+	regmatch_t pmatch[2];
+	const char *ptr;
+	unsigned long logical_addr;
+	size_t total_phys = 0;
+	size_t total_phys_to_logical = 0;
+
+	FILE *fp = fopen(trace_file, "r");
+
+	if (!fp) {
+		pr_err("Failed to open trace file %s: %s\n", trace_file, strerror(errno));
+		return NULL;
+	}
+
+	if (regcomp(&addr_regex, "addr:0x[0-9A-Fa-f]+", REG_EXTENDED) != 0) {
+		pr_err("Failed to compile addr_regex\n");
+		return NULL;
+	}
+
+	if (regcomp(&label_regex,
+		   "^[[:space:]]*[0-9A-Fa-f]+ : [^[:space:]]+[[:space:]]+([^[:space:]]+)",
+		   REG_EXTENDED) != 0) {
+		pr_err("Failed to compile label_regex\n");
+		return NULL;
+	}
+
+	maps = NULL;
+	count = 0;
+	cap = 0;
+
+	while (getline(&line, &len, fp) != -1) {
+		if (regexec(&label_regex, line, 2, pmatch, 0) == 0) {
+			char label[64] = {0};
+			int start = pmatch[1].rm_so;
+			int end   = pmatch[1].rm_eo;
+			int line_len   = end - start;
+
+			if (line_len < 0)
+				line_len = 0;
+			if ((size_t)line_len > sizeof(label) - 1)
+				line_len = (int)(sizeof(label) - 1);
+
+			/* Use snprintf to copy exactly len characters and
+			 * always null terminate
+			 */
+			snprintf(label, sizeof(label), "%.*s", line_len, line + start);
+			ptr = line;
+			while (regexec(&addr_regex, ptr, 1, pmatch, 0) == 0) {
+				unsigned long long phys_addr = 0;
+				struct addr_map entry = {0};
+
+				if (sscanf(ptr + pmatch[0].rm_so + strlen("addr:"),
+					  "%llx", &phys_addr) != 1) {
+					pr_debug("Failed to parse phys addr from trace line\n");
+					continue;
+				}
+
+				total_phys++;
+				pr_debug("Total Phys[%zu]: 0x%016llx\n", total_phys, phys_addr);
+				logical_addr = find_logical_addr(phys_addr,
+							mem_entries_array,
+							n_entries,
+							lp_filter);
+				if (logical_addr == 0) {
+					ptr += pmatch[0].rm_eo;
+					continue;
+				} else {
+					total_phys_to_logical++;
+					pr_debug("  Phys: 0x%016llx to Logical: 0x%016lx\n",
+					phys_addr,
+					logical_addr);
+				}
+				pr_debug("Total physical to logical found    : %zu\n",
+					total_phys_to_logical);
+				snprintf(entry.event, sizeof(entry.event), "%s", label);
+				entry.phys_addr   = phys_addr;
+				entry.logical_addr = logical_addr;
+
+				add_map_entry(&maps, &count, &cap, entry);
+
+				ptr += pmatch[0].rm_eo;
+			}
+		}
+	}
+
+	free(line);
+	fclose(fp);
+	regfree(&addr_regex);
+	regfree(&label_regex);
+
+	*count_out = count;
+	return maps;
+}
+
 static int create_mem_maps(struct powerpc_htm *htm)
 {
 	off_t file_size;
@@ -117,6 +318,13 @@ static int create_mem_maps(struct powerpc_htm *htm)
 	struct htm_mem *mem;
 	char tracefile[128];
 	int ret;
+	u32 lp_filter = 0;
+	size_t n_entries = htm->htm_mem_entries;
+	struct mem_entries *mem_entries_array;
+	size_t num_maps = 0;
+	struct addr_map *maps;
+	FILE *fp;
+	char lp_line[256];
 
 	snprintf(tracefile, sizeof(tracefile), "%s.out", htm->htmbin_file);
 
@@ -129,6 +337,27 @@ static int create_mem_maps(struct powerpc_htm *htm)
 		return ret;
 	}
 
+	/* get the lp index */
+	fp = fopen(lpar_cfg, "r");
+	if (!fp) {
+		pr_err("Failed to open %s: %s\n", lpar_cfg, strerror(errno));
+		return -errno;
+	}
+
+	while (fgets(lp_line, sizeof(lp_line), fp)) {
+		if (strncmp(lp_line, "partition_id=", 13) == 0) {
+			lp_filter = strtoul(lp_line + 13, NULL, 10);
+			break;
+		}
+	}
+
+	fclose(fp);
+
+	if (lp_filter == 0)
+		pr_info("partition_id not found in %s\n", lpar_cfg);
+	else
+		pr_info("Using partition_id = %" PRIu32 "\n", lp_filter);
+
 	fd = open(htm->trans_file, O_RDONLY);
 	if (fd == -1) {
 		pr_err("Failed to open %s: %s\n", htm->trans_file, strerror(errno));
@@ -160,9 +389,44 @@ static int create_mem_maps(struct powerpc_htm *htm)
 		return -1;
 	}
 
+	mem_entries_array = malloc(n_entries * sizeof(struct mem_entries));
+	if (!mem_entries_array) {
+		pr_err("Failed to allocate memory for mem entries: %s\n", strerror(errno));
+		munmap(mapped_data, file_size);
+		close(fd);
+		return -ENOMEM;
+	}
+
+	/* get the HTM memory map data and store it in mem_entries_array
+	 * to use it later on for physical->logical mapping
+	 */
+	for (u64 i = 0; i < n_entries; i++, mem++) {
+		mem_entries_array[i].phy_addr = bswap_64(mem->phy_real);
+		mem_entries_array[i].logical_addr = bswap_64(mem->logical_real);
+		mem_entries_array[i].lp_index = bswap_32(mem->lp_index);
+		mem_entries_array[i].size = bswap_64(mem->size);
+	}
+
 	munmap(mapped_data, file_size);
 	close(fd);
 
+	maps = process_trace_file(tracefile, mem_entries_array, n_entries, lp_filter, &num_maps);
+	if (!maps) {
+		pr_err("Error processing physical addresses from trace file\n");
+		free(mem_entries_array);
+		return -EINVAL;
+	}
+
+	for (size_t i = 0; i < num_maps; i++) {
+		pr_debug("Event: %-20s | Phys: 0x%016llx | Logical: 0x%lx\n",
+			maps[i].event,
+			maps[i].phys_addr,
+			(unsigned long)maps[i].logical_addr);
+	}
+
+	free(maps);
+	free(mem_entries_array);
+
 	return 0;
 }
 
-- 
2.52.0


