Return-Path: <linuxppc-dev+bounces-22854-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1D8CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2026 11:20:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gjpmG6Z9Mz2xQD;
	Sun, 21 Jun 2026 21:20:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782034677;
	cv=none; b=jw+DMKmBye2DYmTlXtOI46uHsxT8qEQN3OcxmATpGf7j0r4oht3DtrIi117gqtVW3IQAADEXiTnIcc+B1queWaz5sCxgN6cYPSUU+/CHMOz95rrfNPAxfZaZTHg2C5IBmwus6zHfBhZ6xXYRSv/qvmq7wrtdEP1PdW5LSYD5oTB5wxRZM/Ghj44i/Urz38sfJGzuSq+2bnekn1imdUX8H+cpsRhrP5onTACfzSTexdGMr/WIneogJVpIUmnzX8YxMj78akiMgcE58c2FbgtI0ZVfrptqtcy5aX56dIA2a/Xn3lohTx8AJ9hLUdMjVDF/3Kz8cxLQ8lIBsCBeyHN2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782034677; c=relaxed/relaxed;
	bh=3PM2SwKGUgQ1Wfor83rkZsilDOPTMWeMgpO7Hmp6Coc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=ZrN+0TLL7SOmGxl1Iw9TJBb2ykNckWX+pnkVHg/ot0LSCsb/ejtEoyS71XT9BOS9sL/mv0Akih7USUoBUfvv/3p2b1Yi8sUnOlYnueK8zyIgKZuEzKb1bBJZdBByAz95W7aQMipDOIvo2O6gLDVyN+EjYTenZGeIpzXIgn8cPyMLPvWKl8TuqV940+h86447rkcMa9sQq8nUb087dyy0vn70rZmfCfzFwTckFIkX/J9NXGfdx5vCE5hLYJERhVKh/LxQ/yONrz9KsASHhcChtUrlneYlu5CAuJWsyohpgkAJt5oL/uNfxNdN31Gow31pGAhBemNbAIcUSWi4v5biow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPvoIDGL; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rostedt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPvoIDGL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rostedt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gjmTc1ZdVz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 19:37:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 99C0F60051;
	Sun, 21 Jun 2026 09:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EEE1F000E9;
	Sun, 21 Jun 2026 09:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782034672;
	bh=3PM2SwKGUgQ1Wfor83rkZsilDOPTMWeMgpO7Hmp6Coc=;
	h=Date:From:To:Cc:Subject;
	b=CPvoIDGL14sCX5ylLaYUAhDC9lMcMiJh12IJzutGSGQKhhN/j3P7fMe1lw15m5Roc
	 tHpoEk8Aby4R7yyQzmUbl4hKAdLn06DdHEiYs3o1201v2up+FU7xKvnepQ/nPPwDCI
	 WFkQeLslfQ8Kj6y7aV8P00hG40B3FZDEvni22GswCCp3bAgMXKZfMgiJsONy+BOgVi
	 k0p/zCAiBS0MY4A0IhU6SDokj6lXppltL7JA3pcuCP15DKxW8Mk4X/xfQ3c3P97y2z
	 c5uOUbqO06EeOjVenm17mc5XrEaYLlP7aug5hC/9nFo5DtP/NtxZmsipMAfim8Ib+w
	 nCbGOugNardpA==
Received: from rostedt by gandalf with local (Exim 4.99.3)
	(envelope-from <rostedt@kernel.org>)
	id 1wbEd0-00000001qTd-46mY;
	Sun, 21 Jun 2026 05:38:10 -0400
Message-ID: <20260621093430.264983361@kernel.org>
User-Agent: quilt/0.69
Date: Sun, 21 Jun 2026 05:34:30 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>,
 linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org,
 linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org,
 kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH 0/2] tracing: Move trace_printk.h out of kernel.h
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

There's been complaints about trace_printk() being defined in kernel.h as it
can increase the compilation time. As it is only used by some developers for
debugging purposes, it should not be in kernel.h causing lots of wasted CPU
cycles for those that do not ever care about it.

Instead, add a CONFIG_TRACE_PRINTK_DEBUGGING option that developers that do
use it can set and not have to always remember to add #include <linux/trace_printk.h>
to the files they add trace_printk() while debugging. It also means that
those that do not have that config set will not have to worry about wasted
CPU cycles as it is only include in the CFLAGS when the option is set, and
its completely ignored otherwise.

Steven Rostedt (2):
      tracing: Move non-trace_printk prototypes back to kernel.h
      tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean up kernel.h

----
 .../driver_development_debugging_guide.rst         |  2 +-
 Makefile                                           |  5 +++++
 arch/powerpc/kvm/book3s_xics.c                     |  1 +
 drivers/gpu/drm/i915/gt/intel_gtt.h                |  1 +
 drivers/gpu/drm/i915/i915_gem.h                    |  1 +
 drivers/hwtracing/stm/dummy_stm.c                  |  4 ++++
 drivers/infiniband/hw/hfi1/trace_dbg.h             |  1 +
 drivers/usb/early/xhci-dbc.c                       |  1 +
 fs/ext4/inline.c                                   |  1 +
 include/linux/kernel.h                             | 19 ++++++++++++++++++-
 include/linux/sunrpc/debug.h                       |  1 +
 include/linux/trace_printk.h                       | 22 +++-------------------
 kernel/trace/Kconfig                               | 10 ++++++++++
 kernel/trace/ring_buffer_benchmark.c               |  1 +
 kernel/trace/trace.h                               |  1 +
 samples/fprobe/fprobe_example.c                    |  1 +
 samples/ftrace/ftrace-direct-modify.c              |  1 +
 samples/ftrace/ftrace-direct-multi-modify.c        |  1 +
 samples/ftrace/ftrace-direct-multi.c               |  2 +-
 samples/ftrace/ftrace-direct-too.c                 |  2 +-
 samples/ftrace/ftrace-direct.c                     |  2 +-
 21 files changed, 56 insertions(+), 24 deletions(-)

