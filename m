Return-Path: <linuxppc-dev+bounces-26639-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EB8C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 04:52:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdZRy4KNcz2yvv;
	Mon, 07 Sep 2026 14:52:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788756734;
	cv=none; b=j/e/vucBj3yb6PwbJM8bi+Ik2cdZSzIzjw7QqnGTNtj9n176lywG9hGn3PxzIaAAAzwoXBW0UHXIiYf1WK30jYu3Qm4Vol+go4lKSuqiMCCNCd/wkCUhRcv9oQYJVVhWIofOBG4KRBUgcNbeB4Sdjp3R6EuQ3zZ1MkT26qEc8ovr1Z8DrAS9Q6XbrFSUJcP1Ak1QK8wE0PU/GS1o7O3CQ+1IyNMKLM5dWXxPvvunaU84/eTQRn0/JGNddua/UZrBsShdPVDB9fGU3rs/sBoQxV4qrrm7vplp1Jad5b2Hx8Va94e6trYJRmqLxW5ufM/Uin7z6wC1ufeObpsCBqsgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788756734; c=relaxed/relaxed;
	bh=lGe5bwb/eYgn9AMup9CCvH2ogR87NmRNuEpL6c/z+js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScH3AzBFfnUZOMzbMGiA6RC/urDgeXLLBNBUMfvQn7e/mgFsGm3pGqTLLED3KIyts0E1pAl+YZ4FR/yL/EiEUMxQ3qa+MII0iUsaIo2cX9MuO/oL3Ht+G3UInEPfRQoszPMzubkBzTxJ7VIhBuybkNfJc3vtEwtV1vBfsrVm0DmLKZ7J6YjAz6p2vguJB9HNWb1Y4sEcYxnYwn2LoI0dnQG7s1wX8JLvfIbtn5mKfk9DgwtpQFWze60HymVDiASVB9LBmc9A3KaR4m80JyY9bJvqXREHhJUe8I6M58V8z15M/0Cwa9YlNQ7RFPX/ZyA2z8lK8JMoMK5/vRLMjeuqdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p8EOurZy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p8EOurZy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdZRx6y9Tz2yvj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 14:52:13 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2d032846c95so33907655ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 21:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756732; x=1789361532; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lGe5bwb/eYgn9AMup9CCvH2ogR87NmRNuEpL6c/z+js=;
        b=p8EOurZy526TfDdFb91RuaAlJUIgrabjAxBAL4EBtlOfl7OlcpIFK1t3Jz1VDQ7V7z
         y6TYBCeyNKkX1Qg2UsxNOU2XbxMJlaPAyBDy/scDQxjrrSO9zdynu1LLYSfixabQ0ZYK
         A0f57F9/QiV+zktTYxE9xUKdARQifYlDyKSDv68iey3A0EvdE7gfcZ22kA+Di5cF9kA+
         WXpIO0mxQ/jz0WjAxgHc24VkddqGWrT+Km9bRVt81YW83KNM+lElccmwH8muSbWRwexW
         8BdCP0YntjcllhO65ISZJjsrchTNMTqr17CdLLD3iG1OGiEbRk2YBdufW8VhFmlEtCvd
         vROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756732; x=1789361532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lGe5bwb/eYgn9AMup9CCvH2ogR87NmRNuEpL6c/z+js=;
        b=jK7OJFvrpgdDIf5QKBEdVQ5JHbiUfXjgyFLVeRdmMAc4qmL0ARdfwFTIu9XjHYIFRs
         kUAtqLezIya6Q/p0/91ERX2k01+qFAbwpNmJJSgFrKwRVTSzUz98tImWvzqg+ohe8HNJ
         ip0TwY2KjGVLIjjhZh8Na6FfCKb9U5aTx8SWNuuFyjGbu23MkSpGLLzLTAZSDgc5ccsG
         OQUGc0JtGrNVIxFeFj4/sETM8u8AcedE8V+4mhNQ+Zo5vhQllPL/DWEIExn0PjeedukB
         eN2Pgbep/rwP3iMTIhi61Y82w+CjmVeNrY8M8H8qB6zrWatUDeHVw7kHWFJK3qd5SOwA
         r5Qg==
X-Forwarded-Encrypted: i=1; AKwUvBw3FC1CH07Fa9TGHNoha+YtmL6huWxQIBZSFYXLBKrjabcSthAdmKurOzJSM145uEqu60UqbgGEO8h8Gcw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++muP6q1WRedoCDcSyj+qmbT0NHDXWyIL4+tBEWGJyMaZ0EK09zw
	otq6F7SaV0kcfoyUR3BpdZPyk/+rM17qRiBTiQuIOHR/rkrcKU4NILUO
X-Gm-Gg: AYBFou3pmfU2wHWjFNHKyd/5pYM+6Y+t0X6z9c+TUNtxAjS4K2wi9RU2HYh15W+K/7V
	1Z2+BYPSS07bDcqX+gxIDqFzbjXLUXeA/+B/mJNmcdp/zUsfx76Yp2eGvsLshXtBOt5Xgj10yDh
	u2pscvP5ifzWawZ3YdvdNnP49F7xv0+vUcAF3IflBbBpDpkX87ySxTJoVOBbeitNNXSsYr4oISS
	0dWQU9K54hNDhujEQMSHx2E3DgaWeHUEPw0Ec+5gu2Md8wUS2P4qtR9v/BNUr643t93P9Npwh7B
	bAHkFjqVs3G0SLijkr3jX8rD6FWwnwMkpEhoXuA7+ZJ6NyCPxkhTr2jGKOm093pOQVv5//Ns327
	5voElCP03F2PISq6PtnfBbntVu5uIyZfi7m811Rj2D0ZbXgneX8V3Zfc1W0jR2FEniROODLlL9B
	oYpixcZ0HuP9pIzJ2AbfuUfL8BANCLgj1ccav8AYjxj6vORn7bxRTUjABVhUV5uuMIxwQ/g/bO+
	S71OCljLmox6w==
X-Received: by 2002:a17:90b:4c4a:b0:398:bc52:825b with SMTP id 98e67ed59e1d1-39b2624c32amr28690908a91.21.1788756731628;
        Sun, 06 Sep 2026 21:52:11 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:52:11 -0700 (PDT)
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
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v2 3/7] powerpc: net: fix typo "upto" in comments
Date: Mon,  7 Sep 2026 10:21:31 +0530
Message-ID: <20260907045135.13317-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907045135.13317-1-hemanth.selam@gmail.com>
References: <20260907045135.13317-1-hemanth.selam@gmail.com>
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

