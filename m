Return-Path: <linuxppc-dev+bounces-22977-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D22CDB479
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 12:41:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmJMS4J3hz2yfN;
	Thu, 25 Jun 2026 22:41:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782391284;
	cv=none; b=LMdJoYOuKxcZm3q0oBC3NiecEfAyvI/1G8xMRczr5/0dklms1bBIXcpDhzDEqX9HgCxvN9IZA5YmTlU5QL0Uep9ofCJL1sM0iIugfyHa/vyKwpkdgOpGhxQxXdskW6mV6V3UK6J/dLrk/i/8oSuW8Rwrb2BroIme43LP6eQhnZ/74DNrmoYB+O9GZ4yjAKXaWH4qdlHnF0wyFNqQONM1DtDbpKJvmWawOY+YHdlzn8boOnkzOckvrNnyUWo67yUNHSVRymxJjTq5biCYw9fM6g7cU3jHlBC6MSnBwJ8SftOWqh9y5RiqzNZT1EtDTvxWp6jk+6+4MhQ6F1BF8PhrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782391284; c=relaxed/relaxed;
	bh=7LYq0ie//aif0rvPoS+W7UvKKsXyfzfR+W5IvevACR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTembCofs2ZKPm2wyfidnCxluZXK4FKcETj6REa2T0RhQTza4h4BC9f5zvmR4SwRjGgrbyDU/pexQILZIDi8qCIm/8Rr5JT2WRKTAULbU4FFTYwJW6OMJ434CCIuDJCAKnJ9bpc1RMIRXJDJUvPA3F/0GtVsQncK/35BHSe6X9gt3CJyymccQjx6JzqDD33rFxlrGs4ypEMj5ZQOo63jZ4p1sL15XMX/N16KBhKMAumvaG9Sf8d1g1tKTNkbjKbt8lxmMK2InMr0WjTKGj6py1lK9E4GpuCil/rr7/lPWhrM9JnV3cb0iyxN5iCkjnBxW9lJ53x5Q1iw6/my1eW4sQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=btca+J6h; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=btca+J6h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmJMR5qqWz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 22:41:23 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3mkht3186638;
	Thu, 25 Jun 2026 12:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7LYq0ie//aif0rvPo
	S+W7UvKKsXyfzfR+W5IvevACR4=; b=btca+J6h87EV0dixFml2rg/B0a3z7buMX
	vOghJH8Z2D6ekNIx74mLVh9yDaI22eyVO0VobVvQtZsNwy1X3DB53BDzddGlBU74
	n1pzozRWII/ORK92qqA7IaSQn2Wfq9/YF/p+6uZr0dhwB46hpbZyQHclEhLUP9k1
	waKgnci20pxJ4dhWS6m/cocWS+n8vm3xFnOeyuW07BN7SclLBByMVHaCqEZPFIAK
	8bU4ywlVCVABa32wyT5vGTH82fzm/H2+pQjg8D1uf146LNBeTf1ZP0YnnFSHVfTs
	3siNufzARjFd8m7hxlut5RSX37GGjCD7Ae+dlS+ix6T3m1yA/BzLA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhr1n0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 12:41:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PCYbJu002246;
	Thu, 25 Jun 2026 12:41:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vywtr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 12:41:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65PCexk216187824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 12:40:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F25B20043;
	Thu, 25 Jun 2026 12:40:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B98920040;
	Thu, 25 Jun 2026 12:40:55 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.39.21.143])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 12:40:55 +0000 (GMT)
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
Subject: [PATCH 1/2] selftests/mm: handle EINVAL when configuring gigantic hugepages
Date: Thu, 25 Jun 2026 18:10:16 +0530
Message-ID: <8bfa921e30eb94072685103f6496784aa23bb166.1782365671.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1782365671.git.sayalip@linux.ibm.com>
References: <cover.1782365671.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3d21e0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=BH8Sa3jHzDjv_dfq7kQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEwNiBTYWx0ZWRfX1nVmDDdRv9Ya
 aKQMIG6CeqWls2DhWDooBvBnH9rf1Tvj3U86aJk8eju75M9GgeZekbqYMZ5MbcCz5E/heJbF2fQ
 gJcXtvqLFitVg2zpw5hh2Oogn8kBdDTZ0j9EmGcLk3Ec3jLhHNeUS+u97vQ4fLkRaTqWjDAmA8n
 eG8YOJ4M/5ehobMDozG90QP0l9ThIrr+53qOK0mxwcyBXJDoBqGH33+dF08lfhWiRLOUMKA6tlw
 WGvmIYai1U73+xnCtAOM9pe8YUEDHsO7lnq3RHm+U6zq6cH/mQcDh+GA2cIlw9Xd4cD7mPqzqDq
 yo99ppHH9GKdZo9BoJ+aD+1UHJwQZRCp1EqMdzkDhr9qQVxlyBYp/QujlL/gu/KcmmvlV05CHNy
 shn/ua4Ku74rnduw84CvVEjG8MT8pHljLLvs4xwJr+yy247p9A0PY9QKDd8A4ui70RLIx+5lRKb
 LQYEwNozRFx1aCQqO0A==
X-Proofpoint-GUID: 0ck7acKIWgQNDdBNXuyFfJ7Rh2vv9q4y
X-Proofpoint-ORIG-GUID: Fk3ArSV7aga3Sj3uoTWpxyn9NwBwXYQV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEwNiBTYWx0ZWRfX6tq/9m+kgMW5
 Y4d/2sIhk9ymXDuFyDBk352ypuPhe1WUdWyMiz6jX7VSgwkVeuuc7a07rmg8tLDg0OZ9wt5Ktoy
 7mRPusNlvHgXHeXMs/EopsrCVo7Kl+I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250106

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

Fixes: 9d07250ea1eb ("selftests/mm: hugepage_settings: add APIs to get and set nr_hugepages")
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/vm_util.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 311fc5b4513e..a8f16eef5c7c 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -735,6 +735,13 @@ void write_file(const char *path, const char *buf, size_t buflen)
 	saved_errno = errno;
 	close(fd);
 	errno = saved_errno;
+
+	if (numwritten < 0 && errno == EINVAL) {
+		ksft_print_msg("%s write(%.*s) failed: %s\n", path,
+			       (int)(buflen - 1), buf, strerror(errno));
+		return;
+	}
+
 	if (numwritten < 0)
 		ksft_exit_fail_msg("%s write(%.*s) failed: %s\n", path, (int)(buflen - 1),
 				buf, strerror(errno));
-- 
2.52.0


