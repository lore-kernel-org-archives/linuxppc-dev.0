Return-Path: <linuxppc-dev+bounces-18108-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932B2105A594
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 12:27:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWn183flRz3cSV;
	Thu, 12 Mar 2026 23:26:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773318412;
	cv=none; b=KwBOtKwp4HtMgtutk+x6EW3KGourf+UEAJgmW73t3DN1OkVpEOAuTHB5bU9qHI6AkagIMhPURn/cOAVY7czomqtC5Bp2UM1k/XlyoWlhAradA69pC89kvR6Owxea0EgTCSB0cNvZGtGiM5eehw53Kwt7kJLuHD9kRb/5as195D4cNaHVBFImS91d0QvgRDUULJC/mps+IFK/Q6bhz/iiSOZ8Ry+TNloSdQw52H747Lek1x/8uAEgDtxQIv9MRJ7ADQ/GQ7WldPQ1jAC1jtj9dpYwvX38w17+yr75xK2evEGuto+GnKL/2RCIP5meBBo12g1+MtA9RW72TZCO4Ul5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773318412; c=relaxed/relaxed;
	bh=M3YfUvPq9GnEF03e//oW7XV7MlglEUe+yZMq58KUZvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcpxblMzRczMt1Kq7p2V7lOG35URK75PonlhimYvmWJwTGheGgEaKHSdISIBPqRpX3fY9e/aO8LtZwSzdVJfSSednKqPu7TspAYAe3VSNJBYydG13Nwb+pcHhtUprO5nfYUYhDWaHg134DjlIZzcWTCZsyeR4Wgmv87OQ6KmNUxiyKhqG1FqSqPKXg/jndNmOtlqDq4/8HTwyDzLAHEwlXxjSyXOUTqMum2hl1vENJwzcdcgrz+twBxuMCPJK53+Yndsp2TtPvXuC5AGcIi0UoiDqqxK09+OsZfYhgTD8MPhliCq3abykrvp1FJkKBSjPnFKH71p1ZKiPokHjZQ+zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RAsHUWSF; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RAsHUWSF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWn175LMsz3cGc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 23:26:51 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C3SiXO2853554;
	Thu, 12 Mar 2026 12:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=M3YfUvPq9GnEF03e/
	/oW7XV7MlglEUe+yZMq58KUZvE=; b=RAsHUWSF664dK0XGfrxWC9SizSsomr1ql
	mZvX688RLJ/n2zPbrhVrAn5mhcggKMzF2N6gZwjQbu/ynXwij5Xb6G4okM9N/0iz
	7ou38QksMTGhWfWUW7w1MuvLaYIt7ksXKQFjVSvAWpjnI8RnKpN3oxBdk86urNgA
	UvqAxWDXnopUAaM2z+EXpNGdOW2UmOSvvYMu7dXBww0WzMWg4DCwCJ47bfIElkRl
	hERfFDnsSmRsTb2bxFw3BU5Mmb0KTYfygBBTz+AbYgimyjcSfoGc5zS5/jm8SwCf
	HwIhD7J4xf42UCIRUb6s5XKp71G2zIxzvu6plYKQOeyERYyZGDywA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91jm2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C9eOSM006036;
	Thu, 12 Mar 2026 12:26:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9j8uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CCQcJh52298104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 12:26:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFFA82005A;
	Thu, 12 Mar 2026 12:26:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A285F2004F;
	Thu, 12 Mar 2026 12:26:35 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.in.ibm.com (unknown [9.109.243.201])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 12:26:35 +0000 (GMT)
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
Subject: [PATCH v2 11/13] selftests/mm: fix double increment in linked list cleanup in compaction_test
Date: Thu, 12 Mar 2026 17:55:38 +0530
Message-ID: <27390ade4251d1f7f6b846bd5836fa79dbf285df.1773305678.git.sayalip@linux.ibm.com>
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
X-Proofpoint-GUID: 42Oz-_cQwFioyKpAa08DKyO7c4l3zeC1
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b2b102 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=gsDyKvM7SmIWZGbsndUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5NSBTYWx0ZWRfX/HkvvqsILRtu
 mjcdFdzQSxKSsIdKHD37n3PlPS3kT1CaDo6o17EulQHQBZCBYhGDafWxxKgMxDTH6M94fB3nZdl
 m8BEzrT5cOz2aFK5HWZfhWF3C6f+qk5xNfrHcxaC+ADgR1kpTAwuOAghIG9fWxyZi1Ik2umEL/i
 E5WdxtZbNNu+Ix8q9RlJpGR+VKpGDS73e4zYtcNhhtIYXiLkdGKE7ZayXy2ghTtBXDTIYH9eKie
 vm/rODWK3L/GwlgoW817S2/8iNSJ+bOmRnlIUVb3rGJKTD6f+KyxFOU2CkKk7/x9bT3S/TNZzAU
 AcOBf8gR1rYg/uemZ9BWHWyPl2Me8cg28sQuT1rDtNaY1Is/5/MNhcq09dH41sSg+BMo16hn2in
 rcpoB67+f68/0Srf7SP/zJShSu8vejtEwLCEvRfjVARh1onNKYqUfS9IhJr7v7IKjlt7bNzK51t
 2K/AjH0Es6ZG+dII6aA==
X-Proofpoint-ORIG-GUID: k10TzA5FDebAP7Xwbb7fqXyCyy-39Pu6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120095

The cleanup loop of allocated memory currently uses:

    for (entry = list; entry != NULL; entry = entry->next) {
        munmap(entry->map, MAP_SIZE);
        if (!entry->next)
            break;
        entry = entry->next;
    }

The inner entry = entry->next causes the loop to skip every
other node, resulting in only half of the mapped regions being
unmapped.

Remove the redundant increment to ensure every entry is visited
and unmapped during cleanup.

Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/compaction_test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 30209c40b697..f73930706bd0 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -263,9 +263,6 @@ int main(int argc, char **argv)
 
 	for (entry = list; entry != NULL; entry = entry->next) {
 		munmap(entry->map, MAP_SIZE);
-		if (!entry->next)
-			break;
-		entry = entry->next;
 	}
 
 	if (check_compaction(mem_free, hugepage_size,
-- 
2.52.0


