Return-Path: <linuxppc-dev+bounces-28925-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D23CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 10:06:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyw5Y29Qjz2y7p;
	Mon, 05 Oct 2026 21:06:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791194785;
	cv=none; b=HMsck3rDRn29AR4nd4G5Dr/ZQ2vEHMfuDwuztjTb6nkg6OwbyxhSWm+2vOQVqANN86wihM586SLAa8yVVp6mOWtPkgcoJqxlLbLixnJ7kaI1tPiQO2Jzcq84GRMWcmbamj+hpb2zRONUlPePAbrt51E+5mlFz+VsV7Ob9EkKAhcJtGk4juB8XfLc58QQZVaaqmCOg6RSvmnJtUfVXs1Rivr6L0R3G6kx6wVdxT/Tqpd/Ma7S0Btk8Sp6JyEJ42yKab67X1nD+IYjKSYJsLj97PekuKN4PIrF9Z5t/W6oK1iewq0S8whjiD661EPxLBMffaCJLdpA53OrmCaCDuhjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791194785; c=relaxed/relaxed;
	bh=lAhDeLm001y8d2rTQ8LrJKpRoIPXeBeu9XYjdt9WEUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbgIaZOyBuDYFVWbRkVMIb4ahNCwbFGPpT5j7VcJk1eDB/vqhSyc1Uyt3qvzGXtWZSgXF7AF17Z3NQcyDgM2yogp0AqmyydzYhC3MG2H2smxsLeWaWj+4g3QFjk5wSzEFPwK6sfLJl9AF0nLXRZL+iSSOn8XQoXpSOAsbCsp6tqkFbPmYOjEK6L1tWKREZiWL1YYpDrkAY6uHK/H6+hyPtb8hz6QtigHFbPj0VEO8/bRxtTtjF8fzG40l+FvKxKSG4n6GDHGYCMPWozmrX3yLDlGf5y8jMhaH3MbSLe6tCONKqXwV5G4o0Y+TohBMmPlF58O0vgmvM8jZgTgKUTqTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9Vw8OX0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9Vw8OX0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyw5X2rzFz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 21:06:24 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AEF81404C3;
	Mon,  5 Oct 2026 10:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8463A1F000FF;
	Mon,  5 Oct 2026 10:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791194782;
	bh=lAhDeLm001y8d2rTQ8LrJKpRoIPXeBeu9XYjdt9WEUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U9Vw8OX0iqlkEMKheLqMbvkJ/ddL3ZMGgKrclUymrHHKsSYX1RAEB1YoHNpGaKitZ
	 BFRlYdQ/V6EFB5LJLlqznpli7kI4tcWfKAspzsDdUlxMDxEJ3ZLrcBqhX6sipMKumj
	 BNFHZfwPypV8prDEsa872iyraShZdLQ5/bjwsAdmhauoNpoBqQjHWbXl9bYxxNlOAw
	 hik6sGI7lAHCBsiLayC/uwuOL02m3h3xLVwKk1HXPVu4Gk7xSvj4iDVH/L0aOu5FDs
	 gBSsL7xVIemQlDbtmdU2J6dJLATMj8KB/9LemNVyps/fPA6dgebPfWCmLcSRUTQJ0p
	 9g/ceZ2N8tpIw==
Date: Mon, 5 Oct 2026 03:06:22 -0700
From: Kees Cook <kees@kernel.org>
To: bot+bpf-ci@kernel.org
Cc: morbo@google.com, willy@infradead.org, akpm@linux-foundation.org,
	andriy.shevchenko@linux.intel.com, david@davidgow.net,
	pmladek@suse.com, shuvampandey1@gmail.com, rostedt@goodmis.org,
	corbet@lwn.net, senozhatsky@chromium.org, gnoack@google.com,
	mic@digikod.net, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, jikos@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
	ihor.solodrai@linux.dev, chleroy@kernel.org,
	u.kleine-koenig@baylibre.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, sbhat@linux.ibm.com,
	blum@kernel.org, alison.schofield@intel.com, dave.jiang@intel.com,
	gregkh@linuxfoundation.org, lgs201920130244@gmail.com,
	iweiny@kernel.org, u.kleine-koenig@pengutronix.de,
	vishal.l.verma@intel.com, rdunlap@infradead.org,
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-trace-k@lists.ozlabs.org, ernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH v4 03/11] seq_buf: Copy what fits when seq_buf_puts() and
 seq_buf_putmem() overflow
Message-ID: <20261005100616.d111aa-kees@kernel.org>
References: <20261003035921.1918874-3-kees@kernel.org>
 <d56cb11faf507e24e879644226fdd67d0191840f3ed43153577f5f6ae6854236@mail.kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d56cb11faf507e24e879644226fdd67d0191840f3ed43153577f5f6ae6854236@mail.kernel.org>

On Sat, Oct 03, 2026 at 04:50:58AM +0000, bot+bpf-ci@kernel.org wrote:
> Can this break callers that rely on seq_buf_puts() dropping a string whole
> when it does not fit?

Yes, good catch; lpfc does. For v5 there's a new patch ahead of this one
that has lpfc_rx_monitor_report() print each record with
seq_buf_printf() and, when one doesn't fit, end the string where it
began, so its debugfs output still stops at the last whole record.

I've checked all the other users of seq_buf_puts() and didn't find any
other cases like this.

-Kees

-- 
Kees Cook

