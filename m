Return-Path: <linuxppc-dev+bounces-28929-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9F2CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 12:24:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyz8v2tH8z2y8G;
	Mon, 05 Oct 2026 23:24:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791200077;
	cv=none; b=LzzmKIW0U3SLrx1VpBxRSVdJKG860jCOLwkq50Xn6Wm0z9H6MdkY+Mks0kg/089/g+VIjbtA9On3TqcWYGT9O74jjmpAfovugA2VaDdo0s8Pmbu/U9dQs/4DVp82Ynr/L7QkP3wkF1zZbzn6oiwTv1opJWOqq2B6pMDR40+b16MmpK017oGmr8q3zTga2FCy9Wxx6EDa2b3A3a0GFLrhkaShrP/qhsXO/pGxSx2OzL70OCRNnmCpYMOcIBb6AmOJhEw+mCeBn1WZT2QLJIzgHwtTvo75Cpji/GMSoX9Iyx4W3/2iZ7/tmpNvWtpIh7ruhn6O8mDsUcQ9SDKkdFx/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791200077; c=relaxed/relaxed;
	bh=GfHzSlHJ8UI5Oxtdm8BU7e9P310nmqwzsr8Vwb26i2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETkMdSNIJ1MNZ/CT9WSWJq575sPSyslhz8bD7gVQpylnPwAkDP/kTBl1Ppya0EPlLNjO8j3NuVyL2STZ9RrbbE1NNwINtGRK2lsXZs6N2F0qUHzhGaXcZJ6nK5vjknjvJC/U4Zc6Ks8yQo9OymO4rrxT1H+khM9KVx637uT7xJZ9ilyKESyCF9DXdCgPUEkRqNlaO9iOt0YUwbjAlbhGuIcMsGx+Vt7+u9l4nNyevHB3pEynB7lPZCC0/WNCUiCnmeovNDlU7vdsZcKnY+uTXjPtEgd+JISa6/lNCjxFvqfxbU6znI8DJC3Q2Cn58cbWlu4g/psgoZ7cvKjfLLfv8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGu7cFHi; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=alx+linux-hardening@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGu7cFHi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=alx+linux-hardening@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyy3H2ytfz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 22:34:35 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5A2126022E;
	Mon,  5 Oct 2026 11:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592031F000FF;
	Mon,  5 Oct 2026 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791200072;
	bh=GfHzSlHJ8UI5Oxtdm8BU7e9P310nmqwzsr8Vwb26i2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LGu7cFHiLoleVxKaNXEWg3+hk4n4alCXvLuprPWQEhjOKkys62HeJhx/UbENV031V
	 vIn/6TtJtxJ4vVZb9rnXmiywGirW0RgkjvnuB58tASjcVtU6wkVSS2shU+C/HAHFbp
	 KlgEOWVTWGCe7lgJrWwgepyszO2dtI/ANUif+WUxrjQTe62Dep2+QJVwl3tBvdSTPQ
	 8tdIKlDYRdYPxPlJ1II3h6zxg0tiajgIXcEHp0czbPWMG/jqrvSNQIebFQEBDguOoU
	 zgLw8YhUIYuFxKCCDsOuzd1eZh0m0cOUc1RtREjfI7QsJ5nwq45p57p9GTKfZsiN69
	 fwUMLC3DnyLNg==
Date: Mon, 5 Oct 2026 13:34:10 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bill Wendling <morbo@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, 
	Shuvam Pandey <shuvampandey1@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Jonathan Corbet <corbet@lwn.net>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, 
	Thorsten Blum <blum@kernel.org>, Alison Schofield <alison.schofield@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Guangshuo Li <lgs201920130244@gmail.com>, Ira Weiny <iweiny@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Vishal Verma <vishal.l.verma@intel.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 05/11] seq_buf: Add seq_buf_strlen()
Message-ID: <asOKvhT01aNb5-Dg@debian>
References: <20261003035906.too.263-kees@kernel.org>
 <20261003035921.1918874-5-kees@kernel.org>
 <asEhEe0Urb5Wx7yi@ashevche-desk.local>
 <202610040023.A3865A6@keescook>
 <asIPlnb0noMd33rr@ashevche-desk.local>
 <20261005112209.1e47fa-kees@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005112209.1e47fa-kees@kernel.org>

Hi Kees, Andy,

> Date: 2026-10-05 04:22:15-0700
> From: Kees Cook <kees@kernel.org>
>
> On Sun, Oct 04, 2026 at 11:34:30AM +0300, Andy Shevchenko wrote:
> > On Sun, Oct 04, 2026 at 12:26:39AM -0700, Kees Cook wrote:
> > > I'd rather not make all 0-len strings return the .data segment's const
> > > "" string...
> >
> > Good point. Perhaps then to add a short note to the kernel doc,
> > so we won't see patches based on the suggestion like I gave?
> 
> Yeah, reasonable. :) For v5 I've added this to seq_buf_str()'s kernel-doc:
> 
>  * A zero-sized seq_buf has nowhere to put a NUL, so the empty string
>  * is returned instead of writing to @s->buffer. Any other seq_buf
>  * returns @s->buffer, even when it holds an empty string, so callers
>  * always get their own buffer back.

Are such buffers actually used on purpose anywhere?  Why not keep the
WARN_ON?


Have a lovely day!
Alex

> 
> -Kees
> 
> -- 
> Kees Cook
> 

-- 
<https://www.alejandro-colomar.es>

