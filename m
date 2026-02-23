Return-Path: <linuxppc-dev+bounces-17081-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2678EEEC2AC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Feb 2026 23:02:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKbwY5ZPbz3c8s;
	Tue, 24 Feb 2026 10:02:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771887757;
	cv=none; b=QTGcA295gni/3XQXCsASGEqJQZ7am6Pbxs5bk7hTq+VqCoBzC9cEjjQPNpQ5ypMQh+TQ6r4RD66D9eY3cYEY79SytmbZmk6iiN9z5AmWek9eG0/WyM4QHFJvD9N0oxEX0AKg/ZLIbKgfZmo+5LfTVTSYwlIzQTEPZ+Ozp2SaHJwL00/5NXz4FPRe8XxEPtHaj2rijm1KIAG9FqkdKpOhHyaj+q1mB0gSBd0m0s9QHUoL2B2KnmleUIPpHPSwCAVC5qojn+y0DPaEiNrOKXdTQK7MJRcEtzVrURxULfNBl3t70r1RwLNFrxxbHCMChWpIoleiEB+AfUM57shc5NQYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771887757; c=relaxed/relaxed;
	bh=MHE2PwVSNmtaNO8BGfW3K8dGHZFbvaGXss3snToR86E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX7+SOr+WGeIxLUOYmrlpXFRE0/ebg+3sVkaH+OTaHte5GjUwqu7uNzkH5orw19qZpkhcCAxwa2aNr1Kr/lDsjHNmeoYMV2mlP48Apc0J7M0I9SStcyLkvwUnBRxFJRdN4+BRkt7JQEqDLj72sx2+im+Xok32Mdd3GdHowjWFb+dI8ilCCySZLfcVR0cqVQUcWBHkVVDkfh9e7ODJqea+zZZXsGRVh4Azr45231OBPq/ppE63OVhd7Sf4gsvEwxjgXTJMPFW69IvpKvkfXraEJQ4SkdfoiIPlTE4LkP1EWTTr5M81lQGuOIbeyYsbQPH6eyKo5XmCtblul1oHDecsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V+fu9p4B; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V+fu9p4B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKbwX2yCBz2xnl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 10:02:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9C73060137;
	Mon, 23 Feb 2026 23:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48409C116C6;
	Mon, 23 Feb 2026 23:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887753;
	bh=nT0awucs3thOhxybhtypZ+eYhg7lv1UzxhZoWxrV7JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+fu9p4BCluguUa+f3d7BCn1pI2i9AqAEMBzkLqH4bddGKT5WSOohV6ymAwB0/TBL
	 lXNzrl+hmSZblzdOixCvwDFcjW9iJo5ImvPlqCzkT22dc1XMIZWAMVzlyyqxTDXaZ5
	 4A5XwGEGtPXUctEhtggMXSRCQOq7U1cR9rpjbXPVnxUBOrPDtTlXe7A3JD/7+OhTOF
	 pTf4SXBjLVNbVuMyClIxv9c3QaOT9qAcBGv/vWbbNANtpasn+pQ210tXeKbMh0saY3
	 VU3OBF9raOPDCjnuuQKM50HH+X66NKDZ7QZi6Z7SFHAdAZXCsNZW64QbGHR00fFjZH
	 58/1MtBytYDmg==
Date: Mon, 23 Feb 2026 15:02:32 -0800
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] kbuild: Use '-fms-anonymous-structs' if it is
 available
Message-ID: <202602231459.2A1DD53E0@keescook>
References: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
 <20260223-fms-anonymous-structs-v1-2-8ee406d3c36c@kernel.org>
 <202602231432.20F3F0CF@keescook>
 <20260223225311.GA2462602@ax162>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223225311.GA2462602@ax162>

On Mon, Feb 23, 2026 at 03:53:11PM -0700, Nathan Chancellor wrote:
> On Mon, Feb 23, 2026 at 02:33:35PM -0800, Kees Cook wrote:
> > Series looks good to me. One style question, why go the round-trip with
> > Kconfig instead of doing it all with a fallback in the Makefile:
> > 
> > CC_FLAGS_DIALECT += $(call cc-option,-fms-anonymous-structs,-fms-extensions)
> 
> I might be misunderstanding how Kbuild works but
> arch/$(SRCARCH)/Makefile may have logic for selecting CROSS_COMPILE,
> which can impact the selection of $(CC), so I cannot use cc-option prior
> to its inclusion but I need CC_FLAGS_DIALECT to be included before
> arch/$(SRCARCH)/Makefile in the main build so that they can be used
> within it, which is only possible after Kconfig has run. This is
> probably worth more flushing out in the code or a comment since it is
> subtle.

Will Kconfig see a different CC than Makefile? Regardless, I trust your
judgement here! I actually rather prefer having it exposed via Kconfig.
:)

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

-- 
Kees Cook

