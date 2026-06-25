Return-Path: <linuxppc-dev+bounces-22975-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD98CDE008
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 11:08:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmGHh5RwZz2y8p;
	Thu, 25 Jun 2026 21:08:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782385680;
	cv=none; b=i/9YnwKYJVkao5wgk6IbCcA2COqIb+aBlF7nY+BOmAUZadDrlwrFyEnzIu3NEVMcEMoY71IA19FK0KHsXAQrqVwlWTMNQeTzWOaJyXAs0HtgUAf4Qla8YEumktyHekBygvA0MHTjmo/0sIJzbIrRJptHyvxGqaJ7HGQ485M9tojyTFk3PHOxxxOQe4PMf+kN3ASWGb0xpVJqGeUMJcVPWwOtT+WOXGPkgWo6YIEMBGM25d7+3i9vDEnQV9bajf8fezfmSJK9nzpfhPqoYAw7/UqMD9P7MqiBc8fxWQ6T00JYjeNHWxr0K6VH1ccZXyod1euQChtg2dY3s0O/90SGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782385680; c=relaxed/relaxed;
	bh=L28gvtHaVFUvm3g298xCnBf8nljEiAgGAj/WveWrpJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zt3oKxboPC5Ulj6/obgBYwGQBgbT3eX+6RmAPB4aRaJ3z5MpqYbDHZqPlOumGOdnEz8091SXRbcsQHd31iq03ltUSrnmuvP4V1OF/wCqsfNU2sf72yVPksZ/EQ8PsM0QTAGShYEZEeyrSvgJoSHrzTYe91lFOKZGlsgJXERnVrsCW59hZas6XfnDxNNiqigpgh5mKiA2bhxc9PF2JJcXIZgK60ZQcaXiUUebEaQjRjOH5/tyXyjWhZNMLdXqa0oGaEY6TUKzlU81Ep5mbn0bAC6SMzabfC8zl2VzB5iEclFz7W9SleSCIJsaqbKm6MRkX8thcoddVmkaYCzuDp8qkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QuDLKX++; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QuDLKX++;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Thu, 25 Jun 2026 21:07:57 AEST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmGHd13C0z2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 21:07:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782385678; x=1813921678;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3mMUyu41hsUV3+8vmn2FEljozTYUkLukSLGnNifcCP4=;
  b=QuDLKX++5hyvwWZGS3FYiEuxLeIj2Ro5VFyuzqvuxh+KjnZNFhNA1GFF
   QW70p9c+/nPWpDPuKvdBjgecZ5pMqe8ZAfaztfPeBT7pnT81cdy0KyIhY
   H7KBnBroinoSBZ8xXMDEqbeiGK7STec6/iO8LK7mhGU7ZWEkBk15ZdmmK
   6GbsAjnijozQUdOwcS1Pjo5I92TfHRRb4vgWmA5Oeqr5pirHSWcxz61HW
   ro06hGKB2lydrJ4SoUJGat6vzIVwGI346PIMvNHM8kMgUd7SpA66Z6/nI
   6SUl8HjHM71mYnJ/cYVY+PxV5i1OmAHYXZUkZ/TlnrMKvf5AHbY0yWTzB
   Q==;
X-CSE-ConnectionGUID: RZ7a+U+LS3G6VmpiweJfmQ==
X-CSE-MsgGUID: PS3S6QCnTfqgUqd2jWuxkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82144901"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="82144901"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 04:06:05 -0700
X-CSE-ConnectionGUID: Ff5wjq2eS3y4NEnYZUPVEg==
X-CSE-MsgGUID: /T55+aBtS92ybM5/4REhrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="249131302"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.126])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 04:05:58 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v4 0/2] tracing: Move non-trace_printk prototypes into
 trace_controls.h
In-Reply-To: <20260625104007.041432666@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260625104007.041432666@kernel.org>
Date: Thu, 25 Jun 2026 14:05:56 +0300
Message-ID: <2037b6b62264c0192d45733ec1099c3ec14085a2@intel.com>
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
Content-Type: text/plain

On Thu, 25 Jun 2026, Steven Rostedt <rostedt@kernel.org> wrote:
> Remove trace_printk.h by creating a trace_controls.h for those places that
> need access to tracing prototypes like tracing_off() and for the places that
> need trace_printk() directly, to have it included directly.
>
> Changse since v3: https://lore.kernel.org/all/20260624081806.120105649@kernel.org/
>
> - Always include trace_controls.h in rcu.h (kernel test robot)
>
>   There are other configs that may include tracing_off() in rcu.h besides
>   the one that had the include of trace_controls.h. Just always include
>   it in that header to be safe.
>
> Steven Rostedt (2):
>       tracing: Move non-trace_printk prototypes into trace_controls.h
>       tracing: Remove trace_printk.h from kernel.h
>
> ----
>  arch/powerpc/kvm/book3s_xics.c         |  1 +
>  arch/powerpc/xmon/xmon.c               |  1 +
>  arch/s390/kernel/ipl.c                 |  1 +
>  arch/s390/kernel/machine_kexec.c       |  1 +
>  drivers/gpu/drm/i915/gt/intel_gtt.h    |  1 +
>  drivers/gpu/drm/i915/i915_gem.h        |  2 ++

For the i915 parts,

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging via whichever tree.

>  drivers/hwtracing/stm/dummy_stm.c      |  1 +
>  drivers/infiniband/hw/hfi1/trace_dbg.h |  1 +
>  drivers/tty/sysrq.c                    |  1 +
>  drivers/usb/early/xhci-dbc.c           |  1 +
>  fs/ext4/inline.c                       |  1 +
>  include/linux/ftrace.h                 |  2 ++
>  include/linux/kernel.h                 |  1 -
>  include/linux/sunrpc/debug.h           |  1 +
>  include/linux/trace_controls.h         | 54 ++++++++++++++++++++++++++++++++
>  include/linux/trace_printk.h           | 56 ++--------------------------------
>  kernel/debug/debug_core.c              |  1 +
>  kernel/panic.c                         |  1 +
>  kernel/rcu/rcu.h                       |  1 +
>  kernel/rcu/rcutorture.c                |  1 +
>  kernel/trace/ring_buffer_benchmark.c   |  1 +
>  kernel/trace/trace.h                   |  1 +
>  kernel/trace/trace_benchmark.c         |  1 +
>  lib/sys_info.c                         |  1 +
>  samples/fprobe/fprobe_example.c        |  1 +
>  samples/ftrace/ftrace-direct-too.c     |  1 -
>  samples/trace_printk/trace-printk.c    |  1 +
>  27 files changed, 82 insertions(+), 55 deletions(-)
>  create mode 100644 include/linux/trace_controls.h

-- 
Jani Nikula, Intel

