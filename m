Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9EBC4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 02:36:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65CC261050
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 02:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 65CC261050
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GdMb55D8vz30J0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 12:36:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=a1WosJ0K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=a1WosJ0K; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GdMZZ44J5z2yLm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Aug 2021 12:36:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GdMZP2s0Lz9sT6;
 Mon,  2 Aug 2021 12:36:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1627871780;
 bh=3h+pDmgdaEzjLhKsKsWflOl3eTtWNpO0qlqcc3HN5gw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=a1WosJ0KTXjCRMYjN+wSNFc6ThlMWt6oNtTvbiU08VVh18S12fqbdg7dtDkTBwLa5
 mW8V1Rs4z1BYZuL+pODWPRcD9vbuP8wr01nokBcoTqy49p0SZolAkJwet6ROF0SgEd
 HIz4pn3qWuGGanDbWuW4js0/5hgiIlpoNRE/cyUZxz2eu0jNe7yDYVqAQscP9GPFnE
 qSf68THatsIhId+0A9UWQp8CymuJZBASivoSVD4ldWSNoXSko1yGGp69QbvPTzYUiQ
 G0ZV6Ba/iniZMiL5MNvLUDtAPk+yDPaeM5eVp48+0XyP3sN+LVB9D69GzgsiEom2l/
 2x/ybfb3/4spg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <masahiroy@kernel.org>, Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch: vdso: remove if-conditionals of
 $(c-gettimeofday-y)
In-Reply-To: <20210731060020.12913-1-masahiroy@kernel.org>
References: <20210731060020.12913-1-masahiroy@kernel.org>
Date: Mon, 02 Aug 2021 12:36:08 +1000
Message-ID: <87v94ozi7b.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Masahiro Yamada <masahiroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-mips@vger.kernel.org, linux-csky@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Albert Ou <aou@eecs.berkeley.edu>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-arm-kernel@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
 linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Masahiro Yamada <masahiroy@kernel.org> writes:
> arm, arm64, csky, mips, powerpc always select GENERIC_GETTIMEOFDAY,
> hence $(gettimeofday-y) never becomes empty.
>
> riscv conditionally selects GENERIC_GETTIMEOFDAY when MMU=y && 64BIT=y,
> but arch/riscv/kernel/vdso/vgettimeofday.o is built only under that
> condition. So, you can always define CFLAGS_vgettimeofday.o
>
> Remove all the meaningless conditionals.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>   - Fix csky as well
>
>  arch/arm/vdso/Makefile              |  4 ----
>  arch/arm64/kernel/vdso/Makefile     |  5 +----
>  arch/arm64/kernel/vdso32/Makefile   |  3 ---
>  arch/csky/kernel/vdso/Makefile      |  4 +---
>  arch/mips/vdso/Makefile             |  2 --
>  arch/powerpc/kernel/vdso32/Makefile | 14 ++++++--------
>  arch/powerpc/kernel/vdso64/Makefile | 14 ++++++--------

I noticed this the other day and was puzzled why we still needed
the conditional, thanks for cleaning it up.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
