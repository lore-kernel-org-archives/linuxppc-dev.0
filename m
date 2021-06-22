Return-Path: <SRS0=MtJN=LQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780EAC2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 11:11:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1309161076
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 11:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1309161076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8Nxy4HlMz3gJ7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 21:11:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=pnczJJxK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e;
 helo=mail-pj1-x102e.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=pnczJJxK; dkim-atps=neutral
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8Ngh1jbYz3c7Q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 20:59:12 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id
 c7-20020a17090ad907b029016faeeab0ccso1491990pjv.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 03:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vsu3dIydt3f5nT2j6TrGrwAAXR/s/7OmUGaERVcQdoM=;
 b=pnczJJxKHMB7ThmLHpWXmBKWj5JvA9KrbMi6qAFy77U08FHlIDStN5+Z/UIOq7gY06
 m2AUtvXnZIR+LAs4Xn0VQ65nxIzvG0vUXjryi9DU7r44gk2mhbBOyry2irl+FMEVfj7o
 +GVjqjkDlPEA4KRHundYZ2EotDgv0inTnwHM7NhjOmQUdKvTt+oS6myS8jw8CvR4tTmC
 FsqbU2bGG7VSXwjNp2YU/YUCT0CIsnUHpaXDSy/U0Ak4E04RGCkAD6aX+zBl9utfUuLe
 WEUaNUMj0juPy+CBJc5maFfVBypC/0KJKMPufWW8zwQuOxoP/ohqRzd6HuE87dPUkUDP
 heFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vsu3dIydt3f5nT2j6TrGrwAAXR/s/7OmUGaERVcQdoM=;
 b=X+VVskf38/i7xuEdtXuPiDKzwUpZQ4RWhLBUAmdw5Z4C/wadJEsvNzetaIHwQwOfqF
 ER9HsZTqmfySugRItU2engLK3lvfv1h+6XG4zigVujNw62mb5uvIy9PxoTy5ICAXxYaL
 /vwKWW4S5y2xN/WY5yUAXejvKpbWpv+hGLhy1XjhA/lc3Ee7+PLz3Zl4vesd/X7bKqMb
 5X9i/LXiDZKib5uQU0eEhdEnMJkinCCw/BB56y68nr9basdKdb7GESlvZ4Rsn6ujU5aC
 mgNM0NVm4tJPwrxEbL+ABlz8zujvW1+D4T3YsLzlBcBTjVy/dz1NHYLuoXAXU6tJCxVR
 MKsg==
X-Gm-Message-State: AOAM532yGpZAmEFsvWi8jmLrFCCTCl0wa1R3oYoU8N97YT8gIfSO8BT0
 LIh/m4+rlUX6THPC6eybmE0=
X-Google-Smtp-Source: ABdhPJxq9mUJQfgQvdt01Ubbhiq6oulm382r6AR+kdY4/sRCNsQW49Q+58Nm8XyVfUOf/kOSWjhdfA==
X-Received: by 2002:a17:90a:5d83:: with SMTP id
 t3mr3395224pji.195.1624359549482; 
 Tue, 22 Jun 2021 03:59:09 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id l6sm5623621pgh.34.2021.06.22.03.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 03:59:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [RFC PATCH 30/43] KVM: PPC: Book3S HV P9: Implement TM fastpath for
 guest entry/exit
Date: Tue, 22 Jun 2021 20:57:23 +1000
Message-Id: <20210622105736.633352-31-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210622105736.633352-1-npiggin@gmail.com>
References: <20210622105736.633352-1-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If TM is not active, only TM register state needs to be saved.

-348 cycles (7218) POWER9 virt-mode NULL hcall

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_p9_entry.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_p9_entry.c b/arch/powerpc/kvm/book3s_hv_p9_entry.c
index f5098995f5cb..81ff8479ac32 100644
--- a/arch/powerpc/kvm/book3s_hv_p9_entry.c
+++ b/arch/powerpc/kvm/book3s_hv_p9_entry.c
@@ -271,8 +271,16 @@ void load_vcpu_state(struct kvm_vcpu *vcpu,
 			   struct p9_host_os_sprs *host_os_sprs)
 {
 	if (cpu_has_feature(CPU_FTR_TM) ||
-	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
-		kvmppc_restore_tm_hv(vcpu, vcpu->arch.shregs.msr, true);
+	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST)) {
+		unsigned long msr = vcpu->arch.shregs.msr;
+		if (MSR_TM_ACTIVE(msr)) {
+			kvmppc_restore_tm_hv(vcpu, msr, true);
+		} else {
+			mtspr(SPRN_TEXASR, vcpu->arch.texasr);
+			mtspr(SPRN_TFHAR, vcpu->arch.tfhar);
+			mtspr(SPRN_TFIAR, vcpu->arch.tfiar);
+		}
+	}
 
 	load_spr_state(vcpu, host_os_sprs);
 
@@ -295,8 +303,16 @@ void store_vcpu_state(struct kvm_vcpu *vcpu)
 	vcpu->arch.vrsave = mfspr(SPRN_VRSAVE);
 
 	if (cpu_has_feature(CPU_FTR_TM) ||
-	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
-		kvmppc_save_tm_hv(vcpu, vcpu->arch.shregs.msr, true);
+	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST)) {
+		unsigned long msr = vcpu->arch.shregs.msr;
+		if (MSR_TM_ACTIVE(msr)) {
+			kvmppc_save_tm_hv(vcpu, msr, true);
+		} else {
+			vcpu->arch.texasr = mfspr(SPRN_TEXASR);
+			vcpu->arch.tfhar = mfspr(SPRN_TFHAR);
+			vcpu->arch.tfiar = mfspr(SPRN_TFIAR);
+		}
+	}
 }
 EXPORT_SYMBOL_GPL(store_vcpu_state);
 
-- 
2.23.0

