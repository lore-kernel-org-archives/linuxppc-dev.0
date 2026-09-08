Return-Path: <linuxppc-dev+bounces-26715-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B294CC79F9E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 05:49:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfCgC5Shcz2yFK;
	Tue, 08 Sep 2026 15:49:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788846551;
	cv=none; b=NroxAkEtEpCtFrN8s45N562bNn5iKYk6WqfoE/wOFzi9An1zQ403margeny1+hbxOD/u+CuKE3R6tidrPMcDKeqJgBJ7wpIf3uNqMERs9KSU6C48yskJy1Rq1xucxIpyOSNjIJ3b9D/H+xHAXtS/UXrGZHHZmpL4i2uYGKM624mRvDc/AEPUYWnf0ySw5C+9/Mpq8KFM+RJdD/WmbjnPpt8KemAOs5xetGa4qivqF1pwyFrXhvQAsFew1q9TuDNw70PginCf7hQ+0sNaYNSD/DWuR7gh6bIL/5okmOB3gI3XfGfxnE4GR+/WeFkSnExbGM8MHtSMneW1P55Jrynx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788846551; c=relaxed/relaxed;
	bh=3Hk+XNhijnUk0JrFp3DVPvigSnryVRt/+DzNzROaqfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFfqiJSvkrN+o0trLTK4c54hCVpuumYnM7/5w4yj7hcWvsFr371yn8toP/w3oltlVvucUERZ16LRmmCiKQ9yK6sYKpTPvWpP0EaRbFU+6kEqzpCtjVKdpY6unB+Lu9wH4ByP+voju16rRtLWEXEmfheAfkhcSNg6iWKd1cVBUatvhxyzKyw9bfAimrYXKKfL+uuhFtfGkQOuLdfTkimqQl/LWBx/Q/NlMI2auuSzfL5gykKV48wx4g0W0B/OTs0TEQvyzaJO+iKd1JIp8FK/5wwvenDBhj6BQt+h3OTTcDrrOVPugjF3PWZJYXTTDAOEasoG0gZMtqcTJ1I5YiFLJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JwjLAVPu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JwjLAVPu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfCgB0Bgwz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 15:49:08 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-85590c5aeabso2756947b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846545; x=1789451345; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Hk+XNhijnUk0JrFp3DVPvigSnryVRt/+DzNzROaqfU=;
        b=JwjLAVPuqF6M0VMZhJYOLF3VyUoEseSsJoPDCKdNf3wu1C52AIOO7NSXCD53vX93ym
         tANwp7fuQq+rtI6ladx2PyzOec3oQfx5EI3ccgIIBtbfoGJ8wNDr+CPLbc7gS/Fe+O5M
         HPP2Iohtv4zRrPwPX1q4oEP5hm/mXzDE3GrRytK3jDMWlenQ+OjCqLF5c00EnnbaMLp0
         rgj2uf6LNlI8XM/YA/k8tC8AiIcvJK5PqdpMqvw/d0/OmhjSJR3gmJqmCweCPquaCJcp
         f9v/hTWrP5L0H/H3Srb40NhSkY9iWG7ZIR5d7mZ36T5F9pyUUts3AA8TuFJfMM+HrI+T
         sowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846545; x=1789451345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Hk+XNhijnUk0JrFp3DVPvigSnryVRt/+DzNzROaqfU=;
        b=m3hpNFc1HM2fQtYVnWZ/xTOAs9uhcf3lSgC4/Yr+/aecK8Kyims1X9qETDYOvLgcLo
         6UGzzWGSAvhN5PG9Q6C767tIblKXElMI7uyKbGLfo8BsC0J/caYKxY9+gUNRABr38wSm
         UIm6clDcHK/kbm+iajgHv+epSZqkeRTA2ZcF1L+cH3X+u+nxKQ0+r4FHutWl6M1o02xR
         9sEp0c6WZv6BgQMxmTyI86cs679UaNgw9kg3DLhI2cYHsgMTKmn2Hy9yThdcTNlpoxQ5
         9xPLUCaGkn54gbEEqYSeh0Ubj7QHlr11HI/0ECU+F/2J6sPEIYMhRBfyHE7+5CjP7v/n
         E6Og==
X-Forwarded-Encrypted: i=1; AKwUvByzDdgP2ru4VrGuXtXgeKJQbvg5CMAy4JpLEYwvJQ3IW8ZzEyPpYPLgI/cHh3hajlSXttoLadZALWig/Kg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nv9wPX0EYVKoBOS+KtTfs+Vs8N0DYE7OC4D2CKOs51yiLVCehL
	mCWH7UM64JBNC6uFV+GJ8VY3ChyXlMTilcYtHSVoEjkdqQqZRuBaTcUT
X-Gm-Gg: AYBFou2Y/Y4B60u0DWtv/D239XE2h7WVzL6OrkQ1vB90PtASwue5Trangh8P0nsgYhQ
	gI46t95NSOmCmNSfY2uQTpoi8Kc1QjlLrTjDWXaRt6cRVOsLMXM9Hrbzr2PkIMf8WUUC3UH6TLv
	8c62kGfxyZoXykfF6jAMzqQZABJNxdwfKtNJ5Wxc3iKXTWtMzaKQoOkte1RIOFwsXfSEa9LssFz
	QJVcisamg/GqCUzh+zuALHyJ2L6CNS6vG424F7EV6N6gbM5TfYmqQaJnGhLeGvljCal0lWZzURw
	nsAziaPUEDBA4CExFZSyQLGXeNXY1XhvXM1mygjicwR5ANgjFG9Oh+qlxKrV9Qi+9HqqvZs8FgO
	8Ci/8imA9jAsYGAGavv5XmdMf6FP8hBS6ETuh+wdG7OYttKOctGKcNj8SkQbGWCxJjF23tJSEEt
	X44x4+xXlnT7LnRg/ORhpi4e/WiCF6QukrrSm7RQh1sMWYwjv7yHCyFskMn0nOYrqfBBLNOGxAH
	MyzW3CDGhpc4g==
X-Received: by 2002:a05:6a21:38c:b0:3d3:ae1f:d7f8 with SMTP id adf61e73a8af0-3da3a0cc91cmr42893779637.24.1788846544946;
        Mon, 07 Sep 2026 22:49:04 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:49:04 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/7] bpf: fix typos and repeated words in comments
Date: Tue,  8 Sep 2026 11:18:46 +0530
Message-ID: <20260908054853.13820-1-hemanth.selam@gmail.com>
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

Fix misspellings and repeated words in comments, found with
scripts/checkpatch.pl using the misspelling list in scripts/spelling.txt.
Comments only, no code changes.

Changes since v3:
 - rebased onto bpf-next.  CI reported a conflict on v3 and asked for a
   rebase and resubmit; the tree has moved on since and the series
   applies cleanly again.  The patches are otherwise identical to v3.

Changes since v2:
 - moved from mainline to bpf-next, which resolved the earlier conflict
   in stream.c where the typo had already been fixed upstream.
 - renamed the selftests patches to the selftests/bpf: prefix used by the
   rest of that directory, as CI suggested.

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


