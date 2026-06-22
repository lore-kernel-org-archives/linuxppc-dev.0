Return-Path: <linuxppc-dev+bounces-22867-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EE8CDB471
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 08:05:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkLNM4cKcz2yVZ;
	Mon, 22 Jun 2026 18:05:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782115523;
	cv=none; b=YF1Hg+DBXefSdahGTadvoqGAwv9wCJ0rHN/lMDQK0MdqOsekYPXVm4FM4C0k5iwmKHAz5Tq61GVu//w/kG2xWiO75KJQdmE9raa5WRm4fgPCLIGRNZOm6fVlQM4rnkgcBvfJjx1SY7czoH0PNykQhHBjGXbMuDSW/AR5eu9ubgSUdW4VC1x+KOM0jA5+rIBIlZOPAZi4/iFe91gI4LWJTSbCshtfvvqFJfn1Af0DUnLO0PiRLcskSH1SU2FqHLoTanpHFy/Ua14I/ZZRwZSKSnN6U+WibgKIsOzO8wRD8F4rR6zOmAkXWeqAr0DL5CPpykHkH73rasDsfByFSQT0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782115523; c=relaxed/relaxed;
	bh=FAbpiNhKVqoEfhFmUfUdlxgESW8QuGiY+lhl+lA+T60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJzOPo3L2bUckrUUBhxMwP2+B1a0TjYldKtDxM4OL9AVun9V/uxH/GaL+x70GGf9kLtKD/N4xzLpNXhiFsdfkD9Vbgvpx88tRlvD5lFHSNLrtwPCmxTyNejIhewT5VmlmW04tOyA6y5aW+EM+m7pbIROKLypDYLHebC2r6DTyDZsYzKWENj2LHw7/Jlz/qCqL8KYF85ACU0w2uXh5Ges0heQ8ZenckK8ChvEPIB9jdum9FWozIgBPj16g3TjSsnGlboGmPz+EhmGf3U8wVx4/91x/Fn5xBkJottdS+fYRHA6Zo7f7s/swt9JbPNT2I5V8juE83EblG/LRuf1VndJoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKhiDDUd; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKhiDDUd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkLNL5MKwz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 18:05:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1913F6001A;
	Mon, 22 Jun 2026 08:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B84C1F000E9;
	Mon, 22 Jun 2026 08:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782115519;
	bh=FAbpiNhKVqoEfhFmUfUdlxgESW8QuGiY+lhl+lA+T60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WKhiDDUdL0KRgYXfe2WI9TPD1Fcz4Jm9ZEs4TCvppOjXgUFC4H1afMQFw+2v6sbYC
	 wyKQOW94sIC2JrNxh5T1XMUYBWAlDKC18spHzcXcYSeSIENbdvnOdBeIFeCRHU0wcr
	 GXhaSILwuzYrxIUKMomqoVtJ32rfzWA7jVghDLmfnz+BZrvg16SiSZpHTKMbep/4WK
	 cTRFBl6B2TwAUd1X5OjJrSj8wdRtwPxWGGAsp+lGM7jfcHoi8eTosbKCizRmGWHd0+
	 cQFh5OCUybibOIb31BzksIWMYD20OkhiGIxmv8Z+opVm7KScIv+rhlWvQYzzdL9N23
	 S4BwD770Utgzw==
Message-ID: <dbb5915e-6587-4de9-87f3-76bea5024da8@kernel.org>
Date: Mon, 22 Jun 2026 10:05:13 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tracing: Move trace_printk.h out of kernel.h
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
References: <20260621093430.264983361@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260621093430.264983361@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 21/06/2026 à 11:34, Steven Rostedt a écrit :
> There's been complaints about trace_printk() being defined in kernel.h as it
> can increase the compilation time. As it is only used by some developers for
> debugging purposes, it should not be in kernel.h causing lots of wasted CPU
> cycles for those that do not ever care about it.

Do we have a measurement of the increased compilation time ?

Christophe

> 
> Instead, add a CONFIG_TRACE_PRINTK_DEBUGGING option that developers that do
> use it can set and not have to always remember to add #include <linux/trace_printk.h>
> to the files they add trace_printk() while debugging. It also means that
> those that do not have that config set will not have to worry about wasted
> CPU cycles as it is only include in the CFLAGS when the option is set, and
> its completely ignored otherwise.
> 
> Steven Rostedt (2):
>        tracing: Move non-trace_printk prototypes back to kernel.h
>        tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean up kernel.h
> 
> ----
>   .../driver_development_debugging_guide.rst         |  2 +-
>   Makefile                                           |  5 +++++
>   arch/powerpc/kvm/book3s_xics.c                     |  1 +
>   drivers/gpu/drm/i915/gt/intel_gtt.h                |  1 +
>   drivers/gpu/drm/i915/i915_gem.h                    |  1 +
>   drivers/hwtracing/stm/dummy_stm.c                  |  4 ++++
>   drivers/infiniband/hw/hfi1/trace_dbg.h             |  1 +
>   drivers/usb/early/xhci-dbc.c                       |  1 +
>   fs/ext4/inline.c                                   |  1 +
>   include/linux/kernel.h                             | 19 ++++++++++++++++++-
>   include/linux/sunrpc/debug.h                       |  1 +
>   include/linux/trace_printk.h                       | 22 +++-------------------
>   kernel/trace/Kconfig                               | 10 ++++++++++
>   kernel/trace/ring_buffer_benchmark.c               |  1 +
>   kernel/trace/trace.h                               |  1 +
>   samples/fprobe/fprobe_example.c                    |  1 +
>   samples/ftrace/ftrace-direct-modify.c              |  1 +
>   samples/ftrace/ftrace-direct-multi-modify.c        |  1 +
>   samples/ftrace/ftrace-direct-multi.c               |  2 +-
>   samples/ftrace/ftrace-direct-too.c                 |  2 +-
>   samples/ftrace/ftrace-direct.c                     |  2 +-
>   21 files changed, 56 insertions(+), 24 deletions(-)
> 


