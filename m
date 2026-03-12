Return-Path: <linuxppc-dev+bounces-18098-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B97105A594
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 12:26:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWn0Y2bgmz3cH0;
	Thu, 12 Mar 2026 23:26:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773318381;
	cv=none; b=cjLzJ8N8XuCHMxRRgijQWuXGxSIpzmVdooZe6wqpdhWTNPE1En0i3D4/5TPhWiOPq0BKNEag8/ZLye7Wjez4VdM4eiJo9AMQZS5J20nSmWyX+x95W7+ShyTUVC1QXg6Hsn0EHING6cCQFXCwuSROnOqYF4eLH4at1ubEdMEcpdHop7NIkGZriRpoSs8Py6Fue4ff75lHUUTgZxKm2uhtXBt5Sl1um/UiHCnecm5h3McgBdMG1O1LGc+E0A4eAfBYO+BPyLHRJTUwbfzz0XiDMj/a6mdim0ycUFwEhznA2bb3/PUf/5vWXAoS6RPxaDuS9XGhaeLFCToGvkpiqHtOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773318381; c=relaxed/relaxed;
	bh=8qSq1MVoaxT0x7vgUoOua+dnJy5M7XPh6J4mmqEG0Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCSbVHpokJO5lvT9Lgh9KEE5HLVBSNnbgBrRj6CGqMXo7aF9R69Zwy2Pdcn3TMorWjHNjwpToJy4jLy8ECRr4q41FsHJBJzYg0bEL4iPuLJjGt5whNenRUb0KvWeKoEL3IScQP8c/80ZLsbeqO5gVQWGjfe4/lBG/NNNnLkWr+pveQu5hJuGMojMP8usB/UP5HFIIk9SrBS6iLkWZTXN/01swzLfdqJPXZNgzo++FSD6DTpixRzasd7Jx8uDayy4fqLHCsaaianFa8qFKbRURukOhjbZGM/zCIZC8Nr3gUBXowsINsDdktdlqS4tnpzVR80BZPzXtdf94Nyaq2xrrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V5K0oyXI; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V5K0oyXI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWn0X3yWwz3cCJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 23:26:20 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMWYmB2307755;
	Thu, 12 Mar 2026 12:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8qSq1MVoaxT0x7vgU
	oOua+dnJy5M7XPh6J4mmqEG0Jk=; b=V5K0oyXIAlN2CAIPwr4AlyTJYmxRR6HTg
	ju2WKdhOHSHhwmLrN6bB6lGycKKQA49JwjpdFN+MaQwm6QHmY/C6WJ6mXyNIsqKr
	ntA6p1qiPbwDWa5Yge9x+xeMdS9bF26JQGrStIuo9JOZ5XPkmY+3Jh4TmuCB9jc5
	qvUXmLk0nU4dXXxZJtxGBfD6pE27M2mrfhRHhFfBcESpF7xd/xG5YLUccglkB0Z7
	tuPfylG5H9xkShNigG0W8h0bSznmTsZLAZSr8JvwSJtL3rIfbYI8RNgulXf3+D+W
	2O+oWhXr1LQ4+l/I2m4fMsBxWJHR2U0o5jN0T+eFaVNscmT7sO0bw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh96agsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C9lbN7006048;
	Thu, 12 Mar 2026 12:26:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9j8sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CCQ57t50266558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 12:26:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A837A2004D;
	Thu, 12 Mar 2026 12:26:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D9242004B;
	Thu, 12 Mar 2026 12:26:01 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.in.ibm.com (unknown [9.109.243.201])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 12:26:01 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: [PATCH v2 01/13] selftests/mm: restore default nr_hugepages value during cleanup in charge_reserved_hugetlb.sh
Date: Thu, 12 Mar 2026 17:55:28 +0530
Message-ID: <9d150c91d4fe18732f9a90234e6878b7bd7f61f7.1773305677.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773305677.git.sayalip@linux.ibm.com>
References: <cover.1773305677.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5NSBTYWx0ZWRfXyt5MxPqV/3Id
 hTNhrbYZLCurtfYEXPNatnN/hOFjgQ+1mMkfU4Fv9Di/WjsEO0YDak1PvRiEYhzceP8rLGph3NH
 fUqsSd4fD5PNEUp9dEaaLGEpUZO3riogyGW0PIXTt2tcVXcTu2mehg9HaMarrMm1ytcPJvStAMZ
 cKDISL9xjw/kpU+ri+4aEq8mbdsJrM1h+bMUDNSjv09I6TYBJA2RwNVX+XOsYaKblgHXKkMvT3x
 TMlHKicZxHc/+p/ejcbVEJeg/tZFAqLLJ397DM6pbCcamX7pSY9FAsGOobR24sYyf7/6Zjj6kvE
 Ay/xW99MzFmmHnXIAtXvpE1xLOgyc6kDqfQHBWfFSbbB1Za+XU5vrc0dvAlsYbS6NeN/KL7Se3N
 nwRaFM4arNuMrzbyuP0Gk4PNvbVc7vo+jRliWxhB95ffgAwvBFwZCg6eQhuFn6P3oIOHbZg5m6V
 SkMeYHtq+ZoqbhxMZgg==
X-Proofpoint-ORIG-GUID: s9imjdtoYdCWrwIH55kSoeUlUuV8-fqF
X-Authority-Analysis: v=2.4 cv=RLO+3oi+ c=1 sm=1 tr=0 ts=69b2b0e1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=ZPMwvEa68uiV5BrjEmoA:9
X-Proofpoint-GUID: XV0_N_WBNmd1FZFKjZZBVtYm8c2R0vMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120095

During cleanup, the value of /proc/sys/vm/nr_hugepages is currently being
set to 0.  At the end of the test, if all tests pass, the original
nr_hugepages value is restored.  However, if any test fails, it remains
set to 0.
With this patch, we ensure that the original nr_hugepages value is
restored during cleanup, regardless of whether the test passes or fails.

Fixes: 7d695b1c3695b ("selftests/mm: save and restore nr_hugepages value")
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
index 447769657634..c9fe68b6fcf9 100755
--- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
@@ -65,7 +65,7 @@ function cleanup() {
   if [[ -e $cgroup_path/hugetlb_cgroup_test2 ]]; then
     rmdir $cgroup_path/hugetlb_cgroup_test2
   fi
-  echo 0 >/proc/sys/vm/nr_hugepages
+  echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
   echo CLEANUP DONE
 }
 
-- 
2.52.0


