Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEFF606A32F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cL7wx6EJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTqY34b5tz2yd7;
	Wed, 18 Nov 2026 16:15:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794978903;
	cv=none; b=L2euOHZ2WiQi4KDndiloHiJARAvXqgjUdKhoTbgw8d8AxxLW6Z2pRdq/secGvTXqV/jVnmCWUIcq/Mg7JUd1PPAad8bfqeq8UUEqfZC6IHf4pbkC8sgPuEEuJucqqhhxf3O9Y8Zhwz0j65vc7pGk8z/VEpCxtAbilp/AcCq+iTFsj04eHpk+b2xc08r1zfWnve5gAF+oqQ22RGVnbTao7+wxPyh4MrB9eK4arHfVN5Aob5hKrrMY5IaZCwaJ2Xk3O6+62vzooXgtcVmcJsGeuIvO4CAp8bePK8vVvy9HnJgSfms2jZ6+R4MMmmeAuq6f5NpXiXqHSX/SpFpSx3t+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794978903; c=relaxed/relaxed;
	bh=aKPz5k3KfnEQ1A9QRLM5kkJiWuZV7J7Ix51XTjbdjT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uh5HzvSaCO7RKkwCM+U7iDWhMTNlkD20hg6uNVJt6/0ce/IJHRbLcBIzOzpzgewvZaB3DhDDHiO37t8oSmPZ9bwSHo2ZQ9vaDLtiRJsFwRNFSOKFkjMLEBghgYpJnQgYH10mVYpTItv2j5p/Tf2nw5WO1zOXuub9ETTq5l86nXve7hAkBlFTIDriMjpqYz2wYCJ1WyCmxr8dLKUNRb74j7DW2Bg3JG+FeIdwhGi7913tYhni4QWfglmJtn77vZtbX7RG/WDxVQkpmo/U+0yJcIAXDb3eD0XvPchnE7cr6lt3nDfXzs6P4xj14ZJImdBaSByeNQgIrIus0T82PqNcaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cL7wx6EJ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cL7wx6EJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTqY21nSyz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 16:15:01 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2U0Hu4068663;
	Wed, 18 Nov 2026 05:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aKPz5k3KfnEQ1A9QR
	LM5kkJiWuZV7J7Ix51XTjbdjT8=; b=cL7wx6EJdBOHIVNVnyCEuYleOg2M9RiIL
	knSh7lFiL6GyonNdGTAX84mNwRXKt1qAnTM8EiMhx3V7AB0jF2Tf4MyyxKfev0+l
	6bAClg8gG1AOCKDCJKBsJ0q7oOxFr/0SDVwG2wceuGSbmH5kYj1f872/9Q3jxpbb
	kdAw1fvNBlIU4qdBnI5RI76v4QD/ksYamtS15qVaZcarqr6lXpFElzn4SMj3YddJ
	C4WkSMngGW1gT2L75rQubLq6vMJMqHfRi89yxZz3dw/hSqiaMWoxAwEAfLBxQpM1
	BjlzR0NJ3rg4uHFBU/cmX1ejh4OuRROm+N/fRHqs+gMXuBP1Zq1hw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t0ypn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 05:14:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Z92O1373174;
	Wed, 18 Nov 2026 05:14:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j00nsghsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 05:14:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI5Eiuk32571910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 05:14:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97EE22004B;
	Wed, 18 Nov 2026 05:14:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 837D420040;
	Wed, 18 Nov 2026 05:14:40 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.20.10])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 05:14:40 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v5 3/3] KVM: PPC: Hard disable interrupts before guest entry
Date: Wed, 18 Nov 2026 10:44:19 +0530
Message-ID: <20261118051419.783878-4-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261118051419.783878-1-sshegde@linux.ibm.com>
References: <20261118051419.783878-1-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afd3449 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=SkEQ8EbvhdlHpgZ8pF0A:9
X-Proofpoint-ORIG-GUID: Cyz6oXSQNqb3P8Yieco17JiTqx1G3zod
X-Proofpoint-GUID: m2QnBkFE9S9Q5_ibCHPz7Vs6X3aLVbZW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxOSBTYWx0ZWRfX/x5ddYz+kBoX
 AUtr9Xe6whfuNvwMngjlceIi7zh/WX9Nk0ksRN8zVjiijRNQcm+EGHMz3n4bOO4YB1v4DGoPrSd
 ErY2Nk/yEIwkpRefOYeWGWUcBJpyYDHBio2J8yWnyWCpVtZ1P/SjR+m26diP7GbNZof0vySfCi7
 S/cs2iJ5oIJi4ox8+7IHFGG6DcwYyT9LYZoEpXsp6SMsZnf/AelB9YTGvsHgpuU2ssvWR8tps2T
 jAXcKUvTLZT1S+tvOWjJj617WgBxyHVSzFnWuJek0lkkgisWG+nFTCv31FVvjMJEqW9pC9L1NYK
 IdgfDlIi/F+WHnpZsUo5an5Qrby55OsZutZwIWTfptM4UDR11XnpOdhbdLflYZdOgpjO7xMk7zO
 P/OU+K/lxOse1fhtCv0I58KfCWZ0zxSl36ScpO7TvphB5QWbl6wCgGNlpxD0w9z+K2WcTrRThMr
 GoqUWqm3ge4A3N7WBlw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxOSBTYWx0ZWRfX61WYF1/5rxgg
 92hPgbSEjykuH5CumlrlLu3kiaBYj6nT1vs0D2KjH9yppWfpl7Ewy+/ebFsFKi1JzZTHiYJiPLD
 0mHYZHFe70+lEicqXiugZLG08wLKRbs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180019
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
do both. With now hard_irq_disable, doing local_irq_disable for PPC32,
just calling that is enough.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Fixes: 12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Closes: https://lore.kernel.org/all/b8f82519-9ae5-c247-e020-e79c627e57df@xenosoft.de/
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Narayana Murty N <nnmlinux@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kvm/booke.c   | 1 -
 arch/powerpc/kvm/powerpc.c | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index aed7b476b7eb..2593f7ae6c09 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -722,7 +722,6 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.shared->msr & MSR_WE) {
 		local_irq_enable();
 		kvm_vcpu_halt(vcpu);
-		local_irq_disable();
 		hard_irq_disable();
 
 		kvmppc_set_exit_type(vcpu, EMULATED_MTMSRWE_EXITS);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9194cf492d1c..f4db7dea57b3 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -81,12 +81,6 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 	int r;
 
 	WARN_ON(irqs_disabled());
-	/*
-	 * local_irq_disable() first: on 32-bit, hard_irq_disable() alone is a
-	 * raw MSR[EE] clear that bypasses the lockdep/irq-tracing state, and
-	 * the xfer_to_guest_mode helpers assert IRQs are seen as disabled.
-	 */
-	local_irq_disable();
 	hard_irq_disable();
 
 	while (true) {
@@ -101,7 +95,6 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 			 */
 			local_irq_enable();
 			r = kvm_xfer_to_guest_mode_handle_work(vcpu);
-			local_irq_disable();
 			hard_irq_disable();
 			if (r) {
 				/*
@@ -134,7 +127,6 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 			local_irq_enable();
 			trace_kvm_check_requests(vcpu);
 			r = kvmppc_core_check_requests(vcpu);
-			local_irq_disable();
 			hard_irq_disable();
 			if (r > 0)
 				continue;
-- 
2.54.0


