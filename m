Return-Path: <linuxppc-dev+bounces-26587-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5482C624D6
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:08:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNF24VZ8z2yr4;
	Sat, 05 Sep 2026 16:08:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788519490;
	cv=none; b=dBVGo7KWtlsRopa6rYdKbwJZ9pdVPX6wNhv9Gx+Z+PT5VjxzaNYAYZK8+O/qK/mYYK5iJVYTAdr8hA3D8/OxNiU/SO3hFlDItfMNMZoh6+3sbglIMsSQA4axSQe8TSIzxe9OCNKpdM2FT9NOlKJYzuQpC7+gFVooZXVrRaDcpCm3b4MaVw8VsQVtYjrkoS4USq73ptclFKWdYVYjbdByJTVKK1KNo0avuAcSXGk3+4bmpgwt7EXK/BnN584JYt9/rbQZx549rSVxHoEkpfc4/xQvzzjUsZhy58tb5XrIbWCCLSdCm4MHlWWbgHstrB9jkr5MGbue6m8OuebtkLzrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788519490; c=relaxed/relaxed;
	bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kd8LVHsOAvbwrm02LYG3kADnG0xHnKysJBvYRRIFgX0060VxryeRwJYuAOqPvTfkVEsbRpC3Ge15V5x1efKg0cIZUfriv5Gtn/a+j+JLqhAUjVafU+BTZno2Q1yuYwf30RhOPtN6IiBs+2n6Z+bYgDjOKO6D03FYmXvHG6ESvKEZHaFQaed48fuDYwrq0i4VPGzHQLmC4URcwxbo0MXEoEYwdlEGBk43EDWlqHpIHAv9O2DTzGc9vgJEfUZ6WTp+N+Z9OACLR9LUWtqJ4KPIeQLthfAW73/U8AwIM2D3RdeL+MNEHMGDpzR1FBrGUhPgrKkG0kjtOdvQYl9VqRVKiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S/yU/GVM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S/yU/GVM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbtjY58Yjz2y22
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 20:58:08 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2cace91f112so7651275ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 03:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519486; x=1789124286; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
        b=S/yU/GVMrUWh5MShEx98dO9R9k3L3tEc3Oxl3kK7sxnvUZfMwXZ4TI5pI1Z7yxkta1
         DASjhe/j2cqKle+VUzrz8lbVF5jJyDtSSirYVDgWytX53YLbKzg/Ad79Vly3EEjurXtO
         /mejUZLXykpwpV5fQCwcW3STjww/OGAZGcqG+8KkkcDp11Zvr2ASJi/yqw6/q0up4trD
         HdIlMpwstAfkbHkqVw7Kx3hLtgsYmIoPWImr6nrK1xDP8hwT1yIUNaa2X/P1ZQyjqk1I
         HrUtyyueunSJTMQ12+joSLHQa5WVlFtk3Fh7YRZd3bGnAhgrSQKFCxUnkdD8jqyFqnMk
         pFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519486; x=1789124286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
        b=CNCDbUj0LFMxN1tI2LPwxqhoJhLr9O+1vtspk7F/CVRqXXFbLNBjNAPYciX2zrPSw5
         6h+vsgiilHu/iRPphwUpCG94qcCJ5ldhhjBTJanJzREG5yr2CD8x4Nj1Lmq7ZW33JdYe
         s9WtZ7fR3shzmY6X2GvuIFYFyGQsg3DdM5UKC9hX12yTn4KknKCYhbDw10zCfuKhd4Bv
         oEwur47uFMsZq4I9n1TPY2qdJGuy6/MFfZA8EwmhEvKwUUOkfPmNd9iAOCPZSGCklyqI
         C217RIWJTFqDnr3x07sF6U3hdE9sWKxvu+IcHrOx1B8yCTQulPsvUUCvY1oStd82UakQ
         aWQw==
X-Forwarded-Encrypted: i=1; AKwUvByhR3jE+E8+rfM/mkK4FXjOCyvlobapgQVJ5j8+SIjRNxg1mC6NDe33N0AMLOo+LbbNAAXh4lGRMZpj150=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kdc4B6KkWczWAM1rLydIDwlWQ2pguURO8fceHK+leaHV25iLCQ
	KD1LKUbEoYhAjyzKM7IoD7uj0DehU87P9MXdk0jq5YQaNwv+bQm/bAP6
X-Gm-Gg: AYBFou0KUnaWOWmlb4IW0uWlWuOE8czSdyLWuuR4/AbrbF0tUmtyvJTm7k2Fl55PwTn
	5q3KkYB0XRRX6Ywbz+M55GP/LCAFNmhOikDWPkOJ8Z8IUuE3mfVSRG1yafn/oVW+RBZdKnx5jM3
	sznkafB4MW24xbGK/ueMiLLKKJRZGRC6We9R1zHPjHA4uddxMg/vCevBNus9saNggTunBu2ABey
	0eE2I214pSfPtk1Z5EqhjQtMIOFonNkVsnL3QLJfCzRDpag3dKK+3b5emhxXyjdQ9PbCQ1I/mzS
	TT9rDeQqBJDLUu6G0X4vDGzaUQCjReRFTvnxnNyC90Ef+1r81P8Rb38LDOQkkf2ksO7wMy68EtA
	xvp8UN5Kp6c6cMQY8qW4hL8XvRVYXSSSjYrAQjVuNmexe3O8gK209uBEph2YVUqUMSy+jUffFrw
	sxmfXaAvEVh2+tXTHUyo9o4fkW1z+XAIoQ7gcMkVRora83VjeepGOSagHhPycQt2KDqhgcPUFnR
	qxWyjWYD8XvGvQ=
X-Received: by 2002:a17:90b:3810:b0:398:9beb:5c18 with SMTP id 98e67ed59e1d1-39b26213a86mr7980524a91.19.1788519486242;
        Fri, 04 Sep 2026 03:58:06 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b123731sm5523091eec.18.2026.09.04.03.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:58:05 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/7] powerpc: net: fix typo "upto" in comments
Date: Fri,  4 Sep 2026 16:27:33 +0530
Message-ID: <20260904105743.39799-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904105743.39799-1-hemanth.selam@gmail.com>
References: <20260904105743.39799-1-hemanth.selam@gmail.com>
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

Correct "upto" to "up to", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/powerpc/net/bpf_jit_comp32.c | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index bfdc50740da8..cf8c1b49da25 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -23,7 +23,7 @@
  *
  *		[	prev sp		] <-------------
  *		[   nv gpr save area	] 16 * 4	|
- * fp (r31) -->	[   ebpf stack space	] upto 512	|
+ * fp (r31) -->	[   ebpf stack space	] up to 512	|
  *		[     frame header	] 16		|
  * sp (r1) --->	[    stack pointer	] --------------
  */
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index fc9db691e820..8a1a00026c69 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -23,7 +23,7 @@
  * Stack layout with frame:
  * Layout when setting up our own stack frame.
  * Note: r1 at bottom, component offsets positive wrt r1.
- * Ensure the top half (upto local_tmp_var) stays consistent
+ * Ensure the top half (up to local_tmp_var) stays consistent
  * with our redzone usage.
  *
  * tail_call_info - stores tailcall count value in main program's
@@ -35,7 +35,7 @@
  *		[   nv gpr save area	] (6 * 8)	|
  *		[ addl. nv gpr save area] (12 * 8)	| <--- exception boundary/callback program
  *		[    local_tmp_var	] 24		|
- * fp (r31) -->	[   ebpf stack space	] upto 512	|
+ * fp (r31) -->	[   ebpf stack space	] up to 512	|
  *		[     frame header	] 32/112	|
  * sp (r1) --->	[    stack pointer	] --------------
  *
-- 
2.48.1


