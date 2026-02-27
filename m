Return-Path: <linuxppc-dev+bounces-17378-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039AEFD5319
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 09:32:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMjlb1bRHz3bjb;
	Fri, 27 Feb 2026 20:32:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772184731;
	cv=none; b=FE5MObuun1rohdEg79JL5qIeZx2b6L+z5LA4SLlD0nqnunXtTCxS+MM3tosrgtgMcxieOQm/1BTkyFVfd0VGbpGNOWrwkzJ0+wBDKh9614uJeMurcWR3e7VpB+FdLr5Ey+HFXKY1aQxZ/kIMtGBmemLQPXmlX512X0Z6XQIHDZkRbnr0oLItXqgSdnkRypphX9oq+/bLFOgT5DgwB/7TYRa/r7EsC/p+vDP/M6e5GNFu+0iwcWeHqSHFlw0OZ0FZNgwBtQ0bPzVVtEk6geMbnv4Xrn+/ufazDs5A+i+8F1C2f+nKMi1PxOPXJ9ZW7qJnQ1M00HxtLkaSuTvibSgIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772184731; c=relaxed/relaxed;
	bh=XOdZaB3lOid4SOqrP5NMga5DLjNzennvRPzmBIDu08I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g25Eo+hKZkgSrpOO/JSkTY+T6hXZL20tvY4z7eKecBaCEaAaByaBLSZXisY6fdNbVgcMbPbyYxkPFyUaLrh85HwImWykza2cYVFQBDZ6/JfgO5mpyFpNr4cS4VOQi3f0RM89QDDtQi44Pts2a2oIYoCPLc/p2JwPqRuWGOGvl2iIAvj6o3xsZ/iu2XZdJHFShHQ8cnlCCP1zgAh4zXAYscbio5wZ02udl68VeYrUZCFe47lwl4u+q5haEJy79uAbRoBAs6XSmc0F53B9IyVH+6qB7oyJpfwgSPPNu3c+8FkLvVBKBxGsCJOgazv1SV/wki+2/GDUlC4jHPqqHaZM1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=30xG3cOQ; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=8swSz8Rs; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=30xG3cOQ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=8swSz8Rs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMjlZ24KKz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 20:32:10 +1100 (AEDT)
Date: Fri, 27 Feb 2026 10:31:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772184718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOdZaB3lOid4SOqrP5NMga5DLjNzennvRPzmBIDu08I=;
	b=30xG3cOQq3Co+onLqk07Fl1SRub/xIIrWg5BlfgkzAWZ0VeIKC54fH8uO8eZEd+hg1DEWm
	3lFzR/rzBx84ZT1ZKzZrWltXdpoXCZ0ibq9i/Dsptb/aoovS1STcf39oBFQSEeuj/xseGE
	6K9RLDzVR2T8QKb0M8tvGIhDcPj4s3MmKysFRs7YVGQwx3ek5/b+BoabeLlNjEv9oYIZMb
	YGETHpEAry3zfcuN5E2Npk67Vw6JW2IG2s1TzFPZSDONjRyV4lLzE+jXmUHCikBXLonAGz
	fd3ywzi5SA0cqDHTHwGAWijGynVhIumuIoXjFDntV7gAIwKpTXIs6V1kTXWbUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772184718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOdZaB3lOid4SOqrP5NMga5DLjNzennvRPzmBIDu08I=;
	b=8swSz8Rslvq4Ux1k+Q/Nlj4jfo/n+8Kwiv+xQ3xlP0PoCvw9xbWvPet52abVwHEuj2VTTA
	7tuFl+I2R98cffCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 5/7] MIPS: VDSO: Drop kconfig MIPS_CLOCK_VSYSCALL
Message-ID: <20260227100849-fb0bfec5-4d67-409c-8dc4-dad10c84fe98@linutronix.de>
References: <20260227-vdso-compat_32bit_time-v1-0-3f0286a7bac3@linutronix.de>
 <20260227-vdso-compat_32bit_time-v1-5-3f0286a7bac3@linutronix.de>
 <7fb5b531-2d78-409f-8f65-e12757f9296e@app.fastmail.com>
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
In-Reply-To: <7fb5b531-2d78-409f-8f65-e12757f9296e@app.fastmail.com>

On Fri, Feb 27, 2026 at 09:46:23AM +0100, Arnd Bergmann wrote:
> On Fri, Feb 27, 2026, at 07:57, Thomas Weiﬂschuh wrote:
> > This configuration option exists so "that we don't provide the symbol
> > when there's no possibility of there being a usable clocksource".
> > However it only covers __vdso_gettimeofday() and none of the other vDSO
> > functions which should be affected by the same circumstances.
> > As these are more widely used than gettimeofday() and nobody seems to
> > have had an issue with them so far, drop MIPS_CLOCK_VSYSCALL completely.
> >
> > The removal of the ifdeffery will also make some upcomming changes
> > easier to read.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> The #ifdef was originally been added in commit 7d2aa4bb90f5 ("mips:
> Fix gettimeofday() in the vdso library") as a bug fix. This may not
> have been the correct fix because I don't see how it addressed the
> case of a kernel with MIPS_CLOCK_VSYSCALL enabled running on a
> CPU without the timer registers, but I think we should try to make
> sure that there is no regression from reverting it now.

I can't make sense out of this commit. The generic vDSO automatically falls
back to the syscall if it can not handle the current clocksource.
There is no explanation *why* this should be broken on MIPS.
It works correctly on my x86 machines.
I will try to reproduce this in QEMU by removing the vDSO capability from
the respective clocksources.

Also vdso_clock_gettime() uses the same codepaths as vdso_gettimeofday()
and apparently that is not broken.

> > -config MIPS_CLOCK_VSYSCALL
> > -	def_bool CSRC_R4K || CLKSRC_MIPS_GIC
> > -
> 
> An easy alternative might be to drop the entire VDSO in
> configurations that turn off the gettimeofday vsyscall today:
> 
> diff --git a/arch/mips/vdso/Kconfig b/arch/mips/vdso/Kconfig
> index 70140248da72..4f6fba9e108f 100644
> --- a/arch/mips/vdso/Kconfig
> +++ b/arch/mips/vdso/Kconfig
> @@ -3,4 +3,4 @@
>  # the lack of relocations. As such, we disable the VDSO for microMIPS builds.
>  
>  config MIPS_DISABLE_VDSO
> -	def_bool CPU_MICROMIPS
> +	def_bool CPU_MICROMIPS || !(CSRC_R4K || CLKSRC_MIPS_GIC)

That is an an independent optimization IMO.


Thomas

