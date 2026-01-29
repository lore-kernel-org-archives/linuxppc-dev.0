Return-Path: <linuxppc-dev+bounces-16385-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DD6D3F09C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jan 2026 05:41:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1p0s0xGkz2xpn;
	Thu, 29 Jan 2026 16:41:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769665293;
	cv=none; b=WRqBjuZK5JXrb8vtKD26fCa7gPNSs/+FxsAW0Gpc0trTdqZ+J7Mco2Yq4WVw0UvKz55QsPP338SdNJQuAodpDwADSeQSRRBrw4BT5W47fPEDIv9H3rZ8aIcyKiTLyO8ub4WRNHj0Xnz66W4Sktju/xVi29JLbgmXoot93D8ooamSPjNbt79kMipgv7it2i0dPoF2GTASr2673VNhBJH6/O7+PV1UlJXzxCMN37BDN39bEVNRgi4raMUxvM+auGY8MkFgbsummNnB0MXZNl0FwSJx+yRm9j8kKro+j10WFu/+Ch0A3cunkY6O8xPHKDGoohSq6c7OWx5DNknh92IQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769665293; c=relaxed/relaxed;
	bh=VRpwDFZtx8gfw6ENpMu1fZxLWb74shyx4FXdx4Tkpsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V73K5dcax7mCq5YLvwfLVznVZ8Pc62EkI5yL/BqxnAbNfARxdW/kYMafkooy5N+6H3rtjx0OJ3Xeujp83hcvGR5fFyavO0luh81muAwGDq9hkTiFvebaN4P+EMLC6y2PLnAEkAVur/UCs3Z6pSzuA51koJzpKRYgrZnf0gpNk6j8Xf3ieGv8NdzqJ6cP6HMtOMdKDgfS4krJeSs9vOsoDZS29xIuyA6Q3ELAjXmCt5g5HaUBMpgeVkdIucD5Uz3veVI7VeeJVgRD3MaqR4HFmJ4FemPETJNiVFpBvlFsDfZ9yae1EAifDkslVOA62P2kSM3yxhMhMt+hBCnjJrw3FA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DTwA5z7Y; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DTwA5z7Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1p0q6N3Kz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2026 16:41:31 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60SLbEP6029468;
	Thu, 29 Jan 2026 05:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VRpwDFZtx8gfw6ENpMu1fZxLWb74shyx4FXdx4Tkp
	sg=; b=DTwA5z7YaisWq8xGZPucObtjdR7IWUUxRWfjqDAZ7YJ2JLZaA7//1D52z
	/ecBgSS72tknyckfIjvItl9+I3BME4mAY4VbfvnahO7bBH4RbKyNXHx/V57rWsWU
	U7qZ3Bv8b7IZ3SUShbtvqqrfYpfeh7ywjKFTu43mV00lsvnaMudBzbOjg/ylFQnh
	rzUOa1MrvkB59KKwrNmToIP+6R/6CfcBeRnl8FRsDMzuRoUNskNMMcWltSxSFsEU
	PHJjPI6fmiiZUHXU+RARkLdSRacYOabCGwLy09LAy3a8yItMlHEF0q6lh1+1V8wd
	BOXh2R3FMvv8iwHQoUp8bGathmt/A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7y448-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 05:40:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60T5ek8A002571;
	Thu, 29 Jan 2026 05:40:46 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7y444-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 05:40:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60T1f4av023679;
	Thu, 29 Jan 2026 05:40:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamk0ah9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 05:40:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60T5efA551970542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 05:40:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D9A62004B;
	Thu, 29 Jan 2026 05:40:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FA2E20040;
	Thu, 29 Jan 2026 05:40:36 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.in.ibm.com (unknown [9.109.207.131])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Jan 2026 05:40:36 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, maddy@linux.ibm.com, mpe@ellerman.id.au
Subject: [PATCH] selftests/bpf: Add powerpc support for get_preempt_count() in selftest
Date: Thu, 29 Jan 2026 11:10:35 +0530
Message-ID: <20260129054035.168078-1-skb99@linux.ibm.com>
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
X-Proofpoint-GUID: M2I4GkjxJy-AGDoPCavxx97disodZo0l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAzMiBTYWx0ZWRfX5bTEF7fP8085
 dzrpIqMm6HP59a8Z72Vflr0LfOeVAQXKE12qAMcZhpJnrEJP+QuObukkpvEmmH00W0Z5e1jetRM
 3Ix1im9ThTvX3z089a3zX/tpV+Tzia39M6eoZwTQLjhhg94yxnrfh2puTuQsn47MlZJaU5pYunC
 lmHoMuE/IFzMoYV4qaYnuJ/UPreKZXg/KI8+tHasM1Vub46Obs8UvjwcKNAuwPJi71AyoURlCGM
 843UzyY9QUV2L20RgTf41DHF5mgWn61izAURlqIqcnklOcG75LTMCVR+Chx3PMGpcRksCB2nNJr
 WsWLeeWDDr1sDnPLrSwY1j8VAVIpWsBf33n3jBnc+G/IOn8YadSjFjU3fyvyx/a1VkGMZXxnXIF
 FqVs017jwzi/zYC2PSco+u9+bbj3xwm8gedNoaxBpFlKFcFMnTIfQOPxyhQS2zJy1DTzpHzoBVU
 uPXIZQWvvQJGS4bXM9w==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=697af2de cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=czdQH0r5uGu0LhivvR8A:9
X-Proofpoint-ORIG-GUID: SRhGOaJNVkvHQyGKJ9sjgKY7iDT_qv42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601290032

get_preempt_count() is enabled to return preempt_count for powerpc,
so that bpf_in_interrupt()/get_preempt_count() works for powerpc as
well.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2cd9165c7348..c3f039a878f3 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -630,6 +630,8 @@ static inline int get_preempt_count(void)
 	return *(int *) bpf_this_cpu_ptr(&__preempt_count);
 #elif defined(bpf_target_arm64)
 	return bpf_get_current_task_btf()->thread_info.preempt.count;
+#elif defined(bpf_target_powerpc)
+	return bpf_get_current_task_btf()->thread_info.preempt_count;
 #endif
 	return 0;
 }
-- 
2.52.0


