Return-Path: <SRS0=XXYE=IV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F595C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 01:14:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C376196E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 01:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C376196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F4D0k368Vz3fjV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 12:14:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=IfMVxfC5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=IfMVxfC5; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4CnX5zxJz3bwZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 12:04:32 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id
 nh23-20020a17090b3657b02900c0d5e235a8so9419572pjb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Mar 2021 18:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wnGO8xVitDb3sZlW1fnEu9cbFCdMiIUqXAxi4DxQqcE=;
 b=IfMVxfC5TUUKvoa+98PhuQkakBklyxWExpsMmTKLIVEH5ApXWj7xWEGyw8XDzYjqpA
 f7OwirFOz9Cs8irOyrSdBQ3EJs+KyvbBzqeGPLC57nZUgPylI+c824Bv5vpawstX5H65
 N7XsMEY14J69MDaBLV5apJidS1LfCJl9YY3KvBtz9dCB4Z+bX5AkoigyhZh38fML8xk1
 K/OmRCgCxIXE4FSVrZjCTBSSVQPuf15O/acHbin1UpWGPuLx2T5Q7elBK9tKUbQ6QuRF
 ixoiw7QhvlsTvmruH2NY31m56KRjQz4aKIdOWkYTeeUvzZPDKdVPtXGx5YbcDUsJhFLv
 7VOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wnGO8xVitDb3sZlW1fnEu9cbFCdMiIUqXAxi4DxQqcE=;
 b=Ibar193IhrPZ1L4LblbmR5bwGkODxBSQ02SWN22qWBcITIWREIuRz9YS9RVdd7kZtA
 4wl4WvRMAK1HLk8Qx+bXc0M7sqXRtobsVGkRFxH2ojamCDQhRz2oKI5Xrtv4S0+20YNA
 mxuwdWQczxFxH9Aphj5i+5C7Zi7tN88vN7oArl/Wyhp2IVX5dHZcKtQkCEd+cvYf1Im/
 OsIWc18Duu1ZV6MXBCR4tol39XF4gicrPGRWnWmtwBqsb8V3LAHiAkcGJfACpRD5BC5O
 dgkd1OqSCxiItgkPazrTXjj1EWmVzWP+y6V0s9i3b9vH5dg9Pu1FKJEUiCd3yTYOO3FL
 Cyzw==
X-Gm-Message-State: AOAM533SrIyBolt0JDu+mylLGb+d2PVQdoWS8xQ18lwISixcd8Fbx16y
 Dyc61qi/QOov3LtBKVKwlfI=
X-Google-Smtp-Source: ABdhPJwWxMXVrBMUiFwhDtZgryG8fMnzrxe6dwx7W5KFvJC+S847hqeoueuHrO5pOte0vOhS12L1HQ==
X-Received: by 2002:a17:90a:5284:: with SMTP id
 w4mr1697194pjh.29.1616461470914; 
 Mon, 22 Mar 2021 18:04:30 -0700 (PDT)
Received: from bobo.ibm.com ([58.84.78.96])
 by smtp.gmail.com with ESMTPSA id e7sm14491894pfc.88.2021.03.22.18.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 18:04:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v4 24/46] KVM: PPC: Book3S HV P9: Use large decrementer for
 HDEC
Date: Tue, 23 Mar 2021 11:02:43 +1000
Message-Id: <20210323010305.1045293-25-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210323010305.1045293-1-npiggin@gmail.com>
References: <20210323010305.1045293-1-npiggin@gmail.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On processors that don't suppress the HDEC exceptions when LPCR[HDICE]=0,
this could help reduce needless guest exits due to leftover exceptions on
entering the guest.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/time.h | 2 ++
 arch/powerpc/kvm/book3s_hv.c    | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 8dd3cdb25338..68d94711811e 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -18,6 +18,8 @@
 #include <asm/vdso/timebase.h>
 
 /* time.c */
+extern u64 decrementer_max;
+
 extern unsigned long tb_ticks_per_jiffy;
 extern unsigned long tb_ticks_per_usec;
 extern unsigned long tb_ticks_per_sec;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 8215430e6d5e..bb30c5ab53d1 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3658,7 +3658,8 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
 		vc->tb_offset_applied = 0;
 	}
 
-	mtspr(SPRN_HDEC, 0x7fffffff);
+	/* HDEC must be at least as large as DEC, so decrementer_max fits */
+	mtspr(SPRN_HDEC, decrementer_max);
 
 	switch_mmu_to_host_radix(kvm, host_pidr);
 
-- 
2.23.0

