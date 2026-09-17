Return-Path: <linuxppc-dev+bounces-27634-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21766C88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 21:19:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm7tV39GVz2xns;
	Fri, 18 Sep 2026 07:19:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789679970;
	cv=none; b=HPRxWyQe/ejyQNfiGwClHJBHK3U3T49SV34BcjZzLnBsBNdv8tzkYR+/PxdbrOKqUNWvGxpJhgNz7tvf2b9TE6bCI+CY3Z7ZahIIZFYLwg5q2iWvMQ6OPBqElJ2LbSuv1+eAQgBXvPj/D6YNN6v6+TpStGwMIENaVVTTp4V0G9nONnLWEN30OFore+HSSyUFj/nbP3A0vb6U29iG8GE3ZGRggfNbXHTBscH6tz04M8WoMCBhQBfc7xG+LKRpGGqmfro7E9JXlUs4qlHY+UI4WYcoNfbhV5Vlb5JPupB3ow6p8OSWHkylozpoRo200656jYuiI/fnqGL6ZuKxfEXIXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789679970; c=relaxed/relaxed;
	bh=ktGRo/YBeSz9wnbKkMSYDEjE6CYr2/sUae67RlWGYCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHafLjCtghxGtCWxGfNWVj3I7+16K5kcQ72eLIQrbqyLC3zQecdxWM9/6VgfBddExeOPojk3e2RDq0C92CBgHKkEqUvEpD9iEMo+CDjlARx/vla5UM+AeS+eAJ54R6Gof2ctsrAn/8HhKT9Y51hdCxpZ2pSvqbZlUhT8HQ3bPFbpSD/w711zqkOvfczg/frpcUSJBPHtXJ0/qkxDTJdAc34fTI3zGkVGIB6jT2zH22/NOqptw4z4Im/UuAyzGt68l5KnIiNgqHICqf/Pn0/3uBsmvA4Tq4wpTF+66yppWX0CbhYSFfARunYLN8vfJ6fiGweFC6R8MBWBvpKRbC4Vyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoTRN8Wv; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoTRN8Wv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm7tT0P62z2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 07:19:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3DFD143D37;
	Thu, 17 Sep 2026 21:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD1A1F000FF;
	Thu, 17 Sep 2026 21:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679966;
	bh=ktGRo/YBeSz9wnbKkMSYDEjE6CYr2/sUae67RlWGYCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OoTRN8WvofN1ZqcIxnZDhzVu1PGAzsxkj0+OvfEzxqCzZmJIykHIrzUYIRP1hWAGN
	 sMN/CTZave2L6uLPnxHu5g4HMzLZXeQqnpzLNMB8trCj4FGmJSCnQZ6mACwTV757Op
	 qkgnnL9ZAallQaqc/VkTf5xvXzltJNkt6TDo/ottlqtRE1jLXreDLVAQdqUY8n/MQr
	 BidJoDjJ04W4SRmRXwrH4FrgpxCjYJjXGwOh+Var1PWPDNWoBP9rRmGs/Lg9MnWM5s
	 zh6rwx/GiTr8OEnuu0DIo7L4oyRHzj4M2UKrqrN0slMzgBKbtIv5ifdygWyaJliMXV
	 BF85dpPODNa6w==
Date: Thu, 17 Sep 2026 14:19:25 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bill Wendling <morbo@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Thorsten Blum <blum@kernel.org>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 6/7] powerpc/papr_scm: Return the string length from the
 sysfs show functions
Message-ID: <202609171419.F084401E5@keescook>
References: <20260917002312.i.923-kees@kernel.org>
 <20260917002333.2306346-6-kees@kernel.org>
 <aqviD9ow5HLGcLTK@ashevche-desk.local>
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
In-Reply-To: <aqviD9ow5HLGcLTK@ashevche-desk.local>

On Thu, Sep 17, 2026 at 03:50:23PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 16, 2026 at 05:23:18PM -0700, Kees Cook wrote:
> > perf_stats_show() and flags_show() build their output with a seq_buf
> > and return seq_buf_used(), which may include the trailing NUL byte
> > when the seq_buf has overflowed. Use seq_buf_strlen() instead.
> > 
> > Build tested ARCH=powerpc ppc64_defconfig with GCC powerpc64-linux-gnu
> > 16.1.0:
> > arch/powerpc/platforms/pseries/papr_scm.o
> 
> ...
> 
> >  free_stats:
> >  	kfree(stats);
> > -	return rc ? rc : (ssize_t)seq_buf_used(&s);
> > +	return rc ? rc : (ssize_t)seq_buf_strlen(&s);
> >  }
> 
> On a brief look it's a single ternary like this in the file, perhaps while at
> it move to Elvis op?
> 
> 	return rc ?: (ssize_t)seq_buf_strlen(&s);

Sure! I've updated this for v2.

-- 
Kees Cook

