Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C2DC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:23:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75FB22082A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="DQiBZxA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FB22082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qtr00K25zF2QM
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 23:23:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="DQiBZxA/";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qrvm4KDbzF3Jv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 21:56:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="DQiBZxA/"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Qrvm0dpNz9s8T; Thu,  4 Oct 2018 21:56:36 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Qrvk5RPxzB4N4;
 Thu,  4 Oct 2018 21:56:34 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538654194; bh=es1uYLyinVrJhvPzLCxRDYg4+tCf3E8LxMLZSdn300k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DQiBZxA/p9rLqgbYzQtaDlh0uPPCmefSwIdwdHQko9D/ouHcPcsSFpGaVfrXucNiJ
 LQacn0kwROGkOwIUg1KTUvZ2IM2VwpPmI2m9EiMAuaQZkvPaxOU3oXe8gD9QUoa96W
 lOj8nkoLuSbZttu4kGCRyY+ydk1m3F94cnjBzMWFzsKAqpGqV1iaXaqyNsP4t4qOp3
 xBVUbzYPC4YKAyOrxeJ0XLW6PbFivGGIJvJXOxdx347RljVHueHvrkNUnxyVGkOWPA
 Scdyc0DKgN0YuR0FhSrrTwSxWJ9hSoo+NgKG98i+uuftOvHeVdmX9opMzXK+YGyu/M
 CXdIWUAgV9DBA==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v4 27/32] KVM: PPC: Book3S HV: Add one-reg interface to
 virtual PTCR register
Date: Thu,  4 Oct 2018 21:56:04 +1000
Message-Id: <1538654169-15602-28-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
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
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds a one-reg register identifier which can be used to read and
set the virtual PTCR for the guest.  This register identifies the
address and size of the virtual partition table for the guest, which
contains information about the nested guests under this guest.

Migrating this value is the only extra requirement for migrating a
guest which has nested guests (assuming of course that the destination
host supports nested virtualization in the kvm-hv module).

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 Documentation/virtual/kvm/api.txt   | 1 +
 arch/powerpc/include/uapi/asm/kvm.h | 1 +
 arch/powerpc/kvm/book3s_hv.c        | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index c664064..017d851 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1922,6 +1922,7 @@ registers, find a list below:
   PPC   | KVM_REG_PPC_TIDR              | 64
   PPC   | KVM_REG_PPC_PSSCR             | 64
   PPC   | KVM_REG_PPC_DEC_EXPIRY        | 64
+  PPC   | KVM_REG_PPC_PTCR              | 64
   PPC   | KVM_REG_PPC_TM_GPR0           | 64
           ...
   PPC   | KVM_REG_PPC_TM_GPR31          | 64
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 1b32b56..8c876c1 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -634,6 +634,7 @@ struct kvm_ppc_cpu_char {
 
 #define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
 #define KVM_REG_PPC_ONLINE	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
+#define KVM_REG_PPC_PTCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc0)
 
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 4da9564..7561c99 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1710,6 +1710,9 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 	case KVM_REG_PPC_ONLINE:
 		*val = get_reg_val(id, vcpu->arch.online);
 		break;
+	case KVM_REG_PPC_PTCR:
+		*val = get_reg_val(id, vcpu->kvm->arch.l1_ptcr);
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -1941,6 +1944,9 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 			atomic_dec(&vcpu->arch.vcore->online_count);
 		vcpu->arch.online = i;
 		break;
+	case KVM_REG_PPC_PTCR:
+		vcpu->kvm->arch.l1_ptcr = set_reg_val(id, *val);
+		break;
 	default:
 		r = -EINVAL;
 		break;
-- 
2.7.4

