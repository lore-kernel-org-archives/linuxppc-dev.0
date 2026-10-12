Return-Path: <linuxppc-dev+bounces-29202-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF696CA9ECF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 00:56:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2zYs6Zy6z2yjN;
	Mon, 12 Oct 2026 11:56:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791766593;
	cv=none; b=jZxwBMAK9LSmnoDa31TAF8Q6cJWgVMMs8QV4CvvO5V7NEIPwO70KF0Q79H4Ey7/MElBJnG+0ps7JE4T/41YCyJ+WglcHU2t8SHwyPtaA25Og5XD5Y5omP6ldSULy7pyZp86fUxYigk14CoUeYWd/YsteH10Z+0dua3R//THoVjoDXdZVl/zDbLosZzFJoNrlUTiC7BEQqckh0h4sGYk/Ax3fv8SIsK7GUqqN7D5wiRDLb09UoQ2R8cOlWdSsBqtvh3sTtFTVxxKVRT5orLcQ6SPGGBXm8bO3G9pYixSDUaFt6NjZXMW/x45WhpwUmTUwmlDOODlXTHU746KoNh8WbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791766593; c=relaxed/relaxed;
	bh=hxf53qqklnBrLDOnVa563Rz7Xv1pTGUtJCKz14BmezI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7e5bQFjA64VlN0zca+oPf6npxgzfzUM7RP6ogt4nYqyDJ7qIe7qLPShigiztZSSTRNLYMjVvvdbSiobOy7qrVG9j4Jl3Y61Z+Kmav3+3ujKABZwfeVWDJG0x+CC/twgOdLh/pEFLJlbemC2F0zrhjM0VFg69KLBv2GDy1OpUwoD98MYrXQnDnWV4AxLM7EAVIp65x8WgmIIh1rVaVSQd+dP7nhxCcWZlhUMniZqjhT/VVNTrc6CUZYrwMEJ5CEwWh11lgkUGkA3Uj11XwnjVw7DOjgkY0e6qxVec4SWMtJgZ+cAgHO93xdCJU8Lct9B32+UJXbvUNdvBVM9U+AcJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Srp4lxTv; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Srp4lxTv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2zYr1bPRz2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 11:56:32 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6947A42EA7;
	Mon, 12 Oct 2026 00:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FB71F0089B;
	Mon, 12 Oct 2026 00:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791766588;
	bh=hxf53qqklnBrLDOnVa563Rz7Xv1pTGUtJCKz14BmezI=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=Srp4lxTvswzQGSZurZdIgokznIEj5wyrJNY9T77hd+9PMBPDY7gvvfunlGvn3ilAt
	 c3UqltVrr8pDMp7TpDjaT+8DWh+uNsnVzDM/cCacLNCkmQrqU91rplRALKRe2zQEwJ
	 jMlbkTkanGJ47er7L6/E5P3rPXC8cQsk79+DBESejMhm2sHhgCTx5z2mewZh/Q+eCS
	 F8OdoYFePL+Ri0/RcYD/MmZKZu+FdwiV3IGzDWFNxqUREJ9KJfdvF45vhgPbd5Rpxn
	 5C0t0G6buQIudJ3rTCmzqaMebg7XdlTR/4PYtBXFKymc2w62JaoqVSbDQu81sYb3fr
	 9hXGvCVno8tUA==
Date: Sun, 11 Oct 2026 17:56:27 -0700
From: Kees Cook <kees@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
List-Id: <linux-hardening.lore.kernel.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
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
Message-ID: <20261012005620.466497-kees@kernel.org>
References: <20261003035906.too.263-kees@kernel.org>
 <20261003035921.1918874-5-kees@kernel.org>
 <asEhEe0Urb5Wx7yi@ashevche-desk.local>
 <202610040023.A3865A6@keescook>
 <asIPlnb0noMd33rr@ashevche-desk.local>
 <20261005112209.1e47fa-kees@kernel.org>
 <asOKvhT01aNb5-Dg@debian>
 <20261005155839.d5d200-kees@kernel.org>
 <asPSYn7sLqiH39Fu@debian>
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
In-Reply-To: <asPSYn7sLqiH39Fu@debian>

On Mon, Oct 05, 2026 at 06:43:23PM +0200, Alejandro Colomar wrote:
> > Yes, though not often: the sched_ext debug dump builds a nested per-CPU
> > seq_buf from seq_buf_get_buf(), which returns a size of 0 once the dump
> > buffer has overflowed, and it handles that case on purpose (see the
> > "$s may already have overflowed" comment in kernel/sched/ext/ext.c).
>
> Hmmmm, so IIUC, it is a sentinel value, and not really a buffer size?

It's the real size of what's left. seq_buf_get_buf() hands out the
unused tail of the seq_buf. Once that has overflowed there is no tail,
so it returns NULL for the buffer and 0 for the size, and sched_ext
initializes the nested seq_buf with both. So that case does get the NULL;
the 0 is how much room it has.

> Did you consider not holding the size of the buffer, but rather an end
> pointer?  It also allows you to find how much you can write to the
> buffer, but has slightly better semantics: the end doesn't change if you
> advance the position.  'end' can only change through reallocations
> (which I don't know if you do in the kernel).

The size doesn't change either: it is set by seq_buf_init(), and writers
advance "len", an offset from the start of the buffer. seq_buf never
reallocates.

An end pointer wouldn't remove the empty case: buffer == end is the same
condition as size == 0, so the accessors would still need the check. It
also makes overflow harder to record. seq_buf marks it with len == size +
1, and the matching position pointer, end + 1, would be weird.

Changing the representation would also means changes outside
lib/seq_buf.c, since tracing reads seq.len and seq.size directly
(trace_seq treats a zero size as "not yet initialized", for one). I'm
not saying that's a good thing to bypass the API, but rather that such
a change should be its own series.

-Kees

-- 
Kees Cook

