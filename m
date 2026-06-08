Return-Path: <linuxppc-dev+bounces-22193-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25ABCD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 13:01:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYsc1249Hz2yv0;
	Mon, 08 Jun 2026 23:01:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780923665;
	cv=none; b=k1kGjoBqzu9cSu8GWALiHoV+vspq0Wu2iEfv0BcmiykSugawizE5mUyRrhWr2aD7JQMnkrQ+QSCb2unUebkgOiutxYDNQlR3zSiQjF+4JGAvhgmpgIiKwWmP+AKx7dQrGih2B4BmciLzj6wONaU61BoYoYatCRkr8xONO44wBFVUhS3GbxvWGnjCmTQxzoFvUMgpNr5Qhwa8c5bY2KHTG5ZVUI/fciE+bVnEEtAS3NRacCfJld/eVxvIPVooVVqAFMdeqkPDaJhh6QQoIY/DXi7uh6lnNrzymPMaR5yA7zYN+q3VDuuLSz/wATEQGNcw1oMziJfdcsNPgu2J98nlnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780923665; c=relaxed/relaxed;
	bh=L3CF53njxJZa2B8YwUl38ew/CKrs+rrrRqngvrvAk6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmmPBhjmtXnw47Jm8D4Jn0x5cOn4tdLlbSYdyNdZLNwiQ86bt5HN9BjGv8xzV4qETgTOEj7gBnyiOVR2TznrJ5v7DOTg037DV/hrbfna2f3FHZarg5M8vAT327G6IrOjA5d8EvRaXAkMM4L5fOjatpXBnrFwtij/qo+aaJVqIoM3L0jUNhKVntrALArZW25bv1uYTHqxdBdUzybAe9G8l5pZqr7vT+9xWVSzuv4iPClnR+BG2bLKJzmjPoIv1ia0DIFkpeqoIzcBt1l3codbluO7k1b275yUmxKR2DeZj13iiF+cA1NNgvTnBMRHLBHCVWp72yLRj/5fHUhnvRmPNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NmfN4eLn; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NmfN4eLn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYsc00JjPz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 23:01:03 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657Ko2rm2849834;
	Mon, 8 Jun 2026 13:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=L3CF53njxJZa2B8Yw
	Ul38ew/CKrs+rrrRqngvrvAk6U=; b=NmfN4eLndqbgROywIQCUEU2JL3lq4kQll
	iKdWwtbSHXrzoexqWqyY3nTwF3NS1l5FWI4FNgzgeMnuuUPDLcso8rnn4Vta2n1S
	fG1f569USRFnT8NPtxhlpDdSxkyrNkum4wP6yGMwxohoLqrbpyDBac7zGV0Y2wW4
	XjarlCLOLBzwHA+7qWGTlZf2qF4phv6zMsYwqJtCG5Hl642uIVisinOzu/ottSlv
	b8PDCik4pCACR6l0gIYBC0YLmduHQ4mhSCzGRelsSpryXiPLZ20wCL9OxN4jFqR+
	azhkpEayykA0K6OB6brIEhaaQ2vezKIeIk1IktKqgrWaeZGXMaZ2Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb957b73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 13:00:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658CneGg004146;
	Mon, 8 Jun 2026 13:00:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vwfm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 13:00:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658D0s8c30474692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 13:00:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A31620040;
	Mon,  8 Jun 2026 13:00:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0B4F20049;
	Mon,  8 Jun 2026 13:00:48 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.124.212.67])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 13:00:48 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [RFC PATCH 2/4] perf/trace-event: Write trace.dat metadata sections during parsing
Date: Mon,  8 Jun 2026 18:29:50 +0530
Message-ID: <20260608125951.90425-4-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608125951.90425-2-tshah@linux.ibm.com>
References: <20260608125951.90425-2-tshah@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a26bd0b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=pu8MBmnsNZc9XKMkDnAA:9
X-Proofpoint-ORIG-GUID: LyBKJ6SXJnXlmaZMilDBluRpSUED59OC
X-Proofpoint-GUID: OjcPYNAgwT-PL8PQsXpI6ukTBTquBeW4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExOSBTYWx0ZWRfX58TKBPzAqOs9
 HSSOV3Xm7uZMWC/x7P465rDRTyxdVbs5LV/ALRQLFSxcfRPDq95rdemPigy6NAQhLIqAwbexvSY
 2AfO9ALhbl/a2BYXLTxaBYwMT18q2zB8K267KYwitjwxld9oO+mjqqKAra86F/zFH50MfYsXkkg
 V2GUAoKlr/8uJI3EvWeMVzPo9Zcl+m+2WDspsCTWxwWMct7EqZHHmQ7n+K8tUqB+lYGbVUgbozX
 UFJZl+9d9VFDLEfvkg5THDmjzhHcf9u1sO72Qh+Z4DvCIvnIlNOno0qIHDxIZsI3jcsMi9D4206
 RP1TW01vE4AptseLoo3y8hmcOgz0aPBYDHKgEUlAMAs6lIzut5QVXRwhP6x43QRMlssRib7efPj
 hx4oK7vrcZYPWo5w7eIITk+z74MmVtn4PBdS/7DznHI7W3QXBhP9nU4ebsPOo4J8r/F1OzLPaaQ
 +PhqVyvmns2RQf0wK9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080119

Perf already captures the tracing metadata as a part of
data section in perf.data

When trace_dat_fp is set, write trace.dat compatible metadata
sections using the perf provided raw buffers.

Sections written:
- Initial format header (magic, version, endian, long_size,
  page_size, compression, options_offset placeholder)
- Section 16: HEADER INFO (header_page + header_event)
- Section 17: FTRACE EVENT FORMATS
- Section 18: EVENT FORMATS (per system/event format files)
- Section 19: KALLSYMS
- Section 21: CMDLINES
- Section 15: STRINGS (written last after all sections)

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/trace-event-read.c | 259 ++++++++++++++++++++++++++++-
 1 file changed, 252 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index ecbbb93f0185..815577703c2e 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -19,6 +19,7 @@
 #include "trace-event.h"
 #include "debug.h"
 #include "util.h"
+#include "trace-dat.h"
 
 static int input_fd;
 
@@ -145,10 +146,9 @@ static char *read_string(void)
 static int read_proc_kallsyms(struct tep_handle *pevent)
 {
 	unsigned int size;
+	char *buf;
 
 	size = read4(pevent);
-	if (!size)
-		return 0;
 	/*
 	 * Just skip it, now that we configure libtraceevent to use the
 	 * tools/perf/ symbol resolver.
@@ -160,11 +160,56 @@ static int read_proc_kallsyms(struct tep_handle *pevent)
 	 * payload", so that older tools can continue reading it and interpret
 	 * it as "no kallsyms payload is present".
 	 */
-	lseek(input_fd, size, SEEK_CUR);
+	/* Write kallsyms section with empty payload if no data */
+	if (!size) {
+		if (trace_dat_fp) {
+			unsigned short section_id = TRACE_DAT_SECTION_KALLSYMS;
+			unsigned short flags = 0;
+			unsigned long long section_size = sizeof(unsigned int);
+			unsigned int kallsyms_data = 0;
+			unsigned int string_id = STRID_KALLSYMS;
+
+			trace_dat_kallsyms_offset = ftell(trace_dat_fp);
+			if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
+			    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
+			    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
+			    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+			    !fwrite(&kallsyms_data, sizeof(unsigned int), 1, trace_dat_fp))
+				return -EIO;
+		}
+		return 0;
+	}
+	buf = malloc(size);
+	if (buf == NULL)
+		return -1;
+	if (read(input_fd, buf, size) < 0) {
+		free(buf);
+		return -1;
+	}
 	trace_data_size += size;
+	/* Write kallsyms section with data */
+	if (trace_dat_fp) {
+		unsigned short section_id = TRACE_DAT_SECTION_KALLSYMS;
+		unsigned int string_id = STRID_KALLSYMS;
+		unsigned long long section_size = sizeof(unsigned int) + size;
+		unsigned short flags = 0;
+
+		trace_dat_kallsyms_offset = ftell(trace_dat_fp);
+		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
+		    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+		    !fwrite(&size, sizeof(unsigned int), 1, trace_dat_fp) ||
+		    !fwrite(buf, 1, size, trace_dat_fp)) {
+			free(buf);
+			return -EIO;
+		}
+	}
+	free(buf);
 	return 0;
 }
 
+
 static int read_ftrace_printk(struct tep_handle *pevent)
 {
 	unsigned int size;
@@ -195,6 +240,13 @@ static int read_ftrace_printk(struct tep_handle *pevent)
 static int read_header_files(struct tep_handle *pevent)
 {
 	unsigned long long size;
+	unsigned long long header_page_size;
+	unsigned long long header_event_size;
+	char *header_event;
+	unsigned short section_id;
+	unsigned short flags;
+	unsigned int string_id;
+	unsigned long long section_size;
 	char *header_page;
 	char buf[BUFSIZ];
 	int ret = 0;
@@ -209,6 +261,7 @@ static int read_header_files(struct tep_handle *pevent)
 
 	size = read8(pevent);
 
+	header_page_size = size;
 	header_page = malloc(size);
 	if (header_page == NULL)
 		return -1;
@@ -227,19 +280,59 @@ static int read_header_files(struct tep_handle *pevent)
 		 */
 		tep_set_long_size(pevent, tep_get_header_page_size(pevent));
 	}
-	free(header_page);
 
-	if (do_read(buf, 13) < 0)
+	if (do_read(buf, 13) < 0) {
+		free(header_page);
 		return -1;
+	}
 
 	if (memcmp(buf, "header_event", 13) != 0) {
 		pr_debug("did not read header event");
+		free(header_page);
 		return -1;
 	}
 
 	size = read8(pevent);
-	skip(size);
+	if (trace_dat_fp) {
+		header_event_size = size;
+		header_event = malloc(size);
+		if (header_event == NULL) {
+			free(header_page);
+			return -1;
+		}
+		if (do_read(header_event, size) < 0) {
+			free(header_page);
+			free(header_event);
+			return -1;
+		}
+		/* Write header_page and header_event to trace.dat */
+		section_id = TRACE_DAT_SECTION_HEADER;
+		flags = 0;
+		string_id = STRID_HEADERS;
+		section_size = 12 + 8 + header_page_size + 13 + 8 +
+				header_event_size;
+
+		trace_dat_header_info_offset = ftell(trace_dat_fp);
+		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
+		    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+		    !fwrite("header_page\0", 1, 12, trace_dat_fp) ||
+		    !fwrite(&header_page_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+		    !fwrite(header_page, 1, header_page_size, trace_dat_fp) ||
+		    !fwrite("header_event\0", 1, 13, trace_dat_fp) ||
+		    !fwrite(&header_event_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+		    !fwrite(header_event, 1, header_event_size, trace_dat_fp)) {
+			free(header_page);
+			free(header_event);
+			return -EIO;
+		}
+		free(header_event);
+	} else {
+		skip(size);
+	}
 
+	free(header_page);
 	return ret;
 }
 
@@ -259,6 +352,13 @@ static int read_ftrace_file(struct tep_handle *pevent, unsigned long long size)
 		pr_debug("error reading ftrace file.\n");
 		goto out;
 	}
+	if (trace_dat_fp) {
+		if (!fwrite(&size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+		    !fwrite(buf, 1, size, trace_dat_fp)) {
+			free(buf);
+			return -EIO;
+		}
+	}
 
 	ret = parse_ftrace_file(pevent, buf, size);
 	if (ret < 0)
@@ -283,6 +383,13 @@ static int read_event_file(struct tep_handle *pevent, char *sys,
 	ret = do_read(buf, size);
 	if (ret < 0)
 		goto out;
+	if (trace_dat_fp) {
+		if (!fwrite(&size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+		    !fwrite(buf, 1, size, trace_dat_fp)) {
+			free(buf);
+			return -EIO;
+		}
+	}
 
 	ret = parse_event_file(pevent, buf, size, sys);
 	if (ret < 0)
@@ -298,8 +405,31 @@ static int read_ftrace_files(struct tep_handle *pevent)
 	int count;
 	int i;
 	int ret;
+	long section_size_pos = 0;
+	long count_pos = 0;
+	unsigned long long section_size = 0;
+	long end_pos;
 
 	count = read4(pevent);
+	/* Write ftrace formats section to trace.dat output file */
+	if (trace_dat_fp) {
+		unsigned short section_id = TRACE_DAT_SECTION_FTRACE;
+		unsigned short flags = 0;
+		unsigned int string_id = STRID_FTRACE_FORMATS;
+
+		trace_dat_ftrace_format_offset = ftell(trace_dat_fp);
+
+		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp))
+			return -EIO;
+		section_size_pos = ftell(trace_dat_fp);
+		if (!fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp))
+			return -EIO;
+		count_pos = ftell(trace_dat_fp);
+		if (!fwrite(&count, sizeof(unsigned int), 1, trace_dat_fp))
+			return -EIO;
+	}
 
 	for (i = 0; i < count; i++) {
 		size = read8(pevent);
@@ -307,6 +437,16 @@ static int read_ftrace_files(struct tep_handle *pevent)
 		if (ret)
 			return ret;
 	}
+	/* Fill in section size after writing all ftrace files */
+	if (trace_dat_fp) {
+		end_pos = ftell(trace_dat_fp);
+		section_size = end_pos - count_pos;
+		fseek(trace_dat_fp, section_size_pos, SEEK_SET);
+		if (!fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp))
+			return -EIO;
+		fseek(trace_dat_fp, end_pos, SEEK_SET);
+	}
+
 	return 0;
 }
 
@@ -318,8 +458,30 @@ static int read_event_files(struct tep_handle *pevent)
 	int count;
 	int i,x;
 	int ret;
+	long section_size_pos = 0;
+	long sys_count_pos = 0;
+	unsigned long long section_size = 0;
+	long end_pos;
 
 	systems = read4(pevent);
+	/* Write event formats section to trace.dat output file */
+	if (trace_dat_fp) {
+		unsigned short section_id = TRACE_DAT_SECTION_EVENTS;
+		unsigned short flags = 0;
+		unsigned int string_id = STRID_EVENT_FORMATS;
+
+		trace_dat_events_format_offset = ftell(trace_dat_fp);
+		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp))
+			return -EIO;
+		section_size_pos = ftell(trace_dat_fp);
+		if (!fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp))
+			return -EIO;
+		sys_count_pos = ftell(trace_dat_fp);
+		if (!fwrite(&systems, sizeof(unsigned int), 1, trace_dat_fp))
+			return -EIO;
+	}
 
 	for (i = 0; i < systems; i++) {
 		sys = read_string();
@@ -327,6 +489,11 @@ static int read_event_files(struct tep_handle *pevent)
 			return -1;
 
 		count = read4(pevent);
+		if (trace_dat_fp) {
+			if (!fwrite(sys, 1, strlen(sys) + 1, trace_dat_fp) ||
+			   !fwrite(&count, sizeof(unsigned int), 1, trace_dat_fp))
+				return -EIO;
+		}
 
 		for (x=0; x < count; x++) {
 			size = read8(pevent);
@@ -338,6 +505,16 @@ static int read_event_files(struct tep_handle *pevent)
 		}
 		free(sys);
 	}
+	/* Fill in section size after writing all event files */
+	if (trace_dat_fp) {
+		end_pos = ftell(trace_dat_fp);
+		section_size = end_pos - sys_count_pos;
+		fseek(trace_dat_fp, section_size_pos, SEEK_SET);
+		if (!fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp))
+			return -EIO;
+		fseek(trace_dat_fp, end_pos, SEEK_SET);
+	}
+
 	return 0;
 }
 
@@ -349,8 +526,25 @@ static int read_saved_cmdline(struct tep_handle *pevent)
 
 	/* it can have 0 size */
 	size = read8(pevent);
-	if (!size)
+	/* Write cmdlines section with empty payload if no data */
+	if (!size) {
+		if (trace_dat_fp) {
+			unsigned short section_id = TRACE_DAT_SECTION_CMDLINE;
+			unsigned short flags = 0;
+			unsigned int string_id = STRID_CMDLINES;
+			unsigned long long section_size = sizeof(unsigned long long);
+			unsigned long long section_data = 0;
+
+			trace_dat_cmdline_offset = ftell(trace_dat_fp);
+			if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
+			    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
+			    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
+			    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+			    !fwrite(&section_data, sizeof(unsigned long long), 1, trace_dat_fp))
+				return -EIO;
+		}
 		return 0;
+	}
 
 	buf = malloc(size + 1);
 	if (buf == NULL) {
@@ -363,6 +557,23 @@ static int read_saved_cmdline(struct tep_handle *pevent)
 		pr_debug("error reading saved cmdlines\n");
 		goto out;
 	}
+	/* Write cmdlines section with data */
+	if (trace_dat_fp) {
+		unsigned short section_id = TRACE_DAT_SECTION_CMDLINE;
+		unsigned short flags = 0;
+		unsigned int string_id = STRID_CMDLINES;
+		unsigned long long section_size = sizeof(unsigned long long) + size;
+
+		trace_dat_cmdline_offset = ftell(trace_dat_fp);
+		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
+		    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+		    !fwrite(&size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+		    !fwrite(buf, 1, size, trace_dat_fp))
+			return -EIO;
+	}
+
 	buf[ret] = '\0';
 
 	parse_saved_cmdline(pevent, buf, size);
@@ -387,6 +598,7 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 	int file_page_size;
 	struct tep_handle *pevent = NULL;
 	int err;
+	char magic_buf[10];
 
 	repipe = __repipe;
 	input_fd = fd;
@@ -398,12 +610,17 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 		return -1;
 	}
 
+	if (trace_dat_fp)
+		memcpy(magic_buf, buf, 3);
+
 	if (do_read(buf, 7) < 0)
 		return -1;
 	if (memcmp(buf, "tracing", 7) != 0) {
 		pr_debug("not a trace file (missing 'tracing' tag)");
 		return -1;
 	}
+	if (trace_dat_fp)
+		memcpy(magic_buf + 3, buf, 7);
 
 	version = read_string();
 	if (version == NULL)
@@ -440,6 +657,28 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 	tep_set_long_size(pevent, file_long_size);
 	tep_set_page_size(pevent, file_page_size);
 
+	/* Write initial file header to trace.dat */
+	if (trace_dat_fp) {
+		unsigned char endian = file_bigendian;
+		unsigned char long_size = file_long_size;
+		unsigned int page_size = file_page_size;
+		unsigned long long placeholder = 0;
+		char trace_dat_version = TRACE_DAT_VERSION;
+
+		if (!fwrite(magic_buf, 1, 10, trace_dat_fp) ||    /* magic + "tracing" */
+		    !fwrite(&trace_dat_version, 1, 2, trace_dat_fp) ||
+		    !fwrite(&endian, 1, 1, trace_dat_fp) ||
+		    !fwrite(&long_size, 1, 1, trace_dat_fp) ||
+		    !fwrite(&page_size, sizeof(unsigned int), 1, trace_dat_fp) ||
+		    !fwrite("none", 1, 4, trace_dat_fp) ||
+		    !fwrite("\0", 1, 1, trace_dat_fp) ||
+		    !fwrite("\0", 1, 1, trace_dat_fp))
+			return -EIO;
+		trace_dat_options_offset = ftell(trace_dat_fp);
+		if (!fwrite(&placeholder, sizeof(unsigned long long), 1, trace_dat_fp))
+			return -EIO;
+	}
+
 	err = read_header_files(pevent);
 	if (err)
 		goto out;
@@ -460,6 +699,12 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 		if (err)
 			goto out;
 	}
+	/* Write strings section to trace.dat output file */
+	if (trace_dat_fp) {
+		err = trace_dat__write_strings_section();
+		if (err)
+			goto out;
+	}
 
 	size = trace_data_size;
 	repipe = false;
-- 
2.53.0


