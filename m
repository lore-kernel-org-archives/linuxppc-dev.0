Return-Path: <linuxppc-dev+bounces-26594-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED427C624D6
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:17:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNRV4m5wz2xlJ;
	Sat, 05 Sep 2026 16:17:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788551502;
	cv=none; b=Fl6/naCBEwFtWba7oWdf1atEySMlLQSIk3xJfC7UoTh/FwJwFHNAFhqffQXB75TzWmxkrWKsHHt4nNwulp+rVEOLyvEG6rXzRAbwXepGE3NyfjHa0X484IVNlw5B67QH6N/73mhF0oepwD6Z/Gr5yN5uT0kVnUBcRbc/Qr/+z0iFw/ZkB71FU5Y9rZWIHfuO3aKdW/4IOUn/kj4PZb5xpikgajqQ7iwhNZXt0uuZxhah8kSNE8O2Am7kC+OcY8xaayAI8l2Pq+y1m0cmZg42hSl/V3odFxr+xE9H+dOlQBacRQ3yjpnvCp2NxWIxwhXWgHXLVFIjDJC+dkMZcTjrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788551502; c=relaxed/relaxed;
	bh=bKfMAbI9WP00e34xfYRqukO9FWyuttxaiqoWfdsqtb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gt3PPdxYpOvdgvFJjILE3lbhYhCT8F1F8AHVIr1zhPopjDVECs6rRzZcyHYLqiYTLdLesPMG0+FcIdU2de0Y2u+8DXlE3nnHDjI4gYRkWBPuzM4aJRajo12QlYZAXQ8ChdvCcCHWVq2J4aiGycTe9gW/2ZGlefkPh3Vd9BovwdrpSXQP3Xxu3wXq36qeGSB8dBdtBQtaUKD8njOmHrWGUqSemoiHN3ogGLL220kWEIdhRoW8ePasQJ6Kg7+Upd5+sI17o4EVwtfgiom0UHqxn6Avpd9StJbqCGMlhtUfW/Qnsn60nZ6H0uGLKat2FoHMjnyCimp7GjCrHQYArvyQeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m/DJ2bES; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m/DJ2bES;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc6Y82X7sz2yrT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 05:51:39 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso1201422b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551496; x=1789156296; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bKfMAbI9WP00e34xfYRqukO9FWyuttxaiqoWfdsqtb0=;
        b=m/DJ2bESmHMAPC2xLVPg1I6eMIYwJlErQoOGvgH8f7G07KeJumjugoGHLX8CX8CKfT
         DX/CFSqQrSJPuwUkjtD8IWIe8VtqgaInod14gLBBi1/3FvgQb8s/RF7YxfP2EUuOxj6x
         mfb5+uM6Rm9TLoFWKZRhmiqPqCJTJNxDTc2Pn7Qw8LbQmR5CvkgLXOIn2MJI8biHhN7P
         gxVtR4UBFpTVuLEO4BUKI5l/SbsoFL8lBfQ0rkHvd+htSUbeAdgbcAn/Yx8fBwjSTB7D
         x5DBCOQDaFP2K92tr1X2yjhpayejP1lA4nnO6LE0BbB02RJDrnxTAK0AezCuGaeTS+Zr
         0F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551496; x=1789156296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bKfMAbI9WP00e34xfYRqukO9FWyuttxaiqoWfdsqtb0=;
        b=e8T3zFMGstkahPM8DWoZfUAzHa/EG+rDGqE5mNYihLCkHA7pySO0vhYE86BExeldBp
         56FFmUwzUz6iFN7RDc+3RIS1hOBP37X+O9mVbXa8ATEzM8Yj11RVA5kdf4Gwdf8eNPgL
         8VEJ/tpqOexz145ITUnYpVrxh9wjhfeKoW35Byz/vpMBn74NunkMST8jgQ1XvBi8OZ5+
         6MjXNiY/vhVby+3wnLQXqWdBK6iou+0cMzxp3wWwfl1a/frHQLoGie1nWdxNShzFIFe8
         CDtP4iuPE9F3BqZDW6fF8GG2AOQQhuC81cA0Al6UPm+YaTlemSEZSFh89WPrSFi8MiSv
         W+Nw==
X-Forwarded-Encrypted: i=1; AKwUvBzy7+oSwQapfQT5/eaDGcFWLcdGaOaJ5P41kxb+Vf3l9vJlrvhyOW5OeWYht6sPZ/c5jjyAefamVe1aPzI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kVOfzFuJxrDkX3cEWBo5REipgmiTKXGCQQG40GBWyZMRPyKKfT
	b/Ms45uZT6Z+5621DNGdy/9pKzs+DX7XwpxQj1zPyTobg+7tLxobFyqJ
X-Gm-Gg: AYBFou0c8/T3QeqshQnBc0L9Zn+4IRR6GyEqWDE1d42XBrnsfWtLrculFNo9WkItCdt
	7WrIMknRf5PDWoLX9h1uKDB6tu808Fm+IlqwsrOT0sYMVBGAa+1ioH9DZlr+VIcAWBN4BU/Opj3
	hOUwekMF86538bwr7sLu4fendxXKM1Ddd7+kNbye9qEoI1rdzytxdoyTeGZQRS+YQVXoHzYlQFX
	j+bM8moYKQnISqd4k8ROnQhqffGUTbrZx1YQaPOTVGk0+I2yOf1kyYdim8TSx7BNn9WViMK6Fnz
	IZnqyZzdfzuS8HvO1glAbRPKkN1uUFiY2EPN71AyQLfKXFYFNBno+5101EDQbUvcqA2MNy6YRW7
	edrKV3SHuYiaAdcMipOt1CGdjDeznLEl6A4PuRvnPcsK2IF4Y824gtnzF33YwZ9EBBiEFdwx/j5
	2OnU3ksJL/6/V9tHUyYCPANdjsdQbrkKkVqRHHHC5Li7aP4rCzOlodWS2eaSiUGGogFOOdWe9eU
	PMlV8LU6Z+vUwvxpmnzqziU03gJlHW6SM2iwLQHmdyT2q4Oqgm25XdKF28kPhhIP7327VIuSqUq
	+18p0SWP82MbzGUCmUi6pOfayb9+aZGpzG7awEiXu3cr7zrZe2cHxZL7ioQhfvNz0OJ2azz6+NE
	=
X-Received: by 2002:a05:6a00:b94:b0:84e:2382:f4f0 with SMTP id d2e1a72fcca58-861660e2f8amr11334624b3a.4.1788551495503;
        Fri, 04 Sep 2026 12:51:35 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 0/7] Fix timed may_goto with private stacks
Date: Fri,  4 Sep 2026 19:51:25 +0000
Message-ID: <20260904195132.141068-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Jeremy reported a bug[1] while executing a BPF program containing
timed_may_goto instructions with private stacks.

timed_may_goto[2] is a runtime safety mechanism that allows BPF
programs to execute longer loops[3]. The BPF verifier replaces each
may_goto instruction with a loop counter initialized to 0xffff and a
timestamp check[4] that terminates the loop after 250 ms.

Private stacks[5] allow BPF programs to use per-CPU memory instead of
consuming more of the native kernel stack when BPF programs are deeply
nested.

To make timed may_goto work, the BPF program reserves 16 bytes of stack
space. The first 8 bytes store the loop counter and the next 8 bytes
store the timestamp.

After the loop counter is exhausted, arch_bpf_timed_may_goto() is
called. On x86, it adds the counter's stack offset to RBP to obtain a
pointer to the counter and timestamp[6]. This works when the BPF
program uses the normal stack because RBP is also the BPF frame pointer.

When a private stack is used, the x86 JIT uses R9 as the BPF frame pointer.
The verifier-generated loads and stores therefore access the counter and
timestamp through R9. However, arch_bpf_timed_may_goto() still adds the
offset to RBP and accesses an unrelated location in the native JIT stack
frame. This is the mismatch Jeremy reported.

Fix the mismatch by resolving the address in the generated BPF
instructions:

        BPF_REG_AX = BPF_REG_FP
        BPF_REG_AX += stack_offset

The JIT can then select the correct BPF frame pointer before calling
arch_bpf_timed_may_goto(). The function receives the resolved pointer
instead of reconstructing it from RBP.

The LoongArch timed may_goto implementation is currently queued through
the loongarch-next tree[7], while its selftests were merged separately
through the bpf-next tree[8]. This series is based on bpf-next and
therefore does not include the LoongArch trampoline update.

[1] https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
[2] https://lore.kernel.org/all/20250304003239.2390751-1-memxor@gmail.com/
[3] https://elixir.bootlin.com/linux/v7.2.2/source/tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h#L8
[4] https://elixir.bootlin.com/linux/v7.2.2/source/kernel/bpf/core.c#L3407
[5] https://lore.kernel.org/bpf/20260417034658.2625353-1-yonghong.song@linux.dev/
[6] https://elixir.bootlin.com/linux/v7.2.2/source/arch/x86/net/bpf_timed_may_goto.S#L18
[7] https://lore.kernel.org/loongarch/20260804153938.16129-3-dongtai.guo@linux.dev/
[8] https://lore.kernel.org/bpf/20260813070906.5164-1-yangtiezhu@loongson.cn/

Siddharth Chintamaneni (7):
  bpf: Fix timed may_goto stack pointer for private stacks
  bpf, x86: Use resolved pointer for timed may_goto
  bpf, arm64: Use resolved pointer for timed may_goto
  bpf, powerpc64: Use resolved pointer for timed may_goto
  bpf, riscv: Use resolved pointer for timed may_goto
  bpf, s390: Use resolved pointer for timed may_goto
  selftests/bpf: Test timed may_goto with private stacks

 arch/arm64/net/bpf_timed_may_goto.S           | 12 ++------
 arch/powerpc/net/bpf_timed_may_goto.S         |  8 ++---
 arch/riscv/net/bpf_timed_may_goto.S           | 13 ++++----
 arch/s390/net/bpf_jit_comp.c                  |  6 ++--
 arch/s390/net/bpf_timed_may_goto.S            |  8 ++---
 arch/x86/net/bpf_timed_may_goto.S             |  6 ----
 kernel/bpf/fixups.c                           | 19 ++++++------
 .../bpf/progs/verifier_bpf_fastcall.c         | 30 ++++++++++---------
 .../selftests/bpf/progs/verifier_may_goto_1.c | 17 ++++++-----
 .../bpf/progs/verifier_private_stack.c        | 19 ++++++++++++
 10 files changed, 75 insertions(+), 63 deletions(-)


base-commit: d761934c9483ecde93fe99d8705282f716dfee50
-- 
2.43.0

