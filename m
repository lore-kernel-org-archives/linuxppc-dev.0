Return-Path: <linuxppc-dev+bounces-23290-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBC2C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:42:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqtmL6nbdz2yR5;
	Wed, 01 Jul 2026 18:41:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895314;
	cv=none; b=ms7mfMK2tSv7ul5gdMdFr6BYXEfSPsGggMOs+6Nkd73P0Gf1r80SgcVgyLeIv7xlcq+p/mFg/PaTCHU/Z94AmzlS+mY9PUUZ+dUjbejXFOygMsBf+XnuYpLx/mnHwxHZdq6oThwI0BtGPUzxDahlmxksvD3eNsfDLT2+X7QlDE2HU7uB79QSnpzTKbs8KQY6SrhX6/5ryW8vNRzvs10R/rVeabSUEuO9lApScE5atAH8KdhIDFDVrgD4CGipJe34l8ASieBbQ+zEEZec2t5TiQuPkGfVOip9vDT8szMzACnKMlivPHnzKvarqiaJ258lWCg4Qy8isD19EUVLzmylgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895314; c=relaxed/relaxed;
	bh=EKznqz6k9fF2prNxCU4Lqg7sev0q8vv+sIJyEvkwQ+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b38V7PE3p6hICMKkELQcDl0mK1UyU/F9KAUq9vKHODa6rIYOv4sts+3UsajOpoi3o8jOTPvM6WOnJoJV6FKXQSeauW8NCD13oLRIcsImgqOTNNqm2Rim2l9Ih6V/kuuDfEx8yN9U2i/ohQRH4e0prLHHcurV9em6FS/mjUlA0gz4o90fB+kJ3IexaZQSezPxQQvftpaQVEGZ88CaD2iVmGZLaiqwquidKxPF3oYxX8V/46KrgMHtB90QtJaYetH8uiDpvJI1o6tIvpzNRBM0vg3PCZMLvQwLX8Fd0duayE+qXbDbt4XHoJIATFTUhLaPkKs75O2xKXdUP+uMcO3Q9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jVKGznss; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jVKGznss;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqtmK6T4Pz2ytT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:41:53 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618IGlJ356574;
	Wed, 1 Jul 2026 08:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EKznqz6k9fF2prNxC
	U4Lqg7sev0q8vv+sIJyEvkwQ+A=; b=jVKGznssHYlP+9Q8lFqg+NhQEGVIdXCe3
	ypu+Xs4HNoA0gK8st4jgU5FL9ERTfZqOJuj0RhfT4NCrPVp1TsNzCN8SiELtX/1D
	Ka/hXN5Kr7fePpMxJ9dSgstAzTjN4I73aOW29Ob18DU0BtdBkejI7byn/XzhqUuG
	21jRimgEYUwW5YmxoWi1yLeLQjRryUk0rOutAMsn2ex3MdygbkwkvBXLarJI/bfZ
	bLndxrK8PWn+qLb9SYJu9LiZpr9Ixf2BUjD0lffu6vgIWbzpuKtm6GpNp96HBGZh
	7aQCuVX49lrWuvdmB7iK77VvlmYWp2s7m0+MPGLxmy8GqZIg/Qm8Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe3gg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618Ygps017220;
	Wed, 1 Jul 2026 08:41:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqemn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618fk4l28311928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:41:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D8DF2004D;
	Wed,  1 Jul 2026 08:41:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A43B420040;
	Wed,  1 Jul 2026 08:41:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:41:42 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com
Subject: [PATCH 6/9] perf tools powerpc: Add HTM trace data processing and decoding support
Date: Wed,  1 Jul 2026 14:11:12 +0530
Message-Id: <20260701084115.80383-7-atrajeev@linux.ibm.com>
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
X-Proofpoint-GUID: KU3rWavRPtFnB-2LrzZkDtT4ITWoKZUq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX++njTn5wgx3W
 pfQ293ROobC27HbkqmaRnoRCE2P2umVT3/Y+Sm7snjHpLDdHRhqBSpd2Z8SZk112ZTlKsnPbj9S
 6Dmqk+oKgD6jEJkM9v/OgOD9IRI749M=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a44d2ce cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=jYK58r7_-pNswP7_GM4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX3KXh5z/LPCxZ
 mARr6atfsBZJsLthM4vpnslhBcVnOV7ARf7uDPsqdMu0rhWAcnkWjX5Xldmcefi3WdVTyqVDkIk
 DbLYS6NCfgZJrHoJy3nWO3ATvpGkXNmqoo3LvifsA+86RcDk7mIUjFvitsSvPW6L/mDn0RIN6xb
 BghMkQitBzgYVUAE4fskxTC7+VEsmkYhcek98reJ/GS82MeCEvhECxXjnKGr0ax7R0JjIOx5T21
 qJqG6P+Y0nUooSZdQjG/2lpW1gS0+5hlsU96Ota9Mqk3rehWz3MFavNjHeteM8zhBnsTj71tFGi
 6UFOiATbuqbyi62zRGepx4a381dWqvAN4igLdMNUZTgfxWop9uIW6QMbCTO7CmmC106i7vLMT5h
 jWgvyBTf4P20CZ46sw1Sch8wo0qCBL5TNk+J7k/xm9ZWWVPRF+hu967Bx630qWvL4czVCyP9mTt
 an3Mk6wpcfFwo2qr/hA==
X-Proofpoint-ORIG-GUID: lvtCUjLgnm113zPYyJShH0lBLlEIMObG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010084

perf data includes SystemMemory Configuration dump. This
information helps to understand the physical to logical real
address mapping for the logical partitions in the system.

To help with relating and identifying the start of memory
mapping data in the auxiliary buffer, two PERF_SAMPLE_RAW records
are also present in the ring buffer. First PERF_SAMPLE_RAW record
represents beginning of system memory mapping data in aux buffer.
And second PERF_SAMPLE_RAW record represents the end of the trace
data in aux buffer and also contains the total size of the memory
map data. These sample raw records are used during post processing.

Add support for processing Hardware Trace Macro (HTM) auxiliary trace
data collected via perf AUX buffers. This enables post-processing of
HTM traces including system memory configuration and trace

HTM trace data includes two types of information:
1. Bus traces captured in the AUX buffer
2. System Memory Configuration that maps physical to logical real
   addresses for logical partitions

The implementation handles the challenge of large HTM trace buffers
(up to 8GB) being collected through perf AUX buffers (typically
16MB) by reading data in chunks during post-processing.

Key features:

- Process PERF_RECORD_SAMPLE events with RAW data that mark boundaries
  between trace data and memory configuration data in the AUX buffer

- Write HTM trace data to htm.bin.nXpXcX files where X represents
  node, chip, and core indices extracted from the event configuration

- Write system memory configuration to translation.nXpXcX files for
  address mapping analysis

- Integrate with external htmdecode tool for trace decoding
  when available (config bit 0 set indicates Bus traces)

- Use fork/exec pattern for secure external command execution with
  proper error handling and exit code checking

The memory configuration data is written in 32-byte entries with the
entry count stored at offset 0x10 in big-endian format. The first
PERF_SAMPLE_RAW record marks the start of memory mapping data, while
the second marks the end and contains the total buffer count.

Error handling includes:
- NULL checks for all file operations
- Verification of write operations
- Graceful degradation if htmdecode is not installed
- Proper resource cleanup (file handles, memory mappings)

Example usage:
  # perf record -C 1 -e htm/nodalchipindex=2,nodeindex=0,htm_type=1/ <workload> # Collect trace data
  # perf script -D    # Shows HTM trace data
  # ls htm.bin.*      # Binary trace files
  # ls translation.*  # Memory configuration files

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/util/powerpc-htm.c | 225 +++++++++++++++++++++++++++++++++-
 1 file changed, 224 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
index ffddf0e59fc1..487989ca4fc7 100644
--- a/tools/perf/util/powerpc-htm.c
+++ b/tools/perf/util/powerpc-htm.c
@@ -14,6 +14,12 @@
 #include <inttypes.h>
 #include "powerpc-htm.h"
 #include <errno.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include "sample.h"
+#include <sys/types.h>
+#include <sys/wait.h>
 
 struct perf_session;
 
@@ -26,8 +32,140 @@ struct powerpc_htm {
 	struct machine			*machine;
 	u32				pmu_type;
 	char				htmbin_file[64];
+	char				trans_file[64];
+	int				htm_mem_entries;
+	int				mem_maps;
 };
 
+struct htm_mem {
+	uint64_t phy_real;
+	uint64_t logical_real;
+	uint32_t lp_index;
+	uint8_t mem_tier;
+	uint8_t mem_type;
+	uint16_t res;
+	uint64_t size;
+};
+
+static int run_htmdecode(const char *input_file, const char *output_file)
+{
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	if (pid == -1) {
+		pr_err("fork() failed: %s\n", strerror(errno));
+		return -errno;
+	}
+
+	if (pid == 0) {
+		/* Child process */
+		int fd = open(output_file, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+
+		if (fd == -1) {
+			pr_err("Failed to open output file: %s\n", strerror(errno));
+			exit(1);
+		}
+
+		/* Redirect stdout to output file */
+		dup2(fd, STDOUT_FILENO);
+		close(fd);
+
+		/* Execute htmdecode - execlp searches PATH automatically */
+		execlp("htmdecode", "htmdecode", "-o", "-j", "-w", "1",
+			"-f", input_file, NULL);
+
+		/* If execlp returns, it failed */
+		pr_err("Failed to execute htmdecode: %s\n", strerror(errno));
+		if (errno == ENOENT)
+			pr_err("htmdecode not found in PATH\n");
+
+		exit(127);  /* Standard "command not found" exit code */
+	}
+
+	/* Parent process - wait for child */
+	if (waitpid(pid, &status, 0) == -1) {
+		pr_err("waitpid() failed: %s\n", strerror(errno));
+		return -errno;
+	}
+
+	/* Check exit status */
+	if (WIFEXITED(status)) {
+		int exit_code = WEXITSTATUS(status);
+
+		if (exit_code == 127) {
+			pr_err("htmdecode not found in PATH\n");
+			return -ENOENT;
+		} else if (exit_code != 0) {
+			pr_err("htmdecode failed with exit code %d\n", exit_code);
+			return -EINVAL;
+		}
+	} else if (WIFSIGNALED(status)) {
+		pr_err("htmdecode killed by signal %d\n", WTERMSIG(status));
+		return -EINTR;
+	}
+
+	return 0;
+}
+
+static int create_mem_maps(struct powerpc_htm *htm)
+{
+	off_t file_size;
+	void *htmdata, *mapped_data;
+	int fd;
+	struct stat file_info;
+	struct htm_mem *mem;
+	char tracefile[128];
+	int ret;
+
+	snprintf(tracefile, sizeof(tracefile), "%s.out", htm->htmbin_file);
+
+	ret = run_htmdecode(htm->htmbin_file, tracefile);
+	if (ret) {
+		if (ret == -ENOENT)
+			pr_info("htmdecode not found. Install htmdecode to decode traces.\n");
+		else
+			pr_info("htmdecode failed with error %d\n", ret);
+		return ret;
+	}
+
+	fd = open(htm->trans_file, O_RDONLY);
+	if (fd == -1) {
+		pr_err("Failed to open %s: %s\n", htm->trans_file, strerror(errno));
+		return -1;
+	}
+
+	if (fstat(fd, &file_info) == -1) {
+		close(fd);
+		pr_err("fstat failed on %s: %s\n", htm->trans_file, strerror(errno));
+		return -1;
+	}
+
+	file_size = file_info.st_size;
+
+	mapped_data = mmap(NULL, file_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (mapped_data == MAP_FAILED) {
+		close(fd);
+		pr_err("mmap failed on %s: %s\n", htm->trans_file, strerror(errno));
+		return -1;
+	}
+
+	htmdata = mapped_data + 0x20;
+	mem = (struct htm_mem *)htmdata;
+
+	if (!mem || !htm->htm_mem_entries) {
+		pr_info("No memory mapping entries captured in HTM translation\n");
+		munmap(mapped_data, file_size);
+		close(fd);
+		return -1;
+	}
+
+	munmap(mapped_data, file_size);
+	close(fd);
+
+	return 0;
+}
+
 /*
  * Check if HTM events have more data to collect.
  *
@@ -95,9 +233,55 @@ static void powerpc_htm_dump_event(size_t len)
 {
 	const char *color = PERF_COLOR_BLUE;
 
-	color_fprintf(stdout, color,
+	if (dump_trace) {
+		color_fprintf(stdout, color,
 			". ... HTM PMU data: size %zu bytes\n",
 			len);
+	}
+}
+
+static int write_htm(void *data, size_t size, struct powerpc_htm *htm)
+{
+	FILE *fp;
+	u64 *num_entries;
+	size_t entries;
+	size_t written;
+	int ret = -1;
+
+	if (htm->mem_maps) {
+		fp = fopen(htm->trans_file, "ab");
+		if (!fp) {
+			pr_err("Failed to open %s: %s\n", htm->trans_file, strerror(errno));
+			return ret;
+		}
+		num_entries = data + 0x10;
+		entries = be64_to_cpu(*num_entries);
+		entries++;
+		written = fwrite(data, 32, entries, fp);
+		if (written != entries) {
+			pr_err("Failed to write data: expected %zu, wrote %zu\n", entries, written);
+			fclose(fp);
+			return ret;
+		}
+		fclose(fp);
+		htm->htm_mem_entries += entries;
+		return 0;
+	}
+
+	fp = fopen(htm->htmbin_file, "a");
+	if (!fp) {
+		pr_err("Failed to open %s: %s\n", htm->htmbin_file, strerror(errno));
+		return ret;
+	}
+	written = fwrite(data, size, 1, fp);
+	if (!written) {
+		pr_err("Failed to htm trace data\n");
+		fclose(fp);
+		return ret;
+	}
+	fclose(fp);
+
+	return 0;
 }
 
 static int powerpc_htm_process_event(struct perf_session *session __maybe_unused,
@@ -105,6 +289,37 @@ static int powerpc_htm_process_event(struct perf_session *session __maybe_unused
 				 struct perf_sample *sample __maybe_unused,
 				 const struct perf_tool *tool __maybe_unused)
 {
+	struct powerpc_htm *htm = container_of(session->auxtrace, struct powerpc_htm,
+			auxtrace);
+
+	if ((event->header.type == PERF_RECORD_SAMPLE) && sample->raw_data) {
+		int *content = (int *)sample->raw_data;
+		struct evsel *evsel = evlist__event2evsel(session->evlist, event);
+		int config = (evsel->core.attr.config) & 0xF;
+		struct auxtrace_buffer *buffer = NULL;
+		struct auxtrace_queues *queues = &htm->queues;
+		unsigned int i = 0;
+		int j = 0;
+
+		if (strstr(evsel->name, "htm") == NULL)
+			return 0;
+
+		for (i = 0; i < queues->nr_queues; i++) {
+			buffer = auxtrace_buffer__next(&queues->queue_array[i], buffer);
+			for (; buffer;) {
+				if (j >= *content)
+					htm->mem_maps = 1;
+				if (write_htm(buffer->data, buffer->size, htm))
+					return -1;
+				j++;
+				buffer = auxtrace_buffer__next(&queues->queue_array[i], buffer);
+			}
+		}
+		/* Only for power bus traces, we decode traces */
+		if (config == 1)
+			create_mem_maps(htm);
+	}
+
 	return 0;
 }
 
@@ -205,6 +420,14 @@ int powerpc_htm_process_auxtrace_info(union perf_event *event,
 	}
 	fclose(fp);
 
+	snprintf(htm->trans_file, sizeof(htm->trans_file), "translation.n%d.p%d.c%d", nodeindex, nodalchipindex, coreindexonchip);
+	fp = fopen(htm->trans_file, "w");
+	if (!fp) {
+		pr_err("Failed to create %s: %s\n", htm->trans_file, strerror(errno));
+		return -errno;
+	}
+	fclose(fp);
+
 	powerpc_htm_print_info(&auxtrace_info->priv[0]);
 
 	err = auxtrace_queues__process_index(&htm->queues, session);
-- 
2.52.0


