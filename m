Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C2606A323
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EDXlCB/v
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTQHZ4byKz2yTH;
	Wed, 18 Nov 2026 00:16:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794921418;
	cv=none; b=Tj+Iuuona4lQc2IeFJXtmRAN/OE+lMX0iaGm7tKydrlDCZeUFQZQmaJCAcTjcKw/MUXWCpdJgWXmduXzOQoZ/PM2wWpwAnzorxmZrYF5espJZcSPn8j5TWwZ7dX9e9w89ZCrofxRAy1dqewxFPbHyoBaNPn8jUE5t903Xa+ib4dn2QFJzoQFjmIxW2lblfeEX1dtdDXJyS9u2HGO0CrpS4jR5XpzAKsIpBH/jsNXiOG1kw7fB4NKa7asIa8jLmOFwN3j9WR6oQbNxvmmu7XbtokwRGiVf5kxnpEOSux1I3nxihmnBLUUGWSxM6Ld2p6VYgQ8qPjBOHzZE5Nt1juYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794921418; c=relaxed/relaxed;
	bh=GQMWrtw3uOcaW7xMHmc+IIvKr/pLDmUiEvProqVRDWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIeXvoLmVG5e3aOfKyrFs/qQkDYT0fQpIJEXfmz5Z/EYFBqC+kOUM5NOAEHtkamqp8Q0jawPH6zG1/urcs0uVbhT0JueXvTEA2oEfOYj5tylvr3V+QcUfa9v2WHDu5JWpDX93lr/wVansvjz9ER7GXQZDxuDueIrJsrOGrhDC3IMU1IkmLcfiFhRP0cXI0CWA9JbsrgO3K0HyEr8YuybGDNujfp/SOwUEl+0wIcOqevaDwgM6fsoEYCJWaItqgvDK6xQPfcXalZYTj4K86QSMnxxsvHuYoFVaLlVLc8sbEIRd47fYwbOf+ieUb0VAl9aFP25mvqrx3TdMI9lkE+uxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EDXlCB/v; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EDXlCB/v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTQHY4rTgz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 00:16:57 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHBwAGF2290022;
	Tue, 17 Nov 2026 13:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GQMWrtw3uOcaW7xMH
	mc+IIvKr/pLDmUiEvProqVRDWY=; b=EDXlCB/vWSqnSr4S3TmpEYzsZiC9gnGtN
	Cx9HF5kXrbm9WeKTyb6yON0QAnYBzd8Srzks6L5skStC8WedXls3cWspmbNK1O5A
	1WZcxmyjhuqva6e0Yyrh5P00621DFBoZPgoRrGySVUGDITv6SB4YlIuK9RIF/nFa
	YiNyg2Wg3N00p4Yc3AKamxh2ukBddNNMn6nEY9muCFpYJTEslFUuFbHZYhJ0Xrc1
	g6Kqjk5nZS7nfuEUaeLN7MbqJZI+eaUCcyfm83PsbgV45sN3sm5+Rok4qhbjVk7O
	jX3Tsf9yDA0pNhcbceoVo0nDoBonzVrgTZlOC5EjOMNlZJ0SNE2qQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfc53d7q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 13:16:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHCJmAL3918134;
	Tue, 17 Nov 2026 13:16:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvdyq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 13:16:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHDGbH051708348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 13:16:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2D9F2004B;
	Tue, 17 Nov 2026 13:16:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21EC72004F;
	Tue, 17 Nov 2026 13:16:33 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.217.181])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 13:16:32 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v4 3/3] KVM: PPC: Hard disable interrupts before guest entry
Date: Tue, 17 Nov 2026 18:46:12 +0530
Message-ID: <20261117131612.707038-4-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261117131612.707038-1-sshegde@linux.ibm.com>
References: <20261117131612.707038-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX3djQtrP3be7U
 DclnT4oBJdFM8XYMaE8ckLXbCilVmjZltUwjjsit8QbCxXNfOVjj90kG2j2cIQG4r7UvLMmfdkv
 CQAJBmTXFgJjQgFiFQie0Sjr3viJJ/o=
X-Authority-Analysis: v=2.4 cv=Fu6QbGrq c=1 sm=1 tr=0 ts=6afc53be cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=SkEQ8EbvhdlHpgZ8pF0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX0Jdzwqxuwggi
 4GJBRrC3rRhnAivX3nqrZHI/sSgztQvZbwd9Xfn0h/XlaRzWYvvBrLum38/bvD4D4QYprVPFGDZ
 3PU97xxRc71yqnt0P3/C7UmXwEpp9l06edQaReyDazXG47wf4+gg9x6lT/N4qyMApLxIoLMqCtT
 KLTKyh1XaoCmIGzpQDd05gjGjhWD9SNqsRh2gLiGkcTF0gJhqLPCMgYbJVexHKLCkfYlEeGVab/
 OFC2zpT/YM5cXXyxo4MNs8IYdu35JEkDb63gIcNQxdLQQT2N0js6nfYiUvPTjNe5pS8sq/2PdYw
 3gHhkJz1Qj8GlhJL+J2yEWpd2mcpLt+APZNZqj5cyIl5GhPvke1ZtRHklyVVFdWdAVuddvlhtzY
 BYUe3fWZjIsM1jEYVOvf6lmT+FCkJ/YmfkrWRTETtImfZyHn5JjIoSmJPN1fB1i8fStbdjHK/aH
 jk9WgJqM/wS8/xW3+xw==
X-Proofpoint-GUID: CmRTWixKgxeJ8PtTpJRsXN7WQckI-dzI
X-Proofpoint-ORIG-GUID: nH3wojI4PGTzPYURodqK6hUp2SQ4UQNS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170051
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


