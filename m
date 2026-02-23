Return-Path: <linuxppc-dev+bounces-17080-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43941EEC2AA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Feb 2026 22:53:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKbjv47d1z3c5f;
	Tue, 24 Feb 2026 09:53:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771887203;
	cv=none; b=lJyocO8J29uzumX3yw6SKVO2snqeYq9WS8pMTXKh3MaBQBnWqph+W5650++mJ0XK39k3uJmFv7uWq+5stKK3Afwg9TNl+u9lIB0gGoq7nuc0NQMXr0C7ZtgdsNctmUQcsMddiqrr3/Ooqf2O2Groqu0rrBJUsWsxX5s2y3PxlH5icuD88bvm1jP6z0zAYLdUXjOXj4J+U0OnksR2u5eyAncKsV0R+HJLpltOveaV+tp8Df/n7TYwtVPzGtz/bIjxLPOZ6GC304Rin8bAkc1pzukXzsmHt6x2Cm2aNgb6BH5h1xDAxMJ1iQANeEbPFQQ9JYg8/RmOTLkhkBHruc4CGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771887203; c=relaxed/relaxed;
	bh=EAPwTc+8uofmbFcnirZdS9sI1kTzfAVBXIc97mv34OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElUMUNJUsoVMe5sTIKNUDRJlVgmI4W/K+C1p9I/hCFhVKoae3MaEBkbY0ctCPMdxGjlHa1Ch1phO1GHkr4WV99UIbghw3yaQlXlOdSNyPcRRkRz9djJ/7/xNC/XnC1IE0LxPZ8/bVltKaTgNndv/cZzaVEMXzoe6RvPm4RMQZxKm8C5IMI4yq3jqsSgelMvR6Te5N4Wj54ALkpB8tPNQkvZww0CfvVLNqjurYrMD5XCzbvJIXmiva4CO8oLEHa9342xgHBgBl28cZAuUPoGJOXUK1MNwIECay6CozgVbe28ejDL12Vhcwpux9pAsGqtg/9LlSh42++AtachzItvqkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZmfHgfUr; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZmfHgfUr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKbjt5Znjz3c40
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 09:53:22 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1267043C9B;
	Mon, 23 Feb 2026 22:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAC4C116C6;
	Mon, 23 Feb 2026 22:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887200;
	bh=XGtuTf6Jcf122l6S01HJPRF+WchS/Q65b0NtmqAoVfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZmfHgfUrB8rf7SxS+m7i6Nbm83akA5w9OLDipQGSOaVcHUJGhBGr5JleV+lvbT9Ih
	 ES1jeEYODvs6SIXAPyGAAqikZa4UUtROdKJg27d0BjUclgv47EtSp4h3ptI4rsvsT/
	 A/Q6dW5mmG7a+LrrgsNs234f6ShddcgHYyrsN1srQ7REoeTAP28vUOzECSlNUqNnLH
	 G9qNJfAkWQ76V6BqhrsUIj/wgc43wW4DjMi+HPcfE29HwNkfPdhL31UnAXovXRGfzq
	 1HY/4jllrJt2uUrbR8H93TaAt2kzOEpXk+3SA5YCx8OLMs+sxQjnNO3yfFcXNCeWQl
	 UR0qUMHlXOhng==
Date: Mon, 23 Feb 2026 15:53:11 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
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
Message-ID: <20260223225311.GA2462602@ax162>
References: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
 <20260223-fms-anonymous-structs-v1-2-8ee406d3c36c@kernel.org>
 <202602231432.20F3F0CF@keescook>
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
In-Reply-To: <202602231432.20F3F0CF@keescook>

On Mon, Feb 23, 2026 at 02:33:35PM -0800, Kees Cook wrote:
> Series looks good to me. One style question, why go the round-trip with
> Kconfig instead of doing it all with a fallback in the Makefile:
> 
> CC_FLAGS_DIALECT += $(call cc-option,-fms-anonymous-structs,-fms-extensions)

I might be misunderstanding how Kbuild works but
arch/$(SRCARCH)/Makefile may have logic for selecting CROSS_COMPILE,
which can impact the selection of $(CC), so I cannot use cc-option prior
to its inclusion but I need CC_FLAGS_DIALECT to be included before
arch/$(SRCARCH)/Makefile in the main build so that they can be used
within it, which is only possible after Kconfig has run. This is
probably worth more flushing out in the code or a comment since it is
subtle.

Cheers,
Nathan

