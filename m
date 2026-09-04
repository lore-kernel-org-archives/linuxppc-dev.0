Return-Path: <linuxppc-dev+bounces-26601-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EF3C624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:18:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNSs0DSzz2yvT;
	Sat, 05 Sep 2026 16:18:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788551505;
	cv=none; b=GTia8qFSNMO/hWKfMeBf2N9ewC86iCX4IXX1Msf2m9w3rj0tdgWP/7LfdhT617R/szP1AlvlNCHU6iw4T+VlS9pWDpve8XZHEUfrPZz5MHmlliNAKe4AL1ZipKlAHgdgHqyrTv0QBdLiKCA8Rb89Cg3ESqM2F/1TkNH50Oz/JxhPNkej0e3/gmlqXad4fqo+5TvYWOk2K1PvLjWB7k7sf3/YdHxMPe3/zsk4UDL3iS6/FBLsRsE0bUvxMIOlCR7GCOJ3CksTlPiYIEKo/1qbBrn70F0RPWePQCcXD9JBgZ9kMEUp+g+odvexMdzUXOa6/NFeRgILolhA0Dl2Gdvjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788551505; c=relaxed/relaxed;
	bh=DQCTqvUlSwcygaUD7WF/GhyApu6o4em2Qqn+xndUeoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuuQribw7y7sPSuC4YhIzpr0rzPKRH2geNQ+neFFCqf+jCLi8vaE0E5AlzJpD2LcBs3MtHe1wdNjugDIS2PGAqnfiRNaF+g78iRhMBWSbBnWu4CMHEIgPcAMAcQv/OuT8GSF/8vtDbZYv7N1AExMjS37dfq6Lwk8cPcgvZca+2O7WIGNdZf90RHT8h0THdP0o2xXzUmrJXcuXQiFme7mINApN3IVB3Q/lxqFel5QEVa6RNhYI4uQLjjyMmiVK2d876wQnI+yyUaWYG1ZrYkkE8kDAIFKGTOPCnWXCweZlqHvON1gdcJ9VXZ0HEeFgx+w2XqpNlpjuYsk6rB/uO+MQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r4ZqZOVN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r4ZqZOVN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc6YD56v2z2yrW
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 05:51:44 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-84e27035206so1228973b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551502; x=1789156302; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQCTqvUlSwcygaUD7WF/GhyApu6o4em2Qqn+xndUeoE=;
        b=r4ZqZOVNUUUxUzQ2Kv+bOFwR72A0TNioKZghrdKDVAkUkImjRdiZgRCBVWk0oz3BwI
         7O9W66Y/hEdYJ4gs73jq6vSKFUdMFlPLrgGiS88bYY118PPlD6nrnf2y6IzZNeZhNb+0
         ZLRA4jGmbfsWvj+yrPfWF/kT68PzM65aPI9BEpyDuwS74Ec/tjxOSCVMrrHBRJdwF6q2
         7N5MbtoINzY5AZ50BPhEHDG622n6XINlSWtgNxHzRL2DgtnUVeCD56sFchYMXstYm5pP
         O/wKCxr9O0V81Kg8LJj7ir/DQABuStvLuyZfn1PTqeJSoE+zKrtTHu0g4eGhvcEv8d34
         mEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551502; x=1789156302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQCTqvUlSwcygaUD7WF/GhyApu6o4em2Qqn+xndUeoE=;
        b=qiwHNbRRzYXPM7bc23Amqc2KRqepUR3es9gEIPzkRoB5xVcvNB8JtL9p48YETwzLXF
         AGHoy8YYRoegynBGGJS98DIB8zrtZ3yfz8Ak8+/hjd0mpqRuT8nZtQYBmvvWmGQid4mK
         LArjVVDQHemmzJ+dGBUW3uLXxcCdXVHYlwMgge7aRbCr9EFRAIYcSX2Wy19a1+43aZwN
         SuzEn+S4A+alviaSPq55UGqF7ane+JNrmW9Z8z+XwlyWrhjQPyzxQIz4H6HlIyLe5XT3
         is5Yg3lsh/COdXLHkhx5GNaVPZGwt0XVtRGBpHESiriJyuiuT6Qpzsi87A/pNcbfn/eq
         gq4g==
X-Forwarded-Encrypted: i=1; AKwUvBwL/7YyeVk4Z+Yhk/Zwr7Va3ub+FS6FzjbPCrJW+NBjsVSKfE3GXOtfJzIWhaI2F4Ikr2KOi74zPsAaMlw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kMYlF3oxhB7UbHfpM3Wm7bv3v0OQOGjEKeWi3Tuyx+9F+QoUH5
	yMx4KM3Uh1hxSk1Vc9ghWy9+F9/sZ1ofPBG2iLvXEkd4jTKNkIaqN/78
X-Gm-Gg: AYBFou3jE3Z7TKoQV5PZ3TM+IjBWrlKPcSNRUrZYrzKrN2CzgM/BspiP7GD0NkffOe9
	jOcQkxhbw9PZv70SPUTMO8iGQ641r88pmQQ9tHsVYUNOl7eCYQyChIZSWrtMhypTFYBFO1A3GAp
	tsVCKtm8S81hLF9uSEZRdp1oW7p1l/B2HwJMlXbMl0lS0p3lvhiyH1DQxRT6xrh080KAinar3ge
	A+fTXvRJcrY4g1aLptwY5QjupQFV9u6XLT6S/O3LGkSU0JILuvKLYfVhZpyLSouD1IWbt3ezN3M
	2q/9SErH6rutcFNo2zxoqsJ1S+HbSm6gEGNt0q+n/LX025BguMoV3ZqwAozdxIB+eA2gcfYQ2A1
	4bnGCF8YCx46xxJfXRxf6UBSMqKzC6WwhaHOeJwOLCNH4tvKMcZUuR99h0K3cAIrQQdGJ+UcOol
	Nmy5hdjg6xiTkWKZCG/SdXYj1U2Wh//gtGcfCTPGe1EkUfYar0OlsfJtCzuRfcCZs4/s6knew/B
	G1z/h+NllA5eue6eTWyzfaZ/ajYXBTqwOD3YATz1j3DY+pPM1xSTOpbtqG7O3OCiVqPZ/F11a06
	Uwh9YGynC9CtdPk966VqhmT93n2SmOUfFKCyh4cm+sdB5W7f1cqkIFfS69xKj/BX8YgzVseevtc
	=
X-Received: by 2002:a05:6a00:ac8a:b0:857:726d:2e9c with SMTP id d2e1a72fcca58-8616b560a78mr11539240b3a.25.1788551502338;
        Fri, 04 Sep 2026 12:51:42 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:41 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
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
Subject: [PATCH bpf-next v1 7/7] selftests/bpf: Test timed may_goto with private stacks
Date: Fri,  4 Sep 2026 19:51:32 +0000
Message-ID: <20260904195132.141068-8-sidchintamaneni@gmail.com>
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

Add private_stack_timed_may_goto() with enough stack usage to select a
private stack. Check that the JIT uses the private-stack frame pointer
when constructing the pointer passed to the architecture trampoline.

Update the translated instruction expectations in may_goto_batch_2(),
may_goto_interaction_x86_64(), and may_goto_interaction() for the
additional pointer construction instruction and adjusted branch offsets.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 .../bpf/progs/verifier_bpf_fastcall.c         | 30 ++++++++++---------
 .../selftests/bpf/progs/verifier_may_goto_1.c | 17 ++++++-----
 .../bpf/progs/verifier_private_stack.c        | 19 ++++++++++++
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 328cf630210a..c5996d9dc8cc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -635,15 +635,16 @@ __xlated("4: r0 = &(void __percpu *)(r0)")
 __xlated("...")
 /* may_goto expansion starts */
 __xlated("6: r12 = *(u64 *)(r10 -24)")
-__xlated("7: if r12 == 0x0 goto pc+6")
+__xlated("7: if r12 == 0x0 goto pc+7")
 __xlated("8: r12 -= 1")
-__xlated("9: if r12 != 0x0 goto pc+2")
-__xlated("10: r12 = -24")
-__xlated("11: call unknown")
-__xlated("12: *(u64 *)(r10 -24) = r12")
+__xlated("9: if r12 != 0x0 goto pc+3")
+__xlated("10: r12 = r10")
+__xlated("11: r12 += -24")
+__xlated("12: call unknown")
+__xlated("13: *(u64 *)(r10 -24) = r12")
 /* may_goto expansion ends */
-__xlated("13: *(u64 *)(r10 -8) = r1")
-__xlated("14: exit")
+__xlated("14: *(u64 *)(r10 -8) = r1")
+__xlated("15: exit")
 __success
 __naked void may_goto_interaction_x86_64(void)
 {
@@ -676,15 +677,16 @@ __xlated("2: r1 = 1")
 __xlated("3: call bpf_get_smp_processor_id")
 /* may_goto expansion starts */
 __xlated("4: r12 = *(u64 *)(r10 -24)")
-__xlated("5: if r12 == 0x0 goto pc+6")
+__xlated("5: if r12 == 0x0 goto pc+7")
 __xlated("6: r12 -= 1")
-__xlated("7: if r12 != 0x0 goto pc+2")
-__xlated("8: r12 = -24")
-__xlated("9: call unknown")
-__xlated("10: *(u64 *)(r10 -24) = r12")
+__xlated("7: if r12 != 0x0 goto pc+3")
+__xlated("8: r12 = r10")
+__xlated("9: r12 += -24")
+__xlated("10: call unknown")
+__xlated("11: *(u64 *)(r10 -24) = r12")
 /* may_goto expansion ends */
-__xlated("11: *(u64 *)(r10 -8) = r1")
-__xlated("12: exit")
+__xlated("12: *(u64 *)(r10 -8) = r1")
+__xlated("13: exit")
 __success
 __naked void may_goto_interaction(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index db7e30da234f..1721897160dc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -90,15 +90,16 @@ __arch_loongarch
 __xlated("0: *(u64 *)(r10 -16) = 65535")
 __xlated("1: *(u64 *)(r10 -8) = 0")
 __xlated("2: r12 = *(u64 *)(r10 -16)")
-__xlated("3: if r12 == 0x0 goto pc+6")
+__xlated("3: if r12 == 0x0 goto pc+7")
 __xlated("4: r12 -= 1")
-__xlated("5: if r12 != 0x0 goto pc+2")
-__xlated("6: r12 = -16")
-__xlated("7: call unknown")
-__xlated("8: *(u64 *)(r10 -16) = r12")
-__xlated("9: r0 = 1")
-__xlated("10: r0 = 2")
-__xlated("11: exit")
+__xlated("5: if r12 != 0x0 goto pc+3")
+__xlated("6: r12 = r10")
+__xlated("7: r12 += -16")
+__xlated("8: call unknown")
+__xlated("9: *(u64 *)(r10 -16) = r12")
+__xlated("10: r0 = 1")
+__xlated("11: r0 = 2")
+__xlated("12: exit")
 __success
 __naked void may_goto_batch_2(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 3d9994a52464..639b53363c9a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -70,6 +70,25 @@ __naked void no_private_stack_nested(void)
 "	::: __clobber_all);
 }
 
+SEC("fentry/bpf_fentry_test9")
+__description("Private stack, timed may_goto")
+__success __retval(0)
+__arch_x86_64
+__jited("	movabsq	$0x{{.*}}, %r9")
+__jited("...")
+__jited("	movq	%r9, %r10")
+__arch_arm64
+__jited("	mov	x9, x25")
+int private_stack_timed_may_goto(void)
+{
+	volatile __u64 stack_space[16] = {};
+
+	while (can_loop)
+		;
+
+	return stack_space[0];
+}
+
 __used
 __naked static void cumulative_stack_depth_subprog(void)
 {
-- 
2.43.0


