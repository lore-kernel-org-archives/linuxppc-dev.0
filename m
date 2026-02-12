Return-Path: <linuxppc-dev+bounces-16835-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0F5EB48EB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Feb 2026 09:31:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBVS65dQWz2yFm;
	Thu, 12 Feb 2026 20:31:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770888710;
	cv=none; b=iP+gkf5Km06wjyCCBLcb/0mcjY8e/b9iEEHaXQ++xtZ9HmAKUKKGrXA8+gsbKndKeh2cnXf5w+Ln46u0jO9BJ6QSHz3AqaZFcZd9Nt/18wf8WKm0jVVSOaSCSgzJQSrNV7OconzkzDlLJ6AS/Y+oh/DQEzDsb7OilUINeUADKlYeBHc3OY43bn/Yy8Bg9Q680rYW51IVLKUowtOfjDSd89b/TftWBTa3rL29c/Uf5tRwZqI1SWjS6yJfFxlc3Nr2gSsirh7DK6uSPyKa8j2wGJVXrjyUhf4HlYKq9fit20Yx/6UHO18vzwXnL33/xgGEza19zOViPPRXTFAfVb+bNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770888710; c=relaxed/relaxed;
	bh=ks4BWxfs6IP6kZxAGA0CrXgQnXf5n4rU8aglfzaiFS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLp2imbUZCFXj+yyI+3kFVEGVpAwdwBSONIsEKo5nYR+zmJ2nYBBJodv80KbXafyiaHHYKfAcTiVZwfUb5rG7qBKaxW6AirE90ObzIrVnUy9PGS4QnhQGDzVPoGqkh3Rnt3FJfJHYz77wtjNOPHDXCzS7+P7LJqFBftofj6wrxVjN/GYasaUcTKVdOm27+K1OHIZwnFzPPwc/a4KP5mX+BuWCB3NU8h6Y5I5MWlllVd0rwI+YWHyRvEevRiDROj4HbksfO7E2en+MnDdt2RdutKrZb3kN5p6iyNuyoAxhWjjqgVP8WQ17MMRAhpJfW3T9LoYRThinOke7buPwoQIZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=afpRfTWP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=afpRfTWP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBVS513HLz2xlh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2026 20:31:48 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61C7u78n806309;
	Thu, 12 Feb 2026 09:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ks4BWxfs6IP6kZxAGA0CrXgQnXf5n4rU8aglfzaiF
	S4=; b=afpRfTWPxTn+G7zuh3Y7TNVBuAa0tLiJUZr895YQUL8ErYQxrh5nYh0mn
	5G5gkUSHaFHcuRK/CVXeSOZAGjTNM0GeeaqdPPGtcJnTNE7Ov23e23ihmN0QCYO+
	u2FrpKSlT2DdH9DnFJx5KEMnzImayAMqN1WDdcBhlESSbQqEDEB0ivlt8RXK1Uc3
	Z96yUG3L695RauHq4NuvTD+TgWhWBTf76Zv/Ndc70EaM61EVmQ6Mud72jiH9ytBQ
	CdpuZC0mC6Q/crnHea7UZ0HbgZRlLLuhPD4b06IO8hnlxcZhk/BF6FY+3/mWh2w0
	9AfB/3cmQbADZRCU/IlVkANuAtdIQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696unc74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 09:26:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61C4jsf9012626;
	Thu, 12 Feb 2026 09:26:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7khnka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 09:26:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61C9Q4Jl39518520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 09:26:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E77E20040;
	Thu, 12 Feb 2026 09:26:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD6F220043;
	Thu, 12 Feb 2026 09:25:59 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.in.ibm.com (unknown [9.109.207.131])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Feb 2026 09:25:59 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, maddy@linux.ibm.com, mpe@ellerman.id.au
Subject: [PATCH v2] selftests/bpf: Add powerpc support for get_preempt_count() in selftest
Date: Thu, 12 Feb 2026 14:55:58 +0530
Message-ID: <20260212092558.370623-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
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
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698d9cb2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=RLNl__C_HODNSpg9kEgA:9
X-Proofpoint-ORIG-GUID: LFwYoB5YgqT2ivpOH70C3OkLaxkxwh9W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA2OCBTYWx0ZWRfX2TEliqCAk0cE
 ZzqxsGG/rmSvlc1lN191Xxb3pfmkkN9PxUYiu3w3gtfOuwTBXx0PzOpNoms1QWBeZjfxhoGnROx
 Zy0NKDu5axiwdWqw141pR6Bl2d725Fd4mhpZuFyK/SkylnoJa7dO2gqNt0kRJLlT2G/iAbe4Aot
 mDaUO8okuoj4TWh6h3UrZ/py0ldNtposaqllqyspW5NFAFlztdFU8XYhePDz0aWFiP87ak9Aq1G
 xTsFdMaoFUR9XgXKzPrCsJZFKiBBK18+eg9P2q5Obv4mO8+e6NAX3/adcHBhl0cClUBpK2NgNQ+
 ApZm4qkTl4JC9wUdhDXNzm/VMUoGkfxWNNGslW3NBZ48TCogfB1pOf/0fEiBvaapd0gDPY86xSf
 MXW4mRyV6RvgnUNdnoJM3QsgphG7/kemVwvTnFxABnt5ro1NY9AnjQNaDh37WHBT4Vt6vkxZKjP
 FODi8FhR/aNN2oVU5mg==
X-Proofpoint-GUID: i1J05qq25vvJNc-Aa6lbYJrB11DndFMM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120068

get_preempt_count() is enabled to return preempt_count for powerpc,
so that bpf_in_interrupt()/bpf_in_nmi()/bpf_in_serving_softirq()/
bpf_in_task()/bpf_in_hardirq()/get_preempt_count() works for
powerpc as well.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
Changes since v1:
* Updated the comments to include powerpc for the APIs.

v1: https://lore.kernel.org/bpf/20260129054035.168078-1-skb99@linux.ibm.com/
---
 tools/testing/selftests/bpf/bpf_experimental.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4b7210c318dd..9df77e59d4f5 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -645,6 +645,8 @@ static inline int get_preempt_count(void)
 			bpf_this_cpu_ptr(&pcpu_hot))->preempt_count;
 #elif defined(bpf_target_arm64)
 	return bpf_get_current_task_btf()->thread_info.preempt.count;
+#elif defined(bpf_target_powerpc)
+	return bpf_get_current_task_btf()->thread_info.preempt_count;
 #endif
 	return 0;
 }
@@ -653,6 +655,7 @@ static inline int get_preempt_count(void)
  *	Report whether it is in interrupt context. Only works on the following archs:
  *	* x86
  *	* arm64
+ *	* powerpc64
  */
 static inline int bpf_in_interrupt(void)
 {
@@ -672,6 +675,7 @@ static inline int bpf_in_interrupt(void)
  *	Report whether it is in NMI context. Only works on the following archs:
  *	* x86
  *	* arm64
+ *	* powerpc64
  */
 static inline int bpf_in_nmi(void)
 {
@@ -682,6 +686,7 @@ static inline int bpf_in_nmi(void)
  *	Report whether it is in hard IRQ context. Only works on the following archs:
  *	* x86
  *	* arm64
+ *	* powerpc64
  */
 static inline int bpf_in_hardirq(void)
 {
@@ -692,6 +697,7 @@ static inline int bpf_in_hardirq(void)
  *	Report whether it is in softirq context. Only works on the following archs:
  *	* x86
  *	* arm64
+ *	* powerpc64
  */
 static inline int bpf_in_serving_softirq(void)
 {
@@ -710,6 +716,7 @@ static inline int bpf_in_serving_softirq(void)
  *	Report whether it is in task context. Only works on the following archs:
  *	* x86
  *	* arm64
+ *	* powerpc64
  */
 static inline int bpf_in_task(void)
 {
-- 
2.52.0


