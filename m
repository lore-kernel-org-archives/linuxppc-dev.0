Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF87C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:58:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B89662147C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sP693IOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89662147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w5gQ6n3XzDqHp
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 15:58:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sP693IOJ"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w5dj4p84zDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:57:10 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id h3so4240236pfg.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Feb 2019 20:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=pD6Sd4tXhUU1w7g3BhLgkNrC7p2Crz6vdbFgbo4L8xQ=;
 b=sP693IOJT1vy9y4K8ltwk4eo4Kt656odYTBfL7JbfxJLpRDrXA7sd5V5FAplRo0ZN/
 9bs5IkvOCysLUq3dtW6hpgRANKveYOxFuodXwK8NhW5HYURzamYnGPjZ2/8GNBSZBcdF
 bvUs2FT84nzjKzKmveJjcog3h0mhrSxM5QUnnZCO3xOElVadLLhS0Xn59sVqn5ZbbbKr
 lHlW6NWIQ2Dw+jGiBltlXJjpgea7oMl88xnpyHlmXPI8HrHwUDO773c2l9ObYwEgOTxo
 CD+JRpEGKVyFUtKyF6DmM0t11lZZlDY+mRfna4L4D10UB6zvTqb1V8exJIOzAJtzLbpH
 8CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=pD6Sd4tXhUU1w7g3BhLgkNrC7p2Crz6vdbFgbo4L8xQ=;
 b=YkuoDjrSvk4dXkw3h65f6BMrLMmuQ9QbwoRUBDl7vksnKKj10PNV0D/J4fSesoqfvt
 MBskhKlxjSqvpJKxz+jDVPa/Yaa4M9zFbgnoyHIOPUEAL5r/L+5CAR8tJD4qoRs9kp05
 8binieOUoVKWu2VXRHn180izB3R8qO6hbjUvXGX5ZfmsPFDB5F4yHQLEtYxgh67okX7r
 amie8/3TLSFOK4AyRPggI1o1ZhEE448lS8EdBT5fe0epRlqXL4bRrX0Td6+4mCoAuZ8z
 rsfC87uGV0MqcnuuA0++i9gExVSjUneWb76MSk5R1apRpS2ZogjOISGIhXzEND8VsybY
 lTyg==
X-Gm-Message-State: AHQUAuZS9/hpKdkvn+eoHvaz/LV17r5Y3z5Do30warE5bGXetGdoyTNt
 0er0MACw2nBIA4aXvBX84LM=
X-Google-Smtp-Source: AHgI3IZe6jbuvbD9VWe/0snFG3vpNh711t9Ibb/PzAZJYJDrUKyRPiQnQdDs4Q3XEaqgIwYtwa9nwA==
X-Received: by 2002:a63:9d0f:: with SMTP id i15mr12962551pgd.77.1549515428187; 
 Wed, 06 Feb 2019 20:57:08 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d88sm14586840pfe.19.2019.02.06.20.57.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 20:57:07 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: Optimise mmio emulation for devices on
 FAST_MMIO_BUS
Date: Thu,  7 Feb 2019 15:56:50 +1100
Message-Id: <20190207045650.18322-1-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
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
Cc: linuxppc-dev@lists.ozlabs.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Devices on the KVM_FAST_MMIO_BUS by definition have length zero and are
thus used for notification purposes rather than data transfer. For
example eventfd for virtio devices.

This means that when emulating mmio instructions which target devices on
this bus we can immediately handle them and return without needing to load
the instruction from guest memory.

For now we restrict this to stores as this is the only use case at
present.

For a normal guest the effect is negligible, however for a nested guest
we save on the order of 5us per access.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index bd2dcfbf00cd..be7bc070eae5 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -442,6 +442,24 @@ int kvmppc_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	u32 last_inst;
 
 	/*
+	 * Fast path - check if the guest physical address corresponds to a
+	 * device on the FAST_MMIO_BUS, if so we can avoid loading the
+	 * instruction all together, then we can just handle it and return.
+	 */
+	if (is_store) {
+		int idx, ret;
+
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
+		ret = kvm_io_bus_write(vcpu, KVM_FAST_MMIO_BUS, (gpa_t) gpa, 0,
+				       NULL);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
+		if (!ret) {
+			kvmppc_set_pc(vcpu, kvmppc_get_pc(vcpu) + 4);
+			return RESUME_GUEST;
+		}
+	}
+
+	/*
 	 * If we fail, we just return to the guest and try executing it again.
 	 */
 	if (kvmppc_get_last_inst(vcpu, INST_GENERIC, &last_inst) !=
-- 
2.13.6

