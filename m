Return-Path: <linuxppc-dev+bounces-28874-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7669CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 08:34:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyG6P0Fxyz30BJ;
	Sun, 04 Oct 2026 19:34:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791102893;
	cv=none; b=MipdVy4b63c8DcwVGyWc6vkRRJJ3fZ7bFOVeJC1oEzSuHiCXPei5iwAZ/fYbM/9HFFngGq4CynbOcyogG1fasO+LvFPy7OgUuAgEFNO0yohMu0+LLJxRBL62myxHkHNRagEMn8L5fGCkOOMtvXZpVju9+AfqjiisPQX7KST3sJqP/wwAbpP57EEgwosKJ6SwqEWUiODOgjILb4RovB3HlpEfr9jZBuSvpsPm+7bpL3qtFKH9qaMB4esKi2Ef/Kvy7HgqbwXTT0VdcVMyu84Gv1i/RM1zSL4TNRMnrci4lgGQhzCeV6HIMlLA/Z0WMYRnnCqmR947wPfR7hoek7rfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791102893; c=relaxed/relaxed;
	bh=M69W4XodigGd2v1ABZQ+ndV4/a4VCqZh/WJrm/TnuuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrNJuvQja122LcrkK12ddodwDEGs7iRz0CL+olZOFaEU0OAYyyAyHEVTzB0/vrsChHFUukrEnz8MfCunTaLBcBUZdaaNavG3usxSFN5E4Ks2eulobq++tld2s4NvdCX6G8OMNMtqrFUcFZUxaLupxyExI2Nv5qjF1yrq6dHdVL+faY6rWHaUGzp8e3WurnJB8GdZgfGXwkSGmnNkyO8T4uACiCAbR06jpWuJkYd8UH/GtAMToNZ75+znvnfcMZWpOGzzhD8Vn3wJ5ByEhjP75f+qp1h/WMalb0NkJRlyJIe8ldnpfeBV9bckQ41rY6Yu7eCmjwZRw2lt3uZrEONhbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HrlMrCxS; dkim-atps=neutral; spf=pass (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HrlMrCxS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyG6L0vLDz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 19:34:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791102890; x=1822638890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mhi7+Hi041UrB2MzTnYXKOXt0lQgzO82otWdLKr7WgI=;
  b=HrlMrCxS1kLHpgmYkBD3gyAL8W3lH82RmNuPDhoqEtqJ85moEkTKo8//
   fcKbkCn8EUqVjOK0ZTbmXwtyN1K0AosxeswoBoMZA9i5cXP0Ypkuserca
   jMhUPB74KAW5VolMFKG5VU+V5xZ0pv35EX3/eR/7El7pZZVL1ZMAMzNDN
   knP0Prdo4q8lp0HZVNGllH6IEGD3dbAtFIzciAaccqPYOJaVOq5gJl6zE
   BkAJZz579IgTT712+iKusyMGVcL3AKOxez0quc03QcwIW0WrKNjngCx+r
   8YCMXQWZyVBNR0iRzzrQolecDJh0tID4NKsebLwBUpcggaLEj5EcU4pdz
   Q==;
X-CSE-ConnectionGUID: TYF/FiY6RpKSctxXOjOxsQ==
X-CSE-MsgGUID: 0QtU8wlHRQCxt2aqTgdCbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="90834740"
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="90834740"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 01:34:43 -0700
X-CSE-ConnectionGUID: nrUIyO1XSTCYN10HdI6xtw==
X-CSE-MsgGUID: HOGC8YPlQBeD01aSwPqHdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="275678711"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 01:34:33 -0700
Date: Sun, 4 Oct 2026 11:34:30 +0300
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
Message-ID: <asIPlnb0noMd33rr@ashevche-desk.local>
References: <20261003035906.too.263-kees@kernel.org>
 <20261003035921.1918874-5-kees@kernel.org>
 <asEhEe0Urb5Wx7yi@ashevche-desk.local>
 <202610040023.A3865A6@keescook>
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
In-Reply-To: <202610040023.A3865A6@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 04, 2026 at 12:26:39AM -0700, Kees Cook wrote:
> On Sat, Oct 03, 2026 at 06:36:49PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 02, 2026 at 08:59:10PM -0700, Kees Cook wrote:

...

> > >  static inline const char *seq_buf_str(struct seq_buf *s)
> > >  {
> > > -	if (WARN_ON(s->size == 0))
> > > +	if (s->size == 0)
> > >  		return "";
> > >  
> > > -	if (seq_buf_buffer_left(s))
> > > -		s->buffer[s->len] = 0;
> > > -	else
> > > -		s->buffer[s->size - 1] = 0;
> > > +	__seq_buf_terminate(s);
> > >  
> > >  	return s->buffer;
> > >  }
> > 
> > Looking at this again, can't it be rewritten now using _strlen()?
> > 
> > 	if (seq_buf_strlen(s))
> > 		return s->buffer;
> > 
> > 	return "";
> > 
> > ?
> 
> It could, but I'm vaguely nervous about the difference between
> 	s->buffer[0] == '\0'
> and
> 	.data ""
> 
> i.e. we only force the return of seq_buf_str() to be _not_ just
> s->buffer when s->buffer is weirdly impossible (due to size == 0).
> I'd rather not make all 0-len strings return the .data segment's const
> "" string...

Good point. Perhaps then to add a short note to the kernel doc,
so we won't see patches based on the suggestion like I gave?

-- 
With Best Regards,
Andy Shevchenko



