Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FF460850AC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Bkvlc9Uh;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=no3DkXB1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJH5R1pbcz3cL8;
	Tue, 03 Nov 2026 03:21:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793636491;
	cv=none; b=CSKmAYi4yMX9z1kTbmR/LOj82eQJ62N/cpERqkCR+PZiysM+czIvQv4TYYVED5tv/eCM9qa86dCxSC+0STGOHtFzrQ+da4n4+3DGI2s7WW57C2IOMSxYkuc5r8wqgxjqL5sxRbhyw1qmvsS+0CKU3AVuo4ZLN/umL2AQ3nMnlV21oXJjMNTZ/uhk+Rz/wR+c7oNH4oTLY5ovlgfyefAwjvqENz3fznRhvIh4QqMjxNwrgIgy+3dt3ISMkad32ZuVVsxyAMTZO3c1sW07bONgz3KElKEyl2028Dlg47xFUounlkC9HgIPgtluITcCSb1vCj/tnbQ4/rPm9sqwza9RgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793636491; c=relaxed/relaxed;
	bh=CAbnxO0/qUW9BHgq0s5afN/fwZolzjrBJaRnSuaEmAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUJdIS16xC/ak40Uf5vfgmOS2cDntXyp9Y7ACUCnyqnRraTLFPz/RCqmvkFLtv4GDZG+ufav7+X72jCujZg2JLccAsI56WrTuAlOM4/Tr5EGMzjut5tUjji4+Hu9j4R+W+D95qbdzsolMPbQfhk71WmQ3Y+AEHOhMflLTkL7cSuijwkzieu0oMn/4YWKSMW18mDnex8q36pA9HlN5Q3qEZSUK2PhzM6p1aNUYDx0yowhojPH9jt5VNEecCDm6L3MHM7quTq04oNp+b3irh9n7UrRyHUs4wY/RrqlnfEtyPoj3rTDQPzUq/5ALQ1JIoT/1gK15tmeyjebK7N66B9ayQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Bkvlc9Uh; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=no3DkXB1; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Bkvlc9Uh;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=no3DkXB1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJH5P4PVdz3cL0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 03:21:29 +1100 (AEDT)
Date: Mon, 2 Nov 2026 17:21:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793636476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CAbnxO0/qUW9BHgq0s5afN/fwZolzjrBJaRnSuaEmAo=;
	b=Bkvlc9UhhyCv5ZdWUMU6G9Li+R2BVAADYWwZuoqUAyqvUjCoGYGxXIn4ALH8UCKwa4wXF8
	oraU/gZ8eujvwMvYkEcPGl9LoaQ4y8L5gTwgvEqTaLIOKyYpw0Vt21vSoLNR9nGu5XUZGy
	Ei+jDbIPpRtvYxUN3n40OXfMZKwhjOcptRjzclaFhqfaMjZ4DnPJp2kIUEARXrDA2lfCj7
	Xc9td9/O5azqjpJ09IA+6VHzOt3kgO7Q3tW3z+AQm8NXUA0NJY3SKFbPnSH3MoCGBJlCpq
	9SKkxdgYMHfQI6T9cHJ58WWsIb3edmk7YJmf4hhOdiwEorZM3Pu5QhcHBVRk7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793636476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CAbnxO0/qUW9BHgq0s5afN/fwZolzjrBJaRnSuaEmAo=;
	b=no3DkXB1ZRbLOBdX8Sfg5H+HK/netv5lLDsnHm2NNe1d6SMQE1Lawcr4U1D9QbHBAGIkXh
	QAa36tqetUjJ21Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V2] x86/entry: Fix ptrace regression
Message-ID: <20261102162113.LEAhpzer@linutronix.de>
References: <20261022142425.3Wx-RrU5@linutronix.de>
 <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13>
 <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
 <871p9g1s3w.ffs@fw13>
 <87y0boze95.ffs@fw13>
 <C6D7BF04-4CF7-48D1-93B5-E80D52C2617D@zytor.com>
 <87se1wyvs8.ffs@fw13>
 <87mrrvxaty.ffs@fw13>
 <87ecd4xwlr.ffs@fw13>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ecd4xwlr.ffs@fw13>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-01 18:58:08 [+0100], Thomas Gleixner wrote:
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -77,6 +77,10 @@ static __always_inline void do_syscall_3
>  	if (likely(nr < IA32_NR_syscalls)) {
>  		nr = array_index_nospec(nr, IA32_NR_syscalls);
>  		regs->ax = ia32_sys_call(regs, (unsigned int)nr);
> +	} else {
> +		/* See comment in do_syscall_64() */
> +		if (nr != -1UL) {
> +			regs->ax = -ENOSYS;

A curly closing bracket here and then it compiles for me. Or remove the
one in the "if" line.

>  	}
>  }

With either of the suggested changes:
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

