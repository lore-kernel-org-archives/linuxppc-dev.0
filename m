Return-Path: <linuxppc-dev+bounces-22119-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0738CD6E6B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 08:29:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWvk83zNbz3brT;
	Fri, 05 Jun 2026 18:29:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780648176;
	cv=none; b=Xw+fVq+0wQuG0nIfkQmywaHVJGNZubzyhH9CrJlQBNWbC4yMRv8I4eSOfWe7C5FZsGf5eqtCS8WMnkLvpClSUDYE3XUPaBt4u/pz1klAUTa3U4i1MhS8yTRaWdxOh1Hg4uXV45R0IwuV/3cXDb9HuUMRpTH76FnO6C72Abg9cM3J8oh58RFYD+ecwv7N17J6Pujnw/0qHRup5dF6Mm2NqXcY/M1G2lgnCS2GTQEz25ZZbYTtDH4Ichn6xhhjxjKYXAWDZL1uGqsctOQDv8nCTkbNoS5TLK1lwRabN/yuxbZQmLkC5pM9X+0+rzeJs7NrxX69RcHgjzHA6p9BDJpveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780648176; c=relaxed/relaxed;
	bh=EoIE6maGdMubNM2SuvofqxTH6KEp7HPXcmO3bqAAjnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMyMgdOjUV2IsnVk/vI6PT+3JlEwXX7ZS5w7ku+OMBULI3CmaJJVpJC4EBkhNnkATHcv/FPdyBmqfPQhlOGIWQ6v9sgRhMr/TKNk/9VVB5TChfQIK5mOoqIwwpbtmnn/cPgJR9L2Oc0+4knIx7fjFH9jkEa0DJPFDsFE1QGSf/hW/LLNMknuoykBHJC0rh8NKLcFm//NwkhDRGM2FdW//ftWxQejbf7Kkps3klH8KrhrPeeYv5VCUlnelTu53eR7LFy50suY+VEHN5RHoNhwF2Zybq886DIViL2LHQkeBa4BveyUEGY5Miz8OETEH0OtJpfN5r3kYU4tD2ylRWGBrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j3lncAU+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j3lncAU+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWvk74ZCQz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 18:29:35 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6552AEKf3001044;
	Fri, 5 Jun 2026 08:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EoIE6maGdMubNM2Su
	vofqxTH6KEp7HPXcmO3bqAAjnE=; b=j3lncAU+qTYQ6bdC+vf3K5EBsgKWjETX8
	7y3nVKQpLIQlD5eVaZoeQ43EZQY899QF5SDnVCsPUJHwTUS8AfQyTuINoVfMTI1q
	tMLEUFx9yzAyFLfBpj7Z8Fe6m99SmrMxxR+XiQpxDs1g0shjlDHbi7PNUW3emqym
	eV+6wUjBDRe1WIBTmpApbAcZMH0DOzoyZc79/NL6/0zyCqNcBK3jn96icf6RmuEw
	2jtUZb6mW0t3hyHDircpLbq8Dsu67kKNDOqvPDSnqMvjBmur25Zqz1c3UGGJinud
	ZvMMKLwV+O0l00TM6KmftAIMITLfvFegviwjzFojbK4qBmBqFKUEg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaejx1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 08:29:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6558O7FW001814;
	Fri, 5 Jun 2026 08:29:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7kgvhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 08:29:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6558TQX916187806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 08:29:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E8892004B;
	Fri,  5 Jun 2026 08:29:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 675B020043;
	Fri,  5 Jun 2026 08:29:24 +0000 (GMT)
Received: from aboo.bl1-in.ibm.com (unknown [9.123.14.187])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 08:29:24 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v3 2/3] powerpc/powernv: fix preempt count leak in pnv_kexec_wait_secondaries_down
Date: Fri,  5 Jun 2026 13:59:11 +0530
Message-ID: <20260605082912.305100-3-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605082912.305100-1-aboorvad@linux.ibm.com>
References: <20260605082912.305100-1-aboorvad@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a2288eb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=AoYj4kKG8rnORiwU5IoA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: VpH3c-xPy_6aYD4ZIjGk7A6ni7zYgXT4
X-Proofpoint-ORIG-GUID: EozKhGVZmtqGjHeclEM33J4FWo044RUM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA3NyBTYWx0ZWRfX4F2GNhY+XJDh
 y3wUuG17OrdtBBqCJIEjKw0rq7D1psgXgucV3jzSz5bGXk55mYKQv9rU/Wdvsqg3ddBjhKDJVg3
 zOl8RMuHHU21fbhtyK0IGndAGOECtKXCStaAZucq5VpXy79dxZIJJTeXO3sd39h+YI5spF2JYtT
 W5PgQliaQWLDc+oi0OjwDWTLGOlBnMJFwbFB55OQ8hlAvQAI26kGLRGkPPEEe3A3AO3WS6frNhE
 soS4DQe1Cnp+JY0rqXxXgRqAy+p8y8LVdSaiozblMNVr6PozxDgKFbhz5hB6YUEnJOjJtWlAGQB
 JCws1FYAR8uNiYUG3ju56BcptCAi+DQFcTiUEKHA/UDUYFehLmAjUFsHGjmkGiGFIyEF4lE7+zg
 0BD1WLAeLWv/9j+dxkUhlyYSvNPdLAxcTj/wzv3YTsWPQbpGV2JLNnvCukzS9aaCsSOhdA2WOxz
 9eVuJFP8WxfEDmECJgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050077

pnv_kexec_wait_secondaries_down() calls get_cpu() to obtain the current
CPU id but never calls the matching put_cpu(), leaking one
preempt_disable() nesting level on every invocation.

In practice the imbalance does not trigger a visible splat because the
kexec teardown path is a one-way trip: IRQs are already disabled, no
schedule() occurs after the leak, and default_machine_kexec() overwrites
preempt_count with HARDIRQ_OFFSET before jumping into kexec_sequence()
which never returns. However the bookkeeping is still wrong.

The function only needs the current CPU id, and this path runs with
interrupts disabled and the CPU pinned, so the preempt_disable()
side-effect of get_cpu() is unnecessary. Replace it with
raw_smp_processor_id().

Fixes: 298b34d7d578 ("powerpc/powernv: Fix kexec races going back to OPAL")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 4dbb47ddbdcc..06ed5e2aa265 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -396,7 +396,8 @@ static void pnv_kexec_wait_secondaries_down(void)
 {
 	int my_cpu, i, notified = -1;
 
-	my_cpu = get_cpu();
+	/* Called with interrupts disabled, so the CPU is pinned. */
+	my_cpu = raw_smp_processor_id();
 
 	for_each_online_cpu(i) {
 		uint8_t status;
-- 
2.54.0


