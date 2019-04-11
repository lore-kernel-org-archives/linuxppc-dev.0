Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E227C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 14:49:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86798206BA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 14:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="fInuLOzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86798206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44g3nc2sFXzDqSl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 00:49:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="fInuLOzo"; 
 dkim-atps=neutral
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44g3lp71jwzDqSc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 00:47:32 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id c8so3554578pfd.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=zp6Q/Y68BYTeE7T9SUFNkX3FL9mBezuutY6a0rQMjqw=;
 b=fInuLOzoiqDBCH4uFPPOO+Tazakc+UjFBe8d2l61/3ZaV2IwtXR2KlcQJEDSYxqU82
 9EU4tfx3XjSFP+d0R8Bn/nH3Xk3wYn1d0cAuZLeNORqUyqCT+j8nDVLxjGOjFgf85rDT
 0go2tyaDzA2258lpwGPSCQDgY8fxA2rIoKHzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=zp6Q/Y68BYTeE7T9SUFNkX3FL9mBezuutY6a0rQMjqw=;
 b=BCgEwqQX7+unagY9d8UPEkmZEiOZOIZOaN30J4I1js0Tf/gsQ53jYQNkN+EJs+tRPZ
 ZH4L9cyr6Vjj5GPcNROi3lKrQVtHnQUCC8btN74WeIUj+KoqTenT9+0+Jh19FW2DHd4D
 Aq2/GI1PZyyfSbF7nPUT3xqcU4VfPFY+tx/yW10B/Sw8mAW0ilC87el0jAFkN1ecCguj
 mRatsaUI0YRJ03js53OLQ5KM2Py2aRD/JubS+BfNlkvYD1Fz7lJtQFkUZA7FKitSfmn4
 oCBuMXUAlRMYmLUBLKjh7E9qLj3cJiudU9VNSeE5t0V0oqbKMNYNrulR4qNeL6tlbvXQ
 iatA==
X-Gm-Message-State: APjAAAXxnVueDZj0hTvVkTeuohE3hfvMg+KLVTA9lCdhbO7+fPJ+UP23
 pglvVa23qq4uL9HxU/ofEbbgxw==
X-Google-Smtp-Source: APXvYqwEJqahLrU1YyR56rULJ8BC07JHMa9D8Y/hEj3sxNiOJwh/6ikQST/MpwiqMNjSa+w2Ep5Znw==
X-Received: by 2002:a63:8143:: with SMTP id t64mr46518636pgd.301.1554994048994; 
 Thu, 11 Apr 2019 07:47:28 -0700 (PDT)
Received: from localhost (124-171-136-51.dyn.iinet.net.au. [124.171.136.51])
 by smtp.gmail.com with ESMTPSA id e21sm53062402pfd.177.2019.04.11.07.47.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 11 Apr 2019 07:47:26 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] crypto: vmx - fix copy-paste error in CTR mode
In-Reply-To: <20190410070234.GA12406@sol.localdomain>
References: <20190315020901.16509-1-dja@axtens.net>
 <20190315022414.GA1671@sol.localdomain>
 <875zsku5mk.fsf@dja-thinkpad.axtens.net>
 <20190315043433.GC1671@sol.localdomain>
 <8736nou2x5.fsf@dja-thinkpad.axtens.net>
 <20190410070234.GA12406@sol.localdomain>
Date: Fri, 12 Apr 2019 00:47:22 +1000
Message-ID: <87imvkwqdh.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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

Eric Biggers <ebiggers@kernel.org> writes:

> Hi Daniel,
>
> On Fri, Mar 15, 2019 at 04:23:02PM +1100, Daniel Axtens wrote:
>> Eric Biggers <ebiggers@kernel.org> writes:
>> 
>> > Hi Daniel,
>> >
>> > On Fri, Mar 15, 2019 at 03:24:35PM +1100, Daniel Axtens wrote:
>> >> Hi Eric,
>> >> 
>> >> >> The original assembly imported from OpenSSL has two copy-paste
>> >> >> errors in handling CTR mode. When dealing with a 2 or 3 block tail,
>> >> >> the code branches to the CBC decryption exit path, rather than to
>> >> >> the CTR exit path.
>> >> >
>> >> > So does this need to be fixed in OpenSSL too?
>> >> 
>> >> Yes, I'm getting in touch with some people internally (at IBM) about
>> >> doing that.
>> >> 
>> >> >> This leads to corruption of the IV, which leads to subsequent blocks
>> >> >> being corrupted.
>> >> >> 
>> >> >> This can be detected with libkcapi test suite, which is available at
>> >> >> https://github.com/smuellerDD/libkcapi
>> >> >> 
>> >> >
>> >> > Is this also detected by the kernel's crypto self-tests, and if not why not?
>> >> > What about with the new option CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y?
>> >> 
>> >> It seems the self-tests do not catch it. To catch it, there has to be a
>> >> test where the blkcipher_walk creates a walk.nbytes such that
>> >> [(the number of AES blocks) mod 8] is either 2 or 3. This happens with
>> >> AF_ALG pretty frequently, but when I booted with self-tests it only hit
>> >> 1, 4, 5, 6 and 7 - it missed 0, 2 and 3.
>> >> 
>> >> I don't have the EXTRA_TESTS option - I'm testing with 5.0-rc6. Is it in
>> >> -next?
>> >> 
>> >> Regards,
>> >> Daniel
>> >
>> > The improvements I recently made to the self-tests are intended to catch exactly
>> > this sort of bug.  They were just merged for v5.1, so try the latest mainline.
>> > This almost certainly would be caught by EXTRA_TESTS (and if not I'd want to
>> > know), but it may be caught by the regular self-tests now too.
>> 
>> Well, even the patched code fails with the new self-tests, so clearly
>> they're catching something! I'll investigate in more detail next week.
>> 
>> Regards,
>> Daniel
>> 
>> >
>> > - Eric

Hi Eric,

>
> Are you still planning to fix the remaining bug?  I booted a ppc64le VM, and I
> see the same test failure (I think) you were referring to:
>
> alg: skcipher: p8_aes_ctr encryption test failed (wrong result) on test vector 3, cfg="uneven misaligned splits, may sleep"
>

Yes, that's the one I saw. I don't have time to follow it up at the
moment, but Nayna is aware of it.

Regards,
Daniel

> - Eric
