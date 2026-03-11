Return-Path: <linuxppc-dev+bounces-18079-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FCE112586A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 18:58:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWKkx1jLhz3cCK;
	Thu, 12 Mar 2026 05:58:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773255481;
	cv=none; b=FA6GufZ83bSdvUVV6LiRtrMHAusgh+8REeJsYFYB9OjrwM3lSH3JD7s9Rzbta7nrVfVLDkXJwMG6yyVdvSqyWKFV1TOkK7ev5ZjOrami6o618eNRBMNXmLthAKelkzXpwTRN8z3QJjkdJMqQc7ARVaqVxmU4MVKiERj45IvPCkpJ3FJXkMG3zXwA4Ag4q1Is+xBzBG8pqXCX19Kku9R2kuC2JVD5qMpMditAUzbY4wKkKk60MAYLiD7asuQdi+SSN7bS6BjvGnc4iubMUh5KBDtkEbHny6wVaEc29PUweqVIA/iUSFglvffnia5fZAxHeU54nfGgMcLx3vlanK6e0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773255481; c=relaxed/relaxed;
	bh=+5HOp+D2LeHu2UXe/cUBxg6LHj8EqqG/+j5Xu/msN7c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YwWmT5kKPPg0nx3NjJBy262I7D+QMy2CNh3flXiw4MIajFbhSPUfU7BRUeq9mOuxYwdWJttyhjomyKI2LqucYtiK2nGa0mzRbm6zb6hrml0vAjWTPgpTBq6IvsV1A1Wg3/viVtrXSB1N6ghsp991bI7HaiyE8bPZbALURfHf/YowfF3fps5XFBl6JDtRMJFN08hr4tDdzlNtObNCw0rPNInoXzUiwxuiJLD3SEBBe4towd46zZm9f+IL4iNBJ/hAZ8fZYvVG8vuGysKIrTopWRsDp2nWdhTn1Ov7f9ZY/qhYEjQcx4fRenPJNEJdAjR9CEPJJk0sqO0dT5DapvwUAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=lwNHqHof; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=lwNHqHof;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWKkw2B5Pz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 05:57:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AAB79441C3;
	Wed, 11 Mar 2026 18:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B60C4CEF7;
	Wed, 11 Mar 2026 18:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773255476;
	bh=RIP4VTL8ZKfCAED/llWzV24bhb3+EBezOHbYfQlNNVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lwNHqHofCZymV9ZwzL4O4QC3oCCorqSKfgbbui0vSPfhppxGKPRL/IJ69bcF8P337
	 vhDG95oCrnrO9ZlV2DZHEmUO88ZgVNVnKPQNiPvM1Z9VRi+eMXmLsJiRCJ8qnumnHG
	 0HNrR7TfydlMZ9E+xCePC4BRnc2O1ZREJXn9QWnU=
Date: Wed, 11 Mar 2026 11:57:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner
 <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, Dan Williams
 <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>, David Sterba
 <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>, Song Liu
 <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>, Li Nan
 <linan122@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: cleanup the RAID5 XOR library v2
Message-Id: <20260311115754.ca2206d1428c49c3bd6e93cf@linux-foundation.org>
In-Reply-To: <20260311070416.972667-1-hch@lst.de>
References: <20260311070416.972667-1-hch@lst.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Mar 2026 08:03:32 +0100 Christoph Hellwig <hch@lst.de> wrote:

> the XOR library used for the RAID5 parity is a bit of a mess right now.
> The main file sits in crypto/ despite not being cryptography and not
> using the crypto API, with the generic implementations sitting in
> include/asm-generic and the arch implementations sitting in an asm/
> header in theory.  The latter doesn't work for many cases, so
> architectures often build the code directly into the core kernel, or
> create another module for the architecture code.
> 
> Changes this to a single module in lib/ that also contains the
> architecture optimizations, similar to the library work Eric Biggers
> has done for the CRC and crypto libraries later.  After that it changes
> to better calling conventions that allow for smarter architecture
> implementations (although none is contained here yet), and uses
> static_call to avoid indirection function call overhead.

Cool, thanks, I updated mm.git's mm-nonmm-unstable branch (and hence
linux-next) to this version.

I retained Heiko's ack on [17/27].

