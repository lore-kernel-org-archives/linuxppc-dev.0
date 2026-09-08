Return-Path: <linuxppc-dev+bounces-26773-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC2AC79FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 08:57:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfHrH6hD3z2y8d;
	Tue, 08 Sep 2026 18:57:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788857839;
	cv=none; b=RnrKgxfYoQ+ARN8L/DLzwUcmgRP1Vw/YV1Kihe5VVc7J2n6aAVNOVKNtA0ETWYk2cFnLDvDI5F9tp2TTnWaMRG+LSpJF4UcrlJfmzMl3u/RTIfp8b5bQUW90BZHKY1Ys72Xe9wzAkzOqeUOp0xUQkzF+Ml3dI6HKUj/wh6qgAvDP2F6TPCPAsj2DFqImq644/NGLe0SlgxgVuNtSGc7l4NuxT73D8ORqrIoLiKFHZotBntK/HF9SFOEBIFARgUm9oCqUc50rzhYDJGL1A/7Rjt3J071GBRauKn+IeZDoOh8NppWTWseWGSaPUgPhOg/4QFhNqE4ZZAdYCPE9PaMdiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788857839; c=relaxed/relaxed;
	bh=BOR2t3VtcjszZ4q3H4RF8INxqX7I/2OnFWmBk3yYh2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYEKKUSlgKCwabgCcic3V7343GZEwDf5O5dmVb0c4g4731bQXNgyOGm4xGiYKSnOSCZwUPZCw90tqzkpIBEryrzrD3JRIj0v+BtGuO+CvcRJhz57Bq8GZMCWVOOy8pGt5cS8jkOcqGStxvlucZjQ6cLEurR8oUsBMjItEFIEB5L5coOwQOHK3G5VF/0y4ZCtTC9R5wimw7nNVpXuvCDDD3tq15gnEWev4uUIXX2/+It+eJz8Ney58CZxwXq+0l7zhWKIS5b714pCJ+Ucs27epG43rIvvGltc6dOf9eXxtURQXbhq3J4PCDTEBtHpOuz92XJXxLoNdiRsl0CEy92DQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMlWBWtH; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMlWBWtH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfHrG6QNHz2y8G
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 18:57:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E869D60A93;
	Tue,  8 Sep 2026 08:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D6F1F00A3A;
	Tue,  8 Sep 2026 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857835;
	bh=BOR2t3VtcjszZ4q3H4RF8INxqX7I/2OnFWmBk3yYh2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RMlWBWtHsUr314SSes2RbgrXEdhowxsDExyywV6MWPiyRlQ2MiRcnzJrKxwP2Uq5y
	 FxFi3d8oyrDb4Ns+a5YQol0nE9UlpMARb5Srs2FLa3c8UgJq9bIRFnwje3hSYKfvsy
	 4lejU8BQqLNJPlkLkj5fUKy1asSopqBNr8Z/GdXh3YL25ZL/xotJOBdRT8X+1frbzz
	 5wc8MC7jxG0TFbXkBqhY75SKcdrJ0GvpwyMgIKA6vQKX0ndFDZCBRqE2+uKYcWsIZK
	 O423o/0XnOMDsJENmzRb5yAhovNWoPRl28a6i0Ifx5k/RVsnRdBM2JH4gLApjYzNXL
	 e95ar8gZlvOGw==
Message-ID: <06996199-5255-41d0-ba6a-ebeca57f61da@kernel.org>
Date: Tue, 8 Sep 2026 10:56:58 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/24] tools headers UAPI: Sync ELF headers with the
 kernel sources
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andy Lutomirski <luto@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Nicolas Schier <nsc@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
 linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-11-3a93791af1cf@linutronix.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-11-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/09/2026 à 08:33, Thomas Weißschuh a écrit :
> Pick up changes from the UAPI ELF header files.
> This picks up general changes to elf.h, elf-em.h which was forgotten
> previously and the new elf-r.h.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> ---
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>   tools/include/uapi/linux/elf-em.h |  71 ++++
>   tools/include/uapi/linux/elf-r.h  | 696 ++++++++++++++++++++++++++++++++++++++
>   tools/include/uapi/linux/elf.h    | 112 +++++-
>   3 files changed, 868 insertions(+), 11 deletions(-)
> 

> diff --git a/tools/include/uapi/linux/elf.h b/tools/include/uapi/linux/elf.h
> index 5834b83d7f9a..88bdcbb526c1 100644
> --- a/tools/include/uapi/linux/elf.h
> +++ b/tools/include/uapi/linux/elf.h

> @@ -312,7 +323,7 @@ typedef struct elf64_phdr {
>   #define SHN_ABS		0xfff1
>   #define SHN_COMMON	0xfff2
>   #define SHN_HIRESERVE	0xffff
> -
> +

Getting the following warning when applying this series with 'b4 shazam'.

/home/chleroy/linux-powerpc/.git/rebase-apply/patch:846: trailing 
whitespace.

Seems to come from here.

>   typedef struct elf32_shdr {
>     Elf32_Word	sh_name;
>     Elf32_Word	sh_type;

