Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A33606A328
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2kUGpeTG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=rACQg86H
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9TsY4D0Jz2y7W;
	Fri, 23 Oct 2026 02:02:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792681361;
	cv=none; b=b2sjAGV9af+RTmhWOBi7tHmv6K0TPv107NrjXH6OdAVD5IywzouSy58VtBNJJWNjRRlTzq/mij3dl7nQgOBDepunk5Noy8DGM/kFOnlVcNHET6sJWdb+YGi+GFwircor+ph07tB3sjLfKYcRkGtVOIDeTt+J+tFlWhoF7nZaqqNXo/uGnJ2QiH0wgyZ+Y3IJgxCApAfFSMNMjDOgFUizMWos1xd5+1UmU8eqg+9NQqRkCEaSbTdIE+YLdLjPwScVyj/no4ZNuo0RJCJVyvKgl/dW30HN8DPbG6O0RUgIBWhLp9b3TU/eFcVHl5c3JsNUsGvjzlyLVRylumhatlInww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792681361; c=relaxed/relaxed;
	bh=UzBCi/OSOXBVd/hf35Hctx/8s00KKyC8gNB54GWWKuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsGnYLDclCmf7NTl6Kc8Ws2EtqPrdESOpi649goFmS7w/e7ljX8PoMq/iGozMVYtymtHzrTqb+BP8Ubk+8YvJnKbP1TK7xw9AzXtZbALxpWhY+buq8r6W7nviUWCyUlihNxegg2Puk4C7zBmzoyvKXJPioo2tv0xlQgi5YCcz1AUN1UW1u4TTPOrpNGVtZ3qmGjgm1M46X7InQTQOtTWnXW8j2jMRVzrseERvspRxRsQXb2ri71MLUoKMGJGzxcCcw2ydYYSF0z9+fVsCmVAoSbLHp1E6AbuLQiBmMsMekEjKE11z5r/9xsFLPomGrewmAnOIKgKkGWDnEDmUshNmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2kUGpeTG; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=rACQg86H; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2kUGpeTG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=rACQg86H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9TsX3jwcz2xwL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 02:02:40 +1100 (AEDT)
Date: Thu, 22 Oct 2026 17:02:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792681357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzBCi/OSOXBVd/hf35Hctx/8s00KKyC8gNB54GWWKuw=;
	b=2kUGpeTGDVBuYHmtDUk+ioLvFvif4ltj8rhWzocDuPm3HaFe4R4vTlOrnH+/NsK85KtmTp
	BQjRWdChCYWAdK0+eKUDRrdj71IFDIxlOzl/dpE7YHJOp63rkeZsrL+lIMWPOayKDZmWQS
	jZAmsd4OLiERAIm81xpmW1yxnaZhra+XaRdURt8feLSfDQkUZypkuicnE2Chx4WDXJq1W7
	gDW8/bA/PN+qgiQxlc+hLTJKpE5MORxYd7/+QpWeOeTOBVrrUrdM+PZPV0PqyhtRPzLVvf
	zZtCZj7gdLMshXYHbUIElhTwDBoSLh7+UVN4FV0jNASdMsB3S53YU8lnjUcMbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792681357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzBCi/OSOXBVd/hf35Hctx/8s00KKyC8gNB54GWWKuw=;
	b=rACQg86HepNQ8r26wtL/lrV9xxe+QpJ6z/mp4SnHXzsO+wI4ld+mzpC3AGpr+fKJ/pFfac
	AwRn+5gmUDC3CcCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
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
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
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
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
Message-ID: <20261022150235.V2CSdtmu@linutronix.de>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261022142425.3Wx-RrU5@linutronix.de>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-22 16:24:30 [+0200], To Thomas Gleixner wrote:
> The test could be updated via the hunk below in case the new behaviour
> is what is expected. hpa made the extension to the test in commit
> 795e2a023b808 ("selftests/x86/syscall: Add tests under ptrace to
> syscall_numbering_64").
>=20
> diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/test=
ing/selftests/x86/syscall_numbering.c
> index ca0eca7b9dced..1435394fba022 100644
> --- a/tools/testing/selftests/x86/syscall_numbering.c
> +++ b/tools/testing/selftests/x86/syscall_numbering.c

Now I notice the fix depends on CONFIG_X86_X32_ABI=3Dy (fails for =3Dn).
But we want to get rid of it anyway so=E2=80=A6
CONFIG_IA32_EMULATION is not affected (with the fix).

Sebastian

