Return-Path: <linuxppc-dev+bounces-25219-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA059C55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 03:44:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD2cR0PgWz308Y;
	Mon, 03 Aug 2026 13:44:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785728694;
	cv=none; b=dzafEkQKcvQP//W33M4jwoI+DUcae0EpjP6mWB8Pz7E9RePHASTec7E7vUgkxVPOAhcxuSCWlMDFCcYC5PUPP2BYER+kvFvMBE/DYgbdg7Hmi0wu28KuLYXfxSBNAs1qBDgZ1Csy4g1kdw53IeGuAiB6AGgSCAqrGwmfe8zmudaRP/g5Uk1GJt3OAbhiNoMoitWBJdpAmUkVC8tlxRH3PiA3iPKZVHPefZxMkzJyYfRIuE7JxvP/cKAoJZMuVyVX8BGq/xsiKM13mRgUOQYGT30MspHLshgoVmTcgEZGvyZHCao8T4IlXF/dAcP5dkzCNSh/oj2METZmz7J/QbhmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785728694; c=relaxed/relaxed;
	bh=NaeGwxoHSthtf3Kc+gKRWGdjtMAtky1GUj9gVucNmBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VkPabNWyKTWhIV8xTzOHfdHYWRQQ1LWsW8sP2Con0NieLUeDtlk9lYuGE2KXgtIjO52Br9YNYJXASPfLVL+/ij//EJF+9U4vLNhFy+UQzTmYpaiemX9eJAp+knjWpLFx5p97Yu8TRvuZd4M9gYa732X6zki6uDLu+0Hzjl8z4EFgpuB4FXPtaD9okBQSuC58u8AfI/VZtwt8GAOat1zk/4jRRteKANWrvJ86bcF8JbX8+fiaaJtvNyhgyR3sAwKD2tBa5F8mrpx5LozKjHHByEJLqNmaTBZ17ZzU7B/cPjca9XLM1ztFefFxTTk68vAAF/qdwQq9pWKz0g9M5a4UJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=X/2xjn8j; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=X/2xjn8j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD2cP5DN3z2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 13:44:53 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmUai161465;
	Mon, 3 Aug 2026 03:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NaeGwxoHSthtf3Kc+gKRWGdjtMAtky1GUj9gVucNm
	Bk=; b=X/2xjn8jx3YhHJYT6452YrshKRfJmn8R54CPElaynwLNeXwvfvQI/HBhi
	pm//Zoqs93Repe7D4wRQkjfmOMW+YeoY7bOJVo5p/oUsFoE38a3hW1Q0gJmvWoXB
	JNW7KPwTNo5AIU31xZf/e16fHeXvRIJFVdbvBG6B8/Gq72q06pZHlQB7BE3kbkCA
	AySl+onW6ICddvVxcKBrUEqGSynsbIMsPoWt8oLUgdzIcc1RxYdTc4LMLqT5g/SR
	1xXEI+qLluxsuzqqQO4gh7CHMmkHVhO3oRzdvTtgEtftwE0siOpW7DygW4gfh5Ef
	HO3RftPpJ/kg386pUtNx9Cbuea8yg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hepb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 03:44:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6733fTGR021479;
	Mon, 3 Aug 2026 03:44:34 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg3cyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 03:44:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6733iXLu24314548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 03:44:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E89E5805E;
	Mon,  3 Aug 2026 03:44:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFD365805C;
	Mon,  3 Aug 2026 03:44:29 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.43.69.228])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with SMTP;
	Mon,  3 Aug 2026 03:44:29 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Mon, 03 Aug 2026 09:14:28 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] KVM: PPC: Book3S HV nestedv2: Don't drop pending doorbell across L2 entry
Date: Mon,  3 Aug 2026 09:14:25 +0530
Message-ID: <20260803034426.44249-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAyNSBTYWx0ZWRfX8wd3N1OmgNXp
 68u1RDahbSLfdfnntWBekv6AsGveUZs/UvFMT0IMfNB4hw7fKGjWZaZKtk0GAPINjgnU5G29f1B
 UrZFMd7i+Xacq5UzNxkDksOAOvio3rc=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a700ea3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=P_kwhO9e6d_EV9OI2pYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAyNSBTYWx0ZWRfX/8bH8poHZh+r
 XohW4y1ACaIR365xTISKKKvztBe7rSIsOE7/kQEBs1c2MN7l8P8WHzrUFTVxmyreSsLCGDGri3T
 QuT7q6NioHETnJj6QEIfGOx4sbxZVlkXwLMrEOGehCg0cMZ2iz4PoLdU3E+Dw1WmfzOzS2eNmr2
 CtZi2i+K2QoPWT6+lvvQlqbIWD9kLtbUKXOTEjureqkGgDVDt4Sue6/Eg6pfTiCbIflybT/T5gY
 8SKYOoFRL1YLaJrMG4Wl9k2H/OBtbOmfOVClWmufx3FTdurguZJ0RufmK78n/gSxGmUdC3ypXsK
 ylKeEDy3DQLy+i0HB+heQIBofcU+T91MYx2wSOfRB8DzeqCf3pdJCyHcKIPocrs1WGslzcpMegr
 Znhoqn0xY+2G4KcLl3aO1g9QPSz0CeZmhlX6+tBnfKrdYM7813Gvd5R+VKGMk/rbYE6y1agkIIZ
 zWqSkzGJdHrbpk7zZGg==
X-Proofpoint-ORIG-GUID: l0lIAL8aaVHMNGzeQlIa-2BLx92K7gER
X-Proofpoint-GUID: l0lIAL8aaVHMNGzeQlIa-2BLx92K7gER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030025

On nestedv2 the L1 converts a pending doorbell into guest DPDES state at
the top of kvmhv_vcpu_entry_nestedv2() and immediately forgets about it:

	if (vcpu->arch.doorbell_request) {
		vcpu->arch.doorbell_request = 0;
		kvmppc_set_dpdes(vcpu, 1);
	}

Clearing 'doorbell_request' at this point assumes that handing DPDES to the
L0 is equivalent to the L2 having taken the doorbell. That is not true, and
the doorbell can be lost in two ways:

  - The block runs before the lazy_irq_pending() check, so the doorbell is
    consumed even on the path that returns 0 without ever calling
    H_GUEST_RUN_VCPU.

  - DPDES stays pending in the L2 until it is actually delivered. The L2
    may exit for an unrelated reason (hcall, page fault, HDEC) with the
    doorbell still set, typically because it was running with MSR[EE]=0.
    Nothing reloads DPDES afterwards, so the L1 never learns this.

Once 'doorbell_request' has been cleared, the L1 has no record of the
pending doorbell. kvmppc_doorbell_pending() returns false, so
kvmppc_read_dpdes() reports the target thread as idle when a sibling vCPU
emulates 'mfspr DPDES', and the vCPU can be treated as having no work
pending and blocked. From the L2's point of view the doorbell is silently
lost, which shows up as an SMT guest hanging on a doorbell-based IPI.

Fix this by making 'doorbell_request' track the L2's DPDES rather than
being consumed by entry:

  - inject DPDES after the early-return paths and before
    kvmhv_nestedv2_flush_vcpu() serializes it into the vcpu run input
    buffer, and no longer clear 'doorbell_request' there,

  - after H_GUEST_RUN_VCPU, reload DPDES from the L0. The run output only
    carries the state the L0 chose to return and the 'valids' bitmap is
    zeroed on exit, so an explicit kvmhv_nestedv2_cached_reload() is
    needed to see the L2's current value,

  - if DPDES is still set the doorbell was not delivered, so keep
    'doorbell_request' pending so that it is re-injected on the next
    entry; otherwise clear it.

This keeps a pending doorbell visible to the L1 for as long as the L2 has
not consumed it, so vCPU wakeup and DPDES emulation on sibling vCPUs stay
consistent with the L2's actual state.

Fixes: 54ec2bd9e017 ("KVM: PPC: Book3S HV nestedv2: Fix doorbell emulation")
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Assisted-by: Claude:Opus-5
---
 arch/powerpc/kvm/book3s_hv.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..40f8717b8a7d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -15,6 +15,7 @@
  * by Alexander Graf <agraf@suse.de>.
  */
 
+#include "asm/guest-state-buffer.h"
 #include <linux/kvm_host.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
@@ -4253,11 +4254,6 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
 	int trap;
 	long rc;
 
-	if (vcpu->arch.doorbell_request) {
-		vcpu->arch.doorbell_request = 0;
-		kvmppc_set_dpdes(vcpu, 1);
-	}
-
 	io = &vcpu->arch.nestedv2_io;
 
 	msr = mfmsr();
@@ -4265,6 +4261,9 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
 	if (lazy_irq_pending())
 		return 0;
 
+	if (vcpu->arch.doorbell_request)
+		kvmppc_set_dpdes(vcpu, 1);
+
 	rc = kvmhv_nestedv2_flush_vcpu(vcpu, time_limit);
 	if (rc < 0)
 		return -EINVAL;
@@ -4296,6 +4295,17 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
 	if (rc < 0)
 		return -EINVAL;
 
+	/* Check if privileged door bell was requested and handled */
+	if (vcpu->arch.vcore->dpdes) {
+		kvmhv_nestedv2_cached_reload(vcpu, KVMPPC_GSID_DPDES);
+		if (vcpu->arch.vcore->dpdes)
+			vcpu->arch.doorbell_request |= vcpu->arch.vcore->dpdes;
+		else
+			cpu->arch.doorbell_request = 0;
+	} else {
+		vcpu->arch.doorbell_request = 0;
+	}
+
 	timer_rearm_host_dec(*tb);
 
 	/* Record context switch and guest_run_time data */
-- 
2.55.0


