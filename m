Return-Path: <linuxppc-dev+bounces-24826-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4259EC531C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 18:50:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6v7T4WcLz2yhP;
	Sun, 26 Jul 2026 04:50:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785005429;
	cv=none; b=gwv9nOk1YUDVeOqzKH+CQqaNrOQBDOQaw5mmltllcKUasyspmulGkGuxB0Cy0zxdN6FmUlEnor2ha3+EGwLBRE+9AB53OyioCNPv6qDMb6dDOPH9EKnfOnL/karuslaGr4Zt2Lnhp2n7VZAEL9/sGKiWEzZT8RkiNJa0jIUFoiAY3TAO0V9tqAKFqizUHJ57PLcUYcFLc+W8FTTNQuPuo7bTo/Svd9g3cZXTTUV/BUuZov+9tAIcydSakDTot9sBmrNbsc360JKkH1LbVFG2XcM9jc6hDkBpnbiCQ5ogUmvrFC0Yi/IXhDx3f9dMtxXD8ecWsVVfK/s66qtOwkdz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785005429; c=relaxed/relaxed;
	bh=50E1KF9n0Gw/7vPEAWrdKza/ZUKnBEn8VRiBmwhiid4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFfe09rhg/Log2azC0sfl/MiDrFHOVVqX/oOySb5QpHqEoTxUH814ud3qFwxeVypW9WdksEI4mwAK3fP1iZNoQ2fJhH5aqidyxZ8WgP5u8VoNnqJfRCqo1Kvi7qYmG4ydp7KAOqmv+/DHKG0RiknFI9ieRSxT1e4MkFMFhBgiOseB5cYx8F4xwXZ8OxaT54VPZ9lviiypZV0xaB63J0L1jbCWlY0xPccJ0IjkqU1YiybUde2uT9vEPjvPbH6XQQnJ96ddoqxtda9Rzxy98AtklujVwfomft2vocdOVcSwNpvSMxbH6G0rGs1duqe66VTFQ2fauK+9BlTGPi5jUw/dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mAlzz+nj; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mAlzz+nj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6v7S6BcLz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 04:50:28 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PHI8nO1107031;
	Sat, 25 Jul 2026 18:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=50E1KF9n0Gw/7vPEA
	WrdKza/ZUKnBEn8VRiBmwhiid4=; b=mAlzz+njXdW9HNQYjgxxFYpbZvEDy2dMd
	0CmgicY90PQ2jtKGXQkgENOzCeGyaA45Hts950F/4gyaafV58lpNJ1pM46sy3Jgd
	5wriS/+OI2NAz4Kxxp1wYWY6KNF2P6ZNen1y9QdBV1HNBemNr3C1z23Xc8wl1Dsm
	5gimTKUcxE0FiGTMJbjcXpYugVndEDMsrhEOww2CZ0glDTk9+fvx/sG7QmrY6Jmz
	+tAVKBJkenzmxeok5UYp82jyPPLgEV1A2dEyPLy/cTqWEXOW5lbfSbawPQJ4/gyU
	26BeUBfVn24glhN2/fBRwPyg7PyMHHIcrkmxgFGMYE6kou7g3YOwg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0n92dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 18:50:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PIfF8k005287;
	Sat, 25 Jul 2026 18:50:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn59t6ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 18:50:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PIoHqc50856360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 18:50:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A71842008D;
	Sat, 25 Jul 2026 18:50:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D28CA2008B;
	Sat, 25 Jul 2026 18:50:12 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.22.45])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 18:50:12 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v4 2/5] perf trace-event: Fix integer truncation in do_read() and skip()
Date: Sun, 26 Jul 2026 00:19:50 +0530
Message-ID: <20260725184953.234759-3-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725184953.234759-1-tshah@linux.ibm.com>
References: <20260725184953.234759-1-tshah@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE3OCBTYWx0ZWRfX/NJugBeOOTR9
 wVNlPER9p6xSKmxF/xH1PlsS8FbOjzYHLxQscIEYapNBUbrVVG7wVk7FDFoVBuUaG4sGTDFDzBM
 /HLnv8lpeU8cmKT5mG59oC8SYYUZh/U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE3OCBTYWx0ZWRfX1LBybafJaz33
 dV8c+4LIraGwVMrVOEU5KAb2EyDMEn8v0BR4LcaZc4MhzeULJX8GZxQJ/iBnmsgT/W7yK5IiPsI
 NYZk5TyJzzwYUtVK5AoiTFp1oAnly608wsQ3ANSHXzh7fdq6qapM0H/rACSzM3U5ihxboyzjiSs
 sLbe7qCcUtIDIkX7xw1COEbpEAbs6Qo8kV2ZHoJt4DF3JlcwyGVSa2iP3d5FkNe7O5/h7CrjahH
 EbcHxn4u9jR4RCKd0Nv196YxM6VKBSmbSR4/1enQ2C0jjkIfNLfgh3bhs70y1wUYF5iwSzEaVJ/
 yrOX/6bd8JcwbLLfyL1fOHurdLe+7u15T8O5T7cUex2Mv21CPMN2znFGx2X5nH8XuzAZjDrb81H
 H4Uua3mFzzKmyvhZ6s0oL5BvzLJxxyrmvIrU0LMMlhZf4HKoue0Ua2J9Dbe5gQZteNZykPt3mJN
 T1RipgBta4sYeoVRhiw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a65056e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Reu3Uk4wQY_54RsGqhsA:9
X-Proofpoint-GUID: emOxx3fE3KfdRN6HReloN_mbHQfem3yf
X-Proofpoint-ORIG-GUID: XYUg1tZbEYT64qRT6u2yavIN2lICSMh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250178

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


