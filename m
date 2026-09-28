Return-Path: <linuxppc-dev+bounces-28394-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FA2CA5FA2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 11:04:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htdkB0cmbz3bQm;
	Mon, 28 Sep 2026 21:04:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790593490;
	cv=none; b=Z/W/wlI+wX8wx2NDjbjoF8nyrEF+I5xdsyf5UsUhQSz0k1GTS7C1rvwhJaq5N/boQwhZ1gZJD8UCCwkGG20vUNId+Hv/GdUdSzXHpGU7DEiUB4z5qNGWA/7dUwcNeHxA5Pubub1SKYmFd3NdJoDiBSBwl/PsDQJRaTnZ6mO4rrTFNgYJW1AvF/SjkSqANhASSVHy3fbrT07LALYppshbF7w0IZDGoDhaWlaY71MSr0KmPYhj7kNK3o0cM4qdoLHzcoEnqIAThKPMwxwf7SpH2u0zMmMMliiOiWnGHaaPeeBpLLjRgsEPnWxVWMhuB678XaG+Fm6KgIIxQD2iVNANkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790593490; c=relaxed/relaxed;
	bh=OmZkydlk2uVtd5GZNwB6fqSnI/9ta3sytitbD/RbAXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVolcykVLqATSmwGmpbOtlKPW2J/NKPTXcPuh4r1FcfbGzagR2eEuLQ127brAYylSS3EieY09GDrLJ9GkFdlS5pmhGVK/5xjWYxduDAKOfAKeEeXTu3Qm0pVkeud6suIBCARdKYYR4uY7eUkmp88ZTPnXlYZjDlyUsBZwlhq8Ki3PKN3kNvhCpvyMeEjz/HWDstCz8KCQ+aLOq2dfH1B3XfRpRvtCvhrZSvXShEF6V80+RbUB/2ykNlF0slaIyqM2Um2SEoNMOwnntO1waA9zNMwGRyqBzyD++BcxdjEWfSCuAJttM1+wEBk2hxcrpXnXVEvB6t4ZIENcPjo/X5NJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mCxBwxwN; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mCxBwxwN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htdk91cZhz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 21:04:48 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9Zx8M3726528;
	Mon, 28 Sep 2026 11:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OmZkydlk2uVtd5GZN
	wB6fqSnI/9ta3sytitbD/RbAXo=; b=mCxBwxwNPnpLBSVlk01dENj6ZUm29igUo
	2LTWCkacXF4W5F1MJ8Kl8r25MKwJgk8D/EU0465EESrXKdq29hX+QzwkWdSA6fJt
	eIeJzWFH9on09ms0qwL+fG0+dHFfDs/eKpi6POF1Y0ti7KoYbd6tX+lCGE6RRnEY
	b70LI6QDi2LldWIxdPecnGJF8vXKaXmp1tB9XvSeO5sRQWpLSUzOQvIBXsO9G+3P
	Wcyz3/NGSZOEFrCCHV66rRGOO5Whm2d6ENn41U/+8h5ZnYpj9PT+yick9OSTpSu8
	pvsCLGsBrL60sJiLqTQO42mLxMR85+oXCPaCk9Ft1m98iieR2VXUA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe0mbq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 11:04:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9HU6p4117429;
	Mon, 28 Sep 2026 11:04:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y4nqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 11:04:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SB4We643843880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 11:04:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8409420043;
	Mon, 28 Sep 2026 11:04:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8F6D20040;
	Mon, 28 Sep 2026 11:04:28 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.68])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 11:04:28 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com
Subject: [PATCH 2/2] KVM: PPC: Replay pending interrupts before entering the guest
Date: Mon, 28 Sep 2026 16:34:11 +0530
Message-ID: <20260928110411.844582-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928110411.844582-1-sshegde@linux.ibm.com>
References: <20260928110411.844582-1-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6aba49c5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=j_Z4ZgiU5xnDcWkxdewA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfXxBmq/wGMBqch
 y3KVGbHhIpZ7EjSO4NDCZy43gfm/NuA1USKZcBp9yt+mOw0xndOK3su7MZikZ2XRYq/sve1bVkN
 wt0Tic4ILbHsUqCFNF68I694eDoVmVo=
X-Proofpoint-ORIG-GUID: ydNCXtBfZL86Wr8r1PqOtlvBFyu7KEAl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX7cqjpIKOZ2Pf
 6RtzM5X7L9wODi4k1BNp8aZrBVkLY3oqaoA2QAiWIKwD3jr+6fTM6Oe/BaEvSYtBpxV31LWvGgo
 7K3fv0CsftJSa4FjUQyRx4vxnLKPhQdNC4PjcZENk6gkTCp1nLyCa9kX+e361218xQ8OLPASX4m
 QUsAt2jOL49Yz0v2yH9ixsLTk+GeiUfSmxl9lDqFOgA2wDP1V2bYFMNERxh75MGezEMv6/N1LJf
 9jigI/TyLlX0Kai6fIIxRNCCHN0jMA6MEVfI4dK3Z5s5iO7WKI3QZZ4+w6FOjhfZcwKHFNAGfqp
 JosWgBGYQ7Ta0bdmT4G8qctgXGHnvygOUfgi1ryMHrfaEzfs7Ig2qQ0HgK9ffpVIjgEyzHP1Ag4
 bJ/7rWT4uvol/KgGOwoZexwPGiI07RELgqfbG5INj5bGff1xJqs+b63DOJITXv8/XS8m7uRTgAp
 FZ0hJZ0YrmkMBhvu7jg==
X-Proofpoint-GUID: M2HdvUP8cMJ2QYlC_JztXMpa7DVqP79E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280042

After applying preempt disable patch, i.e PATCH 1/2, Christian reported
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
may occur and it could set the irq pending bit in PACA. When that
happens replay that interrupt before entering the guest.

Fixes: 12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Closes: https://lore.kernel.org/all/b8f82519-9ae5-c247-e020-e79c627e57df@xenosoft.de/
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kvm/powerpc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9194cf492d1c..847ff07c364b 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -147,6 +147,19 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 			continue;
 		}
 
+#ifdef CONFIG_PPC64
+		/*
+		 * Interrupt arrived between the soft and hard
+		 * disable. Replay it and retry guest entry.
+		 */
+		if (unlikely(local_paca->irq_happened != PACA_IRQ_HARD_DIS)) {
+			local_irq_enable();
+			local_irq_disable();
+			hard_irq_disable();
+			continue;
+		}
+#endif
+
 		guest_enter_irqoff();
 		return 1;
 	}
-- 
2.52.0


