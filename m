Return-Path: <linuxppc-dev+bounces-22973-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715B1CDE008
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 10:43:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmFlb6bB1z2yd7;
	Thu, 25 Jun 2026 20:43:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782384219;
	cv=none; b=D3hMkyQPpg0tewLdWvVBpzB3V8rOztwV/O7lVaEVfTOIwvnhNoJUAA5kSJ7nIDk5+mi/LNyTtRbjbvDH3UcyfkHuMcVIWHI5jvVqKIl8++ygCRLHUjV947vbDwT9raWGXaiKDqWu2rLBsKOBpd9OXYTXJREnhUoP/QY2xzOm1ywci6MS/zQ01h+qbQr4kd3qMWpqLATxVNKlIg/r5D3OcFjF5UBz0bXBxwT4ZFxtAalRXymyyec8xcNEzGi9tA0HPkWdaNLdD8jdFOMhNOY5n3JE5xqJPoezy8ztTglzHHzVzaXyCDJaSUijYqGmFSSVfw30YpO0DGA/tEv17FZROg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782384219; c=relaxed/relaxed;
	bh=olDhkqtxI30UfcWJ97Za0LqCZRLOxs3Rv1WfiI82UaQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=D6IC/yPvYSTGG3yUCl+vzFXwtq5s3dff+gpBl4HpuuBjwENsoXP2Ez8orA46XWi7cv0lFrFp8Pp81untRUymLg2HwTbdeksKcBlGOtUi/fbT7cHSmfbImAO7qKAp0J1iJxBDJEo5xJSe32Y8jYbmAZcsDkIjuUBVMinNGJ2kFyJ36jHagF8zULlNIpT8UXQ7kCM4PibHpyMjSixDuyBSuBz96EmVD1OzvL1WF5KnGvbNrEiAKb2KLcomoRKD/AHNRzyctXqMhNY/g636Z8ErBkXsHCQTHfWWmYZ2xc6Abp7y5uH2zxoAUY/Avwt5lDnZgahXOH0A1vyIypL01Y/qiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T44en6Na; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rostedt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T44en6Na;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rostedt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmFlY4h7wz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 20:43:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E79143B07;
	Thu, 25 Jun 2026 10:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7681F00A3A;
	Thu, 25 Jun 2026 10:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384214;
	bh=olDhkqtxI30UfcWJ97Za0LqCZRLOxs3Rv1WfiI82UaQ=;
	h=Date:From:To:Cc:Subject;
	b=T44en6NaGlPGuxRlGZBX7xnth52c5FHMZA7AOZVAPYNjd0/OrfRoLodTcHRiLQybk
	 YHPoJMZyP0iX25n7G9jANVJXXjT2z//aa7wnRevhkJ0bI3u0YaLzPgTwOLcAbRt64j
	 ACmhmjoVdR07WL1bwoDOgc/oadNP+3aEkFJFaDkjj9n69C6YXWcorpHXSRZwvWTuMo
	 /nSOIt8LzbsdCM6rRxySNy5v7RD5esp/F39Dz65F50D+Tmp5AncdllaYY7jVXX+xRH
	 LpczgNSv52PoLL5Oxla7W8wbkAlEz02czNEPjic5fmsZKO6KeFuPL++VV9MmCK/mlb
	 QVwtXegLzsm0A==
Received: from rostedt by gandalf with local (Exim 4.99.3)
	(envelope-from <rostedt@kernel.org>)
	id 1wchYw-00000002W9c-0A36;
	Thu, 25 Jun 2026 06:44:02 -0400
Message-ID: <20260625104007.041432666@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 25 Jun 2026 06:40:07 -0400
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
Subject: [PATCH v4 0/2] tracing: Move non-trace_printk prototypes into trace_controls.h
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

Remove trace_printk.h by creating a trace_controls.h for those places that
need access to tracing prototypes like tracing_off() and for the places that
need trace_printk() directly, to have it included directly.

Changse since v3: https://lore.kernel.org/all/20260624081806.120105649@kernel.org/

- Always include trace_controls.h in rcu.h (kernel test robot)

  There are other configs that may include tracing_off() in rcu.h besides
  the one that had the include of trace_controls.h. Just always include
  it in that header to be safe.

Steven Rostedt (2):
      tracing: Move non-trace_printk prototypes into trace_controls.h
      tracing: Remove trace_printk.h from kernel.h

----
 arch/powerpc/kvm/book3s_xics.c         |  1 +
 arch/powerpc/xmon/xmon.c               |  1 +
 arch/s390/kernel/ipl.c                 |  1 +
 arch/s390/kernel/machine_kexec.c       |  1 +
 drivers/gpu/drm/i915/gt/intel_gtt.h    |  1 +
 drivers/gpu/drm/i915/i915_gem.h        |  2 ++
 drivers/hwtracing/stm/dummy_stm.c      |  1 +
 drivers/infiniband/hw/hfi1/trace_dbg.h |  1 +
 drivers/tty/sysrq.c                    |  1 +
 drivers/usb/early/xhci-dbc.c           |  1 +
 fs/ext4/inline.c                       |  1 +
 include/linux/ftrace.h                 |  2 ++
 include/linux/kernel.h                 |  1 -
 include/linux/sunrpc/debug.h           |  1 +
 include/linux/trace_controls.h         | 54 ++++++++++++++++++++++++++++++++
 include/linux/trace_printk.h           | 56 ++--------------------------------
 kernel/debug/debug_core.c              |  1 +
 kernel/panic.c                         |  1 +
 kernel/rcu/rcu.h                       |  1 +
 kernel/rcu/rcutorture.c                |  1 +
 kernel/trace/ring_buffer_benchmark.c   |  1 +
 kernel/trace/trace.h                   |  1 +
 kernel/trace/trace_benchmark.c         |  1 +
 lib/sys_info.c                         |  1 +
 samples/fprobe/fprobe_example.c        |  1 +
 samples/ftrace/ftrace-direct-too.c     |  1 -
 samples/trace_printk/trace-printk.c    |  1 +
 27 files changed, 82 insertions(+), 55 deletions(-)
 create mode 100644 include/linux/trace_controls.h

