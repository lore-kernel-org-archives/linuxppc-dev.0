Return-Path: <linuxppc-dev+bounces-24103-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9938FC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 08:44:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzGGK6X1bz2xqM;
	Mon, 13 Jul 2026 18:44:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783932297;
	cv=none; b=hg6rgEUvGPkE1AtFMiCqjPLd8AY6pqzlLYmadp6lOGqql1beZWXjUCaSMWUBTXoOZIOtGntncGGE3JeAa3+uTqICSa2Ay5PS9YB0YUWjnB+ESUWJdBRTs71iXVDtzpl4464UoGxxDvnAU4ruY7xuzfHIJ9H0Beame0pr1LqSsp6ahs0prWX/iOJ0xpIfNJdCJDcvp8KRDhR76OUCed4C54F2fKW/y44Jqgymw5+DxV4ONmMKgevJrQSgttpOxuTobeiDNRGxw6JCX92nIBKwq8HhCzdioHT9cMzsMdeETZWtY1J1+jxEmqPbhBL6SkwlsLH3UppMgDM/Hx6Nnu6P8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783932297; c=relaxed/relaxed;
	bh=wOqYLE7XCd1dyoTtB3Uni1tJhG2ZPfNesMlKhEUlxw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1UVqj2XQu8TGhl0oDo9OJnMFn4Sa/pYiFO+zUbbTUdM/+wmbUNU9ySjunwX+H7bHLXtp7a/l1MU3p5NewHfd8kB+ba2exButI2pkArywxiL4iGQEm5ZbAkE30laPpXtROazbjDcdZRZbk0wtm24UGQrviSE9oCCvrdALeLcyckMEgxwiPlG896mBCg+jQSIevjYfUUNNTxxT4raJ9qFSJdYhPoDpuZiS7wiA3z7gXi8Kz/soMihkAwebrUm5n7350yHJ6YxTf9LNbJMjcTS/xQRRlqpCk7/i+QC/XpkOJ+ABAu+44c/UotT2deQYQVv0mSI+t7B5CvVHzh54WVLsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=r+RdOu7X; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gQkdb4P9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=r+RdOu7X; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gQkdb4P9; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=r+RdOu7X;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gQkdb4P9;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=r+RdOu7X;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gQkdb4P9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzGGJ1TDrz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 18:44:55 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BA357744E;
	Mon, 13 Jul 2026 08:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783932292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOqYLE7XCd1dyoTtB3Uni1tJhG2ZPfNesMlKhEUlxw0=;
	b=r+RdOu7XiG6HWhbr9pAG6XGyeZKMMBFIRjat/72NL2mbYxHP0zrOB3f3QilNPJI7q3w5xs
	wVeyVaHVmQa0RWsKdSNXdpZ68FK/P6qCgxIqCmH0rzBIz1yc8AtG57aGojuCq+btSgCdJM
	kMgpjbKEFSn/eBjKsOd+YBfrfwpNGCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783932292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOqYLE7XCd1dyoTtB3Uni1tJhG2ZPfNesMlKhEUlxw0=;
	b=gQkdb4P9HbkQTKS5EkCscMvwW0dRzYA0YniAiaIdT5hSQuexB294AZ+icFllO6E4kklxGL
	Yl2ucsTSYxhqrIBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r+RdOu7X;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gQkdb4P9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783932292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOqYLE7XCd1dyoTtB3Uni1tJhG2ZPfNesMlKhEUlxw0=;
	b=r+RdOu7XiG6HWhbr9pAG6XGyeZKMMBFIRjat/72NL2mbYxHP0zrOB3f3QilNPJI7q3w5xs
	wVeyVaHVmQa0RWsKdSNXdpZ68FK/P6qCgxIqCmH0rzBIz1yc8AtG57aGojuCq+btSgCdJM
	kMgpjbKEFSn/eBjKsOd+YBfrfwpNGCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783932292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOqYLE7XCd1dyoTtB3Uni1tJhG2ZPfNesMlKhEUlxw0=;
	b=gQkdb4P9HbkQTKS5EkCscMvwW0dRzYA0YniAiaIdT5hSQuexB294AZ+icFllO6E4kklxGL
	Yl2ucsTSYxhqrIBA==
Date: Mon, 13 Jul 2026 10:44:51 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Radu Rendec <radu@rendec.net>
Subject: Re: [patch 4/4] entry, treewide: Make
 syscall_enter_from_user_mode[_work]() indicate syscall execution
Message-ID: <alSlg72c8xmjaj48@kunlun.suse.cz>
References: <20260712134433.549076055@kernel.org>
 <20260712141346.772209074@kernel.org>
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
In-Reply-To: <20260712141346.772209074@kernel.org>
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [14.88 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.69)[0.897];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_CC(0.00)[vger.kernel.org,ellerman.id.au,linux.ibm.com,lists.ozlabs.org,kernel.org,lists.linux.dev,dabbelt.com,lists.infradead.org,arm.com,huawei.com,gmail.com,lwn.net,rendec.net];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spamd-Bar: ++++++++++++++
X-Rspamd-Queue-Id: 8BA357744E
X-Spam: Yes

Hello,

On Sun, Jul 12, 2026 at 11:25:32PM +0200, Thomas Gleixner wrote:
> The return values of syscall_enter_from_user_mode[_work]() are
> non-intuitive. Both functions return the syscall number which should be
> invoked by the architecture specific syscall entry code. The returned
> number can be:
> 
>   - the unmodified syscall number which was handed in by the caller
> 
>   - a modified syscall number (ptrace, seccomp, trace/probe/bpf)
> 
> That has an additional twist. If the return value is -1L then the caller is
> not allowed to modify the return value as that indicates that the modifying
> entity requests to abort the syscall and set the return value already. That
> can obviously not be differentiated from a syscall which handed in -1 as
> syscall number.
> 
> The most trivial way to deal with that is:
> 
>     set_return_value(regs, -ENOSYS);
>     nr = syscall_enter_from_user_mode(regs, nr);
>     if (valid(nr))
>     	handle_syscall(regs, nr);
> 
> That's what LOONGARCH, RISCV, and X86 do. But PowerPC and S390 do not
> preset the return value, so when user space hands in -1 and there is
> nothing setting the return value in the entry work code, then the syscall
> is skipped but the return value is whatever random data has been in the
> return value register.

The reason why PowerPC and S390 do not preset the return value is that
the return value uses the same register as the syscall number. There are
apparently other architectures on which the return value overlaps with
the arguments which also do not preset the return value for that reason.
If they would use the generic entry the same problem would arise.

> Change the return values of syscall_enter_from_user_mode[_work]() to
> boolean and return false, when either ptrace or seccomp request to skip the

There is a difference between seccomp and ptrace.

When seccomp indicates to skip the syscall it has also set the syscall
return value.

However, when the syscall number is -1 and the return value is not
preset that does not indicate anything.

The return value can still hold garbage. ptrace does not have the
ability to indicate that a syscall is to be skipped, at least on the
entry trace. It needs to be skipped based on the syscall number being
invalid.

Thanks

Michal

