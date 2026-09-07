Return-Path: <linuxppc-dev+bounces-26633-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009D3C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 03:46:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdXzx2Y1Mz2yvX;
	Mon, 07 Sep 2026 13:46:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788752781;
	cv=none; b=HtLPNRZbzwC/CdPYGXot0W5P942F1UoF6TO3G9RmET9d3ilN1+mGy5Fu30UMkDhU59oJFafckLm3DOMPvmuJ3uHczgKV1e350ZdDiKFVGIqcv4gjF43mA8tAMUKAiYy+C3HBWbrQpi2iVW67wI8GzX6eFiFfQW6Y34HOrRz7HZ/3zHw7uVSmFbOOIRJ8oL2HN7w3rr6lxDoumzAuSY51AL8X7OArOp+D+u1CLoTL1dcPIwSWaeMFsAHzQdmrHaNyiE8Smu3kQvF2cUd9ULqXnKronY57WxgRfi4rS5UNV4iT963f9oNP731yuePalgbfQgT0VJ1AUOJpbHWvIkEf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788752781; c=relaxed/relaxed;
	bh=xSjKMNqQOf7vnVduvKJk2L33RLBzq/uqEL7cxF2m08g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fb0lb4JbBhb3zJBAHQF+BGnfefX6IijvAqYqPQMafdKeoDJCHgL6WmebA3ineJRNxRIC+RzEjqDZw2JtRydeyR5GDO9Pi2fsSNoAXS2BIPdNibhagCpS+D6Vi0inV2TK8XO3EHT5HQTHRCYCkcM3MAUvz+79nA/vqj1n4VsP2rA1eQx9t1Z/ZayJNwaWng24AdMiCw9QRLRqMUn1iUzocYV64uCVs8gON3IgL141RpFUJPIVAZkBqXclX6f4A0EX/80j33tBEzYdMrIRJ/h5CIKZKuPQPwG/lygY+IGIu6hjOY0F/Z1nKrwc2LrJJ6K1sqXJbtITY3kYR1LdItvbXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CgytICLd; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CgytICLd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdXzw2fKMz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 13:46:20 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6870VbAv2634872;
	Mon, 7 Sep 2026 03:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xSjKMNqQOf7vnVduvKJk2L33RLBzq/uqEL7cxF2m0
	8g=; b=CgytICLd0WqbH7sS5ATl8SuHjkvSgw3bz9ImFoJhSEuMoYgwIpHrQZqNf
	9zgmkEisg6NwjYBWAZhFOZc95J5fTKjWji0z8iLw/3red/DuYfNSJU6Gkgf7kDO9
	aP8cB3ldkzVcERJNXjjbUQOkiv81DV0iIq+G/UfoO/e4ZRx2MwiyIgmuN1uuS3fz
	CSwCvNHBAhd/e0hzSjvu9PHaqNtS0sSKIos+C9ilnXckosd5DzaOWvnaC+c1ZsMU
	EqIL1dqRtd/h2hmu3QTgYiv+UfpfuOvsPIGfm1PPpNLNsd/7mRG20YIJgaJ4CgpT
	yQjfJQx+uhtWyriEdyZouixXF4rtQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqjpar2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 03:46:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6873fov0011599;
	Mon, 7 Sep 2026 03:46:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymg3hmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 03:46:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6873k8mZ35062218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 03:46:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC8242004B;
	Mon,  7 Sep 2026 03:46:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5538A20040;
	Mon,  7 Sep 2026 03:46:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.222.166])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 03:46:04 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        narnalli@in.ibm.com, vpuliyal@in.ibm.com
Subject: [PATCH 1/3] perf build-id: add shared is_valid_elf() helper
Date: Mon,  7 Sep 2026 09:15:52 +0530
Message-Id: <20260907034554.714-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
X-Proofpoint-ORIG-GUID: lxAA3B2BNgskR3P6uN2c0LI3Ncshcc2z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDAzMyBTYWx0ZWRfX8J0k5QxhTafi
 y0T84uSIgPGU8zIc+vKM0T0t7Pb0ZmbQAx7bXWi6yCxrVrZ0n/f81ZEa++i4I+g9K2Em9alZ68N
 0c+EcYPmrAQYpY+yTVC5cg+cRCHGQLE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDAzMyBTYWx0ZWRfX8AhbZwq2Yr+k
 rwwcMMZKmue9rjrJMNPXAbw9PdZLWyN40IRBN/ORrV41oqSqCE6gfSyuq7i5PlweIFvEuzKb8fD
 1bZXOUdrIo9Y6LXR0xspRkt27oRgCF+NoTPNnc5kiCl9U2JxozHDMINymy9ENZI+y+HLYHSamjJ
 K8gnhrRdHliJGtLHAiNYtTdgG14q2p+3Yxtij3o7ccY2USi5TkOvEmwCpD7jw6AYlqOiXKpSM9s
 /gBux6Ohli7d2oW6QKdZIwaHKMMJ8o9pG8LRcioVN9e0Oh6OKQ+bFRHOjsiVnz9hR+DWOsQ4OAd
 KuyHppVtUAw3qII+vqM3dhDuqdkekcP7OWPzaWZJ4H7lnXP1HtgZ7WhbTm7ETx9f7rp6Y1zjZQO
 4fIHJfRvKG42qPgTV8Gsi2bwZFqjNdeC0sTWVMMZ5eFTV0IZ9g/RVOJIAAr17+gPShdq2f8YwZw
 XzXnn3O0SnIov2StMgg==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6a9e3387 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=iY15Xlore5azjA2NVqwA:9
X-Proofpoint-GUID: x1lIR7kKpZCqcB5XCjoeE1f9E2pIU5oV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070033

Add is_valid_elf() to build-id.c and declare it in build-id.h so that
multiple perf subsystems can verify ELF magic without duplicating the
check.  The helper opens the file, reads the first SELFMAG (4) bytes,
and compares them against ELFMAG using memcmp().

Both <elf.h> and <fcntl.h> are already included in build-id.c, so no
new dependencies are added.

Reported-by: Narendra Nalli <narnalli@in.ibm.com>
Reported-by: Vijay Puliyala <vpuliyal@in.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/util/build-id.c | 14 ++++++++++++++
 tools/perf/util/build-id.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index eb95ab90f974..28b6b3f8d5d3 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -43,6 +43,20 @@
 
 static bool no_buildid_cache;
 
+bool is_valid_elf(const char *filename)
+{
+	unsigned char magic[SELFMAG];
+	int fd = open(filename, O_RDONLY);
+	bool valid = false;
+
+	if (fd < 0)
+		return false;
+	if (read(fd, magic, sizeof(magic)) == (ssize_t)sizeof(magic))
+		valid = (memcmp(magic, ELFMAG, SELFMAG) == 0);
+	close(fd);
+	return valid;
+}
+
 static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data __maybe_unused)
 {
 	struct map *map = node->ms.map;
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index 73bad90b06f9..dd5b4e3a4d3e 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -76,4 +76,6 @@ extern char buildid_dir[];
 void set_buildid_dir(const char *dir);
 void disable_buildid_cache(void);
 
+bool is_valid_elf(const char *filename);
+
 #endif
-- 
2.43.0


