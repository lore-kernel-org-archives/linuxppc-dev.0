Return-Path: <linuxppc-dev+bounces-28268-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C46C98328
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Sep 2026 09:48:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsN6Z4VC3z30Nl;
	Sat, 26 Sep 2026 19:48:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:a60:0:28:0:1:25:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790416086;
	cv=none; b=aEZQvA46i52Zi4aRExj2E0ET8e0+xGLCs9nt3b8NYbEhSmfm7jKnqOt8d3abZpd30W3jPPwggo7BzugOBCgnrshHdIq7b+ctqL9UbaaK70kIAA13L0tUKyXuwimKp+vXEx0syr//XBWfPI3NSFLWuh6EFDyoE4Eqd+nOPPdTW1XHFUWCRxCVLKg2m0YIEBtJaV6cL5xwlG1O7ggzJXiCgzwEnoFju0xGnwBRdVBy7vVH4kuq6OTn5UqlS646oCTNjO3LwLoCHRDs59HorKMBPwEgTCZRABNp6DYn4NZ8b388UPpd4ncqhJTqBf04vCiCO7lx5pWMQCxFvK/ZI9NkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790416086; c=relaxed/relaxed;
	bh=KhakconhrGu2oZYTr+VE77hBjiLRqXZ4OFKpCDCtIwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D/c0rskLPTyd6l15Uv8aO/3pwZADlSOKaRArQsjSJn5Zh7r64qZGQp4hCSKZvNRntMDP5ZCod9+uEgHYrizFGpaRcalK3Cy02CQs2seEhs0241ZsfCBBS7ZQmy2tYAs5l2DZxI30eLyJa7QvAHhSLcMhCbme6y2o5sHmK+47XxoMsBp+AfXCYjLudqU/eDey/F5oxDwP0ta0Q2zqjT9XzSsY2nqX0jWlt+83RnOgSeNZD0Maqj4pVv2rRRGSxCmNO6u/tF8fjOjrtXSJjUHCMguVNsNET2BJNv/uIFLeuWLDpwMDbrKBR0vqkwE99ovvUKJdQ3CDk27L+TsAR+Nw5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=2001:a60:0:28:0:1:25:1; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org) smtp.mailfrom=nefkom.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nefkom.net (client-ip=2001:a60:0:28:0:1:25:1; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 477 seconds by postgrey-1.37 at boromir; Sat, 26 Sep 2026 19:48:05 AEST
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsN6Y1S2Xz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:48:04 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4hsMx95lHWz1sPSD;
	Sat, 26 Sep 2026 11:39:57 +0200 (CEST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4hsMx35nYKz1sPRy;
	Sat, 26 Sep 2026 11:39:51 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4hsMx319yNz1qqlR;
	Sat, 26 Sep 2026 11:39:51 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id r0-zxGatOHrc; Sat, 26 Sep 2026 11:39:43 +0200 (CEST)
X-Auth-Info: wFe88JiXbDxEAWB88fOER1RGk4p+sTXtzQeYAh7Q9amIwrx952rztx0YkIPQk3RO
Received: from tiger (aftr-82-135-83-101.dynamic.mnet-online.de [82.135.83.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sat, 26 Sep 2026 11:39:43 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>,  Thomas Gleixner <tglx@kernel.org>,
  Theodore Ts'o <tytso@mit.edu>,  "Jason A. Donenfeld" <Jason@zx2c4.com>,
  Vincenzo Frascino <vincenzo.frascino@arm.com>,  Nick Desaulniers
 <ndesaulniers@google.com>,  Bill Wendling <morbo@google.com>,  Justin
 Stitt <justinstitt@google.com>,  Catalin Marinas
 <catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>,  Mark Rutland
 <mark.rutland@arm.com>,  Huacai Chen <chenhuacai@kernel.org>,  WANG Xuerui
 <kernel@xen0n.name>,  Madhavan Srinivasan <maddy@linux.ibm.com>,  Michael
 Ellerman <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,
  "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,  Paul Walmsley
 <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Heiko Carstens
 <hca@linux.ibm.com>,  Vasily Gorbik <gor@linux.ibm.com>,  Alexander
 Gordeev <agordeev@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Sven Schnelle <svens@linux.ibm.com>,  Ingo
 Molnar <mingo@redhat.com>,  Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  "H. Peter Anvin" <hpa@zytor.com>,
  x86@kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  loongarch@lists.linux.dev,
  linuxppc-dev@lists.ozlabs.org,  linux-riscv@lists.infradead.org,
  linux-s390@vger.kernel.org,  llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
In-Reply-To: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
Date: Sat, 26 Sep 2026 11:39:43 +0200
Message-ID: <87zex4ic68.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
Content-Type: text/plain

On Sep 25 2026, Nathan Chancellor wrote:

> +#if __has_builtin(__builtin_memset_inline)
> +#define memset_inline(dst, value, size) __builtin_memset_inline(dst, value, size)
> +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
> +#define memset_inline(dst, value, size) __builtin_memset(dst, value, size)
> +#else
> +static inline void *memset_inline(void *dst, int value, size_t size)
> +{
> +	char *d = dst;
> +
> +	while (size--)
> +		*d++ = value;
> +
> +	return d;
> +}
> +#endif
> +

memset actually returns the original pointer, not the incremented one.
Nothing uses the return value of memset_inline here, but it is
confusing.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

