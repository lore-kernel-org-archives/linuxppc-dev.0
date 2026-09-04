Return-Path: <linuxppc-dev+bounces-26597-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E7AC624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:18:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNSL4N9tz2yyd;
	Sat, 05 Sep 2026 16:18:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788551503;
	cv=none; b=QtoepCXe/O1mjM13uj7FI4vFzfPmkbRR8DLc2Bey0vsXDNJH269/4+2JzhZAmeZN4McXgDUwFXpsTJq6+9f9yxjh+jI/g8EVB3gVzyD4VCz5IB7JpXpvM1xaELVlzDWLxNb+drz2Z/TGUTNHKA/tOt3mSIvtCBj3VTdYEJhr0dvJLs24xs0IsqD28nfFFksMlteE58U/sVmPqLqwudaoaKfEI4WNDGsZnJpnONRckHPKExU1Vtsalg1L9FZLFrcHMzaZp+U0JC3IPBJWcmF5xX4XEI9WoifgxxN5zQPlEAfyDvfz64OSb+xZ5mmBPGYhzQQSo9K7qCcqAJFs96+ZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788551503; c=relaxed/relaxed;
	bh=JhQhsQ4UfwQumqLXBrbDqGkg/NZUYL46Pvxy1S1ZxCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/lXssEX+rvRqEg+qMfCExh1tFXJAO3Vrv8CEuH6OdunqtPZgOcFfM2z7iSAHPvVahL88VUzi6l6ae2Lp0GyKSdx1NGswubKVzXg7kPE4nbPf3XevVrlHN04XmLRiaaeGq2kNH9e+mjyqo9Z0XHZoRZfiYb5kdhNDUsc6oggznyxhAecD5e+PI5XrzGu/jBQC1LTcB2jtIe6tZtlj2PKVKajMV4XkAoTdErrGSxi0t/92dK/7AtUcvUryCCT1eFQz0esOu5H4LKXGUDlDnXczHxT6STPGxgTMj17Gk2Rtxng5xFIsqe73nzY0iq4xtV0QzQb7OWhOfGu+0JqjmjE8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ILeTcTCi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ILeTcTCi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc6YB46zVz2yrW
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 05:51:42 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-85590c5aeabso1020620b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551500; x=1789156300; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhQhsQ4UfwQumqLXBrbDqGkg/NZUYL46Pvxy1S1ZxCg=;
        b=ILeTcTCixZLLFihUELkyA0hjnYHfYjNd5t8W+ZR02IOYTguHF+aDFK4kVzysYWnn1e
         mGwoEoL/ogmjpxLAitIvcrxBbL1+/HMTOAp9WXxe3ulraiw+21xQ8s+QHhPDm0QNb1YG
         AARiy7BUh+Iixi0M2GUTBh5VLIdzxi8fa4sBcNKuYc5zrXL7+gOB/V3yO7kSVjXqJGQY
         VxXDCDVxhkR/lN1YAdP5CNj28ffjRK0m9iKYJ1WU6eAOme3HO/QxRNp0+Q9z+ZViyHMy
         Pa4FmvJzXXs7H1m6kNPv6MpLOyFCotsctdI575SdfnKw6YFVXX9KHOLLr7f6k+DoHCeY
         S+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551500; x=1789156300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhQhsQ4UfwQumqLXBrbDqGkg/NZUYL46Pvxy1S1ZxCg=;
        b=MyoFw5VSWAfX84OxVXZlbuI+1TuzYX+uQTOz9cuDFCDh4o+HGlSdAOItMJZ+7FrR8d
         RN5lnHSAlVABsswdR2apSfXv+pAsY9qEj7nKZ6A5zz1xdCev6ew7UD+IDn90vbrv+W5G
         AhyU7vNluH90uQH3/bFIFm7lwChFHjqulqwStmgLMzvWmaX9eZRtmiTeOM2u77VzlByU
         hYlQxY/x3tqEhMwrkxv9FwbCCEcHhgqraFlEUAYgBy+ISWXj8b/HRbwO2W/ebM5PKyix
         G4G/aKZcdK1dcagvXQwmArHieV23djOWSbuhDcRO5QKYLvjcQxp1/1jXFWSA/rQo7y+Y
         sXzA==
X-Forwarded-Encrypted: i=1; AKwUvBymfDdieXwwHwl0x6of6fAEjGcmw4dc5011tXflvomU1Zms6+W+2lNLb3n/B4rDTv5JyEBcH8wpXgQh1To=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lNBfHCAcaOO1GlUMj1RJd9lxYEAcr4Mnwm+c7XAnvBGZEicVeo
	CPfL4OS9GiRRbiLF3pr2W72UskcaXoU0Y/O/2YZ4HVYT1kYy/ouUkNFx
X-Gm-Gg: AYBFou08OW8L+3fQbDNeurHDgav/ILCYO0S+HI+Kmbg8oOl9Vn5A67zvUYr+H14rmra
	x6a1GYeWzxBUBiYhSGUMvh6nDVQ2LslvQ9/iZHPynJSoiOqkUsEgVwSuvyhKVIe6VuyhqxrLmxn
	RcEO62g58w7C5f0LWYlGN+vP+yWEuM8mWV2hNINSoEvUPgw/T/0ZHOavBi5dGzCFLVcbyQNWsdi
	60oPmPXyyEODF+3M21G4Iq8hknxSnp54k5s+P/ffvyU5M48PUrPwLyJHxCFHAvHq2ShJrTsGZ3f
	/lN6zCWu+rB5eGJElQzQ/2wGcHkYK7kgZTCrmdDKIC105/oanDvN+zRWuGvjM7aZ0RW8ri6HSyV
	V6LRHU2+nDhOv474DTwlQwz+UQZ6Ay18CiqHd5XeQKYuqZs56DNaX75rXIVDhY+m73IRHvlsi5R
	3jICbiTd+BiJRAQlMfr8KMuQFuH8aptoJLgVpHTYRuZUJNShwa0h40TkLdwfn6eZMKguPYTjmTX
	HXBF7xbQK6dq1q0Fc74zPtSpon5R4haXsAbd+Xr1035v7P17YQFKHQzJcTCzv0ou/+I8yaVD0TC
	NdROIaXbOVwlBEdHVLJYJcyd8tYX3rHIdWAFn/boVoxmjrMOaJN1f3+0Yi1MlAkIadZ08Vdfu3I
	=
X-Received: by 2002:a05:6a00:9286:b0:84f:77cc:63cd with SMTP id d2e1a72fcca58-8616a06be4amr11190015b3a.17.1788551500394;
        Fri, 04 Sep 2026 12:51:40 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:40 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v1 5/7] bpf, riscv: Use resolved pointer for timed may_goto
Date: Fri,  4 Sep 2026 19:51:30 +0000
Message-ID: <20260904195132.141068-6-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904195132.141068-1-sidchintamaneni@gmail.com>
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
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

The timed may_goto fixup now passes the resolved counter pointer through
BPF_REG_AX instead of a stack offset.

Copy the pointer directly into the first argument register rather than
adding it to the BPF frame pointer again.

Fixes: 6ef8ff20c30b ("bpf, riscv: Add support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Assisted-by: Copilot:gpt-5.6-sol
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/riscv/net/bpf_timed_may_goto.S | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/net/bpf_timed_may_goto.S b/arch/riscv/net/bpf_timed_may_goto.S
index 02c637d87420..8c03e272e0bf 100644
--- a/arch/riscv/net/bpf_timed_may_goto.S
+++ b/arch/riscv/net/bpf_timed_may_goto.S
@@ -6,12 +6,11 @@
 
 /*
  * Trampoline for the BPF timed may_goto loop bound. Custom calling convention:
- *	- input:  stack offset in BPF_REG_AX (t0)
+ *	- input:  count and timestamp pointer in BPF_REG_AX (t0)
  *	- output: updated count in BPF_REG_AX (t0)
  *
- * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI, where
- * ptr = BPF_REG_FP (s5) + BPF_REG_AX (t0). BPF R0-R5 (a5, a0-a4) are saved
- * across the call; BPF_REG_FP (s5) is callee-saved and needs no saving.
+ * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI.
+ * BPF R0-R5 (a5, a0-a4) are saved across the call.
  */
 
 SYM_FUNC_START(arch_bpf_timed_may_goto)
@@ -28,7 +27,11 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	REG_S	a3, 1*SZREG(sp)
 	REG_S	a4, 0*SZREG(sp)
 
-	add	a0, t0, s5
+	/*
+	 * BPF_REG_AX (t0) contains the count and timestamp pointer; pass it as
+	 * the first argument in a0.
+	 */
+	mv	a0, t0
 	call	bpf_check_timed_may_goto
 	mv	t0, a0
 
-- 
2.43.0

