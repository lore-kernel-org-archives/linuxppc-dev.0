Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A701606A327
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=fMGKjbRh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZH9X6zj1z2xjN;
	Wed, 25 Nov 2026 22:13:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795605216;
	cv=none; b=dHe7uxYihiRed9aB+DF9qV4gycUnmn2U098dVAbF2pDSsQIILmeCssDtdrgccYHoE9ItkvDr6exJHZeZ6yhfifnt8iRQDuFGp1luJpmY5A0BS6awIkwsnSu+pbbS0EZyX93kX1KhoS6F/cwBRiY72XVwtY3gfjiP6VCwgVs2TnA6zRwIucfFXiEQ2uBl+FO6gTOwc46vHZ9nfuoKEOdfQIOeJuT4hs4SLjCDcfVCi88aTn9/wiCMZo5XL+lDmDwPGTvZOXdHYJdSlIf6u+BVPmoDGUKAdVbaM7IrxSaOmfOEkELZK2vg0PYe3QPRw7tbAqH8vTJjQc9FmM7uMvt2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795605216; c=relaxed/relaxed;
	bh=CC1jwJWwdI454y7ESWHR3zHzYlpHKlOaH1jugkPLgTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1oK2qqLGfjolGuZJg2BOrrIB/3jFBnZH00ZNl+dL3j8lJJwJSojN0JNtEPrqmSjkOfF7n6LKujlPqNX95ssNjG6fWWtkSjtt3VgTWnZPnjg2UyVeetMy2Cj+15FjPsZ/zk4u7z0Sxh7S98x2GOa6t8xh0F0ArGAVNOELacuYmoVq/+asjKcd8LAEg/JxzRNfxkiBtCKwsJCIVthCdKdGhHfgOA2+Isc8xH+mKFB57bMexW9pT0mjXl8+Wa6Y6iFVdmB1w4p/s8saC7Na8qtS49hBi4HXriUu7GS4YaunQD5wVofTknClfKlFKspC41AdwTCHmnkGJ2vEt0ySuNpgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=fMGKjbRh; dkim-atps=neutral; spf=pass (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=sang-engineering.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=fMGKjbRh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sang-engineering.com (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 397 seconds by postgrey-1.37 at boromir; Wed, 25 Nov 2026 22:13:31 AEDT
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZH9R1c2Mz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 22:13:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=CC1j
	wJWwdI454y7ESWHR3zHzYlpHKlOaH1jugkPLgTA=; b=fMGKjbRhsXU3w7WCzWvR
	jDMwCDbDltuKrAz49M+eHGT13cQ+BowtOyhdnUbwFfj+NQrLxOMxLY+6BpmxN6g+
	e+hQDQiz+ZpuLIRuqn6//bWLd1pg3J6Y0H6rx+Ke60vBNEPChA/jZq4wi6AuxdqJ
	8E9763PtVJFG92FhAa2JGFAiS6uUrlC8TR/riiDT1x+PyXycWY6i1o+VZ1GZ9j1+
	ijbXXBjPpojvTdN//jIAl3wJCFB6vLEXCvDUD22Zav154zel+alSFIH2p/iXItuz
	3kCnNSQtjAe1khan/2tDK9ZqUmKacAWqwHv6CU7zOUjwdtOB4i60/gcRrT6W2Cz6
	NA==
Received: (qmail 892782 invoked from network); 25 Nov 2026 12:06:45 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Nov 2026 12:06:45 +0100
X-UD-Smtp-Session: l3s3148p1@DSmP0hdhdJcujnvc
Date: Wed, 25 Nov 2026 12:06:44 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Yige Jiang <yigejiang86@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Wolfram Sang <wsa@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] macintosh: therm_windtunnel: Fix i2c adapter reference
 leak in probe
Message-ID: <awbBRG6VMVKn0Dor@ninjato>
References: <rc-b1-20261110-vc-23-41d00428efcb@gmail.com>
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
In-Reply-To: <rc-b1-20261110-vc-23-41d00428efcb@gmail.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 05:03:43PM +0800, Yige Jiang wrote:
> therm_of_probe() walks the i2c adapters with i2c_get_adapter() and
> drops each reference with i2c_put_adapter() before taking the next one.
> Once do_attach() has started the control loop, however, it returns 0
> while still holding the reference to the current adapter. The pointer
> is not stored anywhere, so that reference is never dropped. This
> happens on every successful probe, including after an unbind/rebind of
> the platform device, and the extra device reference would make
> i2c_del_adapter() for that bus wait forever for the adapter device to
> be released.
> 
> The driver does not use the adapter after do_attach() returns; the
> sensor clients it talks to afterwards are children of the adapter and
> are unregistered by i2c_del_adapter(). Drop the reference right after
> do_attach(), before checking x.running.
> 
> Fixes: 3e7bed52719d ("macintosh: therm_windtunnel: drop using attach_adapter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>

I require tests on HW for this one. Windtunnel support has always been
very fragile.


