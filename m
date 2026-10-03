Return-Path: <linuxppc-dev+bounces-28824-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF627CA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 10:31:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxhlD2PGwz2y1W;
	Sat, 03 Oct 2026 20:31:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791023480;
	cv=none; b=KDthDiANHQrMGEQMj2SQc/gmIkNdhngRU7lA9e8UlozN46z8LmaHMtSackk+qh4RnVw+puTMFUCzmj4RpoH4t8jxFKwSjUhIlvJf68JcPEUa2WiImu27L2qIgHvLykUDFiazJiwiK3OkxvR8xG0PFHdP8jON5SLuwu3RKb9iEAU+Bz0a9zqsPxoa3DWmYYQS1iO5XTWg8yUFHfydARaAvoQrofG2ltccM6qu3euvPeYYzLNVREyk5MmQUZTysXqQaNPeJ+PjIyKQeY41V+NhLQmO1d/ldMfBbsjocSjbyqwekXxWeFE5S86Go6o/Zt/dt7Mq5SQJ+6hUvb+WhxuyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791023480; c=relaxed/relaxed;
	bh=JD1KrrdpLVmHcYg9pYizr+EY3Jnx/IklgTtkuzFE98c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gw09YZJ6uJt8n4RNlBTtEUkccXx/L6w2Ur7v42mRKx6aNIVwz/zDgMzaXdttzr6toCdAeXN01C1lGTC0ovbzs4i8/qO3udFipn7i+q5Di6009zDyvZxuzozeEjfEk11liJtUwGXVItYI4yYHfDjcHjFIVvZUynYQZa5lX0pzeOC5SlxIAuxloT1cCcR0MrSVt44LE6pTZxJhUW+FYFqjMtVR4bruABz247AiRo3iGrqbdomJ+5nisHsuloH161Ks6jKnWz8g+inZiusLLxLEjjnQ8+WsRmOfi5tUGxWp9SeU699dKErK3s9fgCRDfJQqO9E1eBQkVGb3tlhWxv1/0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJubNwg8; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJubNwg8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxhlC2ZDdz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 20:31:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7C07D60D82;
	Sat,  3 Oct 2026 10:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230911F0089C;
	Sat,  3 Oct 2026 10:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791023476;
	bh=JD1KrrdpLVmHcYg9pYizr+EY3Jnx/IklgTtkuzFE98c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jJubNwg8UjkFZDFCgXganeVccWeCUC64B+nvX/QJCoMYXCR46IeLHcDEoC9WXNkcA
	 5ruXH4DMtVtjhNA3d7Uv9pKe+IwqKHYmShLEdJJbzIpK4vuV9dVpZIJ60E6msg+z9i
	 4ti2IfPt7tuWzkUfzzC3uOvSCdCs+N7Wy58NOZc9wgMz5chltNhTn0TZzkalwkJPMG
	 XYVBwyjFfZ1ZdXt14iY8a8VKJi/DAPbLmvDeLBF1DvlcoMfWEqbZ45BNIbuT/5yazm
	 nRU/EDsrSmIva7nHl/5b7LeLaGnBwdw1GGhmcVLS3nQJaKo9nu1Q/zcaFKDoywybDy
	 to4My81OLjUmQ==
Date: Sat, 3 Oct 2026 03:31:15 -0700
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
Subject: Re: [PATCH v4 08/11] seq_buf: Add seq_buf_init_append()
Message-ID: <20261003103059.9e0b86-kees@kernel.org>
References: <20261003035921.1918874-8-kees@kernel.org>
 <f3b5a05404cc45b59981e869a0203ed07497f6f6942e6d72cee63b37612b7cda@mail.kernel.org>
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
In-Reply-To: <f3b5a05404cc45b59981e869a0203ed07497f6f6942e6d72cee63b37612b7cda@mail.kernel.org>

On Sat, Oct 03, 2026 at 04:33:59AM +0000, bot+bpf-ci@kernel.org wrote:
> This isn't a bug in the code, but is the changelog accurate when it says
> seq_buf_init() "always sets the new buffer size to 0 via seq_buf_clear()"?

Yeah, fair. It's not worded clearly. I've fixed the wording for v5
to say seq_buf_init() 'empties the buffer (sets its "len" to 0) via
seq_buf_clear()'.

-Kees

-- 
Kees Cook

