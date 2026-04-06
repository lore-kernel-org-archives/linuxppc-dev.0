Return-Path: <linuxppc-dev+bounces-19396-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2782BEF4EC9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 09:21:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fq3j40tyTz300V;
	Mon, 06 Apr 2026 19:20:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775467256;
	cv=none; b=dIYjVFZioCpDja2aoxymzCxM0SQEs4xm7cQUql3ZNcy2mwSDTgnHdtkcKBWQaosTzbDjq9D3x5SBnQb+pmjziTGWS+QCH5GjbFe6p/Uf5WhJjtuy1K3X/erfRsYZ2NgCc7JTAPgDWqA9uti5Agg+trzcBkC1VQ1b/A2yBIDIb8q3zwmmNAJtNEvnr2a8ZJGzbgdBg4Z7HtcnlS/8MHL6m8gy4Xi5AwnLoG+io5WE9vMcYMR9Iq4/o0PZVQDtrgc7C/MUX1EyIJvSUaRtr0ZAFOh0qZBjd5UZQeQva1xK0jp9HfREdGqxtR7AyD1RwJfZbqkbDedFfQpHCeE4z13V1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775467256; c=relaxed/relaxed;
	bh=pBqdS5nVcWPMjB8CEBH752E10Mp8905KEGmdHXqnGYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tmgfe2lOIR8SIlL36UNt8QhCu+WiEzP9sx7V4WGXhrunDMrKPAdZbnyGmDAjUnn/IgvblVtXmSa7BRbyahCwEhM0NdKX9Ivyrqy75ZAEezlLbprdr42BwWOLH+WBlJnp0lwZSX3KxBmzZXmg8eA4sSa+zjcBgJjbLDB7tUW8Gu2PsUkAtXJs7pWNiv+Tze8atZZ8JKAt1tVFTq5QEdG5k7UhIa7uCCwy9qib6ArT6qIivfCwnpeOLvhW74WOY+FQbdykAcFJ61kLUgB9onSR72VfhmXcxDDV6DGXsjI3KOE0xajE4z5Caay7H4I9UHjsiYPG9DqhswvKN0YNm+jo6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NY/AE8em; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NY/AE8em;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fq3j32ysmz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 19:20:55 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635MdY2g4037439;
	Mon, 6 Apr 2026 09:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pBqdS5nVcWPMjB8CE
	BH752E10Mp8905KEGmdHXqnGYM=; b=NY/AE8emcXIDAWqeHGkVPFPvm8XooucK4
	V1qEeyPnF8vCnKLZqKkDv6bXPcYavYjcfiLRv3VpImxYeucHkimhQ90fwNS0tv8Q
	pRu8H7eq67Eabw67wy4ksdQaHIsKqqwmcLwDltxdh4TzI5XeSzo+T1n58MZtjQHK
	oZKRqUL4SPKtHS6hCw9x7vNSoFqB4Jnbp+uHZNYM0yH/m8JcO3om9j3XvBbPorQp
	0pYdVlQR7KvZVzOGwOLzj0tjssDispGfqUYoJDNxq/rNi8Z/qFQ6VvTAZ6uAQ6pj
	6g338AkAK1htk+nqbEag8m+grhRT4/hj+cPdkp/77cYy2qXOdOR+Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat51wxka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:20:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6366GArt022945;
	Mon, 6 Apr 2026 09:20:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbefkc0xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:20:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6369KYdG38928832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 09:20:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D602A20043;
	Mon,  6 Apr 2026 09:20:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54F5E20040;
	Mon,  6 Apr 2026 09:20:31 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 09:20:31 +0000 (GMT)
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
Subject: [PATCH v4 14/15] selftests/mm: clarify alternate unmapping in compaction_test
Date: Mon,  6 Apr 2026 14:49:33 +0530
Message-ID: <e6ca6066c0869cf58c6fbef59ea2d35547cabc6d.1775466330.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1775466329.git.sayalip@linux.ibm.com>
References: <cover.1775466329.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J6anLQnS c=1 sm=1 tr=0 ts=69d37ae8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=drp7DlKwS4wFpybDI60A:9
 a=ZXulRonScM0A:10
X-Proofpoint-GUID: mqojUT3DmpMioyJHmt3KvQPAQkRaaDlZ
X-Proofpoint-ORIG-GUID: 19LRlPIFPDuzkGxRK8_l-LF11lGhtkKQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA5MCBTYWx0ZWRfX+PdhhPBXeUrs
 qBNQXlMPWA7f+tki8SwCHi0vHgFWvjAfcpSle1z5ZP1KDPAUWDlg5SgWZ7wbFYsdU/+gWK0VcvV
 IFy1h0aOUJDUWdxWWFPr1yzctgBz4EwK/RG6NcsBvgVpz93sHj8TlR8zd4Rb3bF0jJG0SIFrt9U
 v8W2iOl0cWTVeJe6lGqk9ZUU1boNY0AuVnOGnFSCOJExDBpa/3nhQw3YiHbfwXq8YCElnM1lmlL
 S3yyxZ8B0MstX/W3MxydYGEF6+I5M1XuO0SfcNzw1qFvcRDXsoItXOXsZonVbApwQ9F8uqSa1UZ
 O+hgfGnaep5cUGVoFIDEaNOh4X+HSGOuN+yiPmkc8dIq5rW5qgvDRRnjZxbekWbQ3WYPi/CVUqC
 qRXhR62Xf6pIR9wkk2BNywoIP3rYj9FJHxcpBwNX4sDDwlMpjN4qkVr/p8KUhSCKMzNV27vecMs
 3MY/qLyDnwO96lTT4QQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060090

Add a comment explaining that every other entry in the list is
unmapped to intentionally create fragmentation with
locked pages before invoking check_compaction().

Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
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


