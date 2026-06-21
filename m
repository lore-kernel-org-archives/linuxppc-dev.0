Return-Path: <linuxppc-dev+bounces-22862-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4863CDB466
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2026 23:35:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gk73f3mRSz2xyj;
	Mon, 22 Jun 2026 09:35:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782047046;
	cv=none; b=gRm5VlV3MF+Gd9eoJaWXzx8UFMiRGVuZREpDojNaNrtI3jzTsQjd254gMMrUyicc7802h8/wPLo29aSOQ1+3+eA0PC2ktt/q1KFDF35nH39Y34OqQ8OZl+1nSN53urTO/fuQFddeZ1XSF2TPYGWGGpvcj70X8ruz6F5MqCTk8SRKxgcHO+XlTINaIGeJtdGNFBDFLrndEx75dEXm5pLerieIECOhVtCyJwwcVoHcVYBt/hRstHEdYqbd5TSS5R2R7lrNqk8qjwWEIIRrQ8/DWA+F4jNd8kf9rqkrnLBnDnm7g/g8EeuQxx7GzCqarexZsHRfIZyFX7mFTgiIbHqx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782047046; c=relaxed/relaxed;
	bh=XZ3QL+ViFIRQLIm9wDhWdL0BX/Xy+P2cyftFjHpTXuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fU1/V8+bZ4xaR5Ki8SEv2Huswjc4bH8cZyon+ToPYlZHTHVz6sp+nDJNsvOTnLhqAmIOh17l++tGa3y/24w7DkdkK+kFocBjqijsgxW4+dQdpPbPMk2uUsXpGUnD/12agae5dp9riIL/n9gqEDgh8YeN3+rQDxG+hRrNGEE7+aA3f5h4oJC3qmNJ3birwXAYOidRABANDz3PMI5OK6JQt6BdgGZfYfBKTwELDtDraiCRWBzfjbKGX0CeIa+XctkdizVUbL9ebUJT5LuR92rdMf9MkLXdS3zc59EZRuGMNg2S466pnYbiIeDMH2JzbNaaTPr2MuiEv1q8QgHRIr+W1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fov1mXvD; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rostedt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fov1mXvD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rostedt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gjs3T2fJbz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 23:04:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ED7EF43E1A;
	Sun, 21 Jun 2026 13:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436C81F000E9;
	Sun, 21 Jun 2026 13:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782047042;
	bh=XZ3QL+ViFIRQLIm9wDhWdL0BX/Xy+P2cyftFjHpTXuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Fov1mXvDuGCK2T8sN6e2OfQHKCECHfbpGXRBBqt0mJumjJ/lQbWWgN+HJ+/A1VLw+
	 e5YBQ183dvuJj8bkhkLpBwxFrOxwQLVALwfGN8E1vAdvSrax2YUe76xVCjK7uPwOFi
	 8L8TB9EiAaEyP+6x5OTgJet8aZiHBkKPALBPE4+VYsqKVHMeJsBx9VwREe4epBtPeP
	 n9K1YBwfMVRT70tbP5fJHUITXTsn/07OQJHxOY03KDzngCMaGRvGI98OxNWNIGSt1/
	 pUwueEV4G7f1R4ZCP/PbFKS6BI+0tZTyLgw9UhMTaK5YsTglkNBetTBg7DaYsXC78p
	 S9lKpmXhld3Cw==
Date: Sun, 21 Jun 2026 09:03:53 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Julia Lawall <julia.lawall@inria.fr>, Yury
 Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean
 up kernel.h
Message-ID: <20260621090353.24772584@fedora>
In-Reply-To: <20260621135531.243375d9@pumpkin>
References: <20260621093430.264983361@kernel.org>
	<20260621093811.168514984@kernel.org>
	<87ik7cmcb7.ffs@fw13>
	<20260621135531.243375d9@pumpkin>
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

On Sun, 21 Jun 2026 13:55:31 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> Indeed...
> Isn't trace_printk() just an extern?
> Having it defined somewhere isn't going to make any difference to build times.

No it is not. It is a macro to cut as many nanoseconds as possible as
trace_printk() was created to debug tight race conditions and any added
latency can make the race go away.

-- Steve

