Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBD2606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knc1mCl6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFrN30pRhz30Sv;
	Fri, 30 Oct 2026 04:10:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793293843;
	cv=none; b=SvXtODOutdKc3TwowheRHv+RuN9C6MmzBWqROZArkUXyBDn76oVWmTVHZIRzENiQqemkERITbe3nPxLO/EuQ1ZV7/IoowQ+Hkf+KUa7pW6kCtKpKBvY4jx/9TCIprA/wx2mqVoxLR4Uw9LE6yYhBIiaEvpEzZg9NMA00U/Qbzt4T2svOmTKEw6ksvF1u3HffqO11setGuatOJZU6PyOI9qYGD7yiaRMYDQ7m9OLv7W5SmoQMi0r8s/V21JzQciqVak8vnIYMyEDfETAEh//zCbp4/J24/Ktv1XYOXQCK6MckDX8uwe7ZjggVex8gzTfpLhlJUB9zrlGZQLXwG+NCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793293843; c=relaxed/relaxed;
	bh=9KomCOaSA+/T1xTuIFwMvLCBcQ7qcWxyP7y13U0/F7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IccaEdX+IG3lL5npWb/mXtSl/kd5B3qd+Qs9sdNZd3YMOVgaj1eQOzWpEaRTEB0Cm43nJQ7wTcgd8Dyvk5Msb1FJdepuCnviQnwHiVrSc0rR+gd/rgockh/zlsm2KApJDZakueuYTRKOzLct5ts8yLSCx978Bp7JBL1XS5o9LPYWg/v+NSdTWMlcwxigykzVNu6zrcFeSasy6AqoX+FAiMLR+HfEK0rdBHKqoAUvEIBROd8XXqXh9poZaZ4CvLJbA87TSZaSz75IxHZHU9XMj4b+a7JsLLqRIpoUK3W71aeUjGeo71j6mexDjaAEYg/Y1qHV7PkVySJtooOBA5i8TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knc1mCl6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knc1mCl6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFrN200zhz30NF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 04:10:41 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A7F08600E4;
	Thu, 29 Oct 2026 17:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7BB1F01816;
	Thu, 29 Oct 2026 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793293833;
	bh=9KomCOaSA+/T1xTuIFwMvLCBcQ7qcWxyP7y13U0/F7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=knc1mCl64Od/xMRAuFOt80MJsRIWYB4juiYLrAW/vsNnRxOQ0IVZ6IRoIwu47lI7O
	 gGqw/icA7C6TB2ujPDN+/Pa9YQwJ94u01ft7hmCEnqd3+SjlgDQ+eKmIevcG09H36m
	 qqc354jiot/SZ6zAyYXekdZht+2swVDmp5ys0mIKjXDTkwiWfOf0tgI1DhgmRXMeqS
	 D40ZvUXAurzn6ijunoSCpvONezamV4YJKwhaJdJRCgIe2f5CBb7RC1TKCR5w3uLT5V
	 xpYnG8/O2miMkeCVzfKYdKTdKpefnVnoRllakPSjsTPUm7GcgqjXuz1w60ZiNvu2WH
	 hJxDRShDE4gyw==
Date: Thu, 29 Oct 2026 10:10:31 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] lib/crypto: powerpc/poly1305: Remove BROKEN
 implementation
Message-ID: <20261029171031.GC1862@quark>
References: <20261029063522.124421-1-ebiggers@kernel.org>
 <7c8500c2-4b59-40e2-a227-b488f1336fef@app.fastmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c8500c2-4b59-40e2-a227-b488f1336fef@app.fastmail.com>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 10:42:40AM +0100, Ard Biesheuvel wrote:
> On Thu, 29 Oct 2026, at 07:35, Eric Biggers wrote:
> > The PowerPC implementation of Poly1305 has been marked as BROKEN for
> > well over a year, since commit bc8169003b41 ("crypto: powerpc/poly1305 -
> > add depends on BROKEN for now").  So, it's not being built or used.
> >
> > The justification for marking it BROKEN was that it didn't work in
> > softirq context.  That still fully applies.
> >
> > However, it turns out the assembly file actually also contains logic
> > bugs that make it compute incorrect Poly1305 values in some cases.  This
> > is shown by it failing the test case test_poly1305_split_update_carry
> > (if "depends on BROKEN" is removed).  The cause of that appears to be a
> > lost carry bit in Carry_reduction.  However, there also appears to be a
> > bug in do_final_update where it incorrectly assumes v6 is fully reduced.
> >
> > In addition, poly1305_emit_64 contains a secret-dependent branch.
> >
> > Let's just drop this code.  A fixed version can be reconsidered later.
> >
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> >  lib/crypto/Kconfig                     |    6 +-
> >  lib/crypto/Makefile                    |    2 -
> >  lib/crypto/powerpc/poly1305-p10le_64.S | 1076 ------------------------
> >  lib/crypto/powerpc/poly1305.h          |   76 --
> >  4 files changed, 1 insertion(+), 1159 deletions(-)
> >  delete mode 100644 lib/crypto/powerpc/poly1305-p10le_64.S
> >  delete mode 100644 lib/crypto/powerpc/poly1305.h
> >
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-fixes

- Eric

