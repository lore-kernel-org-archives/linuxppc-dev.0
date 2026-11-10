Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451ED606A321
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 05:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HYXP/UhQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNwKr5DKnz2yD3;
	Tue, 10 Nov 2026 16:33:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794288800;
	cv=none; b=lq6wWKPX2A3yDaUA+zqlpvyqY0W7ZiWlDOHeMpwk0tPTSsgthDDCo8dVoKdR7z1XK1R2cjFl2s3hMxZgZmWh5NHCB7E13QowbNYSVSYHg1hk4nv2HZmS6ydZoY6hHK1IBaJHZx7C+iwdq32UcvFDtn5uO3oybmKZgEoJ0kKGCLfteKEep/xQBZU4u4lXeDhyaX0G7RNkI77a1FwLFN1wSNWULGTjyds4K1SVrTC+SjcQ2ACF7nYWMARpnGFmSeQ0AuOtHMR27dceWEaZuHU6f42eUacWw8Rr9ltUjf9swU3t1kMFfF7FuyG6tdcJHSPwEflXl9TvtYMwQzcuV1WxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794288800; c=relaxed/relaxed;
	bh=XURghLDdbpBHSseZCMICptPJ+mhtNx8zOLlVbrChsOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhBr4dxBpEvcetlmHrs8YCYuAt38cItsO1NTppVEC/Dw2A/luK+xAJda7JAAy/fn8PyAljC2dogHDnuy+72B7TRDWRyoZsxUoI1qwx6EjU2s6hWC3aGxuaL7na3vnjyjS1bx+wzhMC/vCHmjnm/zf2nsoMASLnfIcGirEx4nBHsHs4sEm2Der/0xxJACcZSU/KFdfwavvyvAIq5F0yYuTKmaCR/Tt8o4sAymgA6m8FcZMwrFP8dBq3VY6+7Jl0uVqQ83SdxT5WzY/CD9JOSaR1LmKwRnZw4gmsJ/rq3QfkfJaNhfQ+v4JWMCgqzALsKBlvM8vGi99QRqVudyFYlSHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HYXP/UhQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HYXP/UhQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNwKq5yW4z2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 16:33:19 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA51rlk1369037;
	Tue, 10 Nov 2026 05:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XURghLDdbpBHSseZC
	MICptPJ+mhtNx8zOLlVbrChsOg=; b=HYXP/UhQ24guwxYdSY29afs82ONL7hlbZ
	K8WYv6GUqDOj7b8Pw6lL4BK3+fpOhPtk61ZSTS/KwheLco7t22muES6RisNM2YC9
	2yIDjrzWaADczM3I8fMOYp085jKF6hXECsgEr6efO4A65CbIUOsoX2ngsnzIpO4Q
	MQW/kuBtTXsFS+xnwBEEisyJwATtQeGWFi4FbZ81QSUsrVWXWXwUqcinDcEs30sJ
	F/p2lymcj4R34iC7eumrTPaA/NSbRLuyA+tdzILzZTxjDlDW3QlFu3A8jJWfeuaF
	csNi2P/8w2C3xm+8EflWG/tnGWXmhSjYu1k/gwAIQNZXjwMcEiQ1g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkkgjw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 05:33:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA4K28j099402;
	Tue, 10 Nov 2026 05:33:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghg50sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 05:33:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA5X1IL29032788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 05:33:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0D4520043;
	Tue, 10 Nov 2026 05:33:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C15C720040;
	Tue, 10 Nov 2026 05:32:57 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.31.82])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 05:32:57 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v2 3/3] KVM: PPC: Use ppc_hard_irq_disable before guest entry
Date: Tue, 10 Nov 2026 11:02:38 +0530
Message-ID: <20261110053238.3794500-4-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110053238.3794500-1-sshegde@linux.ibm.com>
References: <20261110053238.3794500-1-sshegde@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af2ac93 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SkEQ8EbvhdlHpgZ8pF0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAyMCBTYWx0ZWRfXzQSbEXySvIvA
 DGtUOepxHoORcdCIrpm1A6NXVxaocySZn1tip7FVr8XBM/d07msxC2u2HHKY3P0LH1i736zgMxn
 95lR+yseAtLFN8zCkfN0R8hxvNevsR1gD651alpzN27GL2uuzbsVlteE6VS0lfkTBezFiUbPHDq
 0WR32/u7D09XQecqCOfV8Up28dAycOkt30JrbYnrDYXGmTyKWYpTmo8nJEwppZkDSM0BLqZEU5z
 1oOlnQhL8FSHpKhjI/q1fP3OSLD+LDHhgoo5IsIs8sPuwINb7PUhriNY6qpGWiyRSmHJ723tIYQ
 2VuT5boqsxmgtOxTHCKuVO1qse/XwJ2MMyxgot1PKWkC3o5s/xU7FJ3x66UDIDsxm+FramkU/sH
 J8X6jvk/vM2SylxOtIz0pQ5knuoP6cAEHt8vBmWJqHNvK0wxvJ9vLIh4wc4K5Nsws/O1gOrRbmU
 els2pjxVPlQcKAU0qfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAyMCBTYWx0ZWRfXzkOQGFQHPjGh
 XYZXHb6hkwmnxQw3xsAdE3Nr3Rny6eFdRSCQFIfSocR+wjImFrOODBdjAyqirMiSIAWJD5yoczC
 Is/QBoNB2V+fF7NywUOWtx5fQL2gfsQ=
X-Proofpoint-ORIG-GUID: 5ysNvkqFxTrtpuScNsllgi5GhS4SY-_q
X-Proofpoint-GUID: 1ojaqWB2etFZNsH3pknDmaRKMfLgrVtj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100020
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After applying preempt disable patch, i.e PATCH 2/3, Christian reported
a subsequent warning stopping his board to boot properly.

WARNING: at .kvmppc_fix_ee_before_entry+0x10/0x28, CPU#0: qemu-system-ppc/4667
CPU: 0 UID: 1000 PID: 4667 Comm: qemu-system-ppc Tainted: G        W           7.3.0-rc4-2-powerpc64-smp #1 PREEMPT
Tainted: [W]=WARN
Hardware name: varisys,CYRUS5040 e5500 0x80240012 CoreNet Generic
NIP [c00000000005dc3c] .kvmppc_fix_ee_before_entry+0x10/0x28
LR [c00000000005f298] .kvmppc_handle_exit+0x5b4/0x5e8
Call Trace:
[c000000086587780] [c00000000005ee10] .kvmppc_handle_exit+0x12c/0x5e8 (unreliable)
[c000000086587830] [c000000000062068] .kvmppc_resume_host+0xb8/0x10c

It triggers below warning...

static inline void kvmppc_fix_ee_before_entry(void)
{
        trace_hardirqs_on();

        /*
         * To avoid races, the caller must have gone directly from having
         * interrupts fully-enabled to hard-disabled.
         */
        WARN_ON(local_paca->irq_happened != PACA_IRQ_HARD_DIS);

This happens since kvmppc_prepare_to_enter does first local_irq_disable
followed by hard_irq_disable. This leaves a small window where interrupt
may occur and it could set the irq pending bit in PACA.

That local_irq_disable was necessary for PPC32 to track the lockdep
state etc. On PPC64 hard_irq_disable is good enough. There is no need to
do both. Use the new irq api to do the necessary one.

Fixes: 12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Closes: https://lore.kernel.org/all/b8f82519-9ae5-c247-e020-e79c627e57df@xenosoft.de/
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kvm/powerpc.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9194cf492d1c..4ee3d7bfe917 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -81,13 +81,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 	int r;
 
 	WARN_ON(irqs_disabled());
-	/*
-	 * local_irq_disable() first: on 32-bit, hard_irq_disable() alone is a
-	 * raw MSR[EE] clear that bypasses the lockdep/irq-tracing state, and
-	 * the xfer_to_guest_mode helpers assert IRQs are seen as disabled.
-	 */
-	local_irq_disable();
-	hard_irq_disable();
+	ppc_hard_irq_disable();
 
 	while (true) {
 		xfer_to_guest_mode_prepare();
@@ -101,8 +95,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 			 */
 			local_irq_enable();
 			r = kvm_xfer_to_guest_mode_handle_work(vcpu);
-			local_irq_disable();
-			hard_irq_disable();
+			ppc_hard_irq_disable();
 			if (r) {
 				/*
 				 * The generic helper does not set the exit
@@ -134,8 +127,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 			local_irq_enable();
 			trace_kvm_check_requests(vcpu);
 			r = kvmppc_core_check_requests(vcpu);
-			local_irq_disable();
-			hard_irq_disable();
+			ppc_hard_irq_disable();
 			if (r > 0)
 				continue;
 			break;
-- 
2.52.0


