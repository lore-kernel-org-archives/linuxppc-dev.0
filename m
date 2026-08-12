Return-Path: <linuxppc-dev+bounces-25753-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE9FC5B567
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 03:46:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKZDS5mR2z3br3;
	Wed, 12 Aug 2026 13:46:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786506408;
	cv=none; b=MadW7gs3bSizpxO9coT/+sPWVCYpl2rTWYVGOSGT3yLICG4MO+PbrHZcA7mehkQZ5GKQrBEJdptXkMTt58gmHNe4DX33P1cOWb+wBCJVuWx2F1sMoMGI21HN0ZPe1+euaEcvQnZAidVhGKsIaQv7TTNc0j+UAumdeavvg+5XKJrV7PU1YJeSh4ClAzRlDlgjWnTOJqWlCmqbze1pFeboEy1QGTsorYixATooSTGIkJUgvRb+4DAtT3XUf9vv/B8t6MZavYpnbYNZINDQZOpYUAoE1T/Y4qvonz70uQ8nYrPLkcoLgRV4GFbAqscYOkxCKO1NsAwWb4wOAyP3R37xYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786506408; c=relaxed/relaxed;
	bh=RlTHa3koWgbHAkcHblOzwz27zcB+0vrMaMu9AkyEXE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lrew9q1w8L/B44Yz1kiKQeL/ujU9741sszUVhFDup6lE7AVpUG9WMjj21PNpKb0auzrw0CVD43TF+6tL+DdZDn0YwaFO4b5gBK9R48b3dsONO7MkHiuxuRV35xQqzH2SFn0x2+jkh9Zh6g3dkCJ0/FiX8UCboGdy/twzlnCnTVFV6Tjdg8Q39hdn7Og3NO1wr/bTjr6CO+qfd0Idw3qC7mroT7wtXnKUCkES3NcQoTTY1WqQUHmMEZSUlcoZVmbqSSNsPil5vwFoW6K/xGX/63dTslt7myA/MxNbWB/1s3/T2P2TEyPxMkTcdzuVL4Q5TMJau97Bn9ERS5alC5zXSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Vc3ovu9/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Vc3ovu9/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKZDR4ycJz3bqy
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 13:46:47 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C31hXf2285240;
	Wed, 12 Aug 2026 03:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RlTHa3koWgbHAkcHblOzwz27zcB+0vrMaMu9AkyEX
	E4=; b=Vc3ovu9/Wn3hBc0N0yXq/9hyDfFxW8DLfmBhkwdBsgn6EanP33MvOfsk2
	9oSqdxf5IWZRtOuCh3ZO6fUW2+CFsbP5rAD0n3ME5qAK6pHcRXqhZpgjslLvH4hO
	OvRtXrr8r7QoxKWT5VEELZW34AVC13TD2vTKAE+XsqbxKfKUjQadptlkuzc6o7Ui
	2ORUF8PMDY6vuOwCwpaX2Ph/tB+2pIurWYfXBNb+pEG8oxp7KoxLDNYTrR1oA1xM
	ix/Yl/pwuKJZUOUJoNnnWUZR8b3qspUtR7XWjBidqKWCSCcp33eYlb52/z90iY4V
	j3gYHIN8M0NbgTRGoYHoHj4qKC/1A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9rnkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 03:46:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C3QNo8016602;
	Wed, 12 Aug 2026 03:46:38 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjvayn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 03:46:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C3kahS33030828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 03:46:37 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBCFE58063;
	Wed, 12 Aug 2026 03:46:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BE5858055;
	Wed, 12 Aug 2026 03:46:33 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.127.3.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Wed, 12 Aug 2026 03:46:33 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 12 Aug 2026 09:16:31 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] KVM: PPC: Book3S HV: Don't drop pending doorbell across L2 entry
Date: Wed, 12 Aug 2026 09:16:26 +0530
Message-ID: <20260812034628.1122115-1-vaibhav@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAyNSBTYWx0ZWRfXwuI1TZg8fR1b
 iAqhodKhm7JokUEfWRb/rHTLnbqJ8kSTrJq/3WLVgtvVd9IE0lshsIci7SX+JBZbcIp6rLBxSTr
 63KJvJ9mGHlpIhs+SSFFd8X5v4DBc/+fxlstdWss0uJ9COKNladPQ9dmnPircAiif/VkYrKRNcj
 pFS3MTgERX4V7UlMDW/3Yratpn2xnepoyK1NJFbuKM4gLJiynjYlFlICpAjrOZ6uasKfUqRsFOo
 pQr/+CUkVmpE07WAPvSRCxYT7uO0aosziHI37+kDfHXOWxbEZf5kQqFRUwsCUg1GOrVNWssMCkZ
 j84EhoU5uavnyOFGCDVOQc7hqGLMNSBCGuK+faDQHEXYyLFtl0GDzyC1a2UBeDfsPVPO/K3YpjQ
 APALS4rYfNb9Iw2SrT73D4sCWuNYnHr508Tx5EnjPLKShS1ewdGrK5z2vgNbYVzLjtM+uDXTcWn
 WkGGUZURo6fXTHe5smA==
X-Proofpoint-ORIG-GUID: zOoaDepBYphW4XhPN6tbpop1tsODEhIB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAyNSBTYWx0ZWRfX5+JAVjqIrwIQ
 6IcpZ56wyfYsROefkt/8bI3JW8kH6LXaECyuJa4FSjJQbLLf4dHQ40hAJfsFMQuztFjLnJdozU7
 nlQMbS3FLteql87jfqxUdvPh4A+A6Wo=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7bec9f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=OjXTmG7aikRSz7Sv7TEA:9
X-Proofpoint-GUID: zOoaDepBYphW4XhPN6tbpop1tsODEhIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120025

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

Fix this by converting 'doorbell_request' to an atomic to track the L2's
DPDES rather than being consumed by entry. This also enables new doorbells
to be queued up on a vcpu while and active doorbell request is being
handled.

Since kvm_vcpu_arch 'doorbell_request' is also shared across APIv1 and
Bare-Metal KVM infrastructure on PPC64, the patch also updates these
paths to use kernel's 'atomic_t' helpers.

With this following changes to kvmhv_vcpu_entry_nestedv2() code flow are
done:

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

Testing
=======
This patch has been tested with continuous migration for a APIv2 KVM guest
running stress-ng workload with lots of IPIs flying around, top of a
PowerVM-LPAR and seems to work. Without the patch the migration loop used
to eventually endup in KVM guest reporting lockups, which arent seen
anymore with this patch.

I haven't tested it yet with Bare-Metal nor APIv1 based PPC64 KVM
guests. Will be able to share their results (Hopefully) in next version of
this patch.

Fixes: 54ec2bd9e017 ("KVM: PPC: Book3S HV nestedv2: Fix doorbell emulation")
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Assisted-by: Claude:Opus-5

---
Change-log:
Since V1:
https://lore.kernel.org/linuxppc-dev/20260803034426.44249-1-vaibhav@linux.ibm.com/T/#u
* Address review comments around a typo [Shashiko]
* Address a race condition which Shashiko had pointed to [Shashiko]
* Updated the patch description and added test results
* Refactored 'doorbell_request' to an 'atomic_t'
* Updated code to use atomic_t helpers
---
 arch/powerpc/include/asm/kvm_host.h   |  2 +-
 arch/powerpc/kvm/book3s_hv.c          | 39 ++++++++++++++++-----------
 arch/powerpc/kvm/book3s_hv_builtin.c  |  3 +--
 arch/powerpc/kvm/book3s_hv_nested.c   |  9 ++++---
 arch/powerpc/kvm/book3s_hv_p9_entry.c |  7 +++--
 5 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 2d139c807577..03fac7422aa2 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -775,7 +775,7 @@ struct kvm_vcpu_arch {
 	unsigned long pending_exceptions;
 	u8 ceded;
 	u8 prodded;
-	u8 doorbell_request;
+	atomic_t doorbell_request;
 	u8 irq_pending; /* Used by XIVE to signal pending guest irqs */
 	unsigned long last_inst;
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..fb80c13dbb29 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -15,6 +15,7 @@
  * by Alexander Graf <agraf@suse.de>.
  */
 
+#include "asm/guest-state-buffer.h"
 #include <linux/kvm_host.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
@@ -881,7 +882,7 @@ static bool kvmppc_doorbell_pending(struct kvm_vcpu *vcpu)
 	int thr;
 	struct kvmppc_vcore *vc;
 
-	if (vcpu->arch.doorbell_request)
+	if (atomic_read(&vcpu->arch.doorbell_request))
 		return true;
 	if (cpu_has_feature(CPU_FTR_ARCH_300))
 		return false;
@@ -1557,17 +1558,16 @@ static int kvmppc_emulate_doorbell_instr(struct kvm_vcpu *vcpu)
 		tvcpu = kvmppc_find_vcpu(kvm, vcpu->vcpu_id - thr + arg);
 		if (!tvcpu)
 			break;
-		if (!tvcpu->arch.doorbell_request) {
-			tvcpu->arch.doorbell_request = 1;
+		if (atomic_inc_return(&tvcpu->arch.doorbell_request) >= 1)
 			kvmppc_fast_vcpu_kick_hv(tvcpu);
-		}
 		break;
 	case OP_31_XOP_MSGCLRP:
 		arg = kvmppc_get_gpr(vcpu, rb);
 		if (((arg >> 27) & 0x1f) != PPC_DBELL_SERVER)
 			break;
-		vcpu->arch.vcore->dpdes = 0;
-		vcpu->arch.doorbell_request = 0;
+
+		if (atomic_dec_return(&vcpu->arch.doorbell_request) <= 0)
+			vcpu->arch.vcore->dpdes = 0;
 		break;
 	case OP_31_XOP_MFSPR:
 		switch (get_sprn(inst)) {
@@ -2313,7 +2313,7 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 		 * On POWER8, doorbell_request is 0.
 		 */
 		if (cpu_has_feature(CPU_FTR_ARCH_300))
-			*val = get_reg_val(id, vcpu->arch.doorbell_request);
+			*val = get_reg_val(id, atomic_read(&vcpu->arch.doorbell_request));
 		else
 			*val = get_reg_val(id, vcpu->arch.vcore->dpdes);
 		break;
@@ -2565,7 +2565,7 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 		break;
 	case KVM_REG_PPC_DPDES:
 		if (cpu_has_feature(CPU_FTR_ARCH_300))
-			vcpu->arch.doorbell_request = set_reg_val(id, *val) & 1;
+			atomic_inc(&vcpu->arch.doorbell_request);
 		else
 			vcpu->arch.vcore->dpdes = set_reg_val(id, *val);
 		break;
@@ -4253,10 +4253,6 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
 	int trap;
 	long rc;
 
-	if (vcpu->arch.doorbell_request) {
-		vcpu->arch.doorbell_request = 0;
-		kvmppc_set_dpdes(vcpu, 1);
-	}
 
 	io = &vcpu->arch.nestedv2_io;
 
@@ -4265,6 +4261,10 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
 	if (lazy_irq_pending())
 		return 0;
 
+	/* Set DPDES if any doorbell is requested */
+	if (atomic_read(&vcpu->arch.doorbell_request) > 0)
+		kvmppc_set_dpdes(vcpu, 1);
+
 	rc = kvmhv_nestedv2_flush_vcpu(vcpu, time_limit);
 	if (rc < 0)
 		return -EINVAL;
@@ -4298,6 +4298,17 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	timer_rearm_host_dec(*tb);
 
+	/* Check if privileged door bell was requested and handled */
+	if (atomic_read(&vcpu->arch.doorbell_request) > 0) {
+		/* In case PHYP doesn't return updated dpdes in output gsb */
+		if (vcpu->arch.vcore->dpdes)
+			kvmhv_nestedv2_cached_reload(vcpu,
+						     KVMPPC_GSID_DPDES);
+		/* if dpdes was handled then reduce the doorbell count */
+		if (!vcpu->arch.vcore->dpdes)
+			atomic_dec(&vcpu->arch.doorbell_request);
+	}
+
 	/* Record context switch and guest_run_time data */
 	if (kvmhv_get_l2_counters_status())
 		do_trace_nested_cs_time(vcpu);
@@ -4356,9 +4367,7 @@ static int kvmhv_vcpu_entry_p9_nested(struct kvm_vcpu *vcpu, u64 time_limit, uns
 	 * enables us to receive doorbells when H_ENTER_NESTED is
 	 * in progress for this vCPU
 	 */
-
-	if (vcpu->arch.doorbell_request)
-		vcpu->arch.doorbell_request = 0;
+	atomic_set(&vcpu->arch.doorbell_request, 0);
 
 	/*
 	 * When setting DEC, we must always deal with irq_work_raise
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index fa0e3a22cac0..76bda278cff9 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -594,11 +594,10 @@ void kvmppc_guest_entry_inject_int(struct kvm_vcpu *vcpu)
 		}
 	}
 
-	if (vcpu->arch.doorbell_request) {
+	if (atomic_dec_if_positive(&vcpu->arch.doorbell_request) >= 0) {
 		mtspr(SPRN_DPDES, 1);
 		vcpu->arch.vcore->dpdes = 1;
 		smp_wmb();
-		vcpu->arch.doorbell_request = 0;
 	}
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 22e616662255..cc81089b2bcd 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -32,7 +32,7 @@ void kvmhv_save_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 
 	hr->pcr = vc->pcr | PCR_MASK;
-	hr->dpdes = vcpu->arch.doorbell_request;
+	hr->dpdes = atomic_read(&vcpu->arch.doorbell_request);
 	hr->hfscr = vcpu->arch.hfscr;
 	hr->tb_offset = vc->tb_offset;
 	hr->dawr0 = vcpu->arch.dawr0;
@@ -105,7 +105,7 @@ static void save_hv_return_state(struct kvm_vcpu *vcpu,
 {
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 
-	hr->dpdes = vcpu->arch.doorbell_request;
+	hr->dpdes = atomic_read(&vcpu->arch.doorbell_request);
 	hr->purr = vcpu->arch.purr;
 	hr->spurr = vcpu->arch.spurr;
 	hr->ic = vcpu->arch.ic;
@@ -143,7 +143,7 @@ static void restore_hv_regs(struct kvm_vcpu *vcpu, const struct hv_guest_state *
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 
 	vc->pcr = hr->pcr | PCR_MASK;
-	vcpu->arch.doorbell_request = hr->dpdes;
+	atomic_set(&vcpu->arch.doorbell_request, hr->dpdes);
 	vcpu->arch.hfscr = hr->hfscr;
 	vcpu->arch.dawr0 = hr->dawr0;
 	vcpu->arch.dawrx0 = hr->dawrx0;
@@ -176,7 +176,8 @@ void kvmhv_restore_hv_return_state(struct kvm_vcpu *vcpu,
 	 *   a) Sent after H_ENTER_NESTED was called on this vCPU (arch.doorbell_request would be 1)
 	 *   b) Doorbell was not handled and L2 exited for some other reason (hr->dpdes would be 1)
 	 */
-	vcpu->arch.doorbell_request = vcpu->arch.doorbell_request | hr->dpdes;
+	if (hr->dpdes)
+		atomic_inc(&vcpu->arch.doorbell_request);
 	vcpu->arch.hfscr = hr->hfscr;
 	vcpu->arch.purr = hr->purr;
 	vcpu->arch.spurr = hr->spurr;
diff --git a/arch/powerpc/kvm/book3s_hv_p9_entry.c b/arch/powerpc/kvm/book3s_hv_p9_entry.c
index 34bc0a8a1288..fc44d8aa7a6a 100644
--- a/arch/powerpc/kvm/book3s_hv_p9_entry.c
+++ b/arch/powerpc/kvm/book3s_hv_p9_entry.c
@@ -610,10 +610,9 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 
 	if (vc->pcr)
 		mtspr(SPRN_PCR, vc->pcr | PCR_MASK);
-	if (vcpu->arch.doorbell_request) {
-		vcpu->arch.doorbell_request = 0;
+
+	if (atomic_dec_if_positive(&vcpu->arch.doorbell_request) >= 0)
 		mtspr(SPRN_DPDES, 1);
-	}
 
 	if (dawr_enabled()) {
 		if (vcpu->arch.dawr0 != host_dawr0)
@@ -838,7 +837,7 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 
 	dpdes = mfspr(SPRN_DPDES);
 	if (dpdes)
-		vcpu->arch.doorbell_request = 1;
+		atomic_inc(&vcpu->arch.doorbell_request);
 
 	vc->vtb = mfspr(SPRN_VTB);
 
-- 
2.55.0


