Return-Path: <linuxppc-dev+bounces-24721-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073A9C531CD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 09:41:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5R2P43GHz2yjw;
	Thu, 23 Jul 2026 19:41:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784799661;
	cv=none; b=kd85zyt3TSeY/MeZjcRXbIey+x16/DMT9zFplVRpBQxrUys/FECxXESG62IwjIb4tfFoqCk+6YEr/WUcFTggancTF6hnPSUUvfzxXtYmPowVFHk/aMwWADJ5qyL8+JMHXW0Ho7HozDa9JqLP5h1LhK57V9YjH3hvmrXCKCvxTnNSlWpAlPMlnfmfviSY3DHftz50BvTs9g/2Uoj2a7A+Q1by+3XY1Ygm6wTgy6ZcBBPFRXP59n+H5IPxsAOLZICuS0zijdARmKYEzoAC7F9eQAR2eib1lkb0UhSHIEYUFijBYSuxKwh0ZNZi6smvsOpGE490P2tXL9L0ViDcVjcsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784799661; c=relaxed/relaxed;
	bh=50E1KF9n0Gw/7vPEAWrdKza/ZUKnBEn8VRiBmwhiid4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZj4Q0yLE3JFf7Re2/GQ7LniBDAK6sIPjT28YIay152i+m6sSkBG8JMsRdAmXWtM9ZaPcNpq20xfCfRATuQSl6PwEwYmVWGt7bliuH3WTZfPry1JL1cjhHYE/yZnu5+/d00o4lLbnGzBPmhZ9CF5cg/4vS+lv3uJiUrHzeEhptQ0wffU5agqEM6zAqq3ZDsM/cmbLYCI5Mt2ORSYwl3lINdzSaqF5VxxJzgtFzGx6jwUeqNnVTjWguCydqE0K5iUisvFJ8xHOaQI3sEtj4feRYfgp1KQ9OEL4M3pSh6FopfKiJNa5ne7JIQEnYOCAwR9SwHAC0aP1pE+PUhNhAjJGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ihm5/mh0; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ihm5/mh0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5R2N60mzz2ygJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 19:41:00 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9Btsb701622;
	Thu, 23 Jul 2026 09:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=50E1KF9n0Gw/7vPEA
	WrdKza/ZUKnBEn8VRiBmwhiid4=; b=ihm5/mh0xdHTKRyN0Vd6ivvCTOar6ijYu
	/Omkq9etDylCRr4BeV6jAGebQRgeYPQB0L4bQRhSW1YNUQCvQlV9Uo2hNl3wXOYK
	OCqiVas1HOlRCO0XFBHHDulKNf25igO0VzH/owtiSp0cXDVYDaI6GXrvIOREUnF6
	dzMNZGOBzUErQQS41N4ekETUgU2I5YF1RnqSDE48OvbybLwKIDW973ZZ2SzaL4Ok
	s88dTnrjeQlfVcEoGHVarwOTu7xkCd0jEzHQkb6svI3gPDcujavZOcTDd47QkwL+
	4KsSfj6j4V41sX6bjpKYwUDS51iDj9v7m1RdbbpudILr7Vc7aZfQA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77aptx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 09:40:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N9Ye7J029124;
	Thu, 23 Jul 2026 09:40:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk3hrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 09:40:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N9epsJ41288104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 09:40:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8502A20099;
	Thu, 23 Jul 2026 09:40:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D80D02009A;
	Thu, 23 Jul 2026 09:40:44 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.bl1-in.ibm.com (unknown [9.123.15.94])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 09:40:44 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v2 2/2] perf trace-event: Fix integer truncation in do_read() and skip()
Date: Thu, 23 Jul 2026 15:10:01 +0530
Message-ID: <20260723093958.416650-6-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723093958.416650-3-tshah@linux.ibm.com>
References: <20260723093958.416650-3-tshah@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: nUwtQFi_vSEgwlu1_oxF6r2wCNakJria
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5MSBTYWx0ZWRfX3A2algyfTajG
 CFYNM03GtieamWBfDKXmDgEwaPRiaoWpE+03uD9MdPsiYSriSMbVFexkRJvlVPaoDkN3QclCE3K
 PdQJpUPruNu0qpgZ+yb3TblIP7zijIY=
X-Proofpoint-GUID: fv0eLqSIEJts6gqWgIJULBlzkaRLXava
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5MSBTYWx0ZWRfX3Ogw+1AONF3v
 h5p2/utsvXltgcpc46Fn//vjO7LHc/zamAxUmOAtdQgTFRk3rOq6eEK+wFCeN0vLgR2UZp2v+pY
 7bK33X6C3nas+uWxp9EQhL2+sL6C9ZWCjwAIVR3mvXHNwB0zwL4b3FkHKflAPvQl0CnQQZ/Fe6V
 AtYxO+KHWP/P7bhwiHYk+Glxt6A8quMuYE0zxykmz8BYgHy8I5S+BwqD6Gn2m4ztgKtS4ctY0zZ
 Prq9bROA+2Dmaq0hwEhgzu3dl00eoiXoZk8i7C5E3GGAGS/BMfErdCpkpPWo6cN17Zkm7ZqBXxQ
 MFjmZf0qxzZz30VMcwfLQo452YHIO5AmsRL956qUvZJwPM7WvZK0NsmA040rS2WNsqHStpg5xk9
 ti6OTe9InUA7D82MitbbakTaYovX6CtFITyzlClilTMmO02oU0r1dQC3CJup5bIvVt4TVauLbG/
 xFTBrpKzTZLhA+d6Gxw==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a61e1a9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Reu3Uk4wQY_54RsGqhsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230091

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


