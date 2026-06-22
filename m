Return-Path: <linuxppc-dev+bounces-22874-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDDBCDB46F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 14:45:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkWFZ4rjYz2yVZ;
	Tue, 23 Jun 2026 00:45:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782118440;
	cv=none; b=d9k76mRIQQaEtaHRBZj/HMcCrUWdz3SsLf5yfJIkYuiVSM9gCO4gXO0hKaLzAxGICLVNqePvnJ0MF1yz5xbyxcso+rv1NpKllOv0qiCSMlW6e45mRHmFrGMzqeihGUU1+X3YWsUf7QFBvKEZCVFNhzdv3WILz/aLhcCQV8bwSeSfdIHSmAFNk35wqz7h34jgfYITo2+X++X7dBU6qwA6a4jsOlUdzLkZgftMLqrj4TP3d2efl4JPhGENQ1f2ZiN3371jViE+S2amDIL2VfvVKkS/7TsWvRpxFzEO8SpuLOjABNyeGhSElCPwKmWjPoI26XE7Ayz+dkHV1sPNB4s8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782118440; c=relaxed/relaxed;
	bh=F0QDbKzbwJL5X7qHqHx3lNvTzGz2HWk2gVQO8+kpuo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBglueKXOPSYsLrmqkoZzFvVBO8B6ua9yFamk+wywBfwAr81Yub6s7DY2vxYq/cqF1cpqrUJMiQH7m2eRY8Ryoyo8OiWoIAjE2K/VZAGl+QHkqsOrdOGO6GYY2GF/NIFMJjpIv8ybum7MwNseUdfFA6TnCxUjXQ6hbY6Bwe/dDTchcM7kIKSepmzeHhDdwh7pqXQZXPsk3skor6BCZmXqrc3J7SPp9nbMWOyhoPOLnKVqmoCBJcSZWEA3F29iJnae7uBX4CtEUUNIfyopiKK/Ddt3bbxjEK4+OtbGjbYjTnU3n0sZbiEkSXrh5CeAXap1nxkf85LaZcr+P4mQ7NJaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajlI+5u/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rostedt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajlI+5u/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rostedt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkMSR4kNlz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 18:53:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 903E04065A;
	Mon, 22 Jun 2026 08:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC2D1F000E9;
	Mon, 22 Jun 2026 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782118436;
	bh=F0QDbKzbwJL5X7qHqHx3lNvTzGz2HWk2gVQO8+kpuo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ajlI+5u/5Lj2pViAZ/RRrobaBRBiwWG66TcLSclH6VgEiCX3pzDLlq48vZSrLl/X8
	 83z3ruboQqIDbVazIhHwx5JGip9lf+VbpxcPHWDw4gUbR2Bw69RzekHFOjw35JGN9n
	 l49gtrdtrrpSxrgPKnZ20Ihao2CfoXdAXnGeH046LsVIeNBgYuAr6j2Bl9nhTwMRH1
	 NVF5eY3swwkEMDcbxo+5cJInP+bkLasG/LJYc3V14JQcH8mspffB7CU3PNR9GftU3u
	 4KuHvQ9gz+PnSNbgojMjSyDZOSgzPCMpMUPB3eHzmTZ5JEKCdN/SpRFdTGAODdPinY
	 wPF/FF/evMf3Q==
Date: Mon, 22 Jun 2026 04:53:48 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
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
Message-ID: <20260622045348.3e1a7833@fedora>
In-Reply-To: <20260622083440.GX49951@noisy.programming.kicks-ass.net>
References: <20260621093430.264983361@kernel.org>
	<20260622083440.GX49951@noisy.programming.kicks-ass.net>
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

On Mon, 22 Jun 2026 10:34:40 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Did you forget your C 101 class? If you use a function, you gotta
> include the relevant header.

If this was the way it was back in 2009, yeah sure. But the header
wasn't need for 17 years. Now it suddenly will be.

-- Steve

