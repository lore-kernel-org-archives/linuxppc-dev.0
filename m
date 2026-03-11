Return-Path: <linuxppc-dev+bounces-18046-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05727FD065A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 08:45:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW48R3TNWz3f1Z;
	Wed, 11 Mar 2026 19:45:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=116.203.167.152
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773218743;
	cv=none; b=RXWlXhZGOaskiwu066OSf8wyEq0CRzyi3IDpZHH1Tj3RAcL6PLFyVqLAdzsETFJi4fYFhRd9Jlf+LFc5dbNPnnJLWHtonKq7778Bl5frENuwZjkseIE8qCCdLyxO2tEO5Fi2jiso6waYaCcyQ8DzkQvP5rRYZYQ6OuQ/vKL0qI5/5hAvJVpuXlIQqnFx30bhK3AIav1LKzx0Tpgkflc7Brtdcpno2/+YidYY/ATgdUReeO85hayPiu6fNTnJipjZY985r9uiGPjGhqN6bilFeqvZ1aKfO8lil8yyVzRb9eT3wlaX0v4uF0YqMDaiEjlDR6uQW370nf0Ep8oXUk2ExA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773218743; c=relaxed/relaxed;
	bh=mz2pLUCkhcl+A7HJAWoFhExbwujxhC5QH/K/Z1t3+jg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lRwMHUl8h8Ahx7j/PA8tOJHY+zG318lOC0rL0bnnoVwWDe3t3n8PwT4HGpAMVFAhDG2Xt/GHrPaxb3CIQQyLJXiISR4UUWS6MisBqL2PsjBDqkLkAHcpKCYN3S4QX3uC+AmwhlFCoijEKgwd5yu7fz+goYLyLyYPqP+xpxCaCKBjVe59kQXN++BoxDFMMNn1xxbJiteYexeryQra03BJBiTmm++V1T8ewaKxIL8bbCB0AUsIVuzhgESDzXxiM6dbrfo752V9VzlIJNABE8ADYLWuqvt+JvyCjficSu68LhGmvO7qqjiv1TE1QBS3x+nek48YLD+IHE8w0w0KEQnBfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=permerror (client-ip=116.203.167.152; helo=lithops.sigma-star.at; envelope-from=richard@nod.at; receiver=lists.ozlabs.org) smtp.mailfrom=nod.at
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Unknown mechanism found: ipv4:195.201.40.130) smtp.mailfrom=nod.at (client-ip=116.203.167.152; helo=lithops.sigma-star.at; envelope-from=richard@nod.at; receiver=lists.ozlabs.org)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW48Q1GZPz3f0c
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 19:45:40 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id BC6442B03D8;
	Wed, 11 Mar 2026 09:45:35 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id U1QpR9pLQfYI; Wed, 11 Mar 2026 09:45:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E817E2ABFDC;
	Wed, 11 Mar 2026 09:45:34 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sQ20C_OvpL54; Wed, 11 Mar 2026 09:45:34 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 297CD2A87F7;
	Wed, 11 Mar 2026 09:45:34 +0100 (CET)
Date: Wed, 11 Mar 2026 09:45:33 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, will <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy, CS GROUP" <chleroy@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, davem <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, mingo <mingo@redhat.com>, 
	bp <bp@alien8.de>, dave hansen <dave.hansen@linux.intel.com>, 
	x86 <x86@kernel.org>, hpa <hpa@zytor.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, 
	dan j williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>, 
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>, 
	Li Nan <linan122@huawei.com>, tytso <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, 
	linux-alpha <linux-alpha@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	loongarch <loongarch@lists.linux.dev>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, 
	sparclinux <sparclinux@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, 
	linux-raid <linux-raid@vger.kernel.org>
Message-ID: <942530005.19163.1773218733711.JavaMail.zimbra@nod.at>
In-Reply-To: <20260311070416.972667-4-hch@lst.de>
References: <20260311070416.972667-1-hch@lst.de> <20260311070416.972667-4-hch@lst.de>
Subject: Re: [PATCH 03/27] um/xor: cleanup xor.h
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF147 (Linux)/8.8.12_GA_3809)
Thread-Topic: um/xor: cleanup xor.h
Thread-Index: ROrz3iTmErkYXUli/cm3A2WDQMn1kg==

----- Urspr=C3=BCngliche Mail -----
> Since commit c055e3eae0f1 ("crypto: xor - use ktime for template
> benchmarking") the benchmarking works just fine even for TT_MODE_INFCPU,
> so drop the workarounds.  Note that for CPUs supporting AVX2, which
> includes almost everything built in the last 10 years, the AVX2
> implementation is forced anyway.
>=20
> CONFIG_X86_32 is always correctly set for UM in arch/x86/um/Kconfig,
> so don't override it either.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/include/asm/xor.h | 16 ----------------
> 1 file changed, 16 deletions(-)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

