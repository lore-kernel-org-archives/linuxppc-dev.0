Return-Path: <linuxppc-dev+bounces-26664-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEFDC79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:01:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdlyh1G8qz2yvP;
	Mon, 07 Sep 2026 22:01:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788782460;
	cv=none; b=YGtAhICfka6DW8g2toyeoDnUDxqhU7pCl0vrheyg90YrcIf188J+MlKbmmnnEPzfJW1I2DxnLlkxx2gtx3E2uftb3EP9pG4xY/VXM/i0d8s5tUgsTb6fHRqdv6y06u6lnptKLew2QipEdjR+Ze2jF4k1vAIvjQDdyKwqpCNpRIS6VwjYo1hTttJ0ZQd/w+Y+sbEfE+ReFLhyDeWXrS2+cH/gYo41w2vAS4PJ4aEcTZW/YXWuwugdVaOJPbUcta4eySpP7MgWDbvl6LtDwc3bHioI6RPuj3U13kNJp5Un18iDCBqTC08adIz/YyDI6+M1oBQg4gySmH58CC0PmCcTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788782460; c=relaxed/relaxed;
	bh=jE91T1YbcHjh2wKlRe2CKmWmk4DasShLxHNl5T/s+ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZcTxH+I+glcmnvOZdbyXB/Wq98nrQ2/SpovRPt5/K2goo+nr+PJhwU2l1LXw0UQ9mJ/gXCl5wWROixDM29HRauwKkdt/3r21pYY5uU30JcLdzjBTAg7ZWC6GLqMwD0hWUX4Qyo8vde5nYAp2z6Gg/b4qfsbaSuPF1F7HmkViHWu1NrNXM8XntoLzn7e9dMWZ9GEzpC8lcJX0S0zOChbKb50ifGpyAShDDfCScaN+MqmNgAundHI2YoxSbKpJzWrOk6lAx6vht16/aedtGJJzj3PBskbQZOg9uSjE50TOdfYtMQHSp0Te0NEqOxdi4YtjuBShiDmis1Yrhbdp8hlDeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZrPXajv2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZrPXajv2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdlyf0wXNz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:00:57 +1000 (AEST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-7f4ea388ba6so3322159a34.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 05:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782454; x=1789387254; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jE91T1YbcHjh2wKlRe2CKmWmk4DasShLxHNl5T/s+ds=;
        b=ZrPXajv2YCI0OLT7R/Ovkl3lFhnDkTtvufd+1pDFe4LU9U+kOD0o+5rPlG6Xt37Gbu
         ayZkhhN5PegN5QWhfZxJGwPysvWkRdwhb5UxDwnskjfeyVBNgjDoeZPE8KSKH1fstBX3
         mONuDpG2h8LAIzKfBxBwF2WYsRmY/jASjQpajFuJkC5147ZUK+yxZHcV1bEX1JdrwKJX
         OS/5JC3kKYsBzZ3Ce3yB/M7X3ZKCUcTcqIjmv33uZbPigJJkoZXHbzyEeDN3pNZ8X1RA
         Ty0KZyOHslxGBpWHd+CT1JuBA+DVVBvOT6rBUdWydNg9Kt9agikP745eBrm+zwoG4kxL
         Z99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782454; x=1789387254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jE91T1YbcHjh2wKlRe2CKmWmk4DasShLxHNl5T/s+ds=;
        b=rgDLG3HWxd+YcjIEThproqyU9vzZW3uErUpL9HL6hX/fWmf1GSvQv5YpmV+ibI3gvb
         V913hv8iTf0HJER6zyjEzbkFX5L3ObvXfFR9fgrDlUIKk2j+l9AEAO9xIa0O1FEVKFoA
         CHElnh4zG8nQB4VmLXzkr63zUqEH7r3Dp5fQ0HVyvs6lOLdAPAyTDkr+OAIkTaUEa6UG
         VBHb7NCdBalxbPX6PeIJ+ime1Xde7D2xZw5D43KPH7Uy0FbGP4P9ns/QbbrnG1GEIYUK
         DxMgNB2kae6aU1KPbfp2qtKaE/pQYpA3rJvMkLIAdCNfUoyWO4z+UT33xZAR43e+6i0M
         Xahg==
X-Forwarded-Encrypted: i=1; AKwUvBwwmG0csC7bZGeIfUOWaGFeHjO+i2bGvaGrZqCGyfJwT3uirSNT/uZxSMpztu0e8SpHyZW4YcWF+QOZlro=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n7c5bgOb6sIX4YMiO7FfDLdGumsw/P8VWHAFQ8dCIadrpJYcgk
	8i53eWS1jDEiBGLIqBW+efuxx0Mjk07tSIJA2h8Kr5Z3aFkQL/V7SgSD
X-Gm-Gg: AYBFou3+rbDOXrjLvo7I4lg/qP17pACv8Xa/ieRAxMzmPEjTJZ3oFuzEnyuFT75VRpT
	cgCZUWAynkSd36B/mqAieBf7LwkZk9HLtwwmXuVUUUPwcTiPLHCXqh74XMiO3J3W6kp5iH96EU8
	oLYfThagXUas/HEtAYDkOUpMPHPOQ2XXhnblK5Q1vEymyanDjAcOlzDtjCYTIA6SYihnd8oQWOU
	Ngw7YTFVcmdyDTTQjQnbp3YY4l3lftvop2guUFi2k8fQpo6PWby1E3SHf83X43deaSSi+HQaZTy
	J9J4w/v4aS7Pc1YK0q3L9wDM1Zmb56mYV+MZsYpJnd8MZyVKALHonEFbHC2Pn8ItHX2he0js6OH
	Yn+1svMVEvxLIexOjxm6bz/d8qd3pD+Jtdy8f+Vn6tH1rQXygIFPKplK86WONiTr0vg6sYKaU5t
	SOIvpFIn7PYoKNbq09Pk5kMsiDLzV8guZKfHehD6St3audSmlqJuxWZA3ZrbmKl+D9ROmms5g+t
	/0qn2vB7w5NdA==
X-Received: by 2002:a05:6830:4424:b0:7fa:5c49:5243 with SMTP id 46e09a7af769-7fa5c4954c8mr12688858a34.28.1788782454447;
        Mon, 07 Sep 2026 05:00:54 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:00:54 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/7] bpf: fix typos and repeated words in comments
Date: Mon,  7 Sep 2026 17:30:36 +0530
Message-ID: <20260907120043.36894-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Fix misspellings and repeated words in comments across the BPF
code, found with scripts/checkpatch.pl using the misspelling list
in scripts/spelling.txt.  Comments only, no code changes.

Changes since v2:
 - rebased onto bpf-next; v2 was based on mainline, which is what
   the BPF CI reported a conflict against
 - dropped the kernel/bpf/stream.c hunk: the comment holding
   "accomodate" has since been rewritten upstream and the typo is
   gone, so there is nothing left to fix there

Changes since v1:
 - use the selftests/bpf: and libbpf: subject prefixes that the
   rest of those directories use, as the BPF CI suggested

Hemanth Selam (7):
  ARM: net: fix typo "arithmatic" in comment
  bpf: fix typos in comments
  powerpc: net: fix typo "upto" in comments
  selftests/bpf: fix typos in comments
  sparc: net: fix typo "evalute" in comment
  libbpf: Fix typos in comments
  selftests/bpf: fix repeated words in comments

 arch/arm/net/bpf_jit_32.c                                    | 2 +-
 arch/powerpc/net/bpf_jit_comp32.c                            | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c                            | 4 ++--
 arch/sparc/net/bpf_jit_asm_32.S                              | 2 +-
 include/linux/filter.h                                       | 4 ++--
 kernel/bpf/reuseport_array.c                                 | 2 +-
 tools/lib/bpf/btf.c                                          | 4 ++--
 tools/lib/bpf/usdt.c                                         | 2 +-
 tools/testing/selftests/bpf/libarena/src/asan.bpf.c          | 2 +-
 tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_local_data.h     | 2 +-
 tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c | 2 +-
 tools/testing/selftests/bpf/progs/iters.c                    | 2 +-
 tools/testing/selftests/bpf/progs/verifier_var_off.c         | 2 +-
 14 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.48.1


