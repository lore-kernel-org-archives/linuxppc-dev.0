Return-Path: <linuxppc-dev+bounces-28581-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DC4CA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 15:13:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvz8Z6B1Rz2y24;
	Thu, 01 Oct 2026 01:13:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790781230;
	cv=none; b=Yq3fCD1uzTzqfmq8VwpvADje/Yj1nuAKJIH1CVRG76DWsNTqSSMFCK4mKkxe7woCDKng2wiI/NuGkKvIRVfrMSp+XyO3TtMFRhNaoXlzH/NjS9wwoEb+PsfDrl1TLlkfZuC71Oo+bSPqlv6l786aIrE/IV5mHvEi2n8NjXjCtnYpMZsZFAFrmIeqimPgAVwlQ6hZ182jenMx8z2makPGbDmxWHPg2e4dzPv46mgQDoK/qQC826i8DZRDnFI/ZbsaxikmzJOkyvjCZguQXeRBDlzexgzU8dwnNDmdnPjF9CLCA1/AtioLKDTmhzVvSPDWeojrJV/4CR+XmypvztfavA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790781230; c=relaxed/relaxed;
	bh=VjvLVAMdH25Pwcx27KXLJsLgwjves/K/FG5W879yHtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4AC/3g6CEouvHiuIXP4tv+Tw3GqiAQvHJEEOZtbyf/7mQYa3kLKvTx7YqGw9sBiHcIpuB8u7W8ru0ndsnjP9NBkbjvlics3jyrML/hHc5I9/exuEnzaNbRGssjZF5ybiGeDAh4O49GuKIotvcsRo+zhEK5CM/UcLF7b1xUpgeK1x9JBr/TV4bKRHbElOZpt7UeL/PkZrymRviqd7RKLvSaUIsmzksA6jr7I7WlCnMQvczTPB5Pb3vf2FfIHZAYRcC/dAJfUWV8wSgwJUcvaZAZlrJQuevAtCSmpRjoQITtLSzTNwXtA3sxnZ4WPabCv0PvT5vahviaU6mktiQUipg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n05xolRq; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n05xolRq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvz8Y6DnFz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 01:13:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 72D144369F;
	Wed, 30 Sep 2026 15:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD9E1F00893;
	Wed, 30 Sep 2026 15:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790781227;
	bh=VjvLVAMdH25Pwcx27KXLJsLgwjves/K/FG5W879yHtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n05xolRqMZoeGMX1Ra4yjBtIDnmfnQ1LRl61P06RLuxE0uOOHM/URSrWqCi1e5N5n
	 +mdD4PMTU1Q5epP+tXpj2DjPMhXSXpLaFHOJqibdDNkpBWWZ/nVCo2zgFbkYaLSUF1
	 YufuCIwyVjzc1U2iSBQhPuWlPi1tqYXi0imKd0lPbYcF2S28XjmlPiWUlpR8etfQvF
	 ahR1ytm89zid5O4hkJLCUT8HepSgXHEJCFv3ViscDLZ4eEWA5fb406Hz9q21Z7AgLj
	 QKh8gF/YA+kzVc4c2H/gw4DLcW6PckFQ+eVhgrUAY04S9NR7ZD3xsEA7stQCEkG7oz
	 yjSHW/SJMBLDg==
Date: Wed, 30 Sep 2026 17:13:37 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
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
Message-ID: <20260930151337.GD3142230@ax162>
References: <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
 <areYMjNcaqe86ds4@zx2c4.com>
 <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>
 <are6s5e6On3hpD3M@zx2c4.com>
 <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
 <20260930133813.GA3142230@ax162>
 <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com>
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
In-Reply-To: <ar0gTS71qxnx9AkW@zx2c4.com>

On Wed, Sep 30, 2026 at 04:44:29PM +0200, Jason A. Donenfeld wrote:
> Nathan, would this be okay with you?
> https://git.zx2c4.com/linux-rng/commit/?id=d216701724b7d8209ff42150658ad5c712bdb503

Can you stick

  Cc: stable@vger.kernel.org # v6.12+
  Closes: https://github.com/ClangBuiltLinux/linux/issues/2183

on that? Otherwise, looks good to me, that's basically what I had for my
v3 locally.

-- 
Cheers,
Nathan

