Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A8606A320
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XiTjr3A0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTy6k6dhmz2xlY;
	Wed, 18 Nov 2026 21:11:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794996670;
	cv=none; b=XqGdKQHY0hckf61N924Py72UCY6idZ/428JjWNA8Ju0h7h+Kw4VNVIcEcyqGYkulsARcy2qsrI2hFdKNibFFd5CfMo1e5fZAR9s9ak9xbFb+nDSXGerwgIIdANvh1UG4T+bxiHpU6RlakH3Hu7E+5qo4kGnCnf0m61SsVuqWR0Ty+xroJb+/TFkLeGicFbg4afaruo6lLs9xAo4tw0ru7WPbwRDwwePqkGGFDLr0cwlVh87QGdqBurPq9CbVzRxHDRCds28sRj8a9w4O9fVhdsB7TSOBa6li3yvT1SPtuhyaWg+LnKuy/7lguBVW4CAjTXwMJhkoZAxUWxeW8FA4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794996670; c=relaxed/relaxed;
	bh=10vF1TNZE1jmUzR5IhA4Cr9+ZCuxH/DSuBr/E3tdBrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kRiM72XtWF/MQWxMtJqu3QpGERHjXFNmo4J27auYmWGQDL4J1n3XESb4U9s2bo1MsNPj+64WyMcpc+S0OUZBOYRAjVlU3WsYVJk1h8G6dH1xW204MCVC8cZOxjF65UjQZtGe+33zuSGxBllG/2uxYjC+vFzUrqDQrqHuz1Lt5jaD+jqqMAWiMcTgZJWA+cIpxjEJyDqcUB10D1ICB/uSMMqkxfsouHaeKMmWszkYYpfbNYtaIdt7AbErOZ1sdYBDMqiNO7umt2V0wm09medM0B1sfKkUDHnyw2ke1i788iRisTUcZC9Fcse8AA25KJAZcguPaMg/tgID4hshaLk2+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XiTjr3A0; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=haoxiang_li2024@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XiTjr3A0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=haoxiang_li2024@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTy6f6yKDz2xdX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:11:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=10
	vF1TNZE1jmUzR5IhA4Cr9+ZCuxH/DSuBr/E3tdBrQ=; b=XiTjr3A0742JJy8J3g
	2GjHnhhuzFxw72XZJs08zxmKDvpS9bc2zkFZAMMUV20tXpaw6xrI9IM0delGgf28
	4tJElLPPI0Dc+/nfTiXKdWHSMy2tfFfzFmisZUNzIIKszIpg5cLZ9HqaYmRiKMAe
	gB8y8+NxMy7aqrH+rj9+PkK00=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_9WAef1qJpK6IA--.4941S2;
	Wed, 18 Nov 2026 18:10:10 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	jniethe5@gmail.com,
	gautam@linux.ibm.com,
	vaibhav@linux.ibm.com,
	kconsul@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] KVM: PPC: Book3S HV: Free nestedv2 state on vCPU creation failure
Date: Wed, 18 Nov 2026 18:10:08 +0800
Message-Id: <20261118101008.2242596-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wD3_9WAef1qJpK6IA--.4941S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4fAw48WF4xKrWDtw1fZwb_yoWktFX_uw
	s2q3ZxWaykAay5uw1kAw45WF4Igr48JrW0kw10q3srC39YgrnrWws2qwn8uw1ruayjyFsx
	G3yvvFnxJ34xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRR7PEUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7gKYB2r9eYJzIwAA3P
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When nestedv2 is enabled, kvmppc_core_vcpu_create_hv() allocates guest
state buffers and messages through kvmhv_nestedv2_vcpu_create(). If
the subsequent vcore lookup or allocation fails, it returns without
releasing those resources.

The caller's error path only calls kvmppc_subarch_vcpu_uninit(), which
does not free the nestedv2 state. Call kvmhv_nestedv2_vcpu_free() before
returning from the vcore error path when nestedv2 is enabled.

Fixes: 19d31c5f1157 ("KVM: PPC: Add support for nestedv2 guests")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 arch/powerpc/kvm/book3s_hv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 22283d46e8fe..1a1a4e3ba412 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3097,8 +3097,11 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 		}
 	}
 
-	if (!vcore)
+	if (!vcore) {
+		if (kvmhv_is_nestedv2())
+			kvmhv_nestedv2_vcpu_free(vcpu, &vcpu->arch.nestedv2_io);
 		return err;
+	}
 
 	spin_lock(&vcore->lock);
 	++vcore->num_threads;
-- 
2.25.1


