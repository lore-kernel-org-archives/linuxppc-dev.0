Return-Path: <SRS0=//ir=JJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819B2C433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 01:51:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6686102A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 01:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6686102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJWt95fTdz3byn
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 11:51:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=VvzPE5UU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029;
 helo=mail-pj1-x1029.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=VvzPE5UU; dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJWql20vVz30H2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2021 11:49:07 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id
 ot17-20020a17090b3b51b0290109c9ac3c34so7915269pjb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Apr 2021 18:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uGMuXcs706W1WbX3G4YQ40n7ZTHeko237s34UogQXMQ=;
 b=VvzPE5UUHzeT7qXKTS5YzcuXeU6aLDKX4JEikAx22eH4s4ilVaqIhdRIRZ+VK4Dl+s
 zfzb3Eq0tzAxQ4/Nb1G6vzS1uHjfzWMLBzSlvWvQAegPa2OLEiNSwtQztnKx/aCglv9g
 uCIk7l67Un+mw0HtiGAP4UOMQA2qWsojBsyEoD0K5+SbtPjojdq9F+nBdmTBEVaAGxBt
 fPtg7kNcc5dpjrLaH/Kc0KvzCLZrTvAzBeyzntAckqHRLZ9Yj79PaK5sQJYcTx67ODkM
 RpPL0LFuhlQfOSITvdrSrTnBMcVnXfpbTcwKKRWJQUOzLJfk84Sq9/hFRORLbFMErfJj
 6InA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uGMuXcs706W1WbX3G4YQ40n7ZTHeko237s34UogQXMQ=;
 b=QjMSnDHc6EgJVxMW53MWQjKNBQdTcQdQb/6C5if4oiGmFQIjfaNO8PDNoeuXagX3Jt
 ns8lzOfSvjKQvTMKAAyM/NZKA2yD7PMMVy7+yTLb1s7DlP6yMIUXLVKJ7vGPIbdsecZ+
 Z9tzT25OwDJYAmPmdl1fCpniph8AUdBNxACrjKcrsO27L8XIPBtlAICFjTA5b6sM6V4D
 W7HCdLMW0lP0g0oZi5QOgJ37ZnfnKQQxfFftStIUZReaUmdQmwBRkBZMZ2ZKnfrtyFlF
 7lt8iU/oJqHcwFxBBG4JUuUw+U3yHEw7pf+wxGwdE5fy8gGoXVRLLwn3wWXE32EP0sMK
 F0ZA==
X-Gm-Message-State: AOAM5320DVAJ+Kgw1fTsZYikLp86m5RR6nKzG5TTR4oe5/Dsl/8qhMIs
 peieriWYaZiYR1vGA7SI4RI=
X-Google-Smtp-Source: ABdhPJxowsYUEbRFMRe0mazdV/T9VA4uysRjEZ1Cu9bz/VPnPbSdw4JNr0uDSTPsboXRnc1kPjALeQ==
X-Received: by 2002:a17:902:e803:b029:e9:1f79:2427 with SMTP id
 u3-20020a170902e803b02900e91f792427mr24307901plg.21.1618192144662; 
 Sun, 11 Apr 2021 18:49:04 -0700 (PDT)
Received: from bobo.ibm.com (193-116-90-211.tpgi.com.au. [193.116.90.211])
 by smtp.gmail.com with ESMTPSA id m9sm9502345pgt.65.2021.04.11.18.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Apr 2021 18:49:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v1 04/12] KVM: PPC: Book3S HV: Disallow LPCR[AIL] to be set to
 1 or 2
Date: Mon, 12 Apr 2021 11:48:37 +1000
Message-Id: <20210412014845.1517916-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210412014845.1517916-1-npiggin@gmail.com>
References: <20210412014845.1517916-1-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Fabiano Rosas <farosas@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

These are already disallowed by H_SET_MODE from the guest, also disallow
these by updating LPCR directly.

AIL modes can affect the host interrupt behaviour while the guest LPCR
value is set, so filter it here too.

Acked-by: Paul Mackerras <paulus@ozlabs.org>
Suggested-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 268e31c7e49c..3de8a1f89a7d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -803,7 +803,10 @@ static int kvmppc_h_set_mode(struct kvm_vcpu *vcpu, unsigned long mflags,
 		vcpu->arch.dawrx1 = value2;
 		return H_SUCCESS;
 	case H_SET_MODE_RESOURCE_ADDR_TRANS_MODE:
-		/* KVM does not support mflags=2 (AIL=2) */
+		/*
+		 * KVM does not support mflags=2 (AIL=2) and AIL=1 is reserved.
+		 * Keep this in synch with kvmppc_filter_guest_lpcr_hv.
+		 */
 		if (mflags != 0 && mflags != 3)
 			return H_UNSUPPORTED_FLAG_START;
 		return H_TOO_HARD;
@@ -1645,6 +1648,8 @@ unsigned long kvmppc_filter_lpcr_hv(struct kvm *kvm, unsigned long lpcr)
 	/* On POWER8 and above, userspace can modify AIL */
 	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
 		lpcr &= ~LPCR_AIL;
+	if ((lpcr & LPCR_AIL) != LPCR_AIL_3)
+		lpcr &= ~LPCR_AIL; /* LPCR[AIL]=1/2 is disallowed */
 
 	/*
 	 * On POWER9, allow userspace to enable large decrementer for the
-- 
2.23.0

