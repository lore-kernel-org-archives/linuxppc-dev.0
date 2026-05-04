Return-Path: <linuxppc-dev+bounces-20431-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13336CD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 18:02:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8TxX3Kklz2xnK;
	Tue, 05 May 2026 04:02:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777917728;
	cv=none; b=APQEQiPYZxEkQuWOUm4Ed+J/3nu4nDJpAPSwEFgMCCGsgzyxZH7gkhh/4AAGh1j6MWUEq5E+qOdwPLj0YEJz+J7G64k2vPLUywpncTBKaJQTPCplsFlHjfJiewJtyUYxHdXbDF52knY1eYVlaPKjkkd51/Fm0Id9WI2cY4T6WBvZqvJ2+AKszqfABWdmvQIFhOAjH29lequudQKELehF6k6D9jO5RaTAzHvHOxASpQMwhiFHc7QZ8mlSgXWhB0pHJTgMfmkpcm6YT14sax7GWZF2he/88A7FErc77UXz5twfbv/H2W9PlUEpolfL0YJTH6WivpJ1bJPzZfsu6N/fEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777917728; c=relaxed/relaxed;
	bh=1YRWn+NsbR38/MSwvxQbXr+vmJz6NGHtPCAIcMEHXAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeE0ukRABkGWxrqdtspBBz74VTi65YqYn4YW5Jt6VcTb2Ag/uf7lib4WH5TN+CXS5kvv16Cwv6A68JhHLldjaHQGvsf2aE4anEVOjXpL0SirWrmArsL7CCBHNrOuYXS4wNi4GGP70UGsLiiK2Tljm6p75Qk+dcOwPXIkuedy4oMwvFzhN0UM8pTaMfBRi5k0Dx322tgHtrfyEIt4avJ/vQpKNA8ix2AiecLR1hwE8cgDrYnmBJxkEMfap+UsmZSZwRx+kaZ05ngWp+vLEoYzi61jm5xhQiuEQgU83G6BovNM+PUBECQOcK/kH3rQM0Jygzgs+6gxHXz+bwtDQxtN/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ml1/qumi; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ml1/qumi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8TxW2KBSz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 04:02:07 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0D2FC600C3;
	Mon,  4 May 2026 18:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6F1C2BCB8;
	Mon,  4 May 2026 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777917723;
	bh=szpkNhMXI62ZGJn42+LaItfXpXq/gaSIIeijRGwBhNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ml1/qumiMS+QpbPL+4qP9mrMlLyrmiU97zBcGe+r3Fx8DB9frOllVIwaxRKuEQd7C
	 nCNQL67pWujcN2BskEgyOmaPI2uCI8VMR/nWFR2LeYcZrbcsCIQr4Rs4lYSpY22rU2
	 uMFr4M4tBqqVjKsDkqpEMdDJK/6UDXC6pJ5SsumUze6z88qpDyt9XppA707CvJ8r26
	 IZl79/rvbGSH20RceZGzdldGVU5bN3GgrRdT/jJBmuDXp/ko3+DgVUmJbMx4OUghpP
	 zKqW6Us2fz+pacR6exjt7BUuzXW567t9ByMJq/mf4MBZ2BhMicFK4Ck9uEyawKIN15
	 zoUxh2z1o51IQ==
Date: Mon, 4 May 2026 11:00:44 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH] lib/crypto: powerpc/md5: Drop powerpc optimized MD5 code
Message-ID: <20260504180044.GC2291@sol>
References: <20260504041448.15820-1-ebiggers@kernel.org>
 <111ea924-fef5-441e-9849-83f938c913a7@kernel.org>
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
In-Reply-To: <111ea924-fef5-441e-9849-83f938c913a7@kernel.org>

On Mon, May 04, 2026 at 03:28:24PM +0200, Christophe Leroy (CS GROUP) wrote:
> Hi Eric,
> 
> Le 04/05/2026 à 06:14, Eric Biggers a écrit :
> > Earlier the decision was made to keep this code for a while, despite no
> > other architectures having optimized MD5 code anymore, because of
> > someone using it via AF_ALG via libkcapi-hasher
> > (https://lore.kernel.org/r/f0d771d5-ed70-444c-957a-ad4c16f6c115@csgroup.eu/)
> > 
> > However, with AF_ALG itself now being on its way out due to its
> > continuous stream of security vulnerabilities
> > (https://lore.kernel.org/r/20260430011544.31823-1-ebiggers@kernel.org/),
> > it's time to be a bit more forceful with nudging people towards
> > userspace crypto code.  It's always been the better solution anyway, and
> > it's much more efficient if properly optimized code is used.
> 
> Ok, why not, but what do you propose as an alternative ? Let me explain the
> situation.
> 
> We have two versions of boards:
> - One with powerpc MPC885E, which embeds a SECURITY Engine called TALITOS
> for offloading crypto operations
> - One with powerpc MPC866, which doesn't have the security engine.
> 
> To use the security engine, our software use the AF_ALG interface (via
> libkcapi).
> 
> Our software has to run on both boards, we can't afford two different
> versions of the software and the software shall have no dead code. Therefore
> we rely on the capability of the kernel to do the hash by itself when the
> TALITOS in not available.
> 
> The kernel has always been the place where we do board specific stuff, not
> the application. I can't see why the application would have to ask the
> kernel when the Talitos is there and have to do the hashing by itself when
> the Talitos is not there.
> 
> I'm really concerned with the optimised MD5 going away now, and I'm also
> wondering what will be the way to splice a file into the kernel and get it's
> MD-5 hash from the TALITOS if AF_ALG goes away in medium-term.
> 
> What is the way forward ? I'm open to any suggestion as I really can't see
> where to go for now.
> 
> But please don't remove powerpc MD5 before we find an alternative solution.
> 
> Thanks
> Christophe

I think I gave the solution in the commit message already, no?  Take the
same MD5 code and run it in userspace.  It will be even faster than
invoking that code via AF_ALG.

Yes, the selection of software vs "security" engine (if you actually
still need the latter, which in reality you probably don't) would then
occur in userspace.  But selecting an implementation in userspace isn't
unusual.  It's no different from how different CPU features are handled
in userspace.

Anyway, please don't confuse this patch (which only affects performance)
with full removal of AF_ALG (which would be a hard break, and won't
occur until quite far in the future).  This patch is just a nudge in the
right direction, and a cleanup of the kernel's powerpc support to be
aligned with all the other architectures.  So I do believe we should
proceed with this patch.

- Eric

