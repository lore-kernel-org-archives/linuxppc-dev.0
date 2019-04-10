Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5871C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 07:04:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F754217D6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 07:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1r55rPsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F754217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fFWW1NX1zDqND
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:04:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="1r55rPsS"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fFTr4ZBdzDqJH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 17:02:40 +1000 (AEST)
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2AB112083E;
 Wed, 10 Apr 2019 07:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1554879757;
 bh=UVpPsLqlpWkzRBzUjbk+jM1Pwb7k5hSsjyXBqnhaMJQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1r55rPsS0l7IVSx4ueG5EUrg+w9hBMB6ATcKAYVKZIqwoLj0HJBaPFs38iCwGTdxO
 hz9UQYu57c/5pgOVGtJWESrqnsdrs05XvSXXxxAIzhhJHQ5QL0T8LquJ6VftSFi0kp
 /OHRO8Mvz0d82kyrnSJdH9o1ejwMXc53zC+nSXhA=
Date: Wed, 10 Apr 2019 00:02:35 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] crypto: vmx - fix copy-paste error in CTR mode
Message-ID: <20190410070234.GA12406@sol.localdomain>
References: <20190315020901.16509-1-dja@axtens.net>
 <20190315022414.GA1671@sol.localdomain>
 <875zsku5mk.fsf@dja-thinkpad.axtens.net>
 <20190315043433.GC1671@sol.localdomain>
 <8736nou2x5.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736nou2x5.fsf@dja-thinkpad.axtens.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: leo.barbosa@canonical.com, Herbert Xu <herbert@gondor.apana.org.au>,
 Stephan Mueller <smueller@chronox.de>, nayna@linux.ibm.com,
 omosnacek@gmail.com, leitao@debian.org, pfsmorigo@gmail.com,
 linux-crypto@vger.kernel.org, marcelo.cerri@canonical.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Daniel,

On Fri, Mar 15, 2019 at 04:23:02PM +1100, Daniel Axtens wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > Hi Daniel,
> >
> > On Fri, Mar 15, 2019 at 03:24:35PM +1100, Daniel Axtens wrote:
> >> Hi Eric,
> >> 
> >> >> The original assembly imported from OpenSSL has two copy-paste
> >> >> errors in handling CTR mode. When dealing with a 2 or 3 block tail,
> >> >> the code branches to the CBC decryption exit path, rather than to
> >> >> the CTR exit path.
> >> >
> >> > So does this need to be fixed in OpenSSL too?
> >> 
> >> Yes, I'm getting in touch with some people internally (at IBM) about
> >> doing that.
> >> 
> >> >> This leads to corruption of the IV, which leads to subsequent blocks
> >> >> being corrupted.
> >> >> 
> >> >> This can be detected with libkcapi test suite, which is available at
> >> >> https://github.com/smuellerDD/libkcapi
> >> >> 
> >> >
> >> > Is this also detected by the kernel's crypto self-tests, and if not why not?
> >> > What about with the new option CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y?
> >> 
> >> It seems the self-tests do not catch it. To catch it, there has to be a
> >> test where the blkcipher_walk creates a walk.nbytes such that
> >> [(the number of AES blocks) mod 8] is either 2 or 3. This happens with
> >> AF_ALG pretty frequently, but when I booted with self-tests it only hit
> >> 1, 4, 5, 6 and 7 - it missed 0, 2 and 3.
> >> 
> >> I don't have the EXTRA_TESTS option - I'm testing with 5.0-rc6. Is it in
> >> -next?
> >> 
> >> Regards,
> >> Daniel
> >
> > The improvements I recently made to the self-tests are intended to catch exactly
> > this sort of bug.  They were just merged for v5.1, so try the latest mainline.
> > This almost certainly would be caught by EXTRA_TESTS (and if not I'd want to
> > know), but it may be caught by the regular self-tests now too.
> 
> Well, even the patched code fails with the new self-tests, so clearly
> they're catching something! I'll investigate in more detail next week.
> 
> Regards,
> Daniel
> 
> >
> > - Eric

Are you still planning to fix the remaining bug?  I booted a ppc64le VM, and I
see the same test failure (I think) you were referring to:

alg: skcipher: p8_aes_ctr encryption test failed (wrong result) on test vector 3, cfg="uneven misaligned splits, may sleep"

- Eric
