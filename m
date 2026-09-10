Return-Path: <linuxppc-dev+bounces-27007-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D0EC79FB7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 06:31:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgSWX52tSz2y2L;
	Thu, 10 Sep 2026 16:31:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789021912;
	cv=none; b=igjo0Za9anX9Ht+4hQKZFVGubr1J/18jxBzMKZUHUiJDDbwDldqnBlETLTDqRNM86iRi5kFtSQWLF561eB9gjklPksVYQq8TpUiK0BDc1bDAJ2AVLHHVEvK65WFXLWvy0O47qS30hToyS58R1yu4RKtxyVkEOlhpClxXG18L2nfnqCEovNvHookCx0ZPBCFcguBt5PYk4uAHBb7+yOTHyYVCCHmDpcFpSF9aavHRqAxfOmPP5ZtTHo1bjMfLhE18/NV7t0evdJU/YGwI+YAsz+oEHlACRpTSwbwQSt0vqR379F6jLjEe5wuNAcGwFQfh5AGfvVIt7vwwGOoA9RUL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789021912; c=relaxed/relaxed;
	bh=1toCXFJJyIGT7Bi3z+gvDkztm6+uDMf7He5yX/dqQdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhaAPPC0YIx/5F5aooRT6b0LzzOVhbyKf9aK17gOC5cVW07rboNnP2n2tdi5trWop1vzzC4okjayXlvGycbW3A9BIsT5c8y+HT6f1BitNbbAlrY/vys9SwdJ4NahwK4eu012pm7xXfZkzf2r6nH0qeTtUJI9HrOKqO0q90cgFDHh2le8C+E4XdpVRFPK+21cD/vfUEsoMoPvFMFeL48SJ2D+dpTI9Ce2jmTBPqeVcLdpo1Yk+oqHp6ShefQJ0AbX9kceRF0MZ+DWhq3Yb21LkTMxufomLvTn70/emmR4VJ4FfD8u7pNPRqwHkvTwM4tJpq6vaclTSxWAcoskmzdMKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GG15DFhW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GG15DFhW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgSWW6FRmz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 16:31:51 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-398b3c37877so6294223a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789021910; x=1789626710; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1toCXFJJyIGT7Bi3z+gvDkztm6+uDMf7He5yX/dqQdk=;
        b=GG15DFhWizqad0Tg4QmEe/M8EQQN8QGJPD4p8tEzkZSnFv6EDm8WFOAolXnP+RohFo
         IHPucB5EFmuRJPlsNAPkdxLNQiZyuPTjQ6hLWvcIOb3XVWrD3Rz5kFnTkz/Mhg0cMCp3
         91YR6+NlWjtdGrYNMfWxPaCv6j1/xq4N9Mz/TqwSynx4UUqHII9KhVhcuNhouZyxkrjo
         iK9gcK2buESNdAPUYYGpu80ekqXlGBNgycZ4+gfTkPNKH12BG8vFa0p6T6HeQZqAnlBS
         Zppg5bIVoIcLzFowbPHQjvgnH8g4XleSil4PchVeJN6hB6PLmF0SrwUibCImhh7YJ1Tc
         BGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789021910; x=1789626710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1toCXFJJyIGT7Bi3z+gvDkztm6+uDMf7He5yX/dqQdk=;
        b=dxeJlvhgaHv/RLJY8bk0YHvBMy+v3Z0dW9UrYO3rcs1C4lIq/+ndCcg1MfrrhWciS0
         TCtaKFT0vM8+sRdgRnZWcH4MA6KC2sCOUCEw1FgLsSfaTgRMvPxdPJwmxbqZ21PHmvKg
         yyASq2Su7cF81KNYx3K5cYD4Hg67QHkEWzujZL+vFrSTpzKoEY91DTg8/Dk3f2O3MDoD
         8mXACsv2De1Mpa47KO9b3nJEG8t7gr9WJCIqC5Af60gVNe1eSMhXqKUfP1GeXpNImFDs
         0lDImY6bF4BbVSThTb0SsYQYW44fUL8NOfn9ClNd2Sfm5Fgwyvz458Dkk/ubrlcoSlvz
         oSWw==
X-Forwarded-Encrypted: i=1; AKwUvBy9u11OcMD/e8rHmjMvOIQ/xiG1HQqksAvnSAGMPw2LM2QcT1ywXrxsPfY0wKmyaSPQjXf1t0AYn/x61Yw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mimL4vafi1CJ8CBZ3BgStP5yOytOzdtanuzjikh0sa+rElGCn2
	sb8WDYUJunjUrOWQBRWnVPUXTshmuk7JMcKgxYSOqZhF0WRPwkYsh2Rh
X-Gm-Gg: AYBFou3p9OejeUmiwyybB22vRMaPRFcwqNjHTH7iBPyBXoMcozR0tEiTf3nsa5uQ+Zc
	za80cPoruCLOjmIcl4lkGi5O6qOcBKC3E5KOdUlJBJBbmsSTsD/POe8wIIzGTr3cPvsirEDCwdd
	VZswh9oFwMmb9GAun6nvzJ6NRnsCWls4B6omcAdPB5FEWWNnXeFKSwJBxyYg0QTYHeti1XSfko1
	vkgA32L9pJQDerAQhOcZCTYTvJrn/J0PDax8N09Nla1HPs8xcaPPdcFPVlU1wE+cF9/wlWiq/GB
	yRZk7aAJ1czkPiW7QPHXPNGjTOgQYB/hcevdHLzQ8OMETo4isBs0ftz2eK9k9BrTwPo2yGUMtwI
	+XaaKc2M1SKkyuT0wzYjDHSGMhIBMUWGPl3uHOhJNDznPbISNJAqRAE7h6MPBOkmOK8212Eperw
	jwMmBhYe6iiv48rQvaRYg92vQAZDNgABkZVHDqcRlT+jVN1mLiv8cJ60TXCawyx5wbfAO19XZeA
	fDcQa27pJUpRn9Bu4gJ6OMUkHCIQqkKWGyIPCX/xS0=
X-Received: by 2002:a17:90b:258d:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-39b261323e0mr64061526a91.11.1789021909725;
        Wed, 09 Sep 2026 23:31:49 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e834319sm2507639a91.10.2026.09.09.23.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:31:49 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:01:26 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Christophe Leroy <chleroy@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 01/24] elf, uapi: Add a header for relocation constants
Message-ID: <aqJOscgnnevybiKO@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-1-3a93791af1cf@linutronix.de>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908-vdso-absolute-reloc-v5-1-3a93791af1cf@linutronix.de>

On Tue, Sep 08, 2026 at 08:33:35AM +0200, Thomas Weiﬂschuh wrote:
> While the numeric constants for relocations are architecture specific,
> it is still useful to get access to them from other architectures.
> Also the definitions are useful for userspace in general.
> For example tools processing elf files during a kernel cross-compilation
> can make use of them.
> 
> Introduce a dedicated header for them, similar to the elf-em.h header.
> For now the header is empty but it will be filled step by step in
> upcomming commits.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/uapi/linux/elf-r.h | 5 +++++
>  include/uapi/linux/elf.h   | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
> new file mode 100644
> index 000000000000..2c382c8a4807
> --- /dev/null
> +++ b/include/uapi/linux/elf-r.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_ELF_R_H
> +#define _UAPI_LINUX_ELF_R_H
> +
> +#endif /* _UAPI_LINUX_ELF_R_H */
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index ee30dcd80901..b3e312255552 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/elf-em.h>
> +#include <linux/elf-r.h>
>  
>  /* 32-bit ELF base types. */
>  typedef __u32	Elf32_Addr;
> 
> -- 
> 2.55.0
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

