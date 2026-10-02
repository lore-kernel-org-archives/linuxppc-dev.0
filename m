Return-Path: <linuxppc-dev+bounces-28737-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66531CA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:28:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx3Nq56NLz2yDs;
	Fri, 02 Oct 2026 19:28:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790933291;
	cv=none; b=lGP1YnpOWUr+OmvAq3LpD2HDcnwiPaOH4KOFJ7VcZ62z6rlwLuP3ukYn7+QMr66mFta/8OK4BAFbuGNFQjQE0CkFqGX3w7iAf+ZEivITpRESPnmrJAlnSqUszwM0qSb6cR5WfX1cPxGjoG5o0GL6e5i5Gr2jakoCAWF8tlNWRZwCL2+FQM86gxlXe9rxsWSuCOR6I4B9hpOf2xOEToUreWux7GtSyETgTtAh4FwW+1nWJ1HV5v/194/t+rYF98R/UqPOBSDtKULSU62F/Uyb/LWiWFOgCRFh0HUTS1PjMUNy81Xz1Dx3qyI6U1yOF+tqLhKq2sAvSvlCX2/TTBGavA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790933291; c=relaxed/relaxed;
	bh=dtcin0LGddrGq1z73zXhBfHbevxSulJDQC2ODA9S4LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBCdAwSwcKcdLJRXJWm+k2IWMqMt0Z9DIllEr3Ih5zBXyR06C+XKg4j//2gJjztgDFOUVSR+yIajfpob4SVTSv1LGFRhITIRDustTePQOivA6A4kDBQUn9PNCeYyoa6hI1YmiFNLU1cYo3T2Xdr422pgEQBmWchBBhWUrXAtQSm7gCJhGWSi6KAX+Rj1pQeIIKQT2MmkMNxhZgJx16TNE11Cr9KBP63XX+kl7SApJV/XurotBj9goDO1Ll3dwOzDfgt7jYpIt+ndVvFBv0L5PN3KELJHFRXRcsRhMqWroyWT4KgRGpc7cK0kTCN11YGNp49bWC/Zb/bJqlmcjkU3Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com; dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=JXF9aYC9; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=ixz0=hy=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=JXF9aYC9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=ixz0=hy=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx3Nn1XyXz2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:28:09 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0C3DF60A70;
	Fri,  2 Oct 2026 09:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424F21F000FF;
	Fri,  2 Oct 2026 09:28:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=JXF9aYC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1790933279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtcin0LGddrGq1z73zXhBfHbevxSulJDQC2ODA9S4LA=;
	b=JXF9aYC9WwUSK4dqsSbWZahQOF5tPs+qWfT6am7iM2kEiqJtJzCVxFzDeTv/m/a4MQVUpO
	GLRdB7QsZbpopzZdWvYR/SsEQbyfmCcXe2exUQZ5/eF4uZWlcciUWsy7qUj8Yd99apyea/
	uqdi3Lw+wZdB/dnq0RpegAZySOW8XXE=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 0f473697 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 09:27:58 +0000 (UTC)
Date: Fri, 2 Oct 2026 11:27:54 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
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
Message-ID: <ar95GsA9liO5Avn1@zx2c4.com>
References: <20260930133813.GA3142230@ax162>
 <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com>
 <20260930151337.GD3142230@ax162>
 <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
 <ede392d7-3104-4a0f-9fa1-99b22552dcd6@kernel.org>
 <ar4nD8aRH7wEvTMt@zx2c4.com>
 <20261001102059.GA4176271@ax162>
 <ar46ap4jzLWyP92C@zx2c4.com>
 <83a874fb-db66-4dc2-8e14-68c7e28ae27c@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83a874fb-db66-4dc2-8e14-68c7e28ae27c@kernel.org>

On Fri, Oct 02, 2026 at 11:18:51AM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 01/10/2026 à 12:48, Jason A. Donenfeld a écrit :
> > On Thu, Oct 01, 2026 at 12:20:59PM +0200, Nathan Chancellor wrote:
> >> control. The change that introduced -max-store-memset only did it to
> >> "allow fine-tuning of the inlining threshold for performance analysis
> >> and optimization". If they decide to remove it for whatever reason,
> >> we're back to square one.
> > 
> > I suppose all the more reason to get -finline-stringops=memset added to
> > clang. Then the dual-default thing you came up with below will naturally
> > start choosing the first option when it becomes available.
> > 
> >> I know something like below would be uglier due to the ifdef but it
> >> would avoid changing anything for GCC while clearing up the issue at
> >> hand for clang in a guaranteed stable and succinct manner.
> > 
> > But then we're back to the byte-by-byte codegen that Christophe pointed
> > out.
> >   
> >> If that is not acceptable, something like the following does appear to
> >> work for me.
> > 
> > Okay, great, let's do that.
> > 
> > Does this commit seem okay with you? I used the diff you sent below and
> > adjusted the commit message: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.zx2c4.com%2Flinux-rng%2Fcommit%2F%3Fid%3D56ff95ee85715047eb5b5220243778af657778c8&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cd89b4de22ff94b6be71208df1fa9839a%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639264485055490029%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Vxf8xRCdLavtw4Dmi%2B49FY1lJDWtm%2BjKv7f8BxKTGq4%3D&reserved=0
> > 
> 
> The commit message says: Similarly, GCC has -finline-stringops=memset to 
> do the same [4], should this issue ever hit future version of GCC.
> 
> Why default "-finline-stringops=memset" if 
> $(cc-option,-finline-stringops=memset), have we identified cases where 
> build fail without that or is it just for future provision ?
> 
> As shown in my previous email, with GCC 16 on powerpc32 we get a 
> slightly better code without this option.
 
No, that patch tested this option + actually calling builtin_memset.
This new patch has the original code of zeroing a long at a time, but
has the inline memset option to prevent future GCC from recognizing that
pattern and making it outline. Codegen should be the same.

Jason

