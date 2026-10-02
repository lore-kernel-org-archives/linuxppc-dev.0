Return-Path: <linuxppc-dev+bounces-28748-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA815CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 11:02:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx5Tq25kpz2yj1;
	Fri, 02 Oct 2026 21:02:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790938959;
	cv=none; b=nkl/tf2JBXlf1jyJxojPyG9v3hluqsNhFnn+hKrHEgbHzHS9Yr/Iw5aztD1iqBD22qDkWBU1y2uoD3yukT2iIEqFEVYD85GTeYGUFzxNzwqDOVpIfSMlg3smKinbjVnGTNDoO9NWiiDMML4R5WNvvEE6D5xC0FTmdXCOFPPeLgDs/PWte71ta9KgrP8uXUMDnHF2fiFrbHndBh5hf8iqGoSIlakPmKzhM9p9UfqeWbMdREKIf0EdZiK7trxu/LotjvmnPZEqJWt+F4WetNict8hoMxr7VhImH6tfnklx38PsymBPr528vueE9bKozbUTSrsY+RDtYl2JqVB/sGA1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790938959; c=relaxed/relaxed;
	bh=hKu1k8kGP5SDfYzTUe6BEg1Rh9OEx1S7cLJzvwkIo8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJJXtChd05xWtbru9MGETuB0VXpHxCepivEG1BLNJstiPSqSx94Bdh+3ySlBxt3SOyhV09r4i6kZmc+S43vwgbzoXGKBMXUhii1axzOoCKUJV65N6oOnzj2Dcgb9vviEmDcirwCaIvnTcxCzGmtQMLqpGtAQiTLmr5IhYR8FKnfyzq5fmnRSbvW0ZEmqgKviEhvgmmeWbQ6kzq4AHhDrrMIc+WpDgSuoTgQpAJe0srdRWyLKiAznnPteQrvwui7F9MmK1ZiP6ihKUWMn21+dJB1528qltStr+bWHfqXWXOxDgH5pQc3BXRbBgICSaBPqMqsZu2g97mSQLK250b5ssg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSA8KOPc; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSA8KOPc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx5Tp2ZkKz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 21:02:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EE73841234;
	Fri,  2 Oct 2026 11:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0031F000FF;
	Fri,  2 Oct 2026 11:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790938955;
	bh=hKu1k8kGP5SDfYzTUe6BEg1Rh9OEx1S7cLJzvwkIo8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fSA8KOPcMfD4nTuoQwZ65dnTEvIIcs8MuGlPn8Fs/+3fC7NLGpsaO+RpN1IgsIBZu
	 AUxBtepWGjjVI3M99anax4EK04p2VnA9VIFZGzrlLQlbKdH3xKIuLyNNV+nBS2gK+K
	 5MooxFs6WNfBX0ph/LCjwbFGsD5J8aN8q3nq6gL6dt66NTeVQTiBN3PJLVIx5KOpvx
	 kE87mNLRWpd4R0tmXsVbWwfvfFM0lYN5bAuwZWdHMhEK58ZB7SZ2YSx28z9+Nwg3HW
	 ESud0bA/Itaq1CPRhVc11wMDE18rRr2PF7dQo3epBifa0/5Uf6eMwX7MZUn8/gFQ9j
	 MDkdSwxtvaqxw==
Message-ID: <c39d7d50-e527-4a72-a89f-da4a9ac3cc97@kernel.org>
Date: Fri, 2 Oct 2026 13:02:26 +0200
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
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Nathan Chancellor <nathan@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <179093852073.149722.832232613857480812.b4-ty@kernel.org>
 <CAHmME9pDcYh5OVSqnju8VfgEXt3YBToDBbFNz_OguKA23r6stg@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAHmME9pDcYh5OVSqnju8VfgEXt3YBToDBbFNz_OguKA23r6stg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/10/2026 à 12:58, Jason A. Donenfeld a écrit :
> On Fri, Oct 2, 2026 at 12:57 PM Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
>>
>>
>> On Fri, 25 Sep 2026 22:46:32 +0100, Nathan Chancellor wrote:
>>> After a recent change in LLVM [1], builds with the random vDSO
>>> implementation, such as PowerPC and RISC-V, fail when checking the vDSO:
>>>
>>>    arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not supported
>>>    arch/riscv/kernel/vdso/vdso.so.dbg: dynamic relocations are not supported
>>>
>>> memset() is now generated when zeroing params->reserved for some builds
>>> because LLVM has an optimization (now run in more instances) that can
>>> recognize at compile time when it is assigning a static value to a
>>> contiguous area of memory and turn that into a call to memset(). Both
>>> clang and GCC assume memset() is always available [2].
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] random: vDSO: Avoid call to memset() when zeroing reserved in __cvdso_getrandom_data()
>>        (no commit info)
> 
> That's not for you to apply. I'm sending this through my random tree,
> along with a handful of other things I need to fix. But I wanted to
> let this cook a bit more. I can add your reviewed-by line, though.

Sorry I messed up with 'b4 ty', I do not intent to take this patch in my 
tree.

