Return-Path: <linuxppc-dev+bounces-25136-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1F3C55167
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 20:35:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB1DQ0xMbz2yH4;
	Fri, 31 Jul 2026 06:35:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c0c:9d57::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785443734;
	cv=none; b=QatMWlxRv1YyH3Lw0L3OsH9PLFxk+40TxRgFwlJYrYkxPnXysRkG6stIEtvY6EDP9sP0jtxAGIAIA6OSS6rrI4RDjt+sX04b55btJ59thz6QwDOLNQ1CWua7lnTTVcx/MScxyLtLbM4AKJBkng/lS8gLlHxs0/KFegLimM5QbdY6rW6fdUisVHT+u4KbveARco7LH+JWdGPw87uJEr4uQxxyAH46DFxCR7Gz+Lcg56m6JYVM20bE5KrLPn3XDKfQFXBX2OY4tbJvM964CDblaRTfZ7Ls1scRjuPu7ha89HbbGXRUf+2ynHTPISis3OnAdbAlwXBMenvCoJcX0dKpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785443734; c=relaxed/relaxed;
	bh=wVnbiwOgRnwRBuyk8DDsR0NtjXgFZjDK44N707tHdJs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=MOKfcrV1XP6AraQLnmv0K+cuX/VweYlRR5Tp0/kteS+71WkPupYjGygQD76VkEQR9nSTiRFDnGvTq6b4aQHKOGitAlPIkbBlR1OjTJem3sGDZywpHOnUXTHIRPQrOxwNTSwfE5L9j2UQT69bKd9tJJRIpgPE7ONJ9KtyrArS3NtpLTTaVIdR34+7TLEZgG5+pTphFfqYnULnRjsDXT0GM/Ml4mRFMbQez7aWTZe8ido5xRGta6lTcoW5hUZN11nx72z2qy0JwbBGqjFpKIDHvtpg0XJ6DLYgvt8yrSEJE2YdThXlu7P+ghH62J1gc2jmJmLvfvX2SEECV3OjrUeOfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass (client-ip=2a01:4f8:c0c:9d57::1; helo=mail.3ffe.de; envelope-from=michael@walle.cc; receiver=lists.ozlabs.org) smtp.mailfrom=walle.cc
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=walle.cc (client-ip=2a01:4f8:c0c:9d57::1; helo=mail.3ffe.de; envelope-from=michael@walle.cc; receiver=lists.ozlabs.org)
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB1DP1Nnyz2y8c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 06:35:33 +1000 (AEST)
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id A6AAE9D;
	Thu, 30 Jul 2026 22:35:21 +0200 (CEST)
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 22:35:20 +0200
Message-Id: <DKC6Z5YGBF2O.TAJAN566BN0L@kernel.org>
Subject: Re: [PATCH RESEND] powerpc/configs: enable CONFIG_RAS to fix EDAC
 support
Cc: "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman"
 <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>, "Christophe
 Leroy" <chleroy@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Janusz
 Krzysztofik" <jmkrzyszt@gmail.com>, "Takashi Iwai" <tiwai@suse.de>, "David
 Heidelberg" <david@ixit.cz>, <linux-edac@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Borislav Petkov" <bp@alien8.de>
X-Mailer: aerc 0.20.0
References: <20260730105546.3658570-1-mwalle@kernel.org>
 <20260730185620.GDamueVIGV-8iIzozX@fat_crate.local>
In-Reply-To: <20260730185620.GDamueVIGV-8iIzozX@fat_crate.local>

On Thu Jul 30, 2026 at 8:56 PM CEST, Borislav Petkov wrote:
> On Thu, Jul 30, 2026 at 12:52:18PM +0200, Michael Walle wrote:
>> Before commit e3c4ff6d8c94 ("EDAC: Remove EDAC_MM_EDAC") EDAC_MM_EDAC
>> selected RAS, after that commit, EDAC depends on RAS, but nobody enables
>> it. Enable it in the config again.
>
> I have no clue what you're trying to do but forcing RAS=3Dy in that confi=
g
> better have a real good reason why.

I don't get what you are trying to say. CONFIG_EDAC_MPC85XX is
enabled in the that config already. It's just that the mentioned
commit broke it because it removed the "select RAS", while
EDAC depends on it. So yeah, up to that commit it was always
enabled in that particular config.

> Oh and we cannot support CONFIG_EDAC_MPC85XX anymore due to lack of hw:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/commit/?h=3De=
dac-misc&id=3D749c5102487b558cc7d73961a6d0da2fceaa022d

Still, it's already enabled in that config and it somewhat recently
got IMX9 support, so I guess NXP is interested in keeping it.

That being said, I have the hardware, but right now I don't have
much time personally. The best I could do is "Odd Fixes". (I also
have two pending patches for that edac driver, yet to be posted to
the ML).

-michael

