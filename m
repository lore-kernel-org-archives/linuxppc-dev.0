Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F097C606A31F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hwASE/IL;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=z943ERBm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBGkG4cVjz2xfX;
	Sat, 24 Oct 2026 08:44:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792791846;
	cv=none; b=OcvU76zd7BQmSBI6i/edeUfLBYrggmo6SitiXtpsMJzZCA5h9IDUzb/szBkgFRNx+fXqXj0/zW5DuOloJhwBgdXPfCnnOHJnzuPDIy9pMgjXs0DahpchY7ZMNIZ4ITXXV5UiVeK+HmkooHL2Zb59sLSkffrqfF9n2kvzWcCxKcIbcF2Ki5rtngyKBU33o3BJDVo8st53yipC8eTmdKrvE+fDFWYgsa7gSnMG/Gsd8WkTvoKw2tKMOTkCteRT/cgonOjdfBOiKHC6gaS8WsxEFxi8Y0G0AsfSIeVe6TxcOoTeP/wwPQlLH+VnnhicjOELL3NZCK1/wPqd7MHf/A7vuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792791846; c=relaxed/relaxed;
	bh=rBYqzhjRmnws8Rm/5IL7e+PRpdOctdJtXb4xboAMWSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV/yXGegQjMFHVfWL2PyQFmAq+VNEw6nfI9/AUjcpxoiteANV1cmvatHla88pefz/aGWpbcM36j7bwteW4lEQIblsbz49Bm29T1rgAKurLrQJ5eo/3jNm41c1R0PzPiViLnz9WWgsjPjCWDmVzvvYECe4egN0BiAQKuozcFSXmC7QTdTqAELugdf+vbzTPMLCcvGBOCZNdH4H9o2DIGpHO5qy0MMTvdUAa7ZcYooIqt6eWDL2zNeZNY6tNp7/YofE3DCM+juJwunQJN/8NSdrzbtaustgYmcIo/9DHR5Nbf6x0OJOPjnZt0KhaKw8ozrbpcthlifRRJW93oT/luHnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hwASE/IL; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=z943ERBm; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hwASE/IL;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=z943ERBm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBGkF2fyCz2xLd
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 08:44:05 +1100 (AEDT)
Date: Fri, 23 Oct 2026 23:43:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792791835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rBYqzhjRmnws8Rm/5IL7e+PRpdOctdJtXb4xboAMWSA=;
	b=hwASE/ILIfvsagU4ja9zJyp6NCW7nhDXBrLgESHYvZc9OlC/GQdmV72Hfw8lCHeCcJDiIT
	xFBb+eSpeLzJx+wG16eGrTDnCizzsAb6w+YXHutGNF3HFzHQkD8tsZ70QSbXCrE553aTtc
	FyBITEp8ynQwIVKmsTH4edb2ELcKOcjRqPKGeu5zad/jr9HszyeKdSGpYIGAdGmjIg04RH
	fcQJvL7izNOg661T28mb7TFw7IIiiiTlruIEDWxOW6votoei6lPtMgLjCAwFAfW1s9CXqg
	i8k5N81Ek/SnmSCRgWHVGbIsWAsCZb3iRBPHtLu5gtarfP+kYufKyE0FptRrgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792791835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rBYqzhjRmnws8Rm/5IL7e+PRpdOctdJtXb4xboAMWSA=;
	b=z943ERBmz9863Xr+14sVUMFBonUecgHEkMzxOZxtguvVf4IgWnapYNfN7FD67wKQCXc4NS
	csUXXgLT71khc6BQ==
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
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
Message-ID: <20261023214353.Q3pZID23@linutronix.de>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de>
 <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13>
 <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
 <871p9g1s3w.ffs@fw13>
 <87y0boze95.ffs@fw13>
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
In-Reply-To: <87y0boze95.ffs@fw13>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-23 16:24:22 [+0200], Thomas Gleixner wrote:
> IOW, a tracer modification of regs->ax is not overwritten when the
> syscall number is out of range.
> 
> Between 2.6.19-rc2 and -rc3 x86_64 was changed to _always_ overwrite
> regs->ax when the syscall number is out of range.
> 
> In the 3.8 merge window seccomp introduced the -1 == skip bogosity which
> got fixed up and made "consistent" in several changes afterwards. Just
> that it never reached a state of consistency due to the overloading.
> 
> So are we stuck with this behavior or do we sit down and define what the
> correct behavior should be?

I wouldn't say we are stuck. The test did reassemble the status we had
at the moment. As you wrote yourself the behaviour changed a few times
and not on purpose.
I would say we define what correct behaviour should be and make sure it
is consistent across all the architectures.

> Thanks,
> 
>         tglx

Sebastian

