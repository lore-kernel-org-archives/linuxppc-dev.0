Return-Path: <linuxppc-dev+bounces-28827-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB3DCA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 15:37:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxqX65S1Cz2y32;
	Sun, 04 Oct 2026 01:37:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791041830;
	cv=none; b=Enn7W6MgmRjbwo8YaxJzsq/LBxNG1ouCgy85kBx8b3USs/53AReeOLJU0wVj2nwSzI3pdKGRy+WeQZ7o+rj0XDNtEmEoTIJC77CU7EGyEMmkfnfNPwCq3kOhqxO0fD8+POXD7LqjmPzccpcIrgq+dctBtOaqRACMqLBsozvOM5RQ/iCl221Je1r22gSDRnjQ2LLpDp1RrXIvcNZ3ptUp6a0P5jJgQF+tBt7iC1MEikqHcijI5D0/Zs8q4cdFYyWmJo1HlUIlJOyOo24FUgEMKs9umelGcbB/oGSKEtRGxRPyl8IgbxXaEKgmWlphqf2GdEc5ZLbjDSDQdZp/Fm/yaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791041830; c=relaxed/relaxed;
	bh=rTEhkvEdzr5Wreyg07MhO0d6IPlQZMMHO9Fj4mJgDIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KX1mg9xMUDENpunAHb0JqBTI7hTMWOX+xtjlFxf7UhF97bnbAqTTm/+G5SBPqJ6do8P6c8P56q7w06zWfiaVaiN1BoaWfhpumpW5nUkhtPSdRL+DGqYJmhFJ+KPJ/l9WrbCiKi4wEGQXlbTv3OCUCq25cuL2Efa2p3ovnPaRO3EOVaZgbuFbXd9EepOLMeCS9e59cLuoFSZngjuRGRfDffmp3sRFNNjbJq11HPN1Y8o+sGLF42/zPziS0iQwr/jOWdiCMPm+7F06qTl/eL90zwSGzyxQIrIFiRfuMOWQPUvICQJrgFwICdomeo3om3gbV4puL5b+/wP7gFVj6hCRDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O8YgH+5T; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O8YgH+5T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxqX32fZBz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 01:37:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791041827; x=1822577827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P+t00OnuGzY0L5xQoewWtaL++U09V2T+k7ZFg5Yjqtw=;
  b=O8YgH+5T0gbnNTkaxQ+vB7bPIftKoVS1z+CsguqsdwFiV87ozGWZvvEU
   pn8PwcZ2MU6QL11Jzl4k6cpMDABNZjCvJRCSVnXEB7yE3Rnj+EtjlE0LY
   lIxeL2G9hnxN+6GbddwWE5FNieiwPpZ0+HkELj1jDl3eRHKXm5VgxrMnM
   OuxFfkuodL7PUymxVfOLZeenrFpYmFl3ydjTtms6V/sMX54jnkgZu93iS
   t0zIq49zodpqLB8dZVPgOm5ZjtKsZ+2Dw/9XSdwj68NFBZ68kpaueuQo2
   T5T1Wq+vV+ohXUw7ebr20pw1S3J7n/35r2Sxhcd6M1EsX20PxfX43CP9w
   g==;
X-CSE-ConnectionGUID: /UaiTBX2RKiahO7qhpLzEQ==
X-CSE-MsgGUID: tgAb8h9UQMu7yTIqONogfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="79338280"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="79338280"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 08:37:01 -0700
X-CSE-ConnectionGUID: RYv1bP9xS7udNAN9jt62PQ==
X-CSE-MsgGUID: 2T49n9CQQDWkG0afqOemkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="280207548"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 08:36:51 -0700
Date: Sat, 3 Oct 2026 18:36:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Ira Weiny <iweiny@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 05/11] seq_buf: Add seq_buf_strlen()
Message-ID: <asEhEe0Urb5Wx7yi@ashevche-desk.local>
References: <20261003035906.too.263-kees@kernel.org>
 <20261003035921.1918874-5-kees@kernel.org>
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
In-Reply-To: <20261003035921.1918874-5-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 08:59:10PM -0700, Kees Cook wrote:
> Several strlcat() call sites being converted to seq_buf need behavior
> seq_buf doesn't currently provide. The return from seq_buf_used() is
> not the length of the string in a seq_buf. Once the buffer is full or
> has overflowed it returns the buffer size, which counts the byte that
> seq_buf_str() replaces with the NUL, so a caller that needs the string
> and its length has to call seq_buf_str() and then walk the string with
> strlen().
> 
> Move the termination out of seq_buf_str() into a helper that returns
> where it put the NUL, and add seq_buf_strlen(), which terminates the
> buffer in the same way and returns that offset.
> 
> As discussed in review, don't add WARN_ON() for seq_buf_strlen() and
> drop it from seq_buf_str().
> 
> Add tests comparing seq_buf_strlen() against strlen() of seq_buf_str()
> for empty, appended, truncated, exactly full, and overflowed buffers,
> checking that seq_buf_strlen() alone terminates a full buffer, and
> checking that a zero-sized seq_buf reports an empty string from both
> accessors without touching the buffer.
> 
> Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
> and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.2.0.

...

>  static inline const char *seq_buf_str(struct seq_buf *s)
>  {
> -	if (WARN_ON(s->size == 0))
> +	if (s->size == 0)
>  		return "";
>  
> -	if (seq_buf_buffer_left(s))
> -		s->buffer[s->len] = 0;
> -	else
> -		s->buffer[s->size - 1] = 0;
> +	__seq_buf_terminate(s);
>  
>  	return s->buffer;
>  }

Looking at this again, can't it be rewritten now using _strlen()?

	if (seq_buf_strlen(s))
		return s->buffer;

	return "";

?

...

> +static inline size_t seq_buf_strlen(struct seq_buf *s)
> +{
> +	if (s->size == 0)
> +		return 0;
> +
> +	return __seq_buf_terminate(s);
> +}

(Left for the context to the above.)

-- 
With Best Regards,
Andy Shevchenko



