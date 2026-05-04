Return-Path: <linuxppc-dev+bounces-20411-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82307CD3423
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 08:27:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8F924MqQz309S;
	Mon, 04 May 2026 18:26:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777883174;
	cv=none; b=gyGl95G2sCi9qYFEqQCrnLVAv6d1wGkFeIpjVU+4ahGX8cF/Ip8Nyu2oOqowXDQ0taJW4axBcSB/RmlTCz92KBtsPF3D+oJY5cZJK/+xCloqI3IxU9O8GLNPKntGRYaaYW1bZtATcmjSLhFmzWKc6Yr3PqFeW/uim2sj4GWB9du5LCuRUF2LCDY8OAIW2/o5JEZgSBin4Grt/qnDPIylt4G+d+N+baavxcGh/fLa4kNaJY2G93NnYmS99MSbY3PdNOZTHVMzlPFMqsDGzc30wG3vMeKOLKjkusnjaKpaN9FTPZx2Fxk4AJs8qFi5XVoprbrzfKVNHHAAnkbTtIyS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777883174; c=relaxed/relaxed;
	bh=NcC4IMd/M46lcIebNKowLxjbupegKYGulhXVqQiEBho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JA8EhNTImBUpVHredWp/uclnhrKWIKDA9WRXk+x2l3QHsonm4TxQSNxrrRTgn2K1m7nEzosXFPm7MlWmlbgiQ915aJfqROjzxymsUAcPT9XsU4lvLnBvgxoCSjExlXwOji5hF55woMUaGWH+3MjxYuU3BJYP0g0AHkyYKnlLcjnEDHgfXB8/Fl97eZfx6FxX5ZXFByP2nFxhR64SVReRwI5+IJtOKPr/SY3uiDiHZSVirrzFyB95DqOtXjuCsyblPBAaCLU8gxfDoTMIVd+zvTSKXQLXXDP7BaVkupfUPCFM51e0AGnlVIyYSjzbjx7hXN5D9mp0SYarWuWOHTiJaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kT4sH3qD; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kT4sH3qD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8F914sKQz2yZN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 18:26:13 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 643MHdXM3183452;
	Mon, 4 May 2026 08:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NcC4IMd/M46lcIebN
	KowLxjbupegKYGulhXVqQiEBho=; b=kT4sH3qDNqr9ym8uSr+D7AuOZV4svbNRC
	gDuNeglrVNlohx6N6XJ/nGY0/2ng62/4QowVGiuP0jfm2wIZIrsHIVjJ0sjgai1M
	PtcdYbtbtaGzo8cLcIOJ89LinMnV6lmXtrb947F+J0pr3cTkgqVZ7L7LvxxSM55N
	tQoWFpTi8Lq3cpY0L3rGb25x4/+oQB6Ery/UwhIa5X0pBNWfed8wF/6UiMOUlm7T
	NqgyhEwTvQPr4YxMY2Ok2RfLaL9X0uoypRGMt/7Fq6lM2CxiJ2GRsqgqYlI8xBg3
	77nRjNa4lm3xejiqpQoWPxvDAfpITQxcBj6HZzbR+vljj8/vMaPmg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w65y38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 08:25:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6448ONKW023986;
	Mon, 4 May 2026 08:25:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtg45sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 08:25:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6448Pswm56164802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 08:25:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F0502004B;
	Mon,  4 May 2026 08:25:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD10B20040;
	Mon,  4 May 2026 08:25:50 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 08:25:50 +0000 (GMT)
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
Subject: [PATCH v6 14/14] selftests/mm: clarify alternate unmapping in compaction_test
Date: Mon,  4 May 2026 13:54:51 +0530
Message-ID: <91e4eb8e0d0b5a27e166eca59fd7750fe6e34036.1777877814.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1777877814.git.sayalip@linux.ibm.com>
References: <cover.1777877814.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f85817 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=THlBPJCoSQ4NST9nLWYA:9
X-Proofpoint-ORIG-GUID: NLzTdpf4GZ06u0zeN4xQXz4pmJc3Vhf8
X-Proofpoint-GUID: XI43Xpx6JbIWOebeDXPu_gP1yG8Jtt__
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4NyBTYWx0ZWRfXzeR7DZj7ckY4
 MVMDpR5ydZDuHjf1v2HKAR8lDUstiZJHgEQlpV0s0S008AbqZ1dzzXfN6+3CuclWl2lP3nEiYgn
 KuXJarWcVIckkLiufJZzW0pWLJko/pGkdIvfWwCiX3Ft4cvGrMMfKW7c1Yu4a8tOxAsNbJqk6f9
 2upAvtcmhJslkHXt6ElfhA/OtCtMxl6t2ma1CT/rHyZHp9b5bGjrIy42eQLrKwIClpo4u018gmg
 9azKG1A0qHNde/uL/yHUltBYVNWdVmJjp98Laxpgg//BE6ARTBo0rMKu1lURZBjB0Razeip/9Gq
 HhYv2H62eJtdGPlty125BeqO3N3Uw9j4ot3MhveEW72QFdijhe6qOT/tGpmymCoQa/jHXby9470
 8qyyE43eNOXXWozoznJw9r0o6iju+9vFW7jfrxVwQNKcRMSzmmIF/QgsTObN+OxVXGCjmHwZf1Q
 oZW8KLCqUjaKjJn65Cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040087

Add a comment explaining that every other entry in the list is
unmapped to intentionally create fragmentation with
locked pages before invoking check_compaction().

Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/compaction_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 30209c40b697..e1610e2fbdf6 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -261,6 +261,9 @@ int main(int argc, char **argv)
 		mem_fragmentable_MB -= MAP_SIZE_MB;
 	}
 
+	/* Unmap every other entry in the list to create fragmentation with
+	 * locked pages before invoking check_compaction().
+	 */
 	for (entry = list; entry != NULL; entry = entry->next) {
 		munmap(entry->map, MAP_SIZE);
 		if (!entry->next)
-- 
2.52.0


