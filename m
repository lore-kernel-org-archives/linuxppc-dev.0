Return-Path: <SRS0=kzwA=44=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75AAC10F25
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2020 05:14:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD8F208C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2020 05:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD8F208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48cg9b75NRzDqQK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2020 16:14:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.43; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0043.hostedemail.com
 [216.40.44.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48cg7f47mHzDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2020 16:12:30 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 1A91D18062975
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2020 05:07:19 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay05.hostedemail.com (Postfix) with ESMTP id 76A3B18063C8E;
 Wed, 11 Mar 2020 05:07:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: trade07_221c65ba4ee3b
X-Filterd-Recvd-Size: 4145
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Wed, 11 Mar 2020 05:07:14 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH -next 016/491] KERNEL VIRTUAL MACHINE FOR POWERPC
 (KVM/powerpc): Use fallthrough; 
Date: Tue, 10 Mar 2020 21:51:30 -0700
Message-Id: <37a5342c67e1b68b9ad06aca8da245b0ff409692.1583896348.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/kvm/book3s_32_mmu.c | 2 +-
 arch/powerpc/kvm/book3s_64_mmu.c | 2 +-
 arch/powerpc/kvm/book3s_pr.c     | 2 +-
 arch/powerpc/kvm/booke.c         | 6 +++---
 arch/powerpc/kvm/powerpc.c       | 1 -
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index f21e734..3fbd57 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -234,7 +234,7 @@ static int kvmppc_mmu_book3s_32_xlate_pte(struct kvm_vcpu *vcpu, gva_t eaddr,
 				case 2:
 				case 6:
 					pte->may_write = true;
-					/* fall through */
+					fallthrough;
 				case 3:
 				case 5:
 				case 7:
diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index 5991332..26b8b2 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -311,7 +311,7 @@ static int kvmppc_mmu_book3s_64_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	case 2:
 	case 6:
 		gpte->may_write = true;
-		/* fall through */
+		fallthrough;
 	case 3:
 	case 5:
 	case 7:
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 729a0f..7db3695 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -740,7 +740,7 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		    (vcpu->arch.hflags & BOOK3S_HFLAG_SPLIT_HACK) &&
 		    ((pte.raddr & SPLIT_HACK_MASK) == SPLIT_HACK_OFFS))
 			pte.raddr &= ~SPLIT_HACK_MASK;
-		/* fall through */
+		fallthrough;
 	case MSR_IR:
 		vcpu->arch.mmu.esid_to_vsid(vcpu, eaddr >> SID_SHIFT, &vsid);
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 7b27604..be47815 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -421,11 +421,11 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	case BOOKE_IRQPRIO_DATA_STORAGE:
 	case BOOKE_IRQPRIO_ALIGNMENT:
 		update_dear = true;
-		/* fall through */
+		fallthrough;
 	case BOOKE_IRQPRIO_INST_STORAGE:
 	case BOOKE_IRQPRIO_PROGRAM:
 		update_esr = true;
-		/* fall through */
+		fallthrough;
 	case BOOKE_IRQPRIO_ITLB_MISS:
 	case BOOKE_IRQPRIO_SYSCALL:
 	case BOOKE_IRQPRIO_FP_UNAVAIL:
@@ -459,7 +459,7 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	case BOOKE_IRQPRIO_DECREMENTER:
 	case BOOKE_IRQPRIO_FIT:
 		keep_irq = true;
-		/* fall through */
+		fallthrough;
 	case BOOKE_IRQPRIO_EXTERNAL:
 	case BOOKE_IRQPRIO_DBELL:
 		allowed = vcpu->arch.shared->msr & MSR_EE;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1af96fb5..c242a79 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -525,7 +525,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = 1;
 		break;
 	case KVM_CAP_PPC_GUEST_DEBUG_SSTEP:
-		/* fall through */
 	case KVM_CAP_PPC_PAIRED_SINGLES:
 	case KVM_CAP_PPC_OSI:
 	case KVM_CAP_PPC_GET_PVINFO:
-- 
2.24.0

