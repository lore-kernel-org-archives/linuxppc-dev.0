Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1D9C4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 04:11:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE5B6069E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 04:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BDE5B6069E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GY61v3SLCz3fGw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 14:11:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=BRSoxDop;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029;
 helo=mail-pj1-x1029.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=BRSoxDop; dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GY5bl35BFz30J0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2021 13:52:35 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id
 m2-20020a17090a71c2b0290175cf22899cso12426980pjs.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jul 2021 20:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uO2q8xALjPGGI79F4bk9pgeAW2H5oBKaXR5DgIXBdNY=;
 b=BRSoxDopPSvAk2THcmNSXnA1oZeWbmRQD4ntwoyt3nDzlBuPO7FMzbiLuayIFWNVCm
 ChPhBGyfKEX75npSq5K5Qi++FILtw3ri+602fK5u/bEzdHgxAYz5YjcAozn395bbJz0o
 yCQ7+P3kwUKkQsMEF/cOX7nFFe3zBognZ3WOZBdkKMr7Ug0W/ISdrKQewnZu/WQY46sF
 WVpoO0VEySnSeD4XBtxp4q/hUz5s+GfXP/InX4WLupEucB4dzyEl4RcKPLjGblR/laQd
 PWElyCybjbOTkS33XeCwsTYVRlpd8nuiloINVMEka/uWftlKveDSWtDxB+Sj9lcDhl6i
 N2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uO2q8xALjPGGI79F4bk9pgeAW2H5oBKaXR5DgIXBdNY=;
 b=h6gIvwBdP/XK6i2MmcYia4k4tHB7bHFpbB8bfggrCm5/q97OLTrCDCIgj2auBktV7j
 6dnobUdoT3HPcIP2f2N2mY6ItY1P+S0tNPOo1dIvMmGSw82v0BWQTOsUPgxklg9ry1rl
 BH4J4v0jZ7Xfb6LkiQ5M1Mk1k1kvL/XtD4STq/b8ko0WRW2boDI4qUI4Z3Eytp0fU98W
 caSJVwrp3VhNgXUlM+qz75VdqPgRyE3Z20FOuzmAwtN0+JM58JeE9YUQooLfVLRqzq7+
 /R2f/a7juurCfrIu1Oml5d3LMtfaKO6Q3KH2LRXoQVdokV1SOgN137y/LnGT5LWIwjJx
 GHAA==
X-Gm-Message-State: AOAM531/vMTeXyUUrC+f5gkmfFwzMWPSbIPwd7e5QXm9C+rwm2vo54fW
 rcRlW6rOsh3lxtcr5DpfEoc=
X-Google-Smtp-Source: ABdhPJxPrvxDmXyBJyR9M09fENlyIpZ+o/+PW2SxX4P4b7L7K5IQ+P028QCajZoW+tkGd2ZhAWRGWw==
X-Received: by 2002:a63:1944:: with SMTP id 4mr16115546pgz.306.1627271553272; 
 Sun, 25 Jul 2021 20:52:33 -0700 (PDT)
Received: from bobo.ibm.com (220-244-190-123.tpgi.com.au. [220.244.190.123])
 by smtp.gmail.com with ESMTPSA id p33sm41140341pfw.40.2021.07.25.20.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jul 2021 20:52:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v1 47/55] KVM: PPC: Book3S HV Nested: Avoid extra mftb() in
 nested entry
Date: Mon, 26 Jul 2021 13:50:28 +1000
Message-Id: <20210726035036.739609-48-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210726035036.739609-1-npiggin@gmail.com>
References: <20210726035036.739609-1-npiggin@gmail.com>
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

mftb() is expensive and one can be avoided on nested guest dispatch.

If the time checking code distinguishes between the L0 timer and the
nested HV timer, then both can be tested in the same place with the
same mftb() value.

This also nicely illustrates the relationship between the L0 and nested
HV timers.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/kvm_asm.h  |  1 +
 arch/powerpc/kvm/book3s_hv.c        | 12 ++++++++++++
 arch/powerpc/kvm/book3s_hv_nested.c |  5 -----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index fbbf3cec92e9..d68d71987d5c 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -79,6 +79,7 @@
 #define BOOK3S_INTERRUPT_FP_UNAVAIL	0x800
 #define BOOK3S_INTERRUPT_DECREMENTER	0x900
 #define BOOK3S_INTERRUPT_HV_DECREMENTER	0x980
+#define BOOK3S_INTERRUPT_NESTED_HV_DECREMENTER	0x1980
 #define BOOK3S_INTERRUPT_DOORBELL	0xa00
 #define BOOK3S_INTERRUPT_SYSCALL	0xc00
 #define BOOK3S_INTERRUPT_TRACE		0xd00
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3e5c6b745394..b95e0c5e5557 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1491,6 +1491,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
 	run->ready_for_interrupt_injection = 1;
 	switch (vcpu->arch.trap) {
 	/* We're good on these - the host merely wanted to get our attention */
+	case BOOK3S_INTERRUPT_NESTED_HV_DECREMENTER:
+		WARN_ON_ONCE(1); /* Should never happen */
+		vcpu->arch.trap = BOOK3S_INTERRUPT_HV_DECREMENTER;
+		fallthrough;
 	case BOOK3S_INTERRUPT_HV_DECREMENTER:
 		vcpu->stat.dec_exits++;
 		r = RESUME_GUEST;
@@ -1821,6 +1825,12 @@ static int kvmppc_handle_nested_exit(struct kvm_vcpu *vcpu)
 		vcpu->stat.ext_intr_exits++;
 		r = RESUME_GUEST;
 		break;
+	/* These need to go to the nested HV */
+	case BOOK3S_INTERRUPT_NESTED_HV_DECREMENTER:
+		vcpu->arch.trap = BOOK3S_INTERRUPT_HV_DECREMENTER;
+		vcpu->stat.dec_exits++;
+		r = RESUME_HOST;
+		break;
 	/* SR/HMI/PMI are HV interrupts that host has handled. Resume guest.*/
 	case BOOK3S_INTERRUPT_HMI:
 	case BOOK3S_INTERRUPT_PERFMON:
@@ -3955,6 +3965,8 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 		return BOOK3S_INTERRUPT_HV_DECREMENTER;
 	if (next_timer < time_limit)
 		time_limit = next_timer;
+	else if (*tb >= time_limit) /* nested time limit */
+		return BOOK3S_INTERRUPT_NESTED_HV_DECREMENTER;
 
 	vcpu->arch.ceded = 0;
 
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index fad7bc8736ea..322064564260 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -397,11 +397,6 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
 	vcpu->arch.ret = RESUME_GUEST;
 	vcpu->arch.trap = 0;
 	do {
-		if (mftb() >= hdec_exp) {
-			vcpu->arch.trap = BOOK3S_INTERRUPT_HV_DECREMENTER;
-			r = RESUME_HOST;
-			break;
-		}
 		r = kvmhv_run_single_vcpu(vcpu, hdec_exp, lpcr);
 	} while (is_kvmppc_resume_guest(r));
 
-- 
2.23.0

