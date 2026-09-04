Return-Path: <linuxppc-dev+bounces-26599-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4CFC624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:18:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNSb0sX9z2yvK;
	Sat, 05 Sep 2026 16:18:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788551503;
	cv=none; b=O5moxqjsKYKtbtY0v9sUpLoaQKOTA3227uRNJpTnnHi9A7/1VX4ce313Kd4CtDu33jxw0QxNj3DvlbKd5Dwef3mp1k9qGGxhyqIhyNXF0lain2OqfkMEJheMG33EHrWPNP9UNYGMFshad+h2Mv4E5qQQeK/r1gZKiDdae/WPtwX8sHs4w+yspLqL3W/iPCQppCCiez7TVhJnUCpnvlSUg7rD3diPzzHdjB3H22caaJ6+w93zT0M4Y0mPYRhITIphQEUWV7ks3wrmGD1AM+sWnsea0xPHcx32gpw+H234PIVl6ZaOOvj2Vky3MpfOTW3VQwwtry99hBjOuhmHqnbx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788551503; c=relaxed/relaxed;
	bh=Tq4f0YItm8Nzb37FYEFxDW+SOlv8AsSzRVHLQA1+cF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5cWUlef5E1HZReboraWIZnwIwx3D5IKWPm58JnuHPjLyyuXi/wkKGg5ro8VxKMR6PLuo3FC8fyzZo6fl/n1DPBWQ/U7Pj6xr/rTMfVn1onYQ7LVGWd/nxJYhSUAYosXxA3f4cUqL7qU5iM0RvY7gAZIBWpvRhhaz7UCfeUyDGld1LHBgk7T2YFqTbkKzb0K7HOrfffwHeRJ6vrzF97+MDvwoZ7XCDehr8N2FFqNHBT5g1aXQY5nrcLcX1bWgOLnOe7RK1wT4x0kKHtNW0hujP6GEtIH+RKTDKkT6OAn3eqi90AGCuCcOoey3C37JkL7dMgxjw+eZJT/X0E8duSrsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nOxJ9AUD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nOxJ9AUD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc6Y82SxBz2yqX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 05:51:39 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1062996b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551496; x=1789156296; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tq4f0YItm8Nzb37FYEFxDW+SOlv8AsSzRVHLQA1+cF4=;
        b=nOxJ9AUDu0tf4UDZfEAq1gmlYASiOexeaJ09fybNV24B5pSslW9QhLbjv7+8A7capM
         Lsr5UBVuDZ87sT+GeDAhhCWSKtzA36kOHEzIDCVcowpcFUdte2+YSsixs2ehSB+kjlIl
         8N86AMoVEiAi2l9Q7fX0+jMiAVkSM6WGsgmTtlLXZWzWa8fnjl7aM2WZkWguurvMiHLR
         dbeTNbp4tlTCm2pflIoHfrUhC8DKUlXP3MlJ3NzPK+3i1s7KlhMrwndtGHGl8zHcSUqS
         AxizvCG8hXPIpwIjKoHZj1u/EbAFrQengSVMNOGcDraIXg3ewVAiT5qxm0BEo1M9ca5R
         I49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551496; x=1789156296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tq4f0YItm8Nzb37FYEFxDW+SOlv8AsSzRVHLQA1+cF4=;
        b=IE9b0lSFffeLqxu6vPs1fGfjhcHLBfJo8TUD7rOoDBLpf43e0GmiX+SftDYcttjdf7
         gFLPnSxvxeeoGTc1TCt0LUTOhiwIX3IjSzAqyQk4IFdEYRnKOQ/V1pyMPNim+e4vcmoH
         7Azf7TQJAEwnpxgg2x/aRYic0hbskkFwyM9OpwNEMJcjSsHU/uE5x4aZOqIRO5Mwobor
         mqG8SevXgq5qfE4CL3oqFo7CUfV6ZrC0RTiBbqUNzEUf1/evfdrb2saeRO/DvhpqyV9G
         gh+Ht9H92nN7BFoj5K0HXbvDKeXxjIDnVOt/JJgWEEPDkq4t5V+An8LfH1TIw9h8YmVt
         BWvg==
X-Forwarded-Encrypted: i=1; AKwUvByebwb5bMGHHCcHnwO1CLaXer3jS8oAL7o7Omip5cDl3mXuuKLL5a9k6+8KNM2F2OvCiZtjHz7T7cNn/Mg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l6fShNb9cWZQP09RtqZbFsfabqOO2NPU7q605SErzO1BTxQTM4
	v2sCGT995gIV3z7leNzRjuRATYYusjfQtWIYx4lpxGucm60iGeNDQ0Fz
X-Gm-Gg: AYBFou03ytT0DAtZpQa/EUu78OanOxnSKtmnMci0lh1KyVpNAqo6e6vvPGoxZIGNmJn
	iKotf8lk9yT9MyfE9qF4Mxb2LOlI77iR7ufnaxH6yOoQWZ6HXb9JCGm8+DqnjQffEy3q0xqk9Fh
	xcvttgr5Gal57tlvR5t3/TMawlpjRp30mCUMFH0Yu2x7XqCW9wyAT6/TTWY0VnwCfHDmJnFZ47h
	8voiy1+lZx9kFLH3lq2oD1lfT0kOyBLN+gSWZ4sHE+5t7aYXx+WwiyIFHuIbFdfEnlLa1ycfybh
	uPeztnb//vv1eYVURjWr0SKudQ9JPc+3MQFhBVpotG8zDfo4eCVimqe++eYmjR5W7cLXgOQLp0J
	8Ecwpqlkstm+DWBQ0heEQ88IkNPwRvqnMkvi8J0YTKklGbk4DVkycgBEYX+7J9T2Ghumtayj1un
	7Y1HuiR9GecqLoaiyoJ/JdZvyhgE+4hWF7ydwYsMS++XU2ifJamKq6zt+TaDv5z/VmmpdB+yk3f
	KbnTk9IIRG1cccpd1fIXdFwPA/5NJu1CqIJ2HP7g62RkPzZEabN37Jv55x6tXvkVZrVMhyuQSze
	gj3OGlFoO1nEoNAD1PevVmrJQgh3zdptoN7PJdv++UDbucnOBvraVwrFzo+dP3Dc27NLORI9q2c
	=
X-Received: by 2002:aa7:88c2:0:b0:861:1acf:6915 with SMTP id d2e1a72fcca58-861676aa87cmr9593446b3a.11.1788551496447;
        Fri, 04 Sep 2026 12:51:36 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 1/7] bpf: Fix timed may_goto stack pointer for private stacks
Date: Fri,  4 Sep 2026 19:51:26 +0000
Message-ID: <20260904195132.141068-2-sidchintamaneni@gmail.com>
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

timed may_goto passes a stack offset to the architecture trampoline,
which reconstructs the counter pointer from its BPF frame pointer. This
breaks when the JIT uses a private stack with a different frame pointer.

Resolve the counter pointer in the fixup using BPF_REG_FP and pass the
pointer through BPF_REG_AX. Account for the extra instruction in the
internal branch offsets.

Fixes: e723608bf428 ("bpf: Add verifier support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 kernel/bpf/fixups.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 65b441e4a351..dc59501a32bb 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1797,20 +1797,20 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			stack_depth_extra = 16;
 			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off_cnt);
 			if (insn->off >= 0)
-				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 5);
+				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 6);
 			else
 				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off - 1);
 			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
-			insn_buf[3] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
+			insn_buf[3] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 3);
 			/*
-			 * AX is used as an argument to pass in stack_off_cnt
-			 * (to add to r10/fp), and also as the return value of
-			 * the call to arch_bpf_timed_may_goto.
+			 * AX is used to pass FP + stack_off_cnt as the argument to
+			 * arch_bpf_timed_may_goto(), and also holds its return value.
 			 */
-			insn_buf[4] = BPF_MOV64_IMM(BPF_REG_AX, stack_off_cnt);
-			insn_buf[5] = BPF_EMIT_CALL(arch_bpf_timed_may_goto);
-			insn_buf[6] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt);
-			cnt = 7;
+			insn_buf[4] = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_FP);
+			insn_buf[5] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, stack_off_cnt);
+			insn_buf[6] = BPF_EMIT_CALL(arch_bpf_timed_may_goto);
+			insn_buf[7] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt);
+			cnt = 8;
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
@@ -2661,4 +2661,3 @@ int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env)
 
 	return 0;
 }
-
-- 
2.43.0

