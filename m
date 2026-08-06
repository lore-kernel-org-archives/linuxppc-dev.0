Return-Path: <linuxppc-dev+bounces-25492-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B41CC56205
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 16:17:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGC9h3sssz308X;
	Fri, 07 Aug 2026 02:17:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786033064;
	cv=none; b=GOjer/ecBZJGMW4r/TnnVK+A9zMOmgIUuNTu9HZc4AgyEYJ41nW3SZgaEJsXWxaaBQyEK6L0C1h7UY0KdRVdqFIoU9jKNpFpmm2053rlAqkB5vkucGFQgT5ZWtEhegR9iyukBBNyu5u15LVZOYXUoF7UzD0LzTjKGHyI01VjskZr+kDvT23PvZT2dXA4scLjU4RCKAZvF0uC3Fq/u9tTKt7ClEtlhsMu8UWpAGuCR17mEoPkNuC/HpY/mEViAAx+jp1kV07XXs3fY372pF/0RgtUhhCCNljsKB6HvEBdf7fwEX13xlfS6RyBl09jE5gaO7xouLu6h3MChJzpUpLbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786033064; c=relaxed/relaxed;
	bh=hnBlfXJsXaIiSYhJCF745YIsLdwuhGEKGIc9NgDa0/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bynDyh/qD2EBSkLNEPRMNNnvtlZ/a52BJkWgvo5m+OW3dHcLO8XQ/esiUEivM6pxTHaQ59ux0U/lWWFXn0fTV7rYHlVIlo5aubDX5aXLBXRBMRYFwqLY9N84/U371xmH1aNBd+AWLtDjP5FMoUbusbcjLcSxDGGsAJj5Xnkai4qNQ+4cmhrt1f8CLjeOav67BkZlHDQpjS5nLNKjQFMw/QUwHp9Wab0nZprtoCgBxsf6bPituZcjK6BT1a259lay5pY8EaEasqOsxb/Ca7XWvZ9mx4aagsxNpDya8xb4gNpXOZqph7MIcLAjpaof/rBlJY6rUghdh5d3uKMtzVNe6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLPb0sfi; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLPb0sfi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGC9g6h6Sz3080
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 02:17:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 81AA14053D;
	Thu,  6 Aug 2026 16:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C0C1F00AC4;
	Thu,  6 Aug 2026 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033061;
	bh=hnBlfXJsXaIiSYhJCF745YIsLdwuhGEKGIc9NgDa0/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KLPb0sfixqc567iKbJnqdy7pW/Ov5eDqPyLz+OcDPQBbvxLSp6l/h/vyqX0HcM5Ag
	 ga4gETeKZ0dOT7oL2X553ufujIbgnlSGgmzepBDt75VTewmL7h4dxaAyVGFj4g49LX
	 o9HSQE5IVaYrt3tq/E+4caPJBLsQ5Yy/XAZZpRwyZSIgBWRNjCCA8vfICGY/CypmZN
	 y7IeHdYfb7bp9OXcpghtqTcldacXorKTzALeFXosoFXi0xFglLVi0+o4e2JUVwzrsh
	 0FBA0j3ag6N1M0IA66xVPpoQVNH0KK1LB+11j7CArEnhSQ+k8wU9h5FnHkHUlTMzSN
	 J+qw4taiXJ7Dg==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
 maddy@linux.ibm.com, irogers@google.com, 
 Tanushree Shah <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com, 
 Tanushree.Shah@ibm.com
In-Reply-To: <20260725184953.234759-1-tshah@linux.ibm.com>
References: <20260725184953.234759-1-tshah@linux.ibm.com>
Subject: Re: [PATCH v4 0/5] perf trace-event: Fix overflow, loop and
 cleanup bugs
Message-Id: <178603306100.1984988.9265776445175930441.b4-ty@kernel.org>
Date: Thu, 06 Aug 2026 09:17:41 -0700
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 26 Jul 2026 00:19:48 +0530, Tanushree Shah wrote:
> This series fixes five security issues in trace-event-read.c and
> trace-event.c:
> 1. Stack buffer overflow in read_string() when a string exceeds
>    BUFSIZ, due to a missing bounds check.
> 2. Integer truncation when passing 64-bit sizes into do_read() and
>    skip(), which use 'int' parameters, causing uninitialized memory
>    to be dumped and parsers to read out of bounds.
> 3. Double free / use-after-free in trace_event__cleanup(): it frees
>    t->pevent but never clears the pointer, so calling it twice on
>    the same trace_event touches already-freed memory. Also fixes a
>    related leak in trace_event__init(), which overwrites
>    t->pevent/t->plugin_list without releasing any existing handle
>    if called more than once on the same struct.
> 4. Heap buffer overflow in read_ftrace_printk() and
>    read_saved_cmdline(): size + 1 can overflow to 0 in malloc(),
>    allocating a tiny buffer while a huge read is still attempted
>    into it.
> 5. Infinite loop in skip(): it does not check do_read()'s return
>    value, so a crafted size can spin the loop indefinitely.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



