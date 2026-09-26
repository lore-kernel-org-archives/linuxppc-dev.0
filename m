Return-Path: <linuxppc-dev+bounces-28277-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF651C98318
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Sep 2026 12:39:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsRw71jrQz2y7p;
	Sat, 26 Sep 2026 22:39:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790426359;
	cv=none; b=PmuDkfEz8eu4910j90aqO0+LJfbuIj6Y0m+4Ko6shFKQbMOVcBBLH1JU0esdV30kmHiOa20tkR33CIGQIJkFpFW2SA8jY4elTNutfbfYGWvQgko250k1XWuQTE3OwDqUbBv2gSh9kiCRXv3CS9pQQIaj2gpt2rAiJN8SfL2RR+yEOX34SgKHq8UDbkW5fv77dW2Z5AmFn3hxKFAOLI4+AfP8JQ0jK7WTx1ty73kNzmSppHMojkaI4IfVRSuBfXnVgu1v4YcsGkz8eqNLV8k4fOZOPQnElmYIFQqUdRXjRRP2Wfl1JeXydXyOqF61EZwoVyU+mocWLEpLyHwAgIZcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790426359; c=relaxed/relaxed;
	bh=xUrWyqVmnKFt3e8RhkrZ2j3Y0i3O/ft05oQJMh6wlj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhLY8QAcFtfs0zsh9JOCbDW+DNKckTdtbQQTQUrrUmB1j7RnwbzBhTqQBBTrjkHVQ+pkO5mfERnVtLgCocvZBOdIhgXQ2lPyXrHDfcMbFT0Qtl1FLg13r+iQjcefyAemrrV4NJZCJPThqzqeJesvBc5VNpkY2N9lxgeiQc3q7U02LeJmIipnIWYiHOm7zCYhdDoipWphNZQ6eFMbJWXg+SU+y0o08icNRZv8PHqHYayLR68ZHNzeeQIA0zdWqPx70/gH2/J+jbMHVj7YS5tWRvxV5DXEhc8nDTfE9JjyTmdyKYASGn9f83J+1ET9LNt2E/BSxBGPrxJhGaJJMgiwjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqO5QHmR; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqO5QHmR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsRw63fDgz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 22:39:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2188E44079;
	Sat, 26 Sep 2026 12:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CFA1F000FF;
	Sat, 26 Sep 2026 12:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790426355;
	bh=xUrWyqVmnKFt3e8RhkrZ2j3Y0i3O/ft05oQJMh6wlj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mqO5QHmRcMSYwDEgOPDLIZcr6jr2YfLZFqWA7XF/GlNNvRhVaLD2MqTlse+KUluEL
	 xzQtAcTaB0AUUAyhyXub2Dl1sDoMhQBVGpEqYPhOFnxMIeHAfILAjiNHt5KASH4zgE
	 9rM1gY9zZsC843JVDcJ/evpaUDkxxUnTOWMufD7S2+kem/c2g2lrgfyGSMRjpNUarx
	 z5QFeWBKFuAmXjti4J2zAENqDWuza+nvxNd9M8lkcQxgEaFZWFlweuEwmQoJ24uygc
	 ZwThu0B4gX8MvLQqagGgOMSxUH5JZWmq/Uwr7kjbGCVNI+MI7sGEzKwfcBn23nv76b
	 a+d3+QTbcxiZg==
Date: Sat, 26 Sep 2026 13:39:06 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Message-ID: <20260926123906.GB1486962@ax162>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
 <areYMjNcaqe86ds4@zx2c4.com>
 <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>
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
In-Reply-To: <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>

On Sat, Sep 26, 2026 at 12:55:34PM +0200, Christophe Leroy (CS GROUP) wrote:
> Le 26/09/2026 à 12:02, Jason A. Donenfeld a écrit :
> > Apparently not on RISCV, which is what prompted this patch in the first
> > place. So I suspect Nathan's v2 here is the way to go.
> 
> 
> Don't you have -fno-builtin on RISCV like we have on powerpc ?
> 
> Or is it clang that is missing this option ?

Yes, clang has -fno-builtin but as I mention in the commit message, that
may not always stop the compiler from generating calls to memset(),
which it is allowed to do even with -ffreestanding (which implies
-fno-builtin) per GCC's documentation. -fno-builtin with GCC < 14 just
happens to avoid generating memset() for memset_inline() in all of my
tests, hence why I went with this approach as suggested by Jason.

-- 
Cheers,
Nathan

