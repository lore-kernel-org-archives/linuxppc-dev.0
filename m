Return-Path: <linuxppc-dev+bounces-19124-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A30D3514F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 07:59:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fly7y2pwRz2ySY;
	Wed, 01 Apr 2026 18:59:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775030398;
	cv=none; b=TFR/ESikxdh0v9HqG4m5Xr613gFqWm+jJ7zpUCmMz9u6G/0in4qQ1K7se2eEicTFHtBk3pEJ5jJgRoURszy7CT37yWtA/g3DS35eqEtJtxUUBBo8WklkxVBekR3bXB40OYTHpNMfAIaRho4Qu0pUMLwK7D7ZMl4sNWHFIVYI57TuDMcvJ4Fd5JzfAmavboFvEiC/T2GJvh/jQHB1qhe4PYVpQn0REtcInLpdI32q4eWZq34A/Au1GgMaAhDnI9joOeyPshbOfD13mMD2ZgabT/NHrvaN04LW/d45K9hwp1nTrOJ1uC+KUbF15UJ8JsZRomNUH4Y9/Z7rtWH3ERsVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775030398; c=relaxed/relaxed;
	bh=EeAH21jFBw8UgE8ezbtsg9g4YlG44GxjnxeKCmI5y/M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3hgnFYvKOqij5Zr/sRF9OBgEH8/l8M9BvQ2h1JN/EEM8xDB/KMe5KoGE8ppNBwnXzdaDdBeYcQS7kYER+wf4xr93OIs8ybwc3mTs8ObS0R3lRDQH1jQYozDq32j0jEMlkcTalP3nbUdem6HlFU6yq4GQ2LUblXoFPtbIV2o5LfItjaU6oNkhLWIZbOiJtf1zygNz6gp9eY0sORsgRdVagnuW3mUo7xWOT1xA2ryNi2s4+LkeYAzi/bh3vkUfUDFiE+5nFQLsApdqImnE/Ih26gjYMzejrSewUxQyYaD3On+3NPwvTaKrFiGLVaelvEbu6jA9zWnGdw/BxCQv7x3QQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d5SGREbl; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=C/3cCp21; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CnRd6gcU; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=E0mbtmoc; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d5SGREbl;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=C/3cCp21;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CnRd6gcU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=E0mbtmoc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fly7w1XMTz2xpk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 18:59:55 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF0925BECC;
	Wed,  1 Apr 2026 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775030388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeAH21jFBw8UgE8ezbtsg9g4YlG44GxjnxeKCmI5y/M=;
	b=d5SGREblrM9jo5nq8LPuygMHClMYV7RIJK2FsptzMn+0MaSTcqDIOTYwjo9dLCe1hoWwFf
	rPfWtWWzx5rCzd2Q0LC38AKk8IdkxgCA8c+fl2NOooBkpUvJ7/4Fziz4ihLozqc8lkeq9B
	BgQo/qBmOGy8tyKAc8AoqQEOECS469Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775030388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeAH21jFBw8UgE8ezbtsg9g4YlG44GxjnxeKCmI5y/M=;
	b=C/3cCp21eb6w17K9EALSdceuEAXf9XP7aY597dahcFYrSbWjYh6HSpZcLG9kyNzyF+5YsS
	w2e8rTuYO/Ju06Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775030387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeAH21jFBw8UgE8ezbtsg9g4YlG44GxjnxeKCmI5y/M=;
	b=CnRd6gcU+h+uToebmOkVGhBZOYRHe1Z3rNa1mO/Vx8o0nQ7iphYD5JKFk9qDgZ2KrIeAEG
	p9Rt4vgY78T51A7kcq6LW84NLvH0iQNXt0Hx3MnR1NuM6Ti5ESJZ3MytkmXmQr5t7paCxO
	kof+E2rk8esg/GBcyLGfL+C2tlf1AjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775030387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeAH21jFBw8UgE8ezbtsg9g4YlG44GxjnxeKCmI5y/M=;
	b=E0mbtmocF88ax3fWzvyOmzTUS/xT7bwkq0jMXu0fJzhqTxVLlvQObqdjjYRCgT9Qi0DeSY
	OTIcL8Q2N2io1DAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0CCD4A0B0;
	Wed,  1 Apr 2026 07:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dLMLJnPQzGm8ZwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 01 Apr 2026 07:59:47 +0000
Date: Wed, 01 Apr 2026 09:59:47 +0200
Message-ID: <87tstvqff0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Johannes Berg <johannes@sipsolutions.net>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: aoa: i2sbus: clear stale prepared state
In-Reply-To: <20260331-aoa-i2sbus-clear-stale-active-v2-1-3764ae2889a1@gmail.com>
References: <20260331-aoa-i2sbus-clear-stale-active-v2-1-3764ae2889a1@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
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
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:mid]

On Tue, 31 Mar 2026 23:14:04 +0200,
Cássio Gabriel wrote:
> 
> The i2sbus PCM code uses pi->active to constrain the sibling stream to
> an already prepared duplex format and rate in i2sbus_pcm_open().
> 
> That state is set from i2sbus_pcm_prepare(), but the current code only
> clears it on close. As a result, the sibling stream can inherit stale
> constraints after the prepared state has been torn down.
> 
> Clear pi->active when hw_params() or hw_free() tears down the prepared
> state, and set it again only after prepare succeeds.
> 
> Replace the stale FIXME in the duplex constraint comment with a description
> of the current driver behavior: i2sbus still programs a single shared
> transport configuration for both directions, so mixed formats are not
> supported in duplex mode.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604010125.AvkWBYKI-lkp@intel.com/
> Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Applied to for-next branch now.  Thanks.


Takashi

