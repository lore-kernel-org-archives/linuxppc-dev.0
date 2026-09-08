Return-Path: <linuxppc-dev+bounces-26718-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1EEC79F9E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 05:49:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfCgd3zjvz2yjp;
	Tue, 08 Sep 2026 15:49:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788846573;
	cv=none; b=Xj3+Jbx7aAnPzjUB4ERT606qOljXQfh2sxe+K8QxZQZmCbg2lw0ym1R18gQxAP8Dvw5C5mq63gaOxLweXkJVxJCVb+MBgANUEs9aQoW6GAW/sL0vhNV1h9VGjypy3MHRHcbjuwnWLCihXQShcdFhhPMY5VxXPS7LqmRa9qT6y8y6hOcrS8/cVLsjYfqi4OBYPu0WbBE1rsd8CsQ6fb+aHgN8JyXOzU/tIIkiIl+4SeR5hnOyBDgkeZ/GfLBNysmKqORqOJzR0iimOHh8aC5oBENWBVvJ+V1eP2PmhkQDYjjbWWNDoSlBc9igttubu+ugLWX1AQNONLAIIHZnxXysZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788846573; c=relaxed/relaxed;
	bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6kv9PEIsnTH0u03QoDHGEcbii2FFngPXbqZEotUEOo9MQ8lLHTNpRfzyQE5lUfUPhpQ8+twZx+IaEPRZeXGPuxfE9umiBl2y2jXDINUEnoz2Ki3YTN+e6KslpoRtQ0DdWclXABmlHYwQqxedRPZcogITjxYlKpvUSAgyylLjJigMdwnTB5WL+oSgaWFMOdQl1ArkLokdPr+JxaqDW/puydLB32y3pYOlg9OoNs9mXW/v91PzajMjbebPYQA9RICXRnAXf+WvxUBlZ/SmQxEC9KqGBjBAx9tD+2Iq3W2cSjJaD2hr9xAyVV6J0NE52sK/xQ/hgZITIzzqLF6DrAhkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SbyOogBV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SbyOogBV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfCgc4S8bz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 15:49:32 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2db710396ffso5600585ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846570; x=1789451370; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
        b=SbyOogBVhk5fOD3UO+l3T6M1XO9kPvyEh3yC/Ara5GWLECngHVqbnn/JUauhouLGBk
         x27fccSf3IUm+hq/mwEs+YYXtUAkUC+wZjjt4Kpi1Sy/RXrRHYviwFVwr+1by3++y4TX
         cj+5GG60pyPrCxzsAEEazEBZfgeMp40bVd/A6iC2zfTdRT8xZdLqiWu19Eub3vE9kXya
         sPpYdBrHCeUK06c7OIKRAGxKSeoiiDr8ZC6DDooEnk1H7Wid/3He8dOp8k3VdO+dWkPW
         bWnYyCGLLGBREAymeGVKdMuvlgIEt4hiaEpzsx/0V9JHTybXgYewMi0zkFn7tUNLwv1I
         NG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846570; x=1789451370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
        b=KwCIa4TmxoZEG17onDz9CCHptK/J1G6o6qNC6N2WPFGjwzS6oX4yuIBnKOVBVyWVqd
         lUrWQd8+ndb8D2ZIJs/3bv/5nfN+3osnoX1+PpRmYbmOjnd0QdAKV3T+J38pKIIzhmml
         at3VcMaIWCnHyDk5b359MQcMMt+LRra5xAnTdnn2SoMOvkaF/KbZDtW2aWK0UXlojBGl
         mFq1uKESEotJNyVXvpzYIbTT1+y+RIA+LKEzBae8ONam74gFAykFidI7qwPob4fWbFXw
         ooNQnz0CAlsRchBGuLpCldrSeIUBIUEnu/j8vBH87zZRY54Du1LOCS9Y1pGrQH9LF/ky
         tByQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhfeDBGFY771v+aKLfxaPYupcVcirAC2QlGrheLAk+wEDL+hxZQ5+Df81seF5oFE7MUTvZEfRenwGpyCs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lQ4ZR6xuHLDVCaPvoXyPI37iQkJHIsWc5qZJBWOwVjE7cot2uf
	UDryd22p7Nsi0842mkq3Hi1gZiFUn6Hm5p7PC4fw0aM85n1+EnZyZS4N
X-Gm-Gg: AYBFou3V6MJ6bDHd9dG3S7by85Vhxd8UjSRlZ7bGKQKp9HqJYHFYs7LdldOZ0bhIPaq
	eXIeU3ZBOytocrHGPbLeH8a6bHgsCRmLxO07y4EhjJNKeNlcyLRkhqF3NsRJwA4j6JEwKd8NOVH
	qzORyMw1+G5kzToH9yBBPE0GpDIzGP0BqogDWWeNXISm3t+4s23xKexBMWWcatdvTtqynWQ37YC
	FutVzbaKj6XiBIjLPs0AYpPz1nWtgQWRbQ3HGYGtszQAZ1uvhpkeDUAM/preXSsd9JRMHaPloj6
	sgX2+D+N9TutvHKQf4cVNOCO+8cps0rMK0xnA+ju3l302ZGM4PuqikacQk+neKequR870P7jMyZ
	P5FR4p3i0blp/+LuGonU6MNk21QT/HTtppOC0zGuho3XX3il1s50NmSQiXG4pBp/MZZUE1VFsub
	4kuasbTPICS0CzXR/Qa3D9kcj5OWsSl+sS7Ff+Tyiy8BAGm1yFyprFXynVSkBmAx0tEaJPyduKT
	jWZYTt8nBidqQ==
X-Received: by 2002:a17:90b:28ce:b0:398:a649:8fa3 with SMTP id 98e67ed59e1d1-39b08799871mr33943718a91.23.1788846570489;
        Mon, 07 Sep 2026 22:49:30 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:49:30 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH bpf-next v4 3/7] powerpc: net: fix typo "upto" in comments
Date: Tue,  8 Sep 2026 11:18:49 +0530
Message-ID: <20260908054853.13820-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260908054853.13820-1-hemanth.selam@gmail.com>
References: <20260908054853.13820-1-hemanth.selam@gmail.com>
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


