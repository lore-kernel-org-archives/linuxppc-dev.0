Return-Path: <linuxppc-dev+bounces-25273-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A61C55179
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 15:00:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDKcJ2Jbkz30F3;
	Tue, 04 Aug 2026 01:00:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785769248;
	cv=none; b=bMLIobuVCJ1sejSRlzNgaM50B32Ybv7mZV9BTDpEUDYqeHR4ABGAluiTOV6CuQzXLyvAguOC0GjE+IQo4UDjvZpeEcHh0yb7xxUc+4f1LY1p+uB+ZRAg0EiKzqcuRJ8PnN4pqXio/mIRYhx08/V/m/AfGmMk97jyD18gkxwt3sMYxiSYk5id9jW801cg3lgtxdoGHWo/a+0MuMKBprPCqrGvlkTrPeoMq1eekqcQscBwzQ9Yz3RoD0+b+ThV5aC6LtTyBebaWtB/a2IboLUmRNNj4DxJMlPESMz5GKhFHU/Kn6vn8xTa8myFxgOog3yFWeTEeh5o91NP1+fQO7cscQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785769248; c=relaxed/relaxed;
	bh=AommiyRlfMgU6Leiz9tgZ2I5Fh0fNmrDN+DALrNTDyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAcM4rHsq9ZuO6q6hSGqeJb1hUwdbaVZO6VTgmb/NAtfx8aeyCoNjpaUg6HMHz93RMtA2R4GIKF1khTdoz6B7Va0HKJ2g/k2UtsGt57UnuIB056gAczh/uwWgpbCQe+F7aPQl5Tq9qlJ8Fj3C3Rr7rcHZKgECzk4p0WoNLYmY0E/xVPNwAAEGUGRA/hz3HDC4TLaeG5nVhbMNrdFrPOMIsnaXv+b5f7djZMdOU5795nSJ7giWMIdEhxLjRrZnU8/8pFew3+g7TcVDoaXPgsxVSfOWnT1ZDiwdcJFZHfvVQrToKmnm1AXN84ROHXGUkG0v5YCicWqoDy/me20aKiRbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qUHJgJtJ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qUHJgJtJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDKcG2fp2z30F0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 01:00:46 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHl0T2341262;
	Mon, 3 Aug 2026 15:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AommiyRlfMgU6Leiz
	9tgZ2I5Fh0fNmrDN+DALrNTDyM=; b=qUHJgJtJd/r9j9acoFGOaNewjMWbchP1G
	7W18uT3DNG7pI9rd9w35J9hT1kK9mRVOP5EHpCz9cIYd811dOcD7IASkaYFyfc6d
	aayKJJvV6hvL4SiGWBhP/waCD9gO2mU0jfi4s9hf91G5XxVRM/eTMPNYozjJaemW
	UMdoD4Yj6rZsj1aqN4A7C6wEWMjkDEx4NtXKYv0OnaPEEGeaAZyKbS8L/2am2U++
	DWs5Xz1dRDrEAYdbTg7lr8Y2BjOepc8k60Tk2t98tzJ2G9GuJtECOo73HbkcEOhG
	Y5vnu6mAqN+If6T79hnfmV7ozNHlNMoYtaA6zH2/YsVH65jQSGw1Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euh20h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:00:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EuL52031637;
	Mon, 3 Aug 2026 15:00:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh5u3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:00:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673F0Vod49742146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 15:00:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C810A2004B;
	Mon,  3 Aug 2026 15:00:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C4E720040;
	Mon,  3 Aug 2026 15:00:27 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.27.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 15:00:26 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, rostedt@goodmis.org,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [RFC PATCH v3 2/5] perf/trace-event: Write trace.dat metadata sections during parsing
Date: Mon,  3 Aug 2026 20:29:52 +0530
Message-ID: <20260803145958.299956-3-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803145958.299956-1-tshah@linux.ibm.com>
References: <20260803145958.299956-1-tshah@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: VdNpgzymXdWCYUiB4e1d8uJVIpNfB3vH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfXw4XttTyowE8k
 tV2v+ZihWXtYNHNHsXZM1vYnoFC76XZLWcKr+nv6ptgSkJ2Iv3eJeCoQtJU+xMudIHt1yIXXQ/E
 zdjDJgHIOsdyTP2R4+YACHcgYF9sKYg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX5zX4T4RpOOqS
 z8T0/1sBkvPoJmHunZZucXoyOmPhM0EaY71NhRh8FXYGK1hLRB4sT4kMbaWfx/BVS+FbsjhqIO8
 BC3wl6ZBpZ3SYGGWtCy1MLLxwHc12MoeWixZDFtr/1OHr0YyFi+nYqTYeg+or7vLdNHQSqd0Iyk
 /DBuBTYJ9rIO6lQprntFAksmCrJCZu5noNw+Dt4ooaj8zps3k72n0Z+zEfRzlJLkQEIasBAQPoS
 QIJElvwrMUn3Qhiz5+3FjQucP9q10eAmTezHc/bXl4tpMIdsJXsWblr6naeXkk5QTHViE7yihoY
 09IHjdSWA2edxJQKFrrVh2W6KWz5eDAKHT+uwzYeyBZgL7srPwL2E5brk1emPRa6e1j5HS59Sx3
 USzw3sn9Rf1y8FoMqRNSIzAcG2ZI8QRD+vbAYo3/bc+jW3Hhidvo5FHZgu2AjdsY9VBvBXVKrez
 m31QtjS+dQgwjkDCJ3Q==
X-Proofpoint-GUID: 9Bn9SW2IpKtKtD91ZfR6B-JxXEalAU4X
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70ad15 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=MWTGtYEeQcsAdA271ZEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030133

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

Introduce to_file_u16/u32/u64 helpers wrapping tep_read_number() to
write all trace.dat metadata in the recorded machine's byte
order, ensuring correct cross-platform compatibility.

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/trace-dat.c        | 212 ++++++++++++--------
 tools/perf/util/trace-dat.h        |  40 +++-
 tools/perf/util/trace-event-read.c | 307 ++++++++++++++++++++++++++++-
 3 files changed, 465 insertions(+), 94 deletions(-)

diff --git a/tools/perf/util/trace-dat.c b/tools/perf/util/trace-dat.c
index 55a7bd982c6f..f71e03716e27 100644
--- a/tools/perf/util/trace-dat.c
+++ b/tools/perf/util/trace-dat.c
@@ -43,6 +43,7 @@
 /* Buffer size for reading trace_clock string from debugfs/tracefs */
 #define CLOCK_BUFFER_SIZE 256
 
+bool trace_dat_write_failed;
 FILE *trace_dat_fp;
 int trace_dat_page_size;
 int trace_dat_nr_cpus;
@@ -143,10 +144,12 @@ int trace_dat__collect_cpu_event(int cpu, unsigned long long ts,
 }
 
 /* Write a single page of trace records */
-static int trace_dat__write_page(FILE *fp, unsigned long long base_ts,
+static int trace_dat__write_page(FILE *fp, struct tep_handle *pevent, unsigned long long base_ts,
 			char **records, int *rec_sizes, int nr_recs)
 {
 	unsigned long long commit = 0;
+	unsigned long long ts_out;
+	unsigned long long commit_out;
 	int offset = TRACE_DAT_RECORD_HEADER_SIZE;
 	int i;
 	char *page;
@@ -161,8 +164,12 @@ static int trace_dat__write_page(FILE *fp, unsigned long long base_ts,
 		commit += rec_sizes[i];
 	}
 
-	memcpy(page, &base_ts, sizeof(base_ts));
-	memcpy(page + sizeof(base_ts), &commit, sizeof(commit));
+	/* Byte-swap page header for cross-arch compatibility */
+	ts_out = to_file_u64(pevent, base_ts);
+	commit_out = to_file_u64(pevent, commit);
+
+	memcpy(page, &ts_out, sizeof(ts_out));
+	memcpy(page + sizeof(ts_out), &commit_out, sizeof(commit_out));
 
 	if (!fwrite(page, 1, trace_dat_page_size, fp)) {
 		free(page);
@@ -174,7 +181,8 @@ static int trace_dat__write_page(FILE *fp, unsigned long long base_ts,
 }
 
 /* Write all trace data for a single CPU as trace.dat flyrecord pages */
-static int trace_dat__write_cpu_dat(FILE *fp, int cpu, unsigned long long *file_offset_out)
+static int trace_dat__write_cpu_dat(FILE *fp, struct tep_handle *pevent,
+		int cpu, unsigned long long *file_offset_out)
 {
 	struct cpu_events *cpu_events = &trace_cpu_data[cpu];
 	unsigned long long base_ts;
@@ -229,11 +237,18 @@ static int trace_dat__write_cpu_dat(FILE *fp, int cpu, unsigned long long *file_
 			if (!extend)
 				return -ENOMEM;
 
-			extend_hdr =
-				((time_delta & TRACE_DAT_RECORD_TIME_MASK) <<
-				 TRACE_DAT_RECORD_TIME_SHIFT) |
-				TRACE_DAT_RECORD_TYPE_TIME_EXTEND;
-			delta_upper = time_delta >> TRACE_DAT_RECORD_TIME_SHIFT;
+			if (tep_is_file_bigendian(pevent)) {
+				extend_hdr = (time_delta & TRACE_DAT_RECORD_TIME_MASK) |
+				     (TRACE_DAT_RECORD_TYPE_TIME_EXTEND << 27);
+				delta_upper = time_delta >> 27;
+			} else {
+				extend_hdr = ((time_delta & TRACE_DAT_RECORD_TIME_MASK) <<
+					TRACE_DAT_RECORD_TIME_SHIFT) |
+					TRACE_DAT_RECORD_TYPE_TIME_EXTEND;
+				delta_upper = time_delta >> TRACE_DAT_RECORD_TIME_SHIFT;
+			}
+			extend_hdr  = to_file_u32(pevent, extend_hdr);   /* still needed */
+			delta_upper = to_file_u32(pevent, delta_upper);   /* still needed */
 
 			memcpy(extend, &extend_hdr, TRACE_DAT_WORD_SIZE);
 			memcpy(extend + TRACE_DAT_WORD_SIZE, &delta_upper,
@@ -273,7 +288,7 @@ static int trace_dat__write_cpu_dat(FILE *fp, int cpu, unsigned long long *file_
 		/* Check page fit BEFORE allocating data record */
 		if (page_size_used + needed_size >
 			trace_dat_page_size - TRACE_DAT_RECORD_HEADER_SIZE) {
-			ret = trace_dat__write_page(fp, base_ts,
+			ret = trace_dat__write_page(fp, pevent, base_ts,
 					page_records, page_rec_sizes,
 					nr_page_recs);
 
@@ -299,7 +314,13 @@ static int trace_dat__write_cpu_dat(FILE *fp, int cpu, unsigned long long *file_
 			time_delta = 0;
 		}
 
-		hdr_word = (time_delta << TRACE_DAT_RECORD_TIME_SHIFT) | type_len;
+		if (tep_is_file_bigendian(pevent))
+			hdr_word = ((unsigned int)time_delta & TRACE_DAT_RECORD_TIME_MASK) |
+				(type_len << 27);
+		else
+			hdr_word = ((unsigned int)time_delta << TRACE_DAT_RECORD_TIME_SHIFT) |
+				type_len;
+		hdr_word = to_file_u32(pevent, hdr_word);
 
 		data_rec = calloc(1, data_rec_size);
 		if (!data_rec) {
@@ -311,8 +332,11 @@ static int trace_dat__write_cpu_dat(FILE *fp, int cpu, unsigned long long *file_
 		memcpy(data_rec, &hdr_word, TRACE_DAT_WORD_SIZE);
 
 		/* Large events: write actual byte length after header */
-		if (type_len == 0)
-			memcpy(data_rec + TRACE_DAT_WORD_SIZE, &data_len, TRACE_DAT_WORD_SIZE);
+		if (type_len == 0) {
+			unsigned int data_len_out = to_file_u32(pevent, data_len);
+
+			memcpy(data_rec + TRACE_DAT_WORD_SIZE, &data_len_out, TRACE_DAT_WORD_SIZE);
+		}
 
 		memcpy(data_rec + payload_offset, event->raw, data_len);
 
@@ -366,7 +390,7 @@ static int trace_dat__write_cpu_dat(FILE *fp, int cpu, unsigned long long *file_
 	}
 
 	if (nr_page_recs > 0) {
-		ret = trace_dat__write_page(fp, base_ts,
+		ret = trace_dat__write_page(fp, pevent, base_ts,
 				page_records, page_rec_sizes, nr_page_recs);
 	}
 out_free:
@@ -378,11 +402,11 @@ static int trace_dat__write_cpu_dat(FILE *fp, int cpu, unsigned long long *file_
 }
 
 /* Write the strings section containing section name lookup table */
-int trace_dat__write_strings_section(void)
+int trace_dat__write_strings_section(struct tep_handle *pevent)
 {
-	unsigned short section_id = TRACE_DAT_SECTION_STRINGS;
-	unsigned short flags = 0;
 	unsigned long long section_size = 0;
+	unsigned short section_id = to_file_u16(pevent, TRACE_DAT_SECTION_STRINGS);
+	unsigned short flags = to_file_u16(pevent, 0);
 	static const char * const section_names[] = {
 		"headers",		/* offset 0 - strid for section 16  */
 		"ftrace event formats", /* offset 8 - strid for section 17  */
@@ -397,7 +421,7 @@ int trace_dat__write_strings_section(void)
 	};
 
 	/* string_id points to "strings" string itself */
-	unsigned int string_id = STRID_STRINGS;
+	unsigned int string_id = to_file_u32(pevent, STRID_STRINGS);
 	int i;
 
 	if (!trace_dat_fp)
@@ -405,47 +429,59 @@ int trace_dat__write_strings_section(void)
 
 	for (i = 0; section_names[i] != NULL; i++)
 		section_size += strlen(section_names[i]) + 1;
+	section_size = to_file_u64(pevent, section_size);
 
 	/* write section header */
 	if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
 		       !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
 		       !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
-		       !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp))
-		return -EIO;
+		       !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp)) {
+		pr_warning("Failed to write strings section\n");
+		trace_dat_write_failed = true;
+	}
 
 	/* write strings */
 	for (i = 0; section_names[i] != NULL; i++)
-		if (!fwrite(section_names[i], 1, strlen(section_names[i]) + 1, trace_dat_fp))
-			return -EIO;
+		if (!fwrite(section_names[i], 1, strlen(section_names[i]) + 1, trace_dat_fp)) {
+			pr_warning("Failed to write strings section\n");
+			trace_dat_write_failed = true;
+		}
 	return 0;
 }
 
 /* Writes options section containing CPUCOUNT, TRACECLOCK, EVENT_FORMAT, HEADER_INFO,
  * FTRACE_EVENTS, KALLSYMS, CMDLINES options, ending with DONE option pointing to next section.
  */
-int trace_dat__write_options_section1(void)
+int trace_dat__write_options_section1(struct tep_handle *pevent)
 {
-	unsigned short section_id = TRACE_DAT_SECTION_OPTIONS;
-	unsigned short flags = 0;
-	unsigned int string_id = STRID_OPTIONS_1;
+	unsigned short section_id = to_file_u16(pevent, TRACE_DAT_SECTION_OPTIONS);
+	unsigned short flags = to_file_u16(pevent, 0);
+	unsigned int string_id = to_file_u32(pevent, STRID_OPTIONS_1);
 	unsigned long long section_size = 0;
 	long section_size_pos;
 	long payload_start;
 	unsigned long long section_start;
 	unsigned short opt_id;
 	unsigned int opt_size;
+	unsigned int raw_opt_size;
+	unsigned int nr_cpus;
 	char clock_buf[CLOCK_BUFFER_SIZE];
 	FILE *clock_file;
 	size_t bytes_read;
 	char *path;
 	unsigned long long next_offset;
+	unsigned long long events_off;
+	unsigned long long header_off;
+	unsigned long long ftrace_off;
+	unsigned long long kallsyms_off;
+	unsigned long long cmdline_off;
 	long end_pos;
 
 	if (!trace_dat_fp)
 		return -EBADF;
 
 	/* fill options_offset in initial format */
-	section_start = ftell(trace_dat_fp);
+	section_start = to_file_u64(pevent, ftell(trace_dat_fp));
 
 	if (fseek(trace_dat_fp, trace_dat_options_offset, SEEK_SET) < 0 ||
 	   !fwrite(&section_start, sizeof(unsigned long long), 1, trace_dat_fp) ||
@@ -464,16 +500,17 @@ int trace_dat__write_options_section1(void)
 	payload_start = ftell(trace_dat_fp);
 
 	/* CPUCOUNT option */
-	opt_id = TRACE_DAT_OPTION_CPUCOUNT;
-	opt_size = sizeof(unsigned int);
+	opt_id = to_file_u16(pevent, TRACE_DAT_OPTION_CPUCOUNT);
+	opt_size = to_file_u32(pevent, sizeof(unsigned int));
+	nr_cpus = to_file_u32(pevent, trace_dat_nr_cpus);
 
 	if (!fwrite(&opt_id, sizeof(unsigned short), 1, trace_dat_fp) ||
 	    !fwrite(&opt_size, sizeof(unsigned int), 1, trace_dat_fp) ||
-	    !fwrite(&trace_dat_nr_cpus, sizeof(unsigned int), 1, trace_dat_fp))
+	    !fwrite(&nr_cpus, sizeof(unsigned int), 1, trace_dat_fp))
 		return -EIO;
 
 	/* TRACECLOCK option */
-	opt_id = TRACE_DAT_OPTION_TRACECLOCK;
+	opt_id = to_file_u16(pevent, TRACE_DAT_OPTION_TRACECLOCK);
 
 	path = get_tracing_file("trace_clock");
 	if (path) {
@@ -490,66 +527,72 @@ int trace_dat__write_options_section1(void)
 		strcpy(clock_buf, "local\n");
 		bytes_read = strlen(clock_buf);
 	}
-	opt_size = bytes_read + 1;
+	raw_opt_size = bytes_read + 1;
+	opt_size = to_file_u32(pevent, bytes_read + 1);
 	if (!fwrite(&opt_id, sizeof(unsigned short), 1, trace_dat_fp) ||
 	    !fwrite(&opt_size, sizeof(unsigned int), 1, trace_dat_fp) ||
-	    !fwrite(clock_buf, 1, opt_size, trace_dat_fp))
+	    !fwrite(clock_buf, 1, raw_opt_size, trace_dat_fp))
 		return -EIO;
 
 	/* EVENT option */
-	opt_id = TRACE_DAT_OPTION_EVENT;
-	opt_size = sizeof(unsigned long long);
+	opt_id = to_file_u16(pevent, TRACE_DAT_OPTION_EVENT);
+	opt_size = to_file_u32(pevent, sizeof(unsigned long long));
+	events_off = to_file_u64(pevent, trace_dat_events_format_offset);
 
 	if (!fwrite(&opt_id, sizeof(unsigned short), 1, trace_dat_fp) ||
 	   !fwrite(&opt_size, sizeof(unsigned int), 1, trace_dat_fp) ||
-	   !fwrite(&trace_dat_events_format_offset, sizeof(unsigned long long),
+	   !fwrite(&events_off, sizeof(unsigned long long),
 		   1, trace_dat_fp))
 		return -EIO;
 
 	/* HEADER option */
-	opt_id = TRACE_DAT_OPTION_HEADER;
-	opt_size = sizeof(unsigned long long);
+	opt_id = to_file_u16(pevent, TRACE_DAT_OPTION_HEADER);
+	opt_size = to_file_u32(pevent, sizeof(unsigned long long));
+	header_off = to_file_u64(pevent, trace_dat_header_info_offset);
 
 	if (!fwrite(&opt_id, sizeof(unsigned short), 1, trace_dat_fp) ||
 	    !fwrite(&opt_size, sizeof(unsigned int), 1, trace_dat_fp) ||
-	    !fwrite(&trace_dat_header_info_offset, sizeof(unsigned long long),
+	    !fwrite(&header_off, sizeof(unsigned long long),
 		    1, trace_dat_fp))
 		return -EIO;
 
 	/* FTRACE option */
-	opt_id = TRACE_DAT_OPTION_FTRACE;
-	opt_size = sizeof(unsigned long long);
+	opt_id = to_file_u16(pevent, TRACE_DAT_OPTION_FTRACE);
+	opt_size = to_file_u32(pevent, sizeof(unsigned long long));
+	ftrace_off = to_file_u64(pevent, trace_dat_ftrace_format_offset);
 
 	if (!fwrite(&opt_id, sizeof(unsigned short), 1, trace_dat_fp) ||
 	    !fwrite(&opt_size, sizeof(unsigned int), 1, trace_dat_fp) ||
-	    !fwrite(&trace_dat_ftrace_format_offset, sizeof(unsigned long long),
+	    !fwrite(&ftrace_off, sizeof(unsigned long long),
 		   1, trace_dat_fp))
 		return -EIO;
 
 	/* KALLSYMS option */
-	opt_id = TRACE_DAT_OPTION_KALLSYMS;
-	opt_size = sizeof(unsigned long long);
+	opt_id = to_file_u16(pevent, TRACE_DAT_OPTION_KALLSYMS);
+	opt_size = to_file_u32(pevent, sizeof(unsigned long long));
+	kallsyms_off = to_file_u64(pevent, trace_dat_kallsyms_offset);
 
 	if (!fwrite(&opt_id, sizeof(unsigned short), 1, trace_dat_fp) ||
 	    !fwrite(&opt_size, sizeof(unsigned int), 1, trace_dat_fp) ||
-	    !fwrite(&trace_dat_kallsyms_offset, sizeof(unsigned long long),
+	    !fwrite(&kallsyms_off, sizeof(unsigned long long),
 		    1, trace_dat_fp))
 		return -EIO;
 
 	/* CMDLINE option */
-	opt_id = TRACE_DAT_OPTION_CMDLINE;
-	opt_size = sizeof(unsigned long long);
+	opt_id = to_file_u16(pevent, TRACE_DAT_OPTION_CMDLINE);
+	opt_size = to_file_u32(pevent, sizeof(unsigned long long));
+	cmdline_off = to_file_u64(pevent, trace_dat_cmdline_offset);
 
 	if (!fwrite(&opt_id, sizeof(unsigned short), 1, trace_dat_fp) ||
 	    !fwrite(&opt_size, sizeof(unsigned int), 1, trace_dat_fp) ||
-	    !fwrite(&trace_dat_cmdline_offset, sizeof(unsigned long long),
+	    !fwrite(&cmdline_off, sizeof(unsigned long long),
 		    1, trace_dat_fp))
 		return -EIO;
 
 	/* DONE option id - next_options_offset filled later */
-	opt_id = TRACE_DAT_OPTION_DONE;
-	opt_size = sizeof(unsigned long long);
-	next_offset = 0;  /* placeholder */
+	opt_id = to_file_u16(pevent, TRACE_DAT_OPTION_DONE);
+	opt_size = to_file_u32(pevent, sizeof(unsigned long long));
+	next_offset = to_file_u64(pevent, 0);
 
 	trace_dat_next_options_offset = ftell(trace_dat_fp);
 	if (!fwrite(&opt_id, sizeof(unsigned short), 1, trace_dat_fp) ||
@@ -560,7 +603,7 @@ int trace_dat__write_options_section1(void)
 	/* fill section size */
 	end_pos = ftell(trace_dat_fp);
 
-	section_size = end_pos - payload_start;
+	section_size = to_file_u64(pevent, end_pos - payload_start);
 	if (fseek(trace_dat_fp, section_size_pos, SEEK_SET) < 0 ||
 	    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
 	    fseek(trace_dat_fp, end_pos, SEEK_SET) < 0)
@@ -574,20 +617,21 @@ int trace_dat__write_options_section1(void)
  * (flyrecord section offset, clock type, page size, CPU count,
  * per-CPU offsets/sizes) and DONE option.
  */
-int trace_dat__write_options_section2(void)
+int trace_dat__write_options_section2(struct tep_handle *pevent)
 {
-	unsigned short section_id  = TRACE_DAT_SECTION_OPTIONS;
-	unsigned short flags = 0;
-	unsigned int string_id = STRID_OPTIONS_2;
+	unsigned short section_id = to_file_u16(pevent, TRACE_DAT_SECTION_OPTIONS);
+	unsigned short flags = to_file_u16(pevent, 0);
+	unsigned int string_id = to_file_u32(pevent, STRID_OPTIONS_2);
 	unsigned long long section_size = 0;
 	long section_size_pos;
 	long payload_start;
 	int cpu;
-	unsigned short opt_id = TRACE_DAT_OPTION_BUFFER;
-	unsigned int opt_size = 0;
+	unsigned short opt_id = to_file_u16(pevent, TRACE_DAT_OPTION_BUFFER);
+	unsigned int opt_size = 0;  /* filled after payload written */
 	long opt_size_pos;
 	unsigned long long data_offset = 0;
-	unsigned int page_size = (unsigned int)trace_dat_page_size;
+	unsigned int page_size = to_file_u32(pevent, (unsigned int)trace_dat_page_size);
+	unsigned int nr_cpus   = to_file_u32(pevent, trace_dat_nr_cpus);
 	const char *clock = "local";
 	unsigned long long next;
 	long end_pos;
@@ -600,7 +644,7 @@ int trace_dat__write_options_section2(void)
 		return -EINVAL;
 
 	/* fill done1 next offset - points to this section */
-	next = ftell(trace_dat_fp);
+	next = to_file_u64(pevent, ftell(trace_dat_fp));
 
 	if (fseek(trace_dat_fp, trace_dat_next_options_offset + 2 + 4, SEEK_SET) < 0 ||
 	    !fwrite(&next, sizeof(unsigned long long), 1, trace_dat_fp) ||
@@ -631,15 +675,16 @@ int trace_dat__write_options_section2(void)
 	    !fwrite("\0", 1, 1, trace_dat_fp) ||
 	    !fwrite(clock, 1, strlen(clock) + 1, trace_dat_fp) ||
 	    !fwrite(&page_size, sizeof(unsigned int), 1, trace_dat_fp) ||
-	    !fwrite(&trace_dat_nr_cpus, sizeof(unsigned int), 1, trace_dat_fp))
+	    !fwrite(&nr_cpus, sizeof(unsigned int), 1, trace_dat_fp))
 		return -EIO;
 
 	/* per cpu: cpu_id + offset placeholder + size */
 	for (cpu = 0; cpu < trace_dat_nr_cpus; cpu++) {
+		unsigned int cpu_out          = to_file_u32(pevent, cpu);
 		cpu_offset = 0;  /* filled in write_flyrecord */
-		cpu_size   = 0;  /* filled in write_flyrecord */
+		cpu_size = 0;  /* filled in write_flyrecord */
 
-		if (!fwrite(&cpu, sizeof(unsigned int), 1, trace_dat_fp))
+		if (!fwrite(&cpu_out, sizeof(unsigned int), 1, trace_dat_fp))
 			return -EIO;
 		buffer_opt_cpu_offsets_pos[cpu] = ftell(trace_dat_fp);
 		if (!fwrite(&cpu_offset, sizeof(unsigned long long), 1, trace_dat_fp) ||
@@ -650,17 +695,17 @@ int trace_dat__write_options_section2(void)
 	/* fill opt_size */
 	end_pos = ftell(trace_dat_fp);
 
-	opt_size = end_pos - opt_payload_start;
-	fseek(trace_dat_fp, opt_size_pos, SEEK_SET);
-	if (!fwrite(&opt_size, sizeof(unsigned int), 1, trace_dat_fp))
+	opt_size = to_file_u32(pevent, end_pos - opt_payload_start);
+	if (fseek(trace_dat_fp, opt_size_pos, SEEK_SET) < 0 ||
+	    !fwrite(&opt_size, sizeof(unsigned int), 1, trace_dat_fp) ||
+	    fseek(trace_dat_fp, end_pos, SEEK_SET) < 0)
 		return -EIO;
-	fseek(trace_dat_fp, end_pos, SEEK_SET);
 
 	/* DONE id=0 */
-	done_id = TRACE_DAT_OPTION_DONE;
-	done_size = sizeof(unsigned long long);
+	done_id = to_file_u16(pevent, TRACE_DAT_OPTION_DONE);
+	done_size = to_file_u32(pevent, sizeof(unsigned long long));
 	/* No additional options sections follow this one */
-	next = 0;
+	next = to_file_u64(pevent, 0);
 
 	if (!fwrite(&done_id, sizeof(unsigned short), 1, trace_dat_fp) ||
 	    !fwrite(&done_size, sizeof(unsigned int), 1, trace_dat_fp) ||
@@ -670,24 +715,25 @@ int trace_dat__write_options_section2(void)
 	/* fill section size */
 	end_pos = ftell(trace_dat_fp);
 
-	section_size = end_pos - payload_start;
-	fseek(trace_dat_fp, section_size_pos, SEEK_SET);
-	if (!fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp))
+	section_size = to_file_u64(pevent, end_pos - payload_start);
+	if (fseek(trace_dat_fp, section_size_pos, SEEK_SET) < 0 ||
+	    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+	    fseek(trace_dat_fp, end_pos, SEEK_SET) < 0)
 		return -EIO;
-	fseek(trace_dat_fp, end_pos, SEEK_SET);
 
 	return 0;
 
 }
 
-int trace_dat__write_flyrecord_section(void)
+int trace_dat__write_flyrecord_section(struct tep_handle *pevent)
 {
-	unsigned short section_id = TRACE_DAT_SECTION_FLYRECORD;
-	unsigned short flags = 0;
-	unsigned int string_id = STRID_BUFFER_FLYRECORD;
+	unsigned short section_id = to_file_u16(pevent, TRACE_DAT_SECTION_FLYRECORD);
+	unsigned short flags = to_file_u16(pevent, 0);
+	unsigned int string_id = to_file_u32(pevent, STRID_BUFFER_FLYRECORD);
 	unsigned long long section_size = 0;
 	long section_size_pos;
 	long flyrecord_start;
+	unsigned long long flyrecord_out;
 	long after_header;
 	long padding_needed;
 	unsigned long long *cpu_offsets;
@@ -750,7 +796,7 @@ int trace_dat__write_flyrecord_section(void)
 	for (cpu = 0; cpu < trace_dat_nr_cpus; cpu++) {
 		start = ftell(trace_dat_fp);
 
-		ret = trace_dat__write_cpu_dat(trace_dat_fp, cpu, &cpu_offsets[cpu]);
+		ret = trace_dat__write_cpu_dat(trace_dat_fp, pevent, cpu, &cpu_offsets[cpu]);
 
 		if (ret < 0) {
 			pr_err("Failed to write CPU %d data\n", cpu);
@@ -762,7 +808,7 @@ int trace_dat__write_flyrecord_section(void)
 	/* fill section size */
 	end_pos = ftell(trace_dat_fp);
 
-	section_size = end_pos - after_header;
+	section_size = to_file_u64(pevent, end_pos - after_header);
 	if (fseek(trace_dat_fp, section_size_pos, SEEK_SET) < 0 ||
 	    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp)) {
 		ret = -EIO;
@@ -775,6 +821,8 @@ int trace_dat__write_flyrecord_section(void)
 
 	/* fill cpu offsets and sizes in BUFFER option */
 	for (cpu = 0; cpu < trace_dat_nr_cpus; cpu++) {
+		cpu_offsets[cpu] = to_file_u64(pevent, cpu_offsets[cpu]);
+		cpu_sizes[cpu]   = to_file_u64(pevent, cpu_sizes[cpu]);
 		if (fseek(trace_dat_fp, buffer_opt_cpu_offsets_pos[cpu], SEEK_SET) < 0 ||
 		    !fwrite(&cpu_offsets[cpu], sizeof(unsigned long long), 1, trace_dat_fp) ||
 		    !fwrite(&cpu_sizes[cpu], sizeof(unsigned long long), 1, trace_dat_fp)) {
@@ -784,8 +832,9 @@ int trace_dat__write_flyrecord_section(void)
 	}
 
 	/* fill data offset in buffer option */
+	flyrecord_out = to_file_u64(pevent, flyrecord_start);
 	if (fseek(trace_dat_fp, opt_payload_start, SEEK_SET) < 0 ||
-	    !fwrite(&flyrecord_start, sizeof(unsigned long long), 1, trace_dat_fp)) {
+	    !fwrite(&flyrecord_out, sizeof(unsigned long long), 1, trace_dat_fp)) {
 		ret = -EIO;
 		goto cleanup;
 	}
@@ -795,7 +844,6 @@ int trace_dat__write_flyrecord_section(void)
 		goto cleanup;
 	}
 
-
 cleanup:
 	free(cpu_offsets);
 	free(cpu_sizes);
diff --git a/tools/perf/util/trace-dat.h b/tools/perf/util/trace-dat.h
index 9aec37b708d4..5985083b275a 100644
--- a/tools/perf/util/trace-dat.h
+++ b/tools/perf/util/trace-dat.h
@@ -8,9 +8,13 @@
 #define __PERF_TRACE_DAT_H
 
 #include <stdio.h>
+#include <stdbool.h>
+#include <event-parse.h>
+#include <byteswap.h>
+#include "util.h"
 
 /* trace.dat file format version */
-#define TRACE_DAT_VERSION '7'
+#define TRACE_DAT_VERSION "7"
 
 /*
  * Section IDs for trace.dat format
@@ -51,6 +55,32 @@
 #define STRID_OPTIONS_2        77
 #define STRID_BUFFER_FLYRECORD 85
 
+/*
+ * Set by trace.dat section writers (kallsyms, ftrace, events etc.) on
+ * fwrite() failure; checked by trace_convert__perf2dat() to clean up.
+ */
+extern bool trace_dat_write_failed;
+
+/*
+ * tep handle from the recording machine; set by trace_convert__perf2dat()
+ * before options/flyrecord sections are written.
+ */
+
+static inline uint16_t to_file_u16(struct tep_handle *pevent, uint16_t val)
+{
+	return tep_read_number(pevent, &val, 2);
+}
+
+static inline uint32_t to_file_u32(struct tep_handle *pevent, uint32_t val)
+{
+	return tep_read_number(pevent, &val, 4);
+}
+
+static inline uint64_t to_file_u64(struct tep_handle *pevent, uint64_t val)
+{
+	return tep_read_number(pevent, &val, 8);
+}
+
 struct perf_session;
 
 extern FILE *trace_dat_fp;
@@ -75,9 +105,9 @@ int trace_dat__collect_cpu_event(int cpu, unsigned long long ts,
 void trace_dat__free_cpu_buffers(void);
 
 /* write trace.dat file sections */
-int trace_dat__write_options_section1(void);
-int trace_dat__write_options_section2(void);
-int trace_dat__write_flyrecord_section(void);
-int trace_dat__write_strings_section(void);
+int trace_dat__write_options_section1(struct tep_handle *pevent);
+int trace_dat__write_options_section2(struct tep_handle *pevent);
+int trace_dat__write_flyrecord_section(struct tep_handle *pevent);
+int trace_dat__write_strings_section(struct tep_handle *pevent);
 
 #endif /* __PERF_TRACE_DAT_H */
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index ecbbb93f0185..7e38e9c8f507 100644
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
@@ -160,11 +160,59 @@ static int read_proc_kallsyms(struct tep_handle *pevent)
 	 * payload", so that older tools can continue reading it and interpret
 	 * it as "no kallsyms payload is present".
 	 */
-	lseek(input_fd, size, SEEK_CUR);
+	/* Write kallsyms section with empty payload if no data */
+	if (!size) {
+		if (trace_dat_fp && !trace_dat_write_failed) {
+			unsigned short section_id = to_file_u16(pevent, TRACE_DAT_SECTION_KALLSYMS);
+			unsigned short flags = to_file_u16(pevent, 0);
+			unsigned int string_id = to_file_u32(pevent, STRID_KALLSYMS);
+			unsigned long long section_size = to_file_u64(pevent, sizeof(unsigned int));
+			unsigned int kallsyms_data = to_file_u32(pevent, 0);
+
+			trace_dat_kallsyms_offset = ftell(trace_dat_fp);
+			if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
+			    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
+			    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
+			    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+			    !fwrite(&kallsyms_data, sizeof(unsigned int), 1, trace_dat_fp)) {
+				pr_warning("Failed to write trace.dat kallsyms section\n");
+				trace_dat_write_failed = true;
+			}
+		}
+		return 0;
+	}
+	buf = malloc(size);
+	if (buf == NULL)
+		return -1;
+	if (do_read(buf, size) < 0) {
+		free(buf);
+		return -1;
+	}
 	trace_data_size += size;
+	/* Write kallsyms section with data */
+	if (trace_dat_fp && !trace_dat_write_failed) {
+		unsigned short section_id = to_file_u16(pevent, TRACE_DAT_SECTION_KALLSYMS);
+		unsigned int string_id = to_file_u32(pevent, STRID_KALLSYMS);
+		unsigned long long section_size = to_file_u64(pevent, sizeof(unsigned int) + size);
+		unsigned short flags = to_file_u16(pevent, 0);
+		unsigned int size_out = to_file_u32(pevent, size);
+
+		trace_dat_kallsyms_offset = ftell(trace_dat_fp);
+		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
+		    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+		    !fwrite(&size_out, sizeof(unsigned int), 1, trace_dat_fp) ||
+		    !fwrite(buf, 1, size, trace_dat_fp)) {
+			pr_warning("Failed to write trace.dat kallsyms section\n");
+			trace_dat_write_failed = true;
+		}
+	}
+	free(buf);
 	return 0;
 }
 
+
 static int read_ftrace_printk(struct tep_handle *pevent)
 {
 	unsigned int size;
@@ -195,6 +243,13 @@ static int read_ftrace_printk(struct tep_handle *pevent)
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
@@ -209,6 +264,7 @@ static int read_header_files(struct tep_handle *pevent)
 
 	size = read8(pevent);
 
+	header_page_size = size;
 	header_page = malloc(size);
 	if (header_page == NULL)
 		return -1;
@@ -227,19 +283,63 @@ static int read_header_files(struct tep_handle *pevent)
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
+	if (trace_dat_fp && !trace_dat_write_failed) {
+		unsigned long long header_page_size_out;
+		unsigned long long header_event_size_out;
+
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
+		section_id = to_file_u16(pevent, TRACE_DAT_SECTION_HEADER);
+		flags = to_file_u16(pevent, 0);
+		string_id = to_file_u32(pevent, STRID_HEADERS);
+		section_size = to_file_u64(pevent, 12 + 8 + header_page_size +
+				13 + 8 + header_event_size);
+		header_page_size_out = to_file_u64(pevent, header_page_size);
+		header_event_size_out = to_file_u64(pevent, header_event_size);
+
+		trace_dat_header_info_offset = ftell(trace_dat_fp);
+		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
+		    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+		    !fwrite("header_page\0", 1, 12, trace_dat_fp) ||
+		    !fwrite(&header_page_size_out, sizeof(unsigned long long), 1, trace_dat_fp) ||
+		    !fwrite(header_page, 1, header_page_size, trace_dat_fp) ||
+		    !fwrite("header_event\0", 1, 13, trace_dat_fp) ||
+		    !fwrite(&header_event_size_out, sizeof(unsigned long long), 1, trace_dat_fp) ||
+		    !fwrite(header_event, 1, header_event_size, trace_dat_fp)) {
+			pr_warning("Failed to write trace.dat header section\n");
+			trace_dat_write_failed = true;
+		}
+		free(header_event);
+	} else {
+		skip(size);
+	}
 
+	free(header_page);
 	return ret;
 }
 
@@ -259,6 +359,15 @@ static int read_ftrace_file(struct tep_handle *pevent, unsigned long long size)
 		pr_debug("error reading ftrace file.\n");
 		goto out;
 	}
+	if (trace_dat_fp && !trace_dat_write_failed) {
+		unsigned long long size_out = to_file_u64(pevent, size);
+
+		if (!fwrite(&size_out, sizeof(unsigned long long), 1, trace_dat_fp) ||
+		    !fwrite(buf, 1, size, trace_dat_fp)) {
+			pr_warning("Failed to write trace.dat ftrace event formats section\n");
+			trace_dat_write_failed = true;
+		}
+	}
 
 	ret = parse_ftrace_file(pevent, buf, size);
 	if (ret < 0)
@@ -283,6 +392,15 @@ static int read_event_file(struct tep_handle *pevent, char *sys,
 	ret = do_read(buf, size);
 	if (ret < 0)
 		goto out;
+	if (trace_dat_fp && !trace_dat_write_failed) {
+		unsigned long long size_out = to_file_u64(pevent, size);
+
+		if (!fwrite(&size_out, sizeof(unsigned long long), 1, trace_dat_fp) ||
+		    !fwrite(buf, 1, size, trace_dat_fp)) {
+			pr_warning("Failed to write trace.dat event formats section\n");
+			trace_dat_write_failed = true;
+		}
+	}
 
 	ret = parse_event_file(pevent, buf, size, sys);
 	if (ret < 0)
@@ -298,8 +416,39 @@ static int read_ftrace_files(struct tep_handle *pevent)
 	int count;
 	int i;
 	int ret;
+	long section_size_pos = 0;
+	long count_pos = 0;
+	unsigned long long section_size = 0;
+	long end_pos;
 
 	count = read4(pevent);
+	/* Write ftrace formats section to trace.dat output file */
+	if (trace_dat_fp && !trace_dat_write_failed) {
+		unsigned short section_id = to_file_u16(pevent, TRACE_DAT_SECTION_FTRACE);
+		unsigned short flags = to_file_u16(pevent, 0);
+		unsigned int string_id = to_file_u32(pevent, STRID_FTRACE_FORMATS);
+		unsigned int count_out = to_file_u32(pevent, count);
+
+		section_size = to_file_u64(pevent, 0);
+		trace_dat_ftrace_format_offset = ftell(trace_dat_fp);
+
+		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
+			!fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
+			!fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp)) {
+			pr_warning("Failed to write trace.dat ftrace event formats section\n");
+			trace_dat_write_failed = true;
+		}
+		section_size_pos = ftell(trace_dat_fp);
+		if (!fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp)) {
+			pr_warning("Failed to write trace.dat ftrace event formats section\n");
+			trace_dat_write_failed = true;
+		}
+		count_pos = ftell(trace_dat_fp);
+		if (!fwrite(&count_out, sizeof(unsigned int), 1, trace_dat_fp)) {
+			pr_warning("Failed to write trace.dat ftrace event formats section\n");
+			trace_dat_write_failed = true;
+		}
+	}
 
 	for (i = 0; i < count; i++) {
 		size = read8(pevent);
@@ -307,6 +456,18 @@ static int read_ftrace_files(struct tep_handle *pevent)
 		if (ret)
 			return ret;
 	}
+	/* Fill in section size after writing all ftrace files */
+	if (trace_dat_fp && !trace_dat_write_failed) {
+		end_pos = ftell(trace_dat_fp);
+		section_size = to_file_u64(pevent, end_pos - count_pos);
+		if (fseek(trace_dat_fp, section_size_pos, SEEK_SET) < 0 ||
+			!fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+			fseek(trace_dat_fp, end_pos, SEEK_SET) < 0) {
+			pr_warning("Failed to write trace.dat ftrace event formats section\n");
+			trace_dat_write_failed = true;
+		}
+	}
+
 	return 0;
 }
 
@@ -318,8 +479,38 @@ static int read_event_files(struct tep_handle *pevent)
 	int count;
 	int i,x;
 	int ret;
+	long section_size_pos = 0;
+	long sys_count_pos = 0;
+	unsigned long long section_size = 0;
+	long end_pos;
 
 	systems = read4(pevent);
+	/* Write event formats section to trace.dat output file */
+	if (trace_dat_fp && !trace_dat_write_failed) {
+		unsigned short section_id = to_file_u16(pevent, TRACE_DAT_SECTION_EVENTS);
+		unsigned short flags = to_file_u16(pevent, 0);
+		unsigned int string_id = to_file_u32(pevent, STRID_EVENT_FORMATS);
+		unsigned int systems_out = to_file_u32(pevent, systems);
+
+		section_size = to_file_u64(pevent, 0);
+		trace_dat_events_format_offset = ftell(trace_dat_fp);
+		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
+		    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp)) {
+			pr_warning("Failed to write trace.dat event formats section\n");
+			trace_dat_write_failed = true;
+		}
+		section_size_pos = ftell(trace_dat_fp);
+		if (!fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp)) {
+			pr_warning("Failed to write trace.dat event formats section\n");
+			trace_dat_write_failed = true;
+		}
+		sys_count_pos = ftell(trace_dat_fp);
+		if (!fwrite(&systems_out, sizeof(unsigned int), 1, trace_dat_fp)) {
+			pr_warning("Failed to write trace.dat event formats section\n");
+			trace_dat_write_failed = true;
+		}
+	}
 
 	for (i = 0; i < systems; i++) {
 		sys = read_string();
@@ -327,6 +518,15 @@ static int read_event_files(struct tep_handle *pevent)
 			return -1;
 
 		count = read4(pevent);
+		if (trace_dat_fp && !trace_dat_write_failed) {
+			unsigned int count_out = to_file_u32(pevent, count);
+
+			if (!fwrite(sys, 1, strlen(sys) + 1, trace_dat_fp) ||
+			    !fwrite(&count_out, sizeof(unsigned int), 1, trace_dat_fp)) {
+				pr_warning("Failed to write trace.dat event formats section\n");
+				trace_dat_write_failed = true;
+			}
+		}
 
 		for (x=0; x < count; x++) {
 			size = read8(pevent);
@@ -338,6 +538,18 @@ static int read_event_files(struct tep_handle *pevent)
 		}
 		free(sys);
 	}
+	/* Fill in section size after writing all event files */
+	if (trace_dat_fp && !trace_dat_write_failed) {
+		end_pos = ftell(trace_dat_fp);
+		section_size = to_file_u64(pevent, end_pos - sys_count_pos);
+		fseek(trace_dat_fp, section_size_pos, SEEK_SET);
+		if (!fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp)) {
+			pr_warning("Failed to write trace.dat event formats section\n");
+			trace_dat_write_failed = true;
+		}
+		fseek(trace_dat_fp, end_pos, SEEK_SET);
+	}
+
 	return 0;
 }
 
@@ -349,8 +561,28 @@ static int read_saved_cmdline(struct tep_handle *pevent)
 
 	/* it can have 0 size */
 	size = read8(pevent);
-	if (!size)
+	/* Write cmdlines section with empty payload if no data */
+	if (!size) {
+		if (trace_dat_fp && !trace_dat_write_failed) {
+			unsigned short section_id = to_file_u16(pevent, TRACE_DAT_SECTION_CMDLINE);
+			unsigned short flags = to_file_u16(pevent, 0);
+			unsigned int string_id = to_file_u32(pevent, STRID_CMDLINES);
+			unsigned long long section_size =
+				to_file_u64(pevent, sizeof(unsigned long long));
+			unsigned long long section_data = to_file_u64(pevent, 0);
+
+			trace_dat_cmdline_offset = ftell(trace_dat_fp);
+			if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
+			    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
+			    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
+			    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+			    !fwrite(&section_data, sizeof(unsigned long long), 1, trace_dat_fp)) {
+				pr_warning("Failed to write trace.dat cmdlines section\n");
+				trace_dat_write_failed = true;
+			}
+		}
 		return 0;
+	}
 
 	buf = malloc(size + 1);
 	if (buf == NULL) {
@@ -363,6 +595,27 @@ static int read_saved_cmdline(struct tep_handle *pevent)
 		pr_debug("error reading saved cmdlines\n");
 		goto out;
 	}
+	/* Write cmdlines section with data */
+	if (trace_dat_fp && !trace_dat_write_failed) {
+		unsigned short section_id = to_file_u16(pevent, TRACE_DAT_SECTION_CMDLINE);
+		unsigned short flags = to_file_u16(pevent, 0);
+		unsigned int string_id = to_file_u32(pevent, STRID_CMDLINES);
+		unsigned long long section_size =
+			to_file_u64(pevent, sizeof(unsigned long long) + size);
+		unsigned long long size_out = to_file_u64(pevent, size);
+
+		trace_dat_cmdline_offset = ftell(trace_dat_fp);
+		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
+			!fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
+			!fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
+			!fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp) ||
+			!fwrite(&size_out, sizeof(unsigned long long), 1, trace_dat_fp) ||
+			!fwrite(buf, 1, size, trace_dat_fp)) {
+			pr_warning("Failed to write trace.dat cmdlines section\n");
+			trace_dat_write_failed = true;
+		}
+	}
+
 	buf[ret] = '\0';
 
 	parse_saved_cmdline(pevent, buf, size);
@@ -387,6 +640,7 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 	int file_page_size;
 	struct tep_handle *pevent = NULL;
 	int err;
+	char magic_buf[10];
 
 	repipe = __repipe;
 	input_fd = fd;
@@ -398,12 +652,17 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
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
@@ -440,6 +699,34 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 	tep_set_long_size(pevent, file_long_size);
 	tep_set_page_size(pevent, file_page_size);
 
+	/* Write initial file header to trace.dat */
+	if (trace_dat_fp && !trace_dat_write_failed) {
+		unsigned char endian = file_bigendian;
+		unsigned char long_size = file_long_size;
+		unsigned int page_size = to_file_u32(pevent, file_page_size);
+		unsigned long long placeholder = to_file_u64(pevent, 0);
+
+		if (!fwrite(magic_buf, 1, 10, trace_dat_fp) ||    /* magic + "tracing" */
+		    !fwrite(TRACE_DAT_VERSION, 1, 2, trace_dat_fp) ||
+		    !fwrite(&endian, 1, 1, trace_dat_fp) ||
+		    !fwrite(&long_size, 1, 1, trace_dat_fp) ||
+		    !fwrite(&page_size, sizeof(unsigned int), 1, trace_dat_fp) ||
+		    !fwrite("none", 1, 4, trace_dat_fp) ||
+		    !fwrite("\0", 1, 1, trace_dat_fp) ||
+		    !fwrite("\0", 1, 1, trace_dat_fp)) {
+			pr_warning("Failed to write trace.dat initalfile header\n");
+			trace_dat_write_failed = true;
+		}
+
+		if (!trace_dat_write_failed) {
+			trace_dat_options_offset = ftell(trace_dat_fp);
+			if (!fwrite(&placeholder, sizeof(unsigned long long), 1, trace_dat_fp)) {
+				pr_warning("Failed to write trace.dat initial file header\n");
+				trace_dat_write_failed = true;
+			}
+		}
+	}
+
 	err = read_header_files(pevent);
 	if (err)
 		goto out;
@@ -460,6 +747,12 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 		if (err)
 			goto out;
 	}
+	/* Write strings section to trace.dat output file */
+	if (trace_dat_fp && !trace_dat_write_failed) {
+		err = trace_dat__write_strings_section(pevent);
+		if (err)
+			goto out;
+	}
 
 	size = trace_data_size;
 	repipe = false;
-- 
2.47.1


