Return-Path: <linuxppc-dev+bounces-25255-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7BDC55175
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 09:36:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDBPt4DYGz3078;
	Mon, 03 Aug 2026 19:36:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785749778;
	cv=none; b=iaEECNJPpfFCANoNzWbpUZImTLFEKFzVTeq0iEl3lQq9Y3E22xX+vss2PppRqq1tdPeMOib5guoNwO38rAScOUYVgsKNEHTJEByawn/4p13fmswzXg9lxP9MiOTUzrrUxMbE2lf3W7DsiS6HVUvlprDjvDg6yLnFFPVoPuX/lA0EHzFs+ZWuZQiURg+O2eqjZvXlFxzsW7zczZyV0N3XMyxSVm7J0WJZYoWgJJFnom7Xxn9X57mnWxZ3h8HC2C/xDZVDTpr/X2Ed7p2Vqh0lTn4Wug5IFiapXjZSEKzSPewGpxQMOcqhV5aDTqBuLoT5VMQQofsN84P3y6W4DZAiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785749778; c=relaxed/relaxed;
	bh=xyGS6eaC7kXBJ7eBvZz3JFj30b3KwO7szLpnoko6X1E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gOIrTbjmeIZNrkMZ4U2mL3gmNY3aUt2yYI/vDyp64fubgFpYAfgInmF7ME22jVwcxhoMIhxgjcty/VXtH0yqRHdAYrg6+sM6KEgOW8dzCgZRp1TjMeFqOV9vK8PWL/6tXRXyKz8dynNOPP1gsSTQGW6LOlr5bCc+B4KBlgHwAiMJTuUtht4PURYmJMuw7B1qoLKNPgC2zpOWBcL6fi2SJPEja4LCNrcEqfkOkW/1CSRdzEukNxymKe+03/Ts8l+JkHSX31HowvgpdqtFRr75YdaFnYGBpEveiNldij9fV2H0pgztk96llROaZaXy7VVueW1pnrXp35puknfVS+T8Ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=ipG/IxZG; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Tj39+J+T; dkim-atps=neutral; spf=pass (client-ip=103.168.172.158; helo=fhigh-a7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=ipG/IxZG;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Tj39+J+T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.158; helo=fhigh-a7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 526 seconds by postgrey-1.37 at boromir; Mon, 03 Aug 2026 19:36:17 AEST
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDBPs3ltNz2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 19:36:17 +1000 (AEST)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2522814000F2;
	Mon,  3 Aug 2026 05:27:26 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 03 Aug 2026 05:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785749245;
	 x=1785835645; bh=xyGS6eaC7kXBJ7eBvZz3JFj30b3KwO7szLpnoko6X1E=; b=
	ipG/IxZGzA1K6cYOwfroq8HOVT5peksJCzMw89J0KRBCfagfQJw/e4F23teBsZar
	f+jX8ZAGd6xR7qzkxWTwt2nQ048yDlJapa2sd2x1lm0oePvuS1fKeLHee5gt7GWY
	mPY2umwbeg4/jp1g9MfBt3swRGdDPwniTj5PlyyLUpDiLuQ/KVF5XQ5l4P1orDKF
	8jOhDIzDn0tgI/hxvDbmCojDs0ds41Kqg1L88WWVdZSXmGayv9zrhYmrfXrv3dcX
	gY9H6TmBg1/kACssLY8zhmFk1yPUFbvlTd3+c5Xi6FfD320JU04LMWbQeu5W/2Nu
	StPlCby4hStS4bwZpl69sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785749245; x=
	1785835645; bh=xyGS6eaC7kXBJ7eBvZz3JFj30b3KwO7szLpnoko6X1E=; b=T
	j39+J+TTYRLQ4dfM6eIVKwC82I5vMarfup3W8RbhzYYxbGyqM2ya/+r5b2WCp5pY
	DIVflgD8y4xf5TRSIxP09dQdYwMPKu2QLsSQqlYwjq8awKpsJjKzC5OUISXY/cK8
	r97i5l6cjXaCNhFz9NmBX8NgdzTmsP3ZmMfpTd8p2bF4WUVKpeSJRVYK4+MAPOs+
	FEAqtUmZB4kyLQ3DKvk9nzs/UeEDKydoVmsHTekSc5B/nIEsxUq4DIw5N4TeED06
	gSLrkpMX3bN8EMxKOK40uLZR/ecyGvCtk50rt3/J5Ji/ZMwgRJVqXVDaUWzOQhKe
	WigDo7mBPugRhU4guNR/A==
X-ME-Sender: <xms:915waoVvxgf0S05lO3woGPeh2HkoRco9-CItVwFmgDAC-FpcPU2z5Q>
    <xme:915wanbN2ZdwK5eZi0gYzNuYLwOK-Oz5B6GlLYyFVjjnFgcd368kgKR8c2KfQ6KSM
    NzwYV3ZC8_y9CiIlbBPnrVRtCltB2o-CJELlcLg7KZxuOIrCEZSPr5_>
X-ME-Proxy-Cause: dmFkZTFytL8YYWcQgRGRPGCIQOj93z806GWJomaSPT2z/JMy6t7fpxoiG7HlzupzsQbzxG
    hMF3vYLW5Vh1P7ZhQgABFqv9qa5Y5bcfuEoOKq1oUQZBtlcNjR7zJoK2EipZpYttJPKqUE
    Fby4ZCTmwEYjBqxiiYHIY+PvfjBdKG+7dhdy+QHxPOsY2c+K340N87bv/ZYRL+d0lyk1NT
    1j8M4LZs3VZRZFR62r6X3hOTkauvpo7rTg+Osv3KatRK0t43ltNUAIlFuhCoFCqnBt+yiH
    wqe6Qc8zMZm8AjCnIrVdEv7kHrG4w8de6vP/UDilGvaxoB1PQ7QeNLHXJav21kTrBGL5BQ
    fV3tiZAnKckZ2z/rb6jIHfCBC0oPg7pddB5zzXQ+oPXS4QcgncjYW7/8kXzim0JtZF8NIR
    zBrFq6NMeeaLOZPqPwlRZ20qzmLw5SUAsD5PoJUcEhfTg57Iojc1KrXGZj/4Evdjf3gZ9w
    +9UEoQemKNhHkqRlvHGSHSbgjDHqoF/xZp/o67d03v4HxyXqdpYaFX5QERhLIXQkl35oGm
    dNEOa4htrxSqcGkxUCu6b69+vmtjz/VisOpaAJLfmh8TyCcTL2iXvBPxz73EDy97n70yuP
    oyiVG3PyaNy07jvZSBkDNIOlHbv5H3s6PIwIzbpn92yPA3I3s5cB2ebYzU8w
X-ME-Proxy: <xmx:-l5wajdj2cTW42oGE-PbG6ANUilm6uNdHpUZZLLURUX8SnKiTOcxrQ>
    <xmx:-l5walATmAUD5mn0158sf2y5Pf18QbjmeGL77i8wtJ0eN_gFmpF7ew>
    <xmx:-l5wan5SK_kHpmO9uRsglHHsUOdL59_m62hJArQUfzaiungWmfZgGQ>
    <xmx:-l5waueQZYZe7em4661g1GVczExQEIdk_BcIRJfB77dEuW9-HZ7tuQ>
    <xmx:_V5waqNcaOaEAWSxGo5o5HABo69QvqqSPKi-1G8Ks50H7A3U4D95bPB9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 7F88E32A0062; Mon,  3 Aug 2026 05:27:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
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
X-ThreadId: A6UEPfW3F-JV
Date: Mon, 03 Aug 2026 11:26:59 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: moonafterrain@outlook.com, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Paul Mackerras" <paulus@ozlabs.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Yuhao Jiang" <danisjiang@gmail.com>
Message-Id: <47d5a769-b247-4eac-9776-71d68cf33b5c@app.fastmail.com>
In-Reply-To: <20260802-fixes-v1-6-7368423440f4@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
 <20260802-fixes-v1-6-7368423440f4@outlook.com>
Subject: Re: [PATCH 6/6] powerpc/spufs: don't hold state_mutex during user access
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Aug 2, 2026, at 17:51, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
>
> spufs_mbox_read(), spufs_ibox_read() and spufs_wbox_write() take the
> context state_mutex with spu_acquire() and only drop it once their
> transfer loop has finished, so every put_user()/get_user() in those
> loops runs with the mutex held. The faulting address comes from
> userspace, so the fault can be made to take arbitrarily long via
> userfaultfd region or a FUSE-backed mapping.
>
> Drop the mutex around the user accesses: acquire it per mailbox element,
> just long enough for the ctx->ops mailbox operation, and release it
> before touching the user buffer.
>
> spufs_switch_log_read() has the same problem but its loop needs the lock
> for more than just the copy.
>
> Fixes: cdcc89bb1c6e ("[POWERPC] spufs: make mailbox functions handle 
> multiple elements")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

I'm not sure if anything relies on the accesses to be atomic,
but it does seem unlikely, given that you typically only
have a single CPU thread interacting with an spu context.

It clearly fixes a bug, so

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

      Arnd

