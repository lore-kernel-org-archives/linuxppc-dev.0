Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD3606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=f4gcsUe5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXjsW6bB2z2ySH;
	Mon, 23 Nov 2026 09:09:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795376554;
	cv=none; b=APLvvTTEf6Kadf30fy2meQPG4az1haqlfhwVzTOMkMu1UIUb7BIdykhMhIQ3qb8wtmH97uT+N0ruWmA0MAF/Y98muTf3m483Jx4ZCz2mRj5QfWXdH8SKVimvmtirn0F+UUiL4VKaMfY4QGW6ryjyYtxXcDLL56hWpcwHmoR6V/W5sRnvmsksca0lHgGVuu1pJpSMiCHcRWLI4e8l7zqsfhzpU5ForI5Zb30J9O1eYYLI+QvV0fOlCQKFnioLqZqqPmRhL8zYZMfC7ayKdU7RqEzePCJCOl6TPlcMeZPPdhUFqaqatgxH4ZK4UpPMdUCJ+Q+0TcHsGEDzPB/zhLVG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795376554; c=relaxed/relaxed;
	bh=maHzIxiaoXc4+gcip25itE7mLfNd2FeiXw3rtdr70PU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dmdJxdRuKwPq9wzLpQ3EbVBRMLhJWsOWdJbAM9Q/lYpshF65GCS+u3EhmYD3DUyAKGLfBzb1/LxP0wzsPgGdtrhxi0pvHJfaMXIzQwM1L4581aRjkaXVXo71p38QnUGFVxiLPHQ1sbc4si9vDYk8ZUCeCOTGsgXfVmhYS0G+VS9Cy+ZwHCqnfSSMCJ+GDEC34ALNmfNtxDsGncQK29CAyAfihlOvc+yx4Cik2UwnnE4dv5qnKnKGLxztLCzfcDDSVwjH5YbPkdFjuysnCGxwnni29Aqn9PD7LKrtP/wHcBlHI+YG8Ahw/OvPaz6Ldz1tHI/8wKYouUITFg6ZrABLHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de; dkim=pass (2048-bit key; unprotected) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=f4gcsUe5; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=lukas@lukasstockner.de; receiver=lists.ozlabs.org) smtp.mailfrom=lukasstockner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=f4gcsUe5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lukasstockner.de (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=lukas@lukasstockner.de; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXfc848Zwz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 06:42:30 +1100 (AEDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so25591215e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 11:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lukasstockner-de.20260707.gappssmtp.com; s=20260707; t=1795376542; x=1795981342; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=maHzIxiaoXc4+gcip25itE7mLfNd2FeiXw3rtdr70PU=;
        b=f4gcsUe5l0Dyg+IofRrXb++m3b92Amjz2k4XrGa2TQ4c2MX0HHH9XvT4IUp5J4Ld1y
         pLfD1kPTRHG9pD32znSGl5a3TsM8XdXQpeJhK0KvEMOT+/b4F6N1QGW5ebxtTo/PpPhj
         O3eM+jYCq5DTn8OjSs6MqijhL50wmYNgtb9N1z72HgIOuuTtOSeKPeSclwrS0IHxD3U+
         ifvAIqYO/yISGXnZL5oJLohCHHv6PD+KYL2xP8h1K8LnRLBImBCunegmglYUS50KLioA
         SHzroSLaYttEhzYIfbFdbth2LFCkNz2K2WG3Rx8rTZ1gy+jzZrMHlnGvvI+9c9tHIAAR
         yZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376542; x=1795981342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=maHzIxiaoXc4+gcip25itE7mLfNd2FeiXw3rtdr70PU=;
        b=HJtPGK1gB/bpyc0r70nNZFXBFJDVCsXnwg3mewM3LrQkeBtPS7JBt05RNxD9BkR7W4
         zc33Tpab48fTbJs+DMPykK+j8Trwkvuq+JJyeP52NjTgxJ0xcf87TSJDfctBAQSuc4gw
         T9FzZv+7YgS3g7x+TvcYdv+mEZnClzWyLH87KTnI8aElr7N7PWUzMpQYKaeEeZh4ngR5
         wG05eH02yztCRycvmtCsdAPFzejGOoUtYRwDAB64MblRKJH5CKdXOpFyS/QtWQbLJDES
         BfpqrPqdFDKBrpbG7rn3XQyRXSe7hL3cMwQ5tA4JQmedmFRPJThYTlJ5S5rrnbNcfVEn
         nHVQ==
X-Forwarded-Encrypted: i=1; AL+hErEwIiBr+ZiQB06X2SvunWLLuNdszUtQzWbodV1bdNe2YtimkwNsfr8+uqwslr3COUfuTT3/+6RxdGrE4f4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8F6nrdFhgZCQh3G6B/81dtuLfB+4i9BffdnhF/IaoXZ2sB2mDl
	ItdV+6EmseFPBxI+/pGL1wiV+hZ5/PGUZj0Ge0l26QeSyZPdOzmyvnTIB+GR5/N+1tk=
X-Gm-Gg: AZFdTZeoRgWkxHwRud3kMpxtjnCB1u1T2+aO0zN7s0ilzVHLjufD8OxdblTHv4Z39q+
	tewEb0D2eJZXIMFd9wrB9KUsvV/BQC+JgKgzfBvfbl7ilVv56qmkV3fCc508RWzBZZKw4FavGzi
	fRtCMuEXas4F6tqlBP60Ok3Bfi078NxIfNHkpQZ0XVjela5rdI3UHjMwRWaS0TEfcvMbJvE6qoN
	6otgDfeKIuY6qxeTKcH56v7LWrjXDka8OiVirkko+btsPknlSRmQmpAsNe4Yw6sQcUca+5/POXE
	EjaC7zNGqJen8iU1D6r3OHIwGIhnbDjo5HpisWm+ItPYOYbdKIyDyRzl6xujrdban0gKQd2NvMZ
	7T0VQ1rubmyW46qKHO6okSNluTtk4fw9W5+Qb85YdsxM++vE1j+uHSqVewYPi2htgzz/u4LPQ7V
	rs46hnnOro4T4jFhMVO5TWJQzGQvrZlkGGyxkmgwUJc84Ntg0OwC7NqMfqn+duDdXU/GTDc5FqI
	ubKnTQn7EVFO8L1fPK/PdgJMPWTL9bTQGBTtL02Bv4noN4Hflzr/E0PShYCCULJhbhs2qtshYVG
	QhJS/1+Apcpb5N1RfurhXciBrbHl54ee5QsxhNiy6cqQMWF7ml0xDl8TnV9tBaj6sZeTF0qKveD
	y
X-Received: by 2002:a05:600c:a085:b0:4a5:26b8:4507 with SMTP id 5b1f17b1804b1-4bb8881e6c6mr204049325e9.21.1795376542396;
        Sun, 22 Nov 2026 11:42:22 -0800 (PST)
Received: from lukas-laptop (195-200-20-154.mclarenap.oninferno.net. [195.200.20.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm293917125e9.2.2026.11.22.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:42:22 -0800 (PST)
From: Lukas Stockner <lukas@lukasstockner.de>
To: Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Lukas Stockner <lukas@lukasstockner.de>
Subject: [PATCH 0/4] powerpc32/bpf: fix BPF-to-BPF calls and instruction folding
Date: Sun, 22 Nov 2026 20:42:01 +0100
Message-ID: <20261122194205.218543-1-lukas@lukasstockner.de>
X-Mailer: git-send-email 2.56.0
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes four bugs in the 32-bit PowerPC eBPF JIT.

The current function prologue/epilogue assumes the calling convention for
main programs, while generated calls follow helper calling convention.
Therefore, patch 1 makes it generate a helper-style prologue/epilogue for
subprograms instead.

Patch 2 and 3 are needed to fix the additional arguments in subprograms.
Currently, the fifth argument is not being loaded in the prologue, and
all of them may be overwritten by register reallocation logic when they're
only passed on to another call.

Patch 4 is for the 3-operand folding logic. When the second instruction
uses the same source and destination register, the current folding
doesn't work because it will end up using the previous value of
the register, even though it should have been written by the first
instruction. We encountered this for the case of verifier-inserted zero-
extension MOVs, but it also affects other ALU operations.

Testing:
We found these bugs in an eBPF-based CLAT program on various WiFi APs,
where it would trigger kernels panics on PPC32 hardware (e.g. Enterasys
WS-AP3715i with Freescale P1010 CPU).
While working on the fixes, I tested in QEMU on g3beige using small
reproducers (generated by GLM 5.3 Flash).
Afterwards, we backported this series to v6.6 and tested it on the
WS-AP3715i, and with the fixes applied the CLAT program now works fine.
A previous version of this series (before some cleanups) has also been
deployed on several APs in production without problems.

Lukas Stockner (4):
  powerpc32/bpf: fix argument passing for subprograms
  powerpc32/bpf: fetch fifth argument in BPF subprograms
  powerpc32/bpf: mark all argument registers seen in function calls
  powerpc32/bpf: don't fold MOV into instructions that use dst_reg

 arch/powerpc/net/bpf_jit_comp32.c | 43 ++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

-- 
2.56.0


