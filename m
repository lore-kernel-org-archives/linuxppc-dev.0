Return-Path: <linuxppc-dev+bounces-24780-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2F7C531C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 14:13:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h692g524xz2yFg;
	Sat, 25 Jul 2026 00:13:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784902427;
	cv=none; b=RwKA/yYI8QEzFsCRMhR8w5gi+SY4hTXJyJT2TMOSzILB8fjJrAuDL0krX9/1Mou4HO1Hl/46DjSe6778666cSCox98Y1r6Eue9AJhxzmTP7wXaOA56NQ8ancL70K56JaGByWDYlbaBJ3tO7D5ArK+p0p13p1+Ob0zj3/QzUjxms2huQEuJEA2eebjKJGCX5q9fkp9OjQR7d2nOVOoCBDyD1bc7VP/Y5hkEuFl1bdX/6Y34+zjMER4TaUXvHUcba+cYhv/CGjgeLcC9zjwUElib4X21RZJMUV7sdr/Eg84PMzrMBi4OhkEZT1Af1B7rrR6Br5stCIeF49j/NCxmLswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784902427; c=relaxed/relaxed;
	bh=50E1KF9n0Gw/7vPEAWrdKza/ZUKnBEn8VRiBmwhiid4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7U3OzAjY3Q2lHKivDNJyo5F+e8JCAaa+kqve2lexmOrG9edfRixCUhEegW4ZHdWCQAzrMLWJaJ06iMMA6r4XQGU/wtnpxDEqA2Rdz8H4GD9oX2eO+/hTwvc90QlfnezVm99O2kXeVgFEaVXCxWMzG5OGy2aSZXxc35mgNsGhJ3cXN4i28/0shs0vNpoUC25O69h2Jt7Z4SdEFLVNADKsC0NbH+PatzZ5SPKCn4CD1TdQT7R6RE4zqkZ7h6xSkjgT/pYd6as8JesJ83xKqrnw5l1FNdEJhniikNHVmzQZTPDY3Q9eV2AjNSrj/NJ6SPRkQdfZ3zNST1g5qsPOaE8xQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Gv+fhs0B; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Gv+fhs0B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h692f73f0z2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 00:13:45 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfg811992890;
	Fri, 24 Jul 2026 14:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=50E1KF9n0Gw/7vPEA
	WrdKza/ZUKnBEn8VRiBmwhiid4=; b=Gv+fhs0BMnudPrZ7he3hl9ToOZWkxREUq
	tz9LYO8yhADcHnhR/ZuTSNordGNcpLsGJjj+jNR3SQXbcg9dH5Oi9SvKxgoHMNDr
	T6+hDfMN/3M0Y5sjLO2qcSGE5J0zyhxSnEZG7yzFm852zaBYaQrpATxGguSAs2ph
	QGLScdFUjpYFGy0iKaabO0vN8FW87sxcpMe/e+Qn/T7r3uPwDgidIiSHwNNt6+nB
	Yi0lXQFoCFSMbhGaS+Gc1snLwkZKlsOUCgdycB2iZl+Uz+reO46zl0UlCDh6aIVF
	eWcR9Zpz8j/ikN+PorxY21644i1LUzyThu5VxPU44/yk7r7dJhs4A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h00any-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4eCK014358;
	Fri, 24 Jul 2026 14:13:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqhd3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OEDa1Z46596444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:13:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64BDC2021B;
	Fri, 24 Jul 2026 14:13:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C87F2021A;
	Fri, 24 Jul 2026 14:13:32 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.22.34])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:13:32 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v3 2/5] perf trace-event: Fix integer truncation in do_read() and skip()
Date: Fri, 24 Jul 2026 19:43:13 +0530
Message-ID: <20260724141316.99507-3-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724141316.99507-1-tshah@linux.ibm.com>
References: <20260724141316.99507-1-tshah@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=LdcMLDfi c=1 sm=1 tr=0 ts=6a637315 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Reu3Uk4wQY_54RsGqhsA:9
X-Proofpoint-ORIG-GUID: IJ_6VvIa68JPfNwkqngvcRtpxaZjCrlD
X-Proofpoint-GUID: 97XbBCtXDaKRXaQgHXVj8_Xlxym8NR-3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX0mnPPidN75W3
 Ihi1dAqgfA+zPDU+zk2PelqB8aXJqk9AVjJM3VjAmUgAycbiD9jvzuHucSMk+p4nehpiBcN0YEL
 iWxzPwy0rZF8TmUwae4rdcqakjRHurboIElOac8JJtLV1Pox0kB3hIVRcsPoN3N+nv7MH5HCRwC
 xgp/JODOY92NbCQIMG5tNrnFtl0Qq5uRi4hM65E4OJAFDzQf31QHx4D7EjrofabcTVBGsnnn5BU
 DPV+qmTaFlyqRPNQLTCrjoNAg3G1IsUASUDVZXnXwQ3UQW+5RWGEMyGEwDpqRRG60rSTAyHIl2a
 +nAkPAouDD+FjmKoQSc4tUrZGoSHG5Leg+uSAL9ok0Bks91961UOEb6/mic9Fz8vhBes9a09Xbg
 aVNVFW27X8c46HMtVNS2WOs9kihTOuC3xOmKt+cJse4DurC/wXFAAudmNDbWcE++2XGNR0L9Wbt
 JrxrnVsILQZdDD/6uEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX6hfIowvV0Ffe
 QyOHy07FuHO8yp5czGTSLb29rVwx3Idtc8T97gMnbQcYEbVVu/gnwIJ98kKpx4J5i324a8F4BNL
 YncEOpQY2BF+UTOSaI06nJRPb7jkoxo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240128

The do_read() and skip() functions use 'int' for size parameters,
truncating 64-bit sizes from callers. This causes two issues:

1. Uninitialized memory dump: do_read() reads fewer bytes than
   allocated, leaving uninitialized heap memory that gets written
   to output files.

2. Out-of-bounds read: Parsing functions process the full 64-bit
   size while only partial data was read into the buffer.

Change do_read(), __do_read(), and skip() to use size_t for size
parameters and ssize_t for return values (where applicable), matching
read()/write() system calls.
Update callers to use ssize_t for storing return values.

Fixes: 454c407ec17a ("perf tools: Get rid of read_or_die() in trace-event-read.c")
Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/trace-event-read.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index afd458cf1387..52ed496d92c3 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -25,18 +25,18 @@ static int input_fd;
 static ssize_t trace_data_size;
 static bool repipe;
 
-static int __do_read(int fd, void *buf, int size)
+static ssize_t __do_read(int fd, void *buf, size_t size)
 {
-	int rsize = size;
+	size_t rsize = size;
 
 	while (size) {
-		int ret = read(fd, buf, size);
+		ssize_t ret = read(fd, buf, size);
 
 		if (ret <= 0)
 			return -1;
 
 		if (repipe) {
-			int retw = write(STDOUT_FILENO, buf, ret);
+			ssize_t retw = write(STDOUT_FILENO, buf, ret);
 
 			if (retw <= 0 || retw != ret) {
 				pr_debug("repiping input file");
@@ -51,13 +51,13 @@ static int __do_read(int fd, void *buf, int size)
 	return rsize;
 }
 
-static int do_read(void *data, int size)
+static ssize_t do_read(void *data, size_t size)
 {
-	int r;
+	ssize_t r;
 
 	r = __do_read(input_fd, data, size);
 	if (r <= 0) {
-		pr_debug("reading input file (size expected=%d received=%d)",
+		pr_debug("reading input file (size expected=%zu received=%zd)",
 			 size, r);
 		return -1;
 	}
@@ -68,10 +68,10 @@ static int do_read(void *data, int size)
 }
 
 /* If it fails, the next read will report it */
-static void skip(int size)
+static void skip(size_t size)
 {
 	char buf[BUFSIZ];
-	int r;
+	size_t r;
 
 	while (size) {
 		r = size > BUFSIZ ? BUFSIZ : size;
@@ -202,7 +202,7 @@ static int read_header_files(struct tep_handle *pevent)
 	unsigned long long size;
 	char *header_page;
 	char buf[BUFSIZ];
-	int ret = 0;
+	ssize_t ret = 0;
 
 	if (do_read(buf, 12) < 0)
 		return -1;
@@ -250,7 +250,7 @@ static int read_header_files(struct tep_handle *pevent)
 
 static int read_ftrace_file(struct tep_handle *pevent, unsigned long long size)
 {
-	int ret;
+	ssize_t ret;
 	char *buf;
 
 	buf = malloc(size);
@@ -276,7 +276,7 @@ static int read_ftrace_file(struct tep_handle *pevent, unsigned long long size)
 static int read_event_file(struct tep_handle *pevent, char *sys,
 			   unsigned long long size)
 {
-	int ret;
+	ssize_t ret;
 	char *buf;
 
 	buf = malloc(size);
@@ -322,7 +322,7 @@ static int read_event_files(struct tep_handle *pevent)
 	int systems;
 	int count;
 	int i,x;
-	int ret;
+	ssize_t ret;
 
 	systems = read4(pevent);
 
@@ -350,7 +350,7 @@ static int read_saved_cmdline(struct tep_handle *pevent)
 {
 	unsigned long long size;
 	char *buf;
-	int ret;
+	ssize_t ret;
 
 	/* it can have 0 size */
 	size = read8(pevent);
-- 
2.47.3


