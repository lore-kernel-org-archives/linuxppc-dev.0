Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE99C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 05:06:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928CC2186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 05:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yAUUs08a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928CC2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LD7S2yfNzDqRC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 16:06:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="yAUUs08a"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LCR34r5DzDqR0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 15:34:39 +1100 (AEDT)
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net
 [107.3.167.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C8D9321871;
 Fri, 15 Mar 2019 04:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1552624476;
 bh=bH12L59769d7W/9o6609SayNbxP6NGE7lhYdGRVdHy0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yAUUs08a4qxEJPOgiiQWB5UEkR7zEhphOBCfrAsDS3J8fzd+5cOh1RQfYNiifRBC8
 1U0B2akoE6DsigAfnX6yAd5lJYrTZmRcec+/k1YBu1/f37tyAvqN7Xqnh/upeOnnmk
 hG04B9XrIjtnP3wnP57Z+PD4fiVbsQJaacBwlP2U=
Date: Thu, 14 Mar 2019 21:34:34 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] crypto: vmx - fix copy-paste error in CTR mode
Message-ID: <20190315043433.GC1671@sol.localdomain>
References: <20190315020901.16509-1-dja@axtens.net>
 <20190315022414.GA1671@sol.localdomain>
 <875zsku5mk.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zsku5mk.fsf@dja-thinkpad.axtens.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Mailman-Approved-At: Fri, 15 Mar 2019 16:01:23 +1100
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

On Fri, Mar 15, 2019 at 03:24:35PM +1100, Daniel Axtens wrote:
> Hi Eric,
> 
> >> The original assembly imported from OpenSSL has two copy-paste
> >> errors in handling CTR mode. When dealing with a 2 or 3 block tail,
> >> the code branches to the CBC decryption exit path, rather than to
> >> the CTR exit path.
> >
> > So does this need to be fixed in OpenSSL too?
> 
> Yes, I'm getting in touch with some people internally (at IBM) about
> doing that.
> 
> >> This leads to corruption of the IV, which leads to subsequent blocks
> >> being corrupted.
> >> 
> >> This can be detected with libkcapi test suite, which is available at
> >> https://github.com/smuellerDD/libkcapi
> >> 
> >
> > Is this also detected by the kernel's crypto self-tests, and if not why not?
> > What about with the new option CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y?
> 
> It seems the self-tests do not catch it. To catch it, there has to be a
> test where the blkcipher_walk creates a walk.nbytes such that
> [(the number of AES blocks) mod 8] is either 2 or 3. This happens with
> AF_ALG pretty frequently, but when I booted with self-tests it only hit
> 1, 4, 5, 6 and 7 - it missed 0, 2 and 3.
> 
> I don't have the EXTRA_TESTS option - I'm testing with 5.0-rc6. Is it in
> -next?
> 
> Regards,
> Daniel

The improvements I recently made to the self-tests are intended to catch exactly
this sort of bug.  They were just merged for v5.1, so try the latest mainline.
This almost certainly would be caught by EXTRA_TESTS (and if not I'd want to
know), but it may be caught by the regular self-tests now too.

- Eric
