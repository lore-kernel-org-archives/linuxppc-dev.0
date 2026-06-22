Return-Path: <linuxppc-dev+bounces-22881-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B4ECDB46F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 17:20:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkZhh5t6Fz2yVZ;
	Tue, 23 Jun 2026 03:20:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782147127;
	cv=none; b=RbL6eGQBb7BXlI+09shAs3Ymk56ZPbiKn51DIqV0b3x6w438aKIRQjmOlQZhnR1vQH/renQUvGIyUV1xk5kMz8TL079jWwn6ABWmHK+PLE+b+A0TCnMjTeP1f3sQT4A6tr7bLW/VbN0dAjtJ7O6I1j1sL3bFPKtuHgc0/i/ji/FeUo6Gw8MhJzRK7d4GLsZk5AJNP+qOSChFmZDrr7Fl7h9ApGmDs+i1lXhuq4HsJ27oFnvJH5aqZehg+OHl81l2DhfA/Y567W2qWyJAOM/cKpfE0INSDx4I0pWuI0J8VfZiGshUrsx3VRu2m0sdz39i+7DAOamUnUBCIJAG/bE5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782147127; c=relaxed/relaxed;
	bh=KXhjFgbhEvwE+7GGBfh7My0VIVq6OjTLQwMtEz0hufY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eeqYryXWwtWX+pIhyBPqMIISAIEgh0isMBwlW5NP31r7W1kkf2DmuGH+O/TkV9w/6T/xuiOXyoPoQlx5T7HNHfCfoxpqnNBPjYd5yRjgZRWWNGAo7asFoSAEPOpODcLcfPpXZ7nDppCGUoF1PkFjvhFruW7knzRaUJav/I3JiaTBixthYxlmmCpzmrVitxCSIXzpozmnonJd72hVPwKRa5VyMRoolIjeU+ha+y0bjbxyt2pB2QUuxgzFmEDT75kdWx3f9H2RcujviPeTS0IjZNVl0FYoYmvfxfMNa5+X2VjV00dGUrcm+pLCqoXeQlZyeGr1E2DdMy8u9KEB2mMscQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4kpffoq; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rostedt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4kpffoq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rostedt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkZ462sl5z2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 02:52:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 399EC43B13;
	Mon, 22 Jun 2026 16:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0041F000E9;
	Mon, 22 Jun 2026 16:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147124;
	bh=KXhjFgbhEvwE+7GGBfh7My0VIVq6OjTLQwMtEz0hufY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C4kpffoqKELHy6h2iIonBbM+lwHOlkqgrFXueJXDfdgl75fDx8nTrSA+oGiGyoeAm
	 8CCy0uyoOREJUge4zC6mq+dv0w+QL43toIPSNlcNAZyZKDjugsy6al/c7V2Nxly4Pl
	 B3u0wZw90AH5q2Vforbc/8novl4n4De9d7hKEY2j9fwmOHjRuuHlA8HYlkPOQSxTMr
	 w8OjFxrmzo3xN9JG3zdPXZhL02HItS9kysxEXgHLRRSGAVfOqOYr/WF7zxLGK20H2R
	 AQhZ61uSQFpPSM+xdZ5/Wi01z1P5qKOyIveeDb+LOtEbWIs/Vdg1dtFfhX3DZ+GRC2
	 IABQXBNVHhFSA==
Date: Mon, 22 Jun 2026 12:51:54 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Julia Lawall <julia.lawall@inria.fr>, Yury
 Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 0/2] tracing: Move trace_printk.h out of kernel.h
Message-ID: <20260622125154.6f5b9b33@fedora>
In-Reply-To: <08b3c961-18bb-43d9-8d7f-8a87bcad0afa@infradead.org>
References: <20260621093430.264983361@kernel.org>
	<20260622083440.GX49951@noisy.programming.kicks-ass.net>
	<08b3c961-18bb-43d9-8d7f-8a87bcad0afa@infradead.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 09:40:45 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> > Did you forget your C 101 class? If you use a function, you gotta
> > include the relevant header.  
> 
> Also item #1 in Documentation/process/submit-checklist.rst.

What is that? Remove all trace_printk()s before you submit?

Because that is what you should do. But now you also need to remember
to remove the include <linux/trace_printk.h> too. Or, I guess if
someone uses it a lot, they may just keep it in their files without the
trace_printk()s.

-- Steve

