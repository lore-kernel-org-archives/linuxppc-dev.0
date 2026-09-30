Return-Path: <linuxppc-dev+bounces-28556-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349C4CA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 13:38:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvx2W1PPqz2y24;
	Wed, 30 Sep 2026 23:38:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790775507;
	cv=none; b=OrHm+dLWrEtC6l1+YhfKW2TxxlEupJ6c2EOK3lECASUwR0AKgFIdBJVnTWeppoXWbquS3GsqKEDnpNmqGsKB2yBYzSR+c9YuMq96rCxRwugjAXQuhshIBOIJtc3EHFO6s4TgZ/x5nopj9U65k7+7q3b5rVRYPWn6hH4W54f5HHAmcagrIKx6GOGD7XedaFCr6XvIkQX/Tps1t5dDbYQLliqtR85krZnwd9NMs42FtuVtvi+AdJ3oOvaQqSz83CRzHt6DixoTw35/u9X+2H89pbTWfKTyUZ/569iI24lhvAz9oohTFc94/2nmVAu454VG8vBkfpdJId9PkZA8hnZttw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790775507; c=relaxed/relaxed;
	bh=Ig13N2tfIjFRsSeqDuP4ixyXHADT+oxuPpwsFpsBiHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgwqudTN8XSQxvPLONgHcz3sAqz0VYvBy5Tin2pUSn5hQIfCOQmNLQMDpK0Oxfbf5us0BU4X4ANoohhKB39QeUA43pbYunVfqr9sASvwaJSR7JRnZM+nVVdPyxyDxfvl+d9v1LkiigVY00MlTgQoTfrfMJIvpimxWoBh6yELouOSY1vmAxnFOdXOXMs3Xtq+wH/G0tvwFn0VniDs6EGu11rSwONHLfd3ULAsSK9Z+8n4IiLZgIGHOSItNMGPc16LW9L18Qp4bsph1g4We0k6+myQ2/kp+i03yVYeLxB8Kfykr2o4KkgDdogD8bvU9n/RYZbKCPYM5d7yrH+So7r7mQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f+lk879y; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f+lk879y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvx2V2254z2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 23:38:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3D5BC6025A;
	Wed, 30 Sep 2026 13:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD6B1F000FF;
	Wed, 30 Sep 2026 13:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775502;
	bh=Ig13N2tfIjFRsSeqDuP4ixyXHADT+oxuPpwsFpsBiHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f+lk879yO1tcwpxTCZ8Vu9BSZUmqzoN86ot1Geu5VLUsqPRG9EiYd59TtYmDI/DQx
	 b8PpR9XUHRj0fTYkMmqXQuU21rsM9TF4RTV+0y9feymcUMVNsiCzbuBPKCg7LcBInO
	 A8qletS7Fjls0KgPrzllrFG2yFr3jSqVabH3BfItoBP22iHLl1D1M+B10unFPxeYbS
	 DoBEprp5b4czipy9XTDOYyQwloYcLFKkBr+bQORPpJFN8w65Cv7oGrANxZ7mpBtWFH
	 X/3FQ1hd+ZdBx+IV0FxW43+cOBuEql4F0qrdZWn1SclMvfp5mjwnEyjv/+mEW0gQs2
	 c0/P6Q0/ruZRw==
Date: Wed, 30 Sep 2026 15:38:13 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
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
Message-ID: <20260930133813.GA3142230@ax162>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
 <areYMjNcaqe86ds4@zx2c4.com>
 <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>
 <are6s5e6On3hpD3M@zx2c4.com>
 <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
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
In-Reply-To: <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>

On Tue, Sep 29, 2026 at 11:24:11AM -0700, Nick Desaulniers wrote:
> arch/arm64/kvm/hyp/nvhe/Makefile has this pattern for exactly the same
> problem I suspect.  Maybe that's the right tool in the toolbox?
> 
> ```
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 8dbf2532a573..27fa72d8fb86 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -27,7 +27,7 @@ asflags-y += -DVDSO_CFI=1
>  endif
> 
>  # Files to link into the vdso
> -obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
> +obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o ../../lib/memset.o
> 
>  ifdef CONFIG_VDSO_GETRANDOM
>  obj-vdso += vgetrandom-chacha.o
> ```
> Fixes `make -skj"$(nproc)" ARCH=riscv LLVM=1 mrproper allmodconfig
> vdso_prepare` for me, as per

For the record, this also happens with the 32-bit PowerPC vDSO, as I
noted in the commit message of v2. I should update the issue too, I only
realized this after wider testing. So if this is the route we want to
go, we would need a memset() for that vDSO as well.

> https://github.com/ClangBuiltLinux/linux/issues/2183
> (Nathan, don't forget to link to that in the commit message)

Yes, thanks, I have added it for v3.

> I'm surprised I didn't need -fno-semantic-interposition (or one of the
> related flags... -fvisibility=hidden)
> 
> If we want to get better, (if performance matters here and we want to
> trade source+build system complexity for absolute code perf) I would
> start with that, then worry about clawing back performance via things
> like:
> - __builtin_memset_inline
> - -finline-stringops=memset
> - -ffunction-sections+-Wl,--gc-sections to dead code eliminate the out
> of line copy of memset, though IIRC there's potential for wasted space
> due to alignment requirements (maybe the out of line copy of memset is
> smaller...idk)

Yeah, I guess it is ultimately up to the maintainers what route they
prefer.

-- 
Cheers,
Nathan

