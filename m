Return-Path: <linuxppc-dev+bounces-25673-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1ADC5AD55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 13:50:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJbkS58Pmz2yxG;
	Mon, 10 Aug 2026 23:50:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786369856;
	cv=none; b=V4MeemoEfj/yP6pNTMu3Z3rafXr+GmAKDN4EG0O7fC6/vZYXMBFC2OKTtqJAs+p4OsnZCy7XgUAsgmd4uCqf4DIKfwzWyYo/esMLN8EZnA5uU7okLgiKj+rX7QoBgm7NqnOAoBBYqXnfnKGxEBI+NGb9Gh3UsiAFOonOc2MgHt4foVIfzXXMxljCAH2UH77oRHWiB6FU2u5iwgSF8ACpBvq4HiUICi4A5vdSE2rEnPP3zUjN6TXYkCWNclLEg/raSuBpjjHdw6lIlio/lNiO3c3eU11toNAYpcPM1pTIlmy6gGDRGdsW84wVEat5+t/IWNshrTLZEnJojHiqKCemnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786369856; c=relaxed/relaxed;
	bh=PYulRBG3xNcT9LLPPkDJ9YmYPoSfo3ZnjjiRXmKsU4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WK+/S88osKTO+2gS2Z1AWR36wQsjExCHiMwYJdqupybDkqJI9QxlddtiZ2U+IuSbVmovmi7vUaIWQRdY8tESjqrQFOmQoWvzYmFgEwXvFdDDXPkts3of9WiLrdUVMbJvHzrYeo/WNtXirPJV/PzbTysxae99CG6IGur8xSZv41KSxQ/+NAE/jkcxNbU3YZE/IPlWlLkJciiqG3dBVLxNNfJKdKuxKgLUNtVgwBE9TnLQT0Rf5d85/HL/2pGaR+/vnmslsSnNbupju5K9TPuAOY06fJNgJ9QUnPqxjWdnaKwK4+53L1wztfC3MqnRdUH+lgQ7FD7cl9lDVodhIlW0ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=RG8JcNe2; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=RG8JcNe2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJbkN2FHfz2ysb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 23:50:49 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AFE7E40E019C;
	Mon, 10 Aug 2026 13:50:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OmlQuQJRsPe6; Mon, 10 Aug 2026 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786369835; bh=PYulRBG3xNcT9LLPPkDJ9YmYPoSfo3ZnjjiRXmKsU4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RG8JcNe2YXfO80T1zGwSfYimxSVLcHdDeXr5zpmuXWWc8hsqyZ8jLa99tf4e7Cawe
	 dLe7prdOWAMKhW82Xh/36TwVcEscuKYShdN1mSpJkA56Ni8tQsvfmtzpcB2LNrawFe
	 07XQjq7HYDVFj53UnpaY9NJMQ+OnII+Q2kJPBjjDwxkFk/Rwbef1XCPV8f+VEYW41V
	 CKnFA0kVNtZpH3766HPjkKj3eXKFoz2v2GbPLs0xDXrjTD5JbBX0zqZBaVgTdzmg2e
	 Ut/SElIs17T45DZy1mL//uxx7tsLSPvmRJBWe1krVIXY2PZ6zkSwvnRsovJunpJfch
	 Gc6o14Lja53MUnCdgbk2b3TtxpKCiAz4d+uHID0Y/fC0Fjzd3BGwX6jk8i2ic4xySD
	 K7TjnMuxNHVo3TAVhsMrJ4tW/Zgw+9EyBxLMVS9zvL/TNwCFDg2fwQcR+YZo2EVuqk
	 UCpD7zi6qY+6XYEFxUpnPvC2Iqec3WlwMd0At6fRsJURWSrnKDjiPUsuHijrcKwdeQ
	 TRIlho52jGXKfV+KapiLy3iriVt95cN5XE4YsEXYW2iO3K2EVxkTPTC2n8FctdME4t
	 X78zJflibqPur5pav/nOHfuCoGDNbn7hUK5xdKDaBIGO5b3HuTFZ7od9KpVJpsJtgL
	 MZFYJ9SAkrf+PZukqYpAspKs=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE9FA40E014C;
	Mon, 10 Aug 2026 13:50:22 +0000 (UTC)
Date: Mon, 10 Aug 2026 06:50:20 -0700
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
Message-ID: <20260810135020.GBannXHLXtUlqJjzqS@fat_crate.local>
References: <20260730105546.3658570-1-mwalle@kernel.org>
 <20260730185620.GDamueVIGV-8iIzozX@fat_crate.local>
 <DKC6Z5YGBF2O.TAJAN566BN0L@kernel.org>
 <20260731022855.GNamwIZw7Fz4Yhk__S@fat_crate.local>
 <DKL4118H7S5U.1FN3E4DBY4GHF@kernel.org>
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
In-Reply-To: <DKL4118H7S5U.1FN3E4DBY4GHF@kernel.org>

On Mon, Aug 10, 2026 at 10:10:43AM +0200, Michael Walle wrote:
> No. CONFIG_RAS is not set although CONFIG_EDAC_MPC85XX is set.
> Because CONFIG_RAS was *automatically* selected before the mentioned
> commit.

Dude, I'm agreeing with you!

> And while doing that it will break (at least) the corenet32_smp_defconfig,
> because it removes the "select RAS" (which was on the EDAC_MM_EDAC symbol).

And things like that are fixed by adjusting the config. Basically your patch.

So whoever picks it up, can add:

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

