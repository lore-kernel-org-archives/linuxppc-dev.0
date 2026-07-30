Return-Path: <linuxppc-dev+bounces-25133-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD41C5516D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 18:57:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9z350lTrz2yH4;
	Fri, 31 Jul 2026 04:57:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785437841;
	cv=none; b=ZEQiwNvLb2cnri2iv4EP1t8MAQJc1IZikX6U+d4tx+6HJxMjkfHEjJ34jzndrjIIYuSYTz4jb9CyUOVPycUKibLq6pq3HQuOMoUsmMHqvOdYmS+ScX4B7OxOnL/YnpUW5XWGHy4FfyV1Hms83buelvFxNWEGqBS4EfIgyEa5RyDDoxfitRRzwka8kOoEJyUnfY9Cv/IHD9DA1CyzGIQfO2Ydxs8YZszqmV59QDgVVMu1cafJgCVtKF+NEl2sANzuKTz5mP4Ic42nUeXwX0YltpVgE/Pk7CiYX1vjdAoIhx1F48nVy/BX9R8Zue6mSIQfrK0ClbHdx/FuVfx16Ewe6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785437841; c=relaxed/relaxed;
	bh=r9y9AqYklBzxHjS0JUG0QMsK1O02i4JYhHY2V9bPyuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI2X8PLvVOBKaQW4pnvytV/DvRoAP0PSD4cFTr1fzVLdSAq6SiIn9bfUx6hkYJkxotOlO+3TtTiypR7DSqzfgmWTkTAD/GU956QE4ja2PlI/2FliGHXnk6dgEpfLgdr8UUR50ut21dFOZjt/ezxN8YcRzmwFsIWLT1fCKGH2lbrFwW9EcQjarHPaUkW8D2e/V+jbafZ1ZLEWU5YnZDgNkVEE/6xnbam/W58J7QTMj3LppdiIJ8hi7pYz6fMolbAfqK74mPrjzjLHc4kujT9cIYfCo/V8KkTefOkWKBVt80A9KOjW4sT9sdUeYeGaEHvSzE2ruv2NU4UenU4wk+SipQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=eGofO1bz; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=eGofO1bz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9z314Kjhz2xg8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 04:56:55 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B994440E01CE;
	Thu, 30 Jul 2026 18:56:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ceoLFlg5UfMm; Thu, 30 Jul 2026 18:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785437796; bh=r9y9AqYklBzxHjS0JUG0QMsK1O02i4JYhHY2V9bPyuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGofO1bz21zBADAQdUz4i85SXlmgrQZNHJeoP5hArTcrqoM8IVLKKjZGcp3CSMng4
	 sixVZKjjL8RsP6nNs4j9khBac9BxGukesWcdsD2+ZPgz4qw+ICj8+DezF9aDkVrf8K
	 9O317ULuX5GXKDIv1WnR6iAUvEVvXxyiTFV4IJsYRFQpH3vlKwuWmoq7VWadWcCpXv
	 /Z57OlkJalH+RIe2RmLj167QtCqKTzu0e6dT6JgnfbOpOeNoVOT2SGnXmnN2WJpMhy
	 IuklqwIg3i02oeO9yKaMN4IwNCSf/XzmuteepKBebd1IENWgOiozdeOaSQ/11Z7Ekw
	 r1mF8pwZGgbzIcOn67Y1o4Hi4vVKSgDeSEMl0Sa89jaQZkw6/IvdBND1C1BukLWLc9
	 4ZVnvaSyQ8nxcKYKYoVpjZshntEA4UjUdpnkME+qqaC/2F5RIzLWwzsFOB24E6EWLw
	 oHE+TuNDhPfO8aWKvyUBaoLjZ7auaPmf0aToPeWD90aaxfH+arqfEgddMfAjETL1gt
	 k59E9u47qxK5oZAq+wt7grw/IUfAT6/VTDt4g481xck+j5oGbGztWnD2FTRy0YX8f3
	 LXr5qVOoBGJuNI9GMyFy/pANhwIbSabGk6Awsl4lS7dv+2EUILkVGPIEh0JX/PBRZ3
	 sIpte0jyTzTpoyaEXocZa7Do=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E6DC940E014C;
	Thu, 30 Jul 2026 18:56:23 +0000 (UTC)
Date: Thu, 30 Jul 2026 11:56:20 -0700
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
Message-ID: <20260730185620.GDamueVIGV-8iIzozX@fat_crate.local>
References: <20260730105546.3658570-1-mwalle@kernel.org>
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
In-Reply-To: <20260730105546.3658570-1-mwalle@kernel.org>

On Thu, Jul 30, 2026 at 12:52:18PM +0200, Michael Walle wrote:
> Before commit e3c4ff6d8c94 ("EDAC: Remove EDAC_MM_EDAC") EDAC_MM_EDAC
> selected RAS, after that commit, EDAC depends on RAS, but nobody enables
> it. Enable it in the config again.

I have no clue what you're trying to do but forcing RAS=y in that config
better have a real good reason why.

Oh and we cannot support CONFIG_EDAC_MPC85XX anymore due to lack of hw:

https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/commit/?h=edac-misc&id=749c5102487b558cc7d73961a6d0da2fceaa022d

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

