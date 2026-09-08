Return-Path: <linuxppc-dev+bounces-26779-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32970C79FAB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 09:21:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfJNP3pqvz2xlJ;
	Tue, 08 Sep 2026 19:21:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788859301;
	cv=none; b=G0R2VBKt4cFwxH7IV/akCkfftBIHZXlCbbcpvMbIE/i0vsHiUsi39GPK9jXIHntaVYPtaKcj9gcINM+o6tgod7nQDo7+nPGMC/4RboFhvB1UmfcMnXhHxyDqgq6f4s+5jgh1Ml/69dZ0WXrfWVlFkx16prA4wqHZAERRIgsgw+F4Cpz5voLeZhkXr8DGSe6eg2c0eeqnpGO/W3rKuu9sk4Yr7ICHDuzy+Y4ywrvSibOC8GTR43sHe6q1xWwORyLW/2F301pmj8IiyEETDMAbDdByjcyVCKryiurNEXCP52+Z6Gaz2RcWXVECOT++6yFdKc+vo2Z9GHJ9Rt6ke4DTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788859301; c=relaxed/relaxed;
	bh=4k7jM/SARicUfiyID/Zb58FTA6TVrqfjgQqXrSbBJmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oV3SXr3TlzXzPz52JXYF1kELhaCRjFzrnaIX0r9ULLGdoTK4CJWtKZOF+ILUo4FASeao1YkrlHvw+TcecRjY5h3jAvslTThHPAURD2Rm+wKOmHT5vfGgHcNKb/9DHmbUpUIpXPbAi2f6hTY5pNgI3u/e6c+If0dr7/zfkGNo/K9U77K2lHNAYxodzH8tEmUWHFQuPcwRkGmJbkLyJgJEktD7HQXtV5/T5NnxIey8eKdSOobAY6U7vDXTBxLgwSjXOOhudMgXCnswsQ8hiD9iy0hGCl001BcekmzLq3bcBb9jP3r48XHZdHfUL/VXSVoubIkztld/l1ZMaHPUe6iT0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xn9XtBCz; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xn9XtBCz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfJNN3rPLz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 19:21:40 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5366660A97;
	Tue,  8 Sep 2026 09:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E861F00A3A;
	Tue,  8 Sep 2026 09:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788859298;
	bh=4k7jM/SARicUfiyID/Zb58FTA6TVrqfjgQqXrSbBJmY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Xn9XtBCzNs8WX9mak5mpG8XRdy2i0zrbMydZ5LMlt1Qe6xYAL3LuxfUX8Atn2wQI5
	 1axnL/wqewpo705igfKNy8cNCn9+Zo3sUO5bgJKNWeixiHCJ40tMpOcHYPd0ztKnwc
	 thks3bDKvUFN5YfpBP21ImCqeVd4BuB9bshirgyOkT8qYPLl5IHF7GtOgYNVJtKM5z
	 OWEfgEV7HLlzD0xSV0FLDhASxeMC0R5k+YiWCZlY18vuOZyNV5jOxZq4lBnvbHCbuK
	 MWgRGux7fP8nPYbQvR4llwvXew14x5qlJam3L6qpRO9Kd3dID9dgWciFsi7Ok948U+
	 EV4LzEuy2wGQQ==
Message-ID: <9a27f318-2ab0-4f5e-8e87-daaa85dbc297@kernel.org>
Date: Tue, 8 Sep 2026 11:21:20 +0200
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
Subject: Re: [PATCH v5 16/24] powerpc/elf: Add 32-bit REL16 relocation
 definitions
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
 <20260908-vdso-absolute-reloc-v5-16-3a93791af1cf@linutronix.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-16-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/09/2026 à 08:33, Thomas Weißschuh a écrit :
> These are used by userspace and are necessary for the vdsocheck tool.
> They share the numbers with their 64-bit variants.
> 
> Also update the copy in tools/ so they can be used by vdsocheck.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   include/uapi/linux/elf-r.h       | 7 ++++++-
>   tools/include/uapi/linux/elf-r.h | 7 ++++++-
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
> index 72fc9045a5d4..170888422400 100644
> --- a/include/uapi/linux/elf-r.h
> +++ b/include/uapi/linux/elf-r.h
> @@ -182,8 +182,13 @@
>   #define R_PPC_GOT_DTPREL16_HI	93 /* half16*	(sym+add)@got@dtprel@h */
>   #define R_PPC_GOT_DTPREL16_HA	94 /* half16*	(sym+add)@got@dtprel@ha */
>   
> +#define R_PPC_REL16		249
> +#define R_PPC_REL16_LO		250
> +#define R_PPC_REL16_HI		251
> +#define R_PPC_REL16_HA		252
> +
>   /* keep this the last entry. */
> -#define R_PPC_NUM		95
> +#define R_PPC_NUM		253
>   
>   /* PowerPC64 relocations defined by the ABIs */
>   #define R_PPC64_NONE    R_PPC_NONE
> diff --git a/tools/include/uapi/linux/elf-r.h b/tools/include/uapi/linux/elf-r.h
> index 72fc9045a5d4..170888422400 100644
> --- a/tools/include/uapi/linux/elf-r.h
> +++ b/tools/include/uapi/linux/elf-r.h
> @@ -182,8 +182,13 @@
>   #define R_PPC_GOT_DTPREL16_HI	93 /* half16*	(sym+add)@got@dtprel@h */
>   #define R_PPC_GOT_DTPREL16_HA	94 /* half16*	(sym+add)@got@dtprel@ha */
>   
> +#define R_PPC_REL16		249
> +#define R_PPC_REL16_LO		250
> +#define R_PPC_REL16_HI		251
> +#define R_PPC_REL16_HA		252
> +
>   /* keep this the last entry. */
> -#define R_PPC_NUM		95
> +#define R_PPC_NUM		253
>   
>   /* PowerPC64 relocations defined by the ABIs */
>   #define R_PPC64_NONE    R_PPC_NONE
> 


