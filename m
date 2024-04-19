Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D85C4345F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2024 15:51:28 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OHj3fHUB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VLfJb430Vz3cnv
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2024 01:51:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OHj3fHUB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VLfHl2ZcGz3cZG
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2024 01:50:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 52AA1CE16E7;
	Fri, 19 Apr 2024 15:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33F9C3277B;
	Fri, 19 Apr 2024 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713541839;
	bh=4syrMVBjLG+mqSAuWdu45onjerLE6hugRcJZYIbTm9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHj3fHUBZ5oW6uWZr153zLjsZ6q0yv8DxwxD0Zy4isctsEWry5XXGSfR8Vc3hMrh/
	 vizLT7qFrrEF533kmJCP3HWtZ7Qzr6mVAw251VXfA8O2WlqLyeSYgvuFfPALuIdv03
	 8KfWQePVkfruiceot7yZycnjNdoMZw4MifC81l3AU9dBYam0QRDoIaUN7a6lFYb8MN
	 K0Whze6qtl25bkJdh4oiv03gWibiSz5LhY9l5mv+w3PTDhkRKRk4JGDzV2xKnexhV7
	 tGBMGlG1WEFnNmkggVGWaWOAgxzIa+Avjitv3Mny3kNElAG5XpvzSHnQsEDp7b51Tm
	 Ziw7Ozh3aQ/+w==
Date: Fri, 19 Apr 2024 18:49:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Masami Hiramatsu <masami.hiramatsu@gmail.com>
Subject: Re: [PATCH v4 14/15] kprobes: remove dependency on CONFIG_MODULES
Message-ID: <ZiKSffcTiP2c6fbs@kernel.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-15-rppt@kernel.org>
 <20240418061615.5fad23b954bf317c029acc4d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418061615.5fad23b954bf317c029acc4d@gmail.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, linux-mips@vger.kernel.org, Song Liu <song@kernel.org>, Donald Dutile <ddutile@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Nadav Amit <nadav.amit@gmail.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-trace-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>, Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, loongarch@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, linux-mm@kvack.org, netdev@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev
 >, linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Eric Chanudet <echanude@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, linux-modules@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Masami,

On Thu, Apr 18, 2024 at 06:16:15AM +0900, Masami Hiramatsu wrote:
> Hi Mike,
> 
> On Thu, 11 Apr 2024 19:00:50 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > kprobes depended on CONFIG_MODULES because it has to allocate memory for
> > code.
> > 
> > Since code allocations are now implemented with execmem, kprobes can be
> > enabled in non-modular kernels.
> > 
> > Add #ifdef CONFIG_MODULE guards for the code dealing with kprobes inside
> > modules, make CONFIG_KPROBES select CONFIG_EXECMEM and drop the
> > dependency of CONFIG_KPROBES on CONFIG_MODULES.
> 
> Thanks for this work, but this conflicts with the latest fix in v6.9-rc4.
> Also, can you use IS_ENABLED(CONFIG_MODULES) instead of #ifdefs in
> function body? We have enough dummy functions for that, so it should
> not make a problem.

The code in check_kprobe_address_safe() that gets the module and checks for
__init functions does not compile with IS_ENABLED(CONFIG_MODULES). 
I can pull it out to a helper or leave #ifdef in the function body,
whichever you prefer.
 
> -- 
> Masami Hiramatsu

-- 
Sincerely yours,
Mike.
