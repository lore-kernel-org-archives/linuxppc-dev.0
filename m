Return-Path: <linuxppc-dev+bounces-13800-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D338CCFA0D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Nov 2025 13:45:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d1mml6bs5z2ySq;
	Thu,  6 Nov 2025 00:45:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762350343;
	cv=none; b=cZL19mbiG85SwACHXIatx/LeUMU6i18Yug8Ivjj02uHgdr7J68ZGwgORkdAngT9OLLBDfaohRQgNwLMubvOOs/YUb4ddHKOfggEADImy+N4L/LA+6GDX/CR8jkDMn1dopcRkkXNw+yQM0tN8/5TByF8/qqXy35t7UL/wd5bBHX/psHP5+mrYq1cehM60lTJHeWb6BPP4L8QrRtSuROgcsRXeBRwN3aMu5f6+tUTcpSlfOFZGxVWVrkQaPAi8VCcaWrqJZVbjeFKLCGM71n5du9xRb6So3xGucmu1KYDgjhzflLxjhoX6fUDdsoe4O8RmOpllsHwwX2i9j7I82beYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762350343; c=relaxed/relaxed;
	bh=v2rYgvZieTTaJf5j5KLaO2PaarklVK0OhDArVYYysPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4u2T6vtKMnL/SCx2fR2aXOt15GTUOz1wmLclIUh7UUlPzwb36wapZHw2v8IqCWRoQJNa0yx0RombEo1mIc6C4SBt55/ux3hbsPfMCQkavwQr9YPmq/PUZGDnQwet4tuckBLGIlln8Bylq/Y6P/86OZ9J5A7AePpoow34o4OoFI7iri9hDZZ2hQql3iT8qu2YqF3oEGoH5kBsYJqAonnhRShxRy0r89dQsWW+8a1fACT6n7WfGsxA7Sl5/3Z+r8GPmX3jSYMRmWCOwp6m3hXF+YV4HI8iVdztkUao9Rdv4CGTpTy5VKeyywmILrhybPZW7oMZ70TcIxs84+GHJqRCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d1mmk2mYQz2ySP
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2025 00:45:41 +1100 (AEDT)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 5A5DiSRa1593373;
	Wed, 5 Nov 2025 07:44:28 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 5A5DiQRd1593372;
	Wed, 5 Nov 2025 07:44:26 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 5 Nov 2025 07:44:26 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-efi@vger.kernel.org, llvm@lists.linux.dev,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] kbuild: Add '-fms-extensions' to areas with dedicated
 CFLAGS
Message-ID: <aQtUujos2ADVs-_O@gate>
References: <20251101-kbuild-ms-extensions-dedicated-cflags-v1-1-38004aba524b@kernel.org>
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
In-Reply-To: <20251101-kbuild-ms-extensions-dedicated-cflags-v1-1-38004aba524b@kernel.org>

Hi!

On Sat, Nov 01, 2025 at 12:35:47PM -0400, Nathan Chancellor wrote:
> There are many places within the kernel that use their own CFLAGS
> instead of the main KBUILD_CFLAGS, meaning code written with the main
> kernel's use of '-fms-extensions' in mind that may be tangentially
> included in these areas will result in "error: declaration does not
> declare anything" messages from the compiler.

Please fix such non-standard code then, instead?  The only (documented)
thing -fms-extensions does for C code is give meaning to something that
otherwise is a syntax error (and it is for a good reason!)


Segher

