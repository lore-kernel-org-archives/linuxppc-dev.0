Return-Path: <linuxppc-dev+bounces-26636-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B149C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 04:51:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdZRV3jjwz2yvX;
	Mon, 07 Sep 2026 14:51:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788756710;
	cv=none; b=SIzHVC7fl6klGXa7kBpCLKROQjbG1R7AbikZt1Rd3stBAIHAsnWu3ql9hO6BW+fOq69AhXZkruptszZdVBdeZd1nnkPuGA/ZXpCYDmj8GBZjAJ8qZn9GwVX3dus/V/kq/mYNDq4Z0pjfTg53g0lKizoF7Ywo1le8zGmpb8PkTrJF7cGcCFaRaVpHTKgwU+rHxHBGaHgpNSb2uAoWhQL9nq1UBvGY7Jc/qrVdjIS3eStK8ygCfEqx7yQJi8ItnjTPeR+Oqyxsl00ga4UAcfYn9vyRK51fSiG6lcxmhEMK2eWF2KLSBrY+IQpHUyIjs4PbQ7jX6KgQmUJcIHc5diRC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788756710; c=relaxed/relaxed;
	bh=dSkZ75+revt0e4KyfnrpcrTujkH4yPeuqSBvDGGLspk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSftjWXoWicRlm4PlILNYJmhKRCCq+1kxGsLkLB+YRMYHrIrDCpkon73fi98vANZfHt6ZnYvbaBRV/RjS8tuRHiHU+ngQLOuxxnbXBDwccqg+yHuwFph87bZtUfuve1m1ceR7uB6yHoq/8T0xyREF5w+lP3vNQd3PoUaF0VDMs/W5H2kqIMFcxbW/RaQbEXPlW3R17MBEPZVM442KsR1yPab17oIHJqaWwHwx1Xi5wRSG4bWL0yQX50sv6XeTaKtlMBPC16aWBDPQU3Q+TlOBsh3OWjMNjwHkLYdvd/pkiK5M3ySju+M2LY89AVJ7e4dLlYjxBf5ly4etmv7ZxpJGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SAhTB5W/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SAhTB5W/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdZRS694Qz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 14:51:48 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c9aea40d799so1625398a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 21:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756706; x=1789361506; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dSkZ75+revt0e4KyfnrpcrTujkH4yPeuqSBvDGGLspk=;
        b=SAhTB5W/jqR7op2dUMYgjphhyG+LkhALg6m+8v2nRFJUdfQbkd0+Byhj1lbBrNmc3B
         JuMfk8J4JR64ZXPw20MfCu5Do4gYqec/7iDO/GCcJtdtGQua0HOgFSGekVBCfHLDSv+U
         U/XfxmEdaGL77AHdi3DSqcDZS5U2/BH+VSuOR3adxGRcdoJ9rnXtlJF3x52tYJ5LbUQs
         e04fDTIArWkJZ2134KKMjlb9aPrXvoE8KnoS4kUJEo5EEemB5ircpfKRtwBKl/u/3R3/
         Q3oHwmHENIjxZbEcrwsggecJ//ziuNsHem56jxzCWnLEXqVPDYVJbRCHvekjLK0700Lk
         1g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756706; x=1789361506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dSkZ75+revt0e4KyfnrpcrTujkH4yPeuqSBvDGGLspk=;
        b=JG7l6aydvCqWpuSLmWYAc84j52Q8depE3v9+Ehoncwt2QyyNRD4Jvn9mP1bIwumxQw
         EzKVqNiI4Zut2h7cECjWcvbpcuZjms7YPzU9HsMEeJaVim9F+ik1z4D2chWmgr9mL0Qn
         9K6LvBSe5QFQEhhsEwOoZ3SVJwtKAzflSAXRgXpzUIBQrNhpC6ph8Kj2qs5zjvAzXyon
         RQoLJePC2IwXmRhMgWfNUUndEt36ddekJfuGpnNN1m4rGd0ASYdm8Y/KlZ8jzgYKwJXi
         TFau9HpnuCCG1TcO7IvOLXNUAemNMsglFK2Iy0XLGCYRfBMwbwG7amdnZoetkOkJkGZ1
         fZ3g==
X-Forwarded-Encrypted: i=1; AKwUvBx//ViywD7PxpiqkBw46eexH+llQDHzqbZenCm0yhpPp3s0bDW59mA1ykg1QhQJdpa6P35PAk3qugjvJV0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kuiJgfzWrD1gwJ/IcE8q5YM4lWsuR/1WH635CX0ejaEajoGYky
	8//qubgzTHrFDeaejJkd4W9a53QLNc+p+oWQoNcdDWePlDvwn2kCI5oG
X-Gm-Gg: AYBFou04zvN40fsOy6ZND1JdWHhHSpbHOCVj6g5xb7kqUYzx3DjARaXWjrb75KqyQzP
	084oITTE933iq/dHYc651jSlC/hX2MxKt/vXpxCtq45NWX5MqkJyLQ5NUsmDKNKbh2Ycu4ICVOV
	HeZLF0kYUSLAIGTNu8cX6ScN4W3RhVT1v0s+smWpHDMHVLs7e9QRdINDaiPwFPoAy+Dv5EWG0ZQ
	uu5b8RfITy6ObzJBBtN/EQ6KP18DSSzJT+0gMyEXhv2wbpIo+gaez/G3xHl4HNHo8QWou6f9VVR
	o4yHHBS4v9OsAGds72x1GH8H5LDiAVUo+FONo4ZgFkt/Nd6geSsPy4Dm/9/4zIybztwbhwgQz9I
	xnG4jD1oTE/iL38zkaUtRo/Sa9xe8bdL//9uKcth0AtV+v4jwAmjM3JKRkicXvGqCKiBbKTnD4l
	hCaPxuosAneeFcHeYGlOSn2sBxz/giQVhcb7vUT/GdUO2XOHwGSkHdxMJpij6ikT9ixIkcgJ9qo
	8WbKzAEHK26Jw==
X-Received: by 2002:a17:90b:1643:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-39b26272f04mr30192034a91.14.1788756706071;
        Sun, 06 Sep 2026 21:51:46 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:51:45 -0700 (PDT)
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
Subject: [PATCH v2 0/7] bpf: fix typos and repeated words in comments
Date: Mon,  7 Sep 2026 10:21:28 +0530
Message-ID: <20260907045135.13317-1-hemanth.selam@gmail.com>
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

This is v2 of the spelling fixes for this tree.

Changes since v1:
Subject prefixes corrected: 'selftests: bpf:' becomes 'selftests/bpf:'
and the tools/lib patch becomes 'libbpf:', as the CI bot suggested.

Only comments change; no code is touched.

 arch/arm/net/bpf_jit_32.c                                    | 2 +-
 arch/powerpc/net/bpf_jit_comp32.c                            | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c                            | 4 ++--
 arch/sparc/net/bpf_jit_asm_32.S                              | 2 +-
 include/linux/filter.h                                       | 4 ++--
 kernel/bpf/reuseport_array.c                                 | 2 +-
 kernel/bpf/stream.c                                          | 2 +-
 tools/lib/bpf/btf.c                                          | 4 ++--
 tools/lib/bpf/usdt.c                                         | 2 +-
 tools/testing/selftests/bpf/libarena/src/asan.bpf.c          | 2 +-
 tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_local_data.h     | 2 +-
 tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c | 2 +-
 tools/testing/selftests/bpf/progs/iters.c                    | 2 +-
 tools/testing/selftests/bpf/progs/verifier_var_off.c         | 2 +-
 15 files changed, 18 insertions(+), 18 deletions(-)


