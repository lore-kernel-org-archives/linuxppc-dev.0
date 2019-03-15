Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA4EC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 05:24:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4014F218A1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 05:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="SjD4/V2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4014F218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LDXq5z53zDqSc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 16:24:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="SjD4/V2h"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LDW40n9MzDqPw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 16:23:09 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id q17so5463277pfh.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 22:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=qMdwfvZITrowvpwdZKU/+XKGW/QRW91nSYH9YGEXUSA=;
 b=SjD4/V2has6vbuD3Jv2vY9unoSW+Ndx9LSg/P2JQ125jdC0qMqhiF6pZZg5rKUt+fW
 rOa6+M47H1CA3NmSUD0CRyY3sOFo1c71rFVpFawHwNNDIfZmRyNuwilNxRuCbC4wq6b4
 5NcNoIEaXS39cegwDjPOhoIU+oq4eWZ9tIoOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=qMdwfvZITrowvpwdZKU/+XKGW/QRW91nSYH9YGEXUSA=;
 b=G3GfgQmeJpMMv6+AO5P7agmAxgqKhOy38LYG0hcSoslFsGvHfaEq7ytHliSzeCJYht
 OpiMUB+07UnSUcOUdliBMV/Dlb4aIHcQhl63yWkhhECJ14/0R5t0u+ORFcR8ANBacu+2
 6uSMFI6cDOjOdAT9ocDo7xLBHjzgmxcXrngZWqRjv7GLHTJgvqo0B8zCLWLEqEVjkhXj
 3DROaJC6vBmeuA2GT/ygDIqjPR9CtAJX+LAliG41BU7rime5+u/P68u+/D5movkw3fZd
 WrWgfyhded079Fie+Zmj50YUB+xSTEx4+o3KTSP9XHy5i0WnGvI698uPh3llfpTWFjra
 7SqA==
X-Gm-Message-State: APjAAAUDGmD9gZgvE0LmifD+wzCHAqE5A8gnK9NNirHG6BlO5sg5Jl0b
 DhAjzsHjml/ClivzeV9Ew+eJ6A==
X-Google-Smtp-Source: APXvYqweGIS4KtAzEejVFS0vNqdG/bIMkHtK/QkNeLPWDbeK/jLdbk4yfJpYVEUz7MF+IKxzS2FPiA==
X-Received: by 2002:a17:902:801:: with SMTP id 1mr2121725plk.299.1552627386748; 
 Thu, 14 Mar 2019 22:23:06 -0700 (PDT)
Received: from localhost (124-171-209-25.dyn.iinet.net.au. [124.171.209.25])
 by smtp.gmail.com with ESMTPSA id d11sm1403181pfh.29.2019.03.14.22.23.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Mar 2019 22:23:05 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] crypto: vmx - fix copy-paste error in CTR mode
In-Reply-To: <20190315043433.GC1671@sol.localdomain>
References: <20190315020901.16509-1-dja@axtens.net>
 <20190315022414.GA1671@sol.localdomain>
 <875zsku5mk.fsf@dja-thinkpad.axtens.net>
 <20190315043433.GC1671@sol.localdomain>
Date: Fri, 15 Mar 2019 16:23:02 +1100
Message-ID: <8736nou2x5.fsf@dja-thinkpad.axtens.net>
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
> On Fri, Mar 15, 2019 at 03:24:35PM +1100, Daniel Axtens wrote:
>> Hi Eric,
>> 
>> >> The original assembly imported from OpenSSL has two copy-paste
>> >> errors in handling CTR mode. When dealing with a 2 or 3 block tail,
>> >> the code branches to the CBC decryption exit path, rather than to
>> >> the CTR exit path.
>> >
>> > So does this need to be fixed in OpenSSL too?
>> 
>> Yes, I'm getting in touch with some people internally (at IBM) about
>> doing that.
>> 
>> >> This leads to corruption of the IV, which leads to subsequent blocks
>> >> being corrupted.
>> >> 
>> >> This can be detected with libkcapi test suite, which is available at
>> >> https://github.com/smuellerDD/libkcapi
>> >> 
>> >
>> > Is this also detected by the kernel's crypto self-tests, and if not why not?
>> > What about with the new option CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y?
>> 
>> It seems the self-tests do not catch it. To catch it, there has to be a
>> test where the blkcipher_walk creates a walk.nbytes such that
>> [(the number of AES blocks) mod 8] is either 2 or 3. This happens with
>> AF_ALG pretty frequently, but when I booted with self-tests it only hit
>> 1, 4, 5, 6 and 7 - it missed 0, 2 and 3.
>> 
>> I don't have the EXTRA_TESTS option - I'm testing with 5.0-rc6. Is it in
>> -next?
>> 
>> Regards,
>> Daniel
>
> The improvements I recently made to the self-tests are intended to catch exactly
> this sort of bug.  They were just merged for v5.1, so try the latest mainline.
> This almost certainly would be caught by EXTRA_TESTS (and if not I'd want to
> know), but it may be caught by the regular self-tests now too.

Well, even the patched code fails with the new self-tests, so clearly
they're catching something! I'll investigate in more detail next week.

Regards,
Daniel

>
> - Eric
