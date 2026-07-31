Return-Path: <linuxppc-dev+bounces-25161-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE87C55162
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 02:29:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB94x1QVNz2xwH;
	Fri, 31 Jul 2026 12:29:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785464977;
	cv=none; b=D/dakvb2mzF9mjZOAn+phmQxXM4kEdbR5TbTMmGtb91oGlEYLQoo1lPd/cW1WVjQqeSbOxrF17elyqN2agEFtaMTlouaL2ylebiqWtJlFgRAFWWF3ub7DgiYZWzda/NH8bJyyWOYdB8QBtSwAPEv/ZzCvk95qHf1k7sZTr7QImZDPfC9tfv9xTPrLj4u5cFMloohO/q0B3T+p9lvFpdiNlKVWDgcMp10XCpzc0OsPP0+72AokfkHS/hybd0/ZJHAkK/DKHqfDbe7/B9QxDBjNLuPo/ZrBiDDYX3lIwpqJesIzaESLV8jODTkKCZvNp7wQhPlvxNIhDlpjEX8MLtuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785464977; c=relaxed/relaxed;
	bh=1sB0jqLjwS21h/XSayp+OK4nt0HLJSEJzxtB2mgcB0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aL5GNpjuZWxr9epF4tyuQFL+2BokpCw5SrSeO+kYx1GyQCZHv9Cv+NXEo4cl9tKKj2BBeDQbCMRz3ifw7JLcR4mSXclcvkM2MdPyqCKflp7RUJsa6uxicwPxhrac88/Sl5goYB1EFS2lHEA6YSdcbvCilOUI+PxNsorMMGbiamSr2P8dxsQifNweO1DyB53BIcTKXwf0kuJAulklAobTZf70n2sFu9R7G174Mc47/4+D6gOHa6ovlFRV1QgP9UpafGe0mQvobgx3fGaSrCCEkRzEkaTCm8dq2qRbEaEKN7tEvz5qgTZ6gx4g/0Di1XLhKeSMAk4cCfx48hXAS11Z5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=e7ZtD5kN; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=e7ZtD5kN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB94r33DWz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 12:29:30 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3F6EA40E014C;
	Fri, 31 Jul 2026 02:29:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QkcLnvcNnX16; Fri, 31 Jul 2026 02:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785464951; bh=1sB0jqLjwS21h/XSayp+OK4nt0HLJSEJzxtB2mgcB0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7ZtD5kNcgcQGqnfeaH3eazd7UsRBtXpmHNQ2qybbqQScers2Lz5rh8NynV1wzGtP
	 +4Q3ziZIRZn7ohrY5f2M2uXkNaUMA+weFsoxFXhEz/xgxeUbHnt3/BqIJjyv1une/i
	 GPho2cYGi1V6Pef//+6r/qk4NYdJGNOKejip2Rn/rxRowL62JlOHmE98Ppuv59TX2p
	 /T9Y23w8bj1x52fo98tMFe5Bldbe1yp6RfVZPMP7A9pcXPMWEZwvMlSyA/06UeK4XH
	 PUxnYK+e3bDhsHLL9WBpMt1Zji5eImOGJeHiiCUACW9I7J23ZKhXPI97Wp8+MYyiV9
	 1JyQFOmOk6LpPVsIjvgTxC92Cg9L2H3qhRf8rIQJjHwh10E8Ei0rIvJGiTlXXWZ3ym
	 xXn1Kux8QWrYbtZNykq6j6JT3SbCrTOazWPnwufxewPSKA1LTdDOtSveU8Cjp3046Z
	 5FoD4Qe42Moz7tRVvqQh6x4ongXvA1rYu7iiIeKMYRvP0MWy7+Tt846sEsmM+J4vQ6
	 i9CurrGXeUx9dU9Wx0LQe6NVZaAsfA9H/olaYujVFDWcxjP8PvZF9D8XE5Sw9Fo9SA
	 3wvXyzZfwCw+CAkz0PKUhPAOkgjXRHr/pY0ZuqM9GozCsm3wHZJkrKKOD4QMa3j9La
	 KpQsfLtDQcT68lChuwb2jxl0=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A008540E00B8;
	Fri, 31 Jul 2026 02:28:58 +0000 (UTC)
Date: Thu, 30 Jul 2026 19:28:55 -0700
From: Borislav Petkov <bp@alien8.de>
To: Michael Walle <mwalle@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Takashi Iwai <tiwai@suse.de>, David Heidelberg <david@ixit.cz>,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH RESEND] powerpc/configs: enable CONFIG_RAS to fix EDAC
 support
Message-ID: <20260731022855.GNamwIZw7Fz4Yhk__S@fat_crate.local>
References: <20260730105546.3658570-1-mwalle@kernel.org>
 <20260730185620.GDamueVIGV-8iIzozX@fat_crate.local>
 <DKC6Z5YGBF2O.TAJAN566BN0L@kernel.org>
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
In-Reply-To: <DKC6Z5YGBF2O.TAJAN566BN0L@kernel.org>

On Thu, Jul 30, 2026 at 10:35:20PM +0200, Michael Walle wrote:
> I don't get what you are trying to say. CONFIG_EDAC_MPC85XX is
> enabled in the that config already.

You mean, *because* CONFIG_EDAC_MPC85XX is =y, then RAS=y? I guess that is
true for this particular config.

> It's just that the mentioned commit broke it because it removed the "select
> RAS", while EDAC depends on it.

No, that commit dropped a select statement which is good in its own right.

> Still, it's already enabled in that config and it somewhat recently
> got IMX9 support,

Who got IMX9 support?

> so I guess NXP is interested in keeping it.

I have not heard anything.

> That being said, I have the hardware, but right now I don't have
> much time personally. 

Welcome to the club. :-)

> The best I could do is "Odd Fixes". (I also have two pending patches for
> that edac driver, yet to be posted to the ML).

That driver is orphaned and no one maintains it now. You would be the only one
who is using it.

I can pick up well tested patches tho.

:-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

