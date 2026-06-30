Return-Path: <linuxppc-dev+bounces-23178-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAFDC43638
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 09:33:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqHxz6hyBz2xF8;
	Tue, 30 Jun 2026 19:33:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782811991;
	cv=none; b=ZLjfXGAzEaqp6P92e2w92BmI53D+YptQ0RORjcxpxMXPiVbnBEVzmkc7MJmoZ/3W1ZdiESq9BbbitHNkYsCFKNlml6ijwKUpr2eVrczm69VtRoZW6/Rmb2t2TZqVNNOzPB/a/KaSbImdjSHycvXL6yeFxAGNVVgWTt/S84xbhNF5q1lCZPrd065unGVJSg99RjK7yVqLj0qQ9ZSBGFroRQL4rrwSqU1NBz1K6fzhjvJKmRa4ltXV8g6H+uVb1w0LTt+xW9t2/39sOIABNtC/pYgX41CeD/VZjKs1/aY3jpuLALY7mZqLy340bTpIvsmp1IDrqt9a6s/Fbe9X6BDCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782811991; c=relaxed/relaxed;
	bh=o4+wzZnPNfvdybn6YX7nc5DkNAUY9L3NUADRxYWOER8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kebtjFixlYyxkaq5Fvjx3NlL5Df11n6dX49FF3ESKAw7UtURa68uQSosNFeRtbYaCYFwrKKZXjz5f1I/CPVXHTNYSQD12wRDh+F4E4skj4QmIKDILWRg6jlwqh3D/iEQNI4VFXHOuTp2qVABE1GeBdVqBDMfifvzQ/f9rpA+9YJ9b1FF7o9N6EZ4mWY2IC2QV8brmPbdQGrgYNIYKU/HaYAGaH7UblHIVwg7t8OineCG899MFKIRnqCnanwxf3YI7t9dSKBEwG7E3NHJS38mH8EXxCAVt5Jbhu2EZ56sLAA6DxwZelXsIJfNvbu9BTLmFEwY5WLOovWGZ1mT4VwhFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bOb8zeaI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bOb8zeaI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqHxz0LH2z2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 19:33:10 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5mI1F1191463;
	Tue, 30 Jun 2026 09:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o4+wzZnPNfvdybn6Y
	X7nc5DkNAUY9L3NUADRxYWOER8=; b=bOb8zeaIuxnpv22PufFs9I3oZRBV5Cujx
	8xd4Ts/4FeXuqOsjAhc4LPmtJsnDQLukUnqnHAppO7dr5drmP/YL1TSfKq3Q5nfD
	JssJB7C9vj9IAQdtvwTHr2dkWLry5IbLYwwQnGFVliNjPuvFOD2U1vV737kjHtrD
	mARls0NXFfQyIyGHze82t4iNzJNCv+5/69+C8xDk9w+GmXierU4ekHiYRhOCZgtT
	WCAjgfOBDw81BAoeXen5a/DdCVcztZ6oaHtGs2QmnGeWtmONYeumvZoMnPhvSSzE
	2fiKP7nOyGPOrChDH9QVHKxwnfjHD04Vpk+Fb+f6hpEaH/K6IyKhA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdwxug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:32:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65U9JdWS008478;
	Tue, 30 Jun 2026 09:32:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq9nt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:32:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65U9Wq8f33816882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 09:32:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A504D20040;
	Tue, 30 Jun 2026 09:32:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D1D22004B;
	Tue, 30 Jun 2026 09:32:48 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.39.22.200])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 09:32:48 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Miaohe Lin <linmiaohe@huawei.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Sayali Patil <sayalip@linux.ibm.com>
Subject: [PATCH v2 1/3] selftests/mm: handle EINVAL when configuring gigantic hugepages
Date: Tue, 30 Jun 2026 15:02:33 +0530
Message-ID: <3d394c8cd59fe380d4e2d13b051544f241918f07.1782811071.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1782811071.git.sayalip@linux.ibm.com>
References: <cover.1782811071.git.sayalip@linux.ibm.com>
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
X-Proofpoint-GUID: xJVSUbnOl2G7ZXCx00F3ZO_n6NcW3RVp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4MyBTYWx0ZWRfX0EMc4VoUcDCE
 IEBiQQg4zMV+0kBa87OkYBUAsZNDA7VY9UezgswDsyPKEbj6AOlJCJ8xd2E/fWPplpgauR3C3XO
 cIxod6gPcGMQZYsn2I6+I+A7DbwrmE4=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a438d49 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=yTfXbcNXddHye2M3kacA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4MyBTYWx0ZWRfXzFO8HiS2Dw3+
 1HLN4LoDwpGQPawYk4xuDsKt8ak9gt1xd4UnMV4B5eCTTlfnNfmiQAcRrIHDv56Z2UHcwEQVu5v
 IRMdke878aTWpEMW/wFtP5uXUo4lyNjtMbYiOfHV4HQRm4qQChGgdYWZvH8xFIzw8xE1zpifU4W
 cl+MjiTnYEIKCwNg2DTVzS/lkcH8K5PiV+ZDBXkVe/ErLSIeTpk8jT+NZeYWZMZL7oQoFvz9JfJ
 dHRugCkt/xIyBg/oGCgn0WtVg8wPlwrC1lNPqFaoQM1hjnLlD2eBp94OfkEqLw2U1GcJZqSfKmv
 wxgyIxSfRlsM5t+xL0F+T0/dFHibTt6U3LaEQtl6JATDa01l1hZELG40QP/9YBRKRVTD+JKV+Os
 jVbhIvADgmrJ1hxx+8IKYCafBYJgjIJhO6Z/cX0vzHnJk7bEhitb/LoJCHfiMKVK6IL3EtkbYfw
 33cLYCYCatdwO68RnEQ==
X-Proofpoint-ORIG-GUID: acpLKRj3unJJ-61VLBezEVwfJw2gDzgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300083

Some MM selftests attempt to configure the amount of
HugeTLB pages of different sizes by writing to nr_hugepages.

PowerPC hash MMU pSeries systems advertise gigantic hugepage sizes
but do not support runtime allocation of such pages, writes
to the corresponding nr_hugepages file fail with -EINVAL.
This causes the test to bail out even though the failure is due
to a platform limitation rather than the
functionality being tested.

Treat -EINVAL from the sysfs write as a skipped configuration request
and continue running the test instead of failing.

Before patch:
   -------------------------
   running ./hugetlb-madvise
   -------------------------
   TAP version 13
   1..1
     [INFO] detected hugetlb page size: 16777216 KiB
     [INFO] detected hugetlb page size: 16384 KiB
    ok 1 MADV_DONTNEED and MADV_REMOVE on hugetlb
    Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
    Bail out! /sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages
    write(0) failed: Invalid argument
    Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
    [FAIL]

After patch:
   -------------------------
   running ./hugetlb-madvise
   -------------------------
   TAP version 13
   1..1
    [INFO] detected hugetlb page size: 16777216 KiB
    [INFO] detected hugetlb page size: 16384 KiB
   ok 1 MADV_DONTNEED and MADV_REMOVE on hugetlb
   Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
   /sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages
   write(0) failed: Invalid argument
   [PASS]

Fixes: 27477b28b74f ("selftests/mm: hugepage_settings: add APIs to get and set nr_hugepages")
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 .../testing/selftests/mm/hugepage_settings.c  | 32 ++++++++++++++++++-
 .../testing/selftests/mm/hugepage_settings.h  |  1 +
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/hugepage_settings.c b/tools/testing/selftests/mm/hugepage_settings.c
index 2eab2110ac6a..ce38ae3da01a 100644
--- a/tools/testing/selftests/mm/hugepage_settings.c
+++ b/tools/testing/selftests/mm/hugepage_settings.c
@@ -422,6 +422,36 @@ static void hugetlb_sysfs_path(char *buf, size_t buflen,
 		 size / 1024, attr);
 }
 
+void hugetlb_write_num(const char *path, unsigned long num)
+{
+	int fd, saved_errno;
+	ssize_t numwritten;
+	char buf[21];
+
+	sprintf(buf, "%lu", num);
+
+	fd = open(path, O_WRONLY);
+	if (fd == -1)
+		ksft_exit_fail_msg("%s open failed: %s\n", path, strerror(errno));
+
+	numwritten = write(fd, buf, strlen(buf));
+	saved_errno = errno;
+	close(fd);
+	errno = saved_errno;
+
+	/* Treat EINVAL as a skipped configuration (e.g., unsupported gigantic pages) */
+	if (numwritten < 0 && errno == EINVAL) {
+		ksft_print_msg("%s write(%s) failed: %s\n", path, buf, strerror(errno));
+		return;
+	}
+
+	if (numwritten < 0)
+		ksft_exit_fail_msg("%s write(%s) failed: %s\n", path, buf, strerror(errno));
+	if (numwritten != strlen(buf))
+		ksft_exit_fail_msg("%s write(%s) is truncated, expected %zu bytes, got %zd bytes\n",
+				   path, buf, strlen(buf), numwritten);
+}
+
 unsigned long hugetlb_nr_pages(unsigned long size)
 {
 	char path[PATH_MAX];
@@ -437,7 +467,7 @@ void hugetlb_set_nr_pages(unsigned long size, unsigned long nr)
 
 	hugetlb_sysfs_path(path, sizeof(path), size, "nr_hugepages");
 
-	write_num(path, nr);
+	hugetlb_write_num(path, nr);
 }
 
 unsigned long hugetlb_free_pages(unsigned long size)
diff --git a/tools/testing/selftests/mm/hugepage_settings.h b/tools/testing/selftests/mm/hugepage_settings.h
index 726c73c43c05..390fcc483b9e 100644
--- a/tools/testing/selftests/mm/hugepage_settings.h
+++ b/tools/testing/selftests/mm/hugepage_settings.h
@@ -95,6 +95,7 @@ bool thp_is_enabled(void);
 int detect_hugetlb_page_sizes(unsigned long sizes[], int max);
 unsigned long default_huge_page_size(void);
 
+void hugetlb_write_num(const char *path, unsigned long num);
 unsigned long hugetlb_nr_pages(unsigned long size);
 void hugetlb_set_nr_pages(unsigned long size, unsigned long nr);
 unsigned long hugetlb_free_pages(unsigned long size);
-- 
2.52.0


