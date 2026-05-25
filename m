Return-Path: <linuxppc-dev+bounces-21475-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20124CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 15:31:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPKbq4jCxz2xfB;
	Tue, 26 May 2026 01:31:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779723079;
	cv=none; b=Pu9ZecvBS3pbtjRWRngqkccRPH22of4UfEaPujDp+4wZAL8xTOml7Qf8F8GEfNHCqKQxB/CaDiXPpfFJj8/U2xxxMweLPJ7bQJJnfmxHWzTUOtu5s4lBTtyp8w2oCsCxT6u9ds19ETFpt/tFd3fXFs0LPl9zlmER/0rQo75L2B0r/j2/l9pnmxC9/piuRApMNF/NQCDpb8IvvqIZRE4zzbzF8pnJCKb6G8d0ppq95QOyGdoV1IlIbj/4mmmswhFWd08Hipfmv8GESZNgRSSRKW2qjsif2b2IW1lYsVeE0qysCvugwY9TB3/jsDwttJotye/eTH2neCr/r1mW13NCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779723079; c=relaxed/relaxed;
	bh=gL2IpC5MvWuY4f2YMU2jwkl0JtJd1OwYuxD8i2xf5OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQbj8YXnEbKStvmwqzIO87qSw/DNZpfgyWaGdC6UXjLNmsGjfaLbD5jsfYFNAFTiA9xCJSaGOaFgLiy+EukGu0lnu2/4ZWda8T6nobHSl0mTVxEGYRTgh+KN7Rapr3iuN/hBqpjY4g3ToHSdEC+RH2LwP+qfIt4WbdslY/UTUqIzgkpAm6Etl0HOL2tQSLqdOnqmfp1NnOu1z8r98mpkND6Xg9Q78f8apE7oAqQr7Aw/9QxeaXpFveYwnV6sjoyjdhfwPXoSQ4iKtTtDjru/XgRkQSE0piSFrH9cgmGkkCaywH4MgPZ2I5BfLpA9qlb/px5hDEdL1uav1RYwa5m3wA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass (client-ip=209.85.128.42; helo=mail-wm1-f42.google.com; envelope-from=breno.debian@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.128.42; helo=mail-wm1-f42.google.com; envelope-from=breno.debian@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPKbn4LN2z2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 01:31:16 +1000 (AEST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so31339625e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 08:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779723073; x=1780327873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gL2IpC5MvWuY4f2YMU2jwkl0JtJd1OwYuxD8i2xf5OA=;
        b=o7zc9DKQIHzU/3ZqxOnEGAFCgBv2U6nTmKDxsKHk+x1kfMzEpdKkTQSd05HRy5hctu
         AdskaN3c/XltS1Uvk3XKgiYwmXENsYXH0C64Pl65WEn25huy5c20mBHX9UNE0J5TLxmC
         yMa1lBysNVQNTbVI3AfG7WjDEiIm4Kdw94KPtzLXQZnmN2TQXzv6XQ9NmZCh9oFlBFL6
         iFmS9dJKNkMemn0K5TvKscRySCh/e+JElOlF7hnkmUTs3fQDincMCHWPq5WmvXVziwt5
         KAce8OfF+QuaJd1d4C8GCNgcUWw6RMyTqfeQ5YqepCW38e0jE23xPkedc8i+NxAZbklE
         IGVQ==
X-Forwarded-Encrypted: i=1; AFNElJ83CGT9HIZm1gLZo19OLNBz1jYoJTTa1tYkTMrSJ4O029GIqT9mGXpjQBLStYgpIyPHTPAnBaYpQaQqJ34=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxTGpMjIcBEKToIc4rk883jLmFYrlEd1yVbIVHpLbj8OW2cWfRN
	gMgezyjZrwH9+qKoGI/qyjyaXzA8Fi4yhlBnzU+NiXUUpo5AzkJ+q8t6
X-Gm-Gg: Acq92OFZRFI/4/7Dy+Ic1EWt0ZDQVNR2hEJ0LWlplfkbKggI+WMGLMfNHtnJtfGbakL
	sdVa0EnoDifZ9qWSWd8J5sfoQ+cM01lyvJevx1XlcnCnilmLufXRcQzOfzcMvAAKxoiIRhJxhnG
	OS9xcZh64HqK/ZzUHsAxy1DIB1wEOGiA5oC+6MvKIigTNcg/6TE+lVS3g0zOHnRktrex9U/8iGD
	k28mgU5J+0+0dZE9mCsbMSG8NeKlRxf8ZNMKi3B5xyPLJul/2AlC9gHM/jX+MXMjzfdtezePsvp
	Tm7ONzKbYJSLhzo2RAxExa9klspz9OwQvqXtfzjmqlTppbBQL9ZvXq2aQnzAdbdqNMSQ0TkWUmw
	ALcIoN8v+fYmkFM3tAk9e1g5bdwGZck+yvw2DLlNA6lLeLyK3IH8vVCRrwhPm/u8wTQB+BksvG4
	yYhnnUTFMQ0quU7967k9FXiwtoTTtejJ5Ivq6CTgKMkw==
X-Received: by 2002:a05:600c:3113:b0:490:6237:521b with SMTP id 5b1f17b1804b1-49062375366mr90500225e9.27.1779723073078;
        Mon, 25 May 2026 08:31:13 -0700 (PDT)
Received: from gmail.com ([62.197.47.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d6ebf0sm28873101f8f.34.2026.05.25.08.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:31:10 -0700 (PDT)
Date: Mon, 25 May 2026 16:30:45 +0100
From: Breno Leitao <leitao@debian.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Nayna Jain <nayna@linux.ibm.com>, 
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Eric Biggers <ebiggers@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: powerpc: update VMX AES entries
Message-ID: <ahRrFOvjvBSOVB7F@gmail.com>
References: <20260524212943.799757-3-thorsten.blum@linux.dev>
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
In-Reply-To: <20260524212943.799757-3-thorsten.blum@linux.dev>

On Sun, May 24, 2026 at 11:29:45PM +0000, Thorsten Blum wrote:
> Commit 7cf2082e74ce ("lib/crypto: powerpc/aes: Migrate POWER8 optimized
> code into library") removed arch/powerpc/crypto/aes.c and moved
> arch/powerpc/crypto/aesp8-ppc.pl to lib/crypto/powerpc/.
> 
> However, the "IBM Power VMX Cryptographic instructions" entry still
> references the removed file and no longer covers the moved aesp8-ppc.pl.
> 
> Remove the stale entry, add lib/crypto/powerpc/aesp8-ppc.pl, and tighten
> the arch/powerpc/crypto/aesp8-ppc.* pattern to match the remaining
> header only.
> 
> Fixes: 7cf2082e74ce ("lib/crypto: powerpc/aes: Migrate POWER8 optimized code into library")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Acked-by: Breno Leitao <leitao@debian.org>

