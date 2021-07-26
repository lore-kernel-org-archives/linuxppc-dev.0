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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495D6C432BE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 04:13:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6356069E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 04:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF6356069E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GY63G4SgBz3jC7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 14:12:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=q0zvUm3T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634;
 helo=mail-pl1-x634.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=q0zvUm3T; dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GY5bt3CM7z3dFc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2021 13:52:42 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d1so2755553pll.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jul 2021 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uA8TbX3pYs2LbKbx2AqpBXWdMPxg/1XwQyLtHZ8k4pk=;
 b=q0zvUm3TdOgPeQLfr9sl7pSpHI3OiRrMO74Sa2ndO/muk12RQUeSUujFdcIE80IV7P
 F4gtTODUo9IguULkuthSrvAqvksQeHi9a2ud4K1wl9wPv5e31dnvzLQznN0gbEBWpZ4y
 8AZouMK2qFnGJkyFIeh/6kl3o8Z280aQ5Xx/burOJgp09wXcF/l4LnnVvK/dbXa6kB2B
 yMyxrW3DQjrEv6eybQeFtlsL83USLO/9JJRVpcH68YkMUm3HCSGT5phXnxq8t9ApUgRO
 /yJSOpFbSBYNQjTv2IwpcT20cz7LwuvTjrwSKf0r1NApVreyV0AYUk7F5nPiDnAR5y0q
 I5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uA8TbX3pYs2LbKbx2AqpBXWdMPxg/1XwQyLtHZ8k4pk=;
 b=k1UIH7VkeFQthF4yMHbTILwKJNkwIOjDJnCxeeBuGs24MeY+XxhbynDDbCtOeCD8QE
 hgxU8EnPgljyipoEprPWm3ljNj9Ob8EVMftZW1Urybq1H2cTdjpfgd6LKKnruOKKpIn2
 89BaxuVIC7VfQu/3JSSui+44A3PisiARQFPYQcLgUtVsWUiilPCaAQNy9AH0kb5gDu8A
 VXJhNPl4iMNmldMHP7xLktxV9WR+WXVzBGJnna5JNCmTmzT0qJ3rxqV6YfUsNWHQ39OB
 3gUqiOu9muI5HJUfA6a82RjvnuF6l7ucCZgpx18FyK0pDWEAXzWJeK/9gfa6tDG4zDx4
 AVag==
X-Gm-Message-State: AOAM533TE1GIG7urkWrn2bmvp2/fkncrLLK4JcJ5YSBhlWtYRUKgZv35
 Ite+Ys9k9dX6uNG113IOrhM=
X-Google-Smtp-Source: ABdhPJyDzzba2kzswPB+YgoKplhqURknNv8gSWMDKpLSXONGI2J1wXWOnb44s6R5WiFC76hLE8jz6Q==
X-Received: by 2002:a63:f712:: with SMTP id x18mr16448939pgh.389.1627271559976; 
 Sun, 25 Jul 2021 20:52:39 -0700 (PDT)
Received: from bobo.ibm.com (220-244-190-123.tpgi.com.au. [220.244.190.123])
 by smtp.gmail.com with ESMTPSA id p33sm41140341pfw.40.2021.07.25.20.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jul 2021 20:52:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v1 50/55] KVM: PPC: Book3S HV P9: Add unlikely annotation for
 !mmu_ready
Date: Mon, 26 Jul 2021 13:50:31 +1000
Message-Id: <20210726035036.739609-51-npiggin@gmail.com>
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

The mmu will almost always be ready.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ee4e38cf5df4..2bd000e2c269 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4376,7 +4376,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 	vc->runner = vcpu;
 
 	/* See if the MMU is ready to go */
-	if (!kvm->arch.mmu_ready) {
+	if (unlikely(!kvm->arch.mmu_ready)) {
 		r = kvmhv_setup_mmu(vcpu);
 		if (r) {
 			run->exit_reason = KVM_EXIT_FAIL_ENTRY;
-- 
2.23.0

