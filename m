Return-Path: <linuxppc-dev+bounces-21066-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8BCCD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 06:56:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJpVw1Fqtz3c7M;
	Mon, 18 May 2026 16:56:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779087384;
	cv=none; b=lIQLIy95pyduql85sjWY7xjTrEq5EoqBGeW80r+IEvGf7xxZz92YUD697+yYTM6yUU1hblvkYZXoUuHpCXdwhaJpqPGdYG4ZFTksUefpves2B/kAQncH8itMLVy3r1gX0SsSu6IBalQVI7Hx9t1V1hHTEOmMficMyT2yse9IpT64pzex2cmILejEsFKPqBIRtkMquQ3YEhFun3C5KsA2IfrTvUFidQxgAdS33ThYD1SZeyD7gua+exTHIxSJhBaoJ8zMj91vzfcY7iSLip7qAiFnaBN+u4xiqatvP78cgA7q7tnR5Grerh+5w3o33zt8fLxSU5tVV4OCLwlLw4g2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779087384; c=relaxed/relaxed;
	bh=qooOZb/B2Ompg/B1DlGA3rpHr2gG72y6Bq3BkqGDnjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+PaL+joba31wb3hArVundAfJ+IzD8BHHhs2vbLXuJIIvy8CWRY/JlCXvQaGVf8GRfxX98hS2k+eye7xskEb+/TsXFkgsl5P+E2zbucQAEzAym6x1uRz/SMXJruorwfg4uFcbaT+6/KpcpxAZCq+Y/pFFsVzobiwyJV/1SaM9rb8Sb/1VmLPeebSn9Z5OlkCxHOwADWZvLhh0b86ViphRE3ugS6AGsrQpG53Tu06ACzT4KnCrcO5JnZvDL3tauq2lo5BhcxToU4mvETHWXFacKb0If89PpZ123nyUth9oq9/HxlfnzEycoINJI5tltfINaOY1Pz/pRPFrjG0aOEmeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o1qtntj/; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o1qtntj/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJpVv1rJQz3c1D
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 16:56:22 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HKFtJZ1950620;
	Mon, 18 May 2026 06:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qooOZb/B2Ompg/B1D
	lGA3rpHr2gG72y6Bq3BkqGDnjs=; b=o1qtntj/fb+q/YfuX2CEvyYSg6Gjn1dj5
	qNSKnEZpwnqNYQq5+Px+3OufULgaQdvKusAYfssH7x0GpzEg6BbcjLf1dvF9XzxW
	qIzhiSujr4Ar5kS/oLhbmVxQtWbODdlqGgwMzM0xEquQx5oNyScr3+1hbIgxiG+p
	JCpqA7jjVMeRWMS7Hf9w/stXOfVJbegtuj5JUY6Gf2Ffn8CzU8fXLDwglYjMgDgR
	pffepwM2W1Eyc6CspmpI1kGVaQO62yXZZ367MKYmXOZ7LIYjPsmvT0Mm1zW/R91/
	w5RaujFuz7jEwM29i0WRkivxhUHwaJzZsoUHM81B+Pc6o7/oC1d5A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8867sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 06:56:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I6s56v009726;
	Mon, 18 May 2026 06:56:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhcj0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 06:56:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I6uFx445875630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 06:56:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D2C120043;
	Mon, 18 May 2026 06:56:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E04B2004B;
	Mon, 18 May 2026 06:56:14 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 06:56:14 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: [PATCH v2 1/2] lkdtm/powerpc: add isync after slbmte to enforce SLB update ordering
Date: Mon, 18 May 2026 12:26:04 +0530
Message-ID: <2f8d430962a96a7498903b994f081deee4a4d97a.1778975974.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1778975974.git.sayalip@linux.ibm.com>
References: <cover.1778975974.git.sayalip@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: H8J7X_ZVH6Gp9LAIx6TjpwYOzmQoiQxz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA2MiBTYWx0ZWRfX0nfDLIW52eML
 KcgTLIG0en8xoB6xgFHAb7WogPqCCZhH/V5W65/25/YpAKEGKWuszKi6sHXTPiWyVH9zWtFCIlM
 gcwqdjDxZRIXDmJcC8npG8f5+ndUA6ju7qjqwyWDv1C7umsFsxRzLiMAMhXBVFNG0ByC1ePId0+
 8Dawk/vRer9x08Bx42h6JfRh+U9cmXhBnXRexAvuY5qVTLOoGzk8U9SFpwqp7NFfh12cCeol6r6
 Hi5gBTjj/TXQtZKVcoFnDz6Eusxl1VmozPajOKpinjBoMNUY7acZNm5lVMFdIdp966+nSo1pKn+
 w63i6LFIzzc9zt/CANHjsfx7EsOgSzSdhGoZuF69LZQHabH7Sg9N8Ch46JL3fX3PEcbx5tmNOYj
 8JALNTjcM1wvgytWye5AC7PbtlupnJ1Un4SfTCdk8f2ax28lGyW9k9VKbUyrqCQTdKJ2UisEU+p
 fpMtmCY73F/HREkHsPQ==
X-Proofpoint-GUID: PxX5zw0ZgsbU6qgcFHnjbsbGaXO2jYhq
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0ab814 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=kezLWu8HVOdeeWrntvsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180062

The slbmte instruction modifies the Segment Lookaside Buffer, but without
a context synchronizing operation the CPU is not guaranteed to observe
the updated SLB state for subsequent instructions. This can result in
use of stale translation state when memory is accessed immediately after
SLB modifications.

Add isync after each slbmte in the PPC_SLB_MULTIHIT test to ensure proper
ordering of SLB updates before subsequent memory accesses.

This aligns with Power ISA context synchronization requirements for changes
in address translation state and improves the reliability of SLB multihit
injection tests in hash MMU mode.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 drivers/misc/lkdtm/powerpc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/lkdtm/powerpc.c b/drivers/misc/lkdtm/powerpc.c
index be385449911a..ef07e5201edf 100644
--- a/drivers/misc/lkdtm/powerpc.c
+++ b/drivers/misc/lkdtm/powerpc.c
@@ -17,11 +17,14 @@ static void insert_slb_entry(unsigned long p, int ssize, int page_size)
 		     : "r" (mk_vsid_data(p, ssize, flags)),
 		       "r" (mk_esid_data(p, ssize, SLB_NUM_BOLTED))
 		     : "memory");
+	isync();
 
 	asm volatile("slbmte %0,%1" :
 			: "r" (mk_vsid_data(p, ssize, flags)),
 			  "r" (mk_esid_data(p, ssize, SLB_NUM_BOLTED + 1))
 			: "memory");
+	isync();
+
 	preempt_enable();
 }
 
@@ -84,6 +87,7 @@ static void insert_dup_slb_entry_0(void)
 			: "r" (vsid),
 			  "r" (esid | SLB_NUM_BOLTED)
 			: "memory");
+	isync();
 
 	asm volatile("slbmfee  %0,%1" : "=r" (esid) : "r" (i));
 	asm volatile("slbmfev  %0,%1" : "=r" (vsid) : "r" (i));
@@ -93,6 +97,7 @@ static void insert_dup_slb_entry_0(void)
 			: "r" (vsid),
 			  "r" (esid | (SLB_NUM_BOLTED + 1))
 			: "memory");
+	isync();
 
 	pr_info("%s accessing test address 0x%lx: 0x%lx\n",
 		__func__, test_address, *test_ptr);
-- 
2.52.0


