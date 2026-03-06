Return-Path: <linuxppc-dev+bounces-17856-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4571CFCB624
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 23:17:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fSMkR2xBPz3c9y;
	Sat, 07 Mar 2026 10:17:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772839039;
	cv=none; b=QzlL+lhV7AJ1aEyc26ZWL1NNRWJ4szowBv4rngwF4blu+60EDdGRuPVSInqDiUbdkPjxlXKo/AA31YNhWNST/02UUVyC8VkIlMPMWtkGRKSjlUqmik3lLIFL64ab9yakq0NggsdSkXJ6b/OMJ96xfBOPTFEK7u9h2K8AGh1P4WD1y4auQoj5RyQO/Hg1x0jc45A2bfzZq+9UbC6tloisv7/JpZAnef2epUsruz/uVwbqUF4mBqIbwgN40yNUhTLdG3wh2N+Z8cGDbkJudNYesPlmixwZucDwarmrsdZD9UEOKLRmeIcox98izL8v9CfOo4n1TqOlYepPOYlnKGpP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772839039; c=relaxed/relaxed;
	bh=8ZR7Dp2IPiEMUD6BfjnRAuZaSEUl5mI6F5vABdqGEZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViK4sj5qQcZQf6eMvUt98xeNwFW6OsIw1XZNF/2ammAXFaq2z0Sht10mgt5vEvkGYcoMidMYP3XxjpXGRWPyr5QgGjVdV2T3XlKx/mUE382sAdo//hMsS61rlVoXOXddJJOJxSjr+cfPMz6yXS4o4yielq10c8todi0b4VKyeiVmGWVOP7jaySmILb3UBW/FixTxBMeRZbddaQRBCcEEs5M2XURgkFXmy66ioLO9PYs0TnGrlOmRgn1LpO9PaVrZU6VWxMDUPVCCuxz8JV8hiaV/x33UGSe18Zxkr1xO1jtEYF05n36OJ2MmZoAw1XCQzlAZfeEPzv5DftAWawmCvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CiNTmhly; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CiNTmhly;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fSMkQ11Gmz3c9l
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2026 10:17:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 79D9260018;
	Fri,  6 Mar 2026 23:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B13C4CEF7;
	Fri,  6 Mar 2026 23:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772839035;
	bh=A/uuCYUUHbNrrdKdzYdGzSe5pMInGIZfaSIgsjBFQtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CiNTmhly2/1kTdtRkuNAgOXwAQT7A+wQx51m3gawq6ph2TOb1AmR20TS/sy1txYNU
	 iElaZlD0mEOexw6DRDS/H4TTDu/pyj/oV6d7iSt93lYyho/X6/HC8T986ocCrdSX8f
	 W0fMhB4DiENlMrX0hKOJVXylpR8JdeJwPK1us4hrvgF/gpr5p0tTJy8J9/hBJuGZ7x
	 J6oOaB9DvzC1IcXPWbDiXcwZ6M+56B4nTerYJlMNfl+KbCI8z/0xfmHkRzg6Ie7YMn
	 mh/kZD1RDkMqTowspybgiAXSVWjmzHV1BRX2XnLenj50feqtNdUtqkWd/KSVt0jhRK
	 6S7laj3n5tF8A==
Date: Fri, 6 Mar 2026 16:17:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
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
	Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 0/2] kbuild: Switch from '-fms-extensions' to
 '-fms-anonymous-structs' when available
Message-ID: <20260306231705.GD2746259@ax162>
References: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
 <01433066-eb9b-4a96-8d7f-794af941d365@zytor.com>
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
In-Reply-To: <01433066-eb9b-4a96-8d7f-794af941d365@zytor.com>

On Thu, Mar 05, 2026 at 03:43:29PM -0800, H. Peter Anvin wrote:
> Question: does clang allow this with __extension__, or only if the option is
> on the command line?  It would be desirable in the long run if both clang and

It looks like only on the command line:

  https://godbolt.org/z/zrE766obe

> gcc would allow this with __extension__, as that would be required to use it
> in uapi headers (at least without some doable-but-nontrivial preprocessing,
> which might be worthwhile to do anyway...)

I agree that would be desirable but wouldn't that change how
__extension__ works? As far as I can tell from reading GCC's
documentation [1], __extension__ just supresses warnings from -pedantic
and such, it does not actually enable a used extension if it conflicts
with whatever -std= value is passed?

[1]: https://gcc.gnu.org/onlinedocs/gcc/Alternate-Keywords.html

Cheers,
Nathan

