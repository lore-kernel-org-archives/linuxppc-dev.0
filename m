Return-Path: <linuxppc-dev+bounces-19385-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F03BEF4EC6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 08:41:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fq2qw13Fcz2yfS;
	Mon, 06 Apr 2026 18:41:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775464908;
	cv=none; b=KZ5PCOKEG7y2X88KjOpq9nExim85g3xMvtew62w9Z3iQdKS6PCKCAxYjAk5HMqt7mIWf8qXsp0xE4wU8+1bYDqM94jpbiygKqFsAZcIHzYxjv35vP/GwUy/2MwS/dFEYoJazcbsCYAli0AOZB++vxXCQTUQxPHCTTx45b/Grj2jMzuAUc+Ge4eH/MLiPXc08IUPffAh3Zz0VhUodntE01hxObmyvIcUJRwt9IWMmU1BBndzgswIxwg5v0dYQVPmyjsDRLJRxNM619Gp9Nq7GSV1EJpuKZ7GhqCOnuRaRom7w1zA/JC3KrdcZg7KxvAcmdmo0ezdzHX+X19IAyiS4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775464908; c=relaxed/relaxed;
	bh=gpLNydfTyspq2Ps/yiY/PGpQxBX81uVkAkd06CjHbMM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AM7dFuMo6aYyfu8wE26ONVogygvCjA14uwOgY29E/QW6GqEZYE9A4DhLh50zO7qEOjWLB9rW0XdUwnGcMVBYbrqr7ObzlGxqP/QiUuhs5uGFn6xPwDZGV1rpiF0hRQtOu6VdX6S4JK8If9FzwA6Q9EGOlvL6dJ1iWwHkKWiZU1GXOk0VPija6qPvpxf/oztxgAui1bRCxOdTeMbf180+Qa01gDHlgf8fV4zkxLFbtFRsTBrgo7Sn6l/gm+DxstVqs4Ks7tBcw0y32kmTCpeVgPlC3z+0guZw5WPuFB8nx+s426n15HtT+Q98S2ZKnMl0JrPrdRGRHJOONMyAIn8o6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dB0vJiH1; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s0yW/C4P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dB0vJiH1; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s0yW/C4P; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dB0vJiH1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s0yW/C4P;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dB0vJiH1;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s0yW/C4P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fq2qs547Xz2ySV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 18:41:45 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A4125BE4D;
	Mon,  6 Apr 2026 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775464897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpLNydfTyspq2Ps/yiY/PGpQxBX81uVkAkd06CjHbMM=;
	b=dB0vJiH1sNB7aK44Rb9FiUx4wMwjsgIAHvOux5E++upoCeF3QLpkf1YHB9PMw0ZPCp0zj+
	KrGVGWY6sWNy5QQyUqev+R8qJXDrL7H621CBQDQvGlTyzDkGIQvcH4FCXxtzqs6fWak32+
	eBi9y1xgfLsKuB+gcS/5vJFS6lHWjFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775464897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpLNydfTyspq2Ps/yiY/PGpQxBX81uVkAkd06CjHbMM=;
	b=s0yW/C4PzUh+Go4b0wu+xU0GLlLE8etbz78LiImWV4lnHBz/1vH7XqDIljaQ9Fsn/o/voJ
	AdaMGNqJIwxrK3Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775464897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpLNydfTyspq2Ps/yiY/PGpQxBX81uVkAkd06CjHbMM=;
	b=dB0vJiH1sNB7aK44Rb9FiUx4wMwjsgIAHvOux5E++upoCeF3QLpkf1YHB9PMw0ZPCp0zj+
	KrGVGWY6sWNy5QQyUqev+R8qJXDrL7H621CBQDQvGlTyzDkGIQvcH4FCXxtzqs6fWak32+
	eBi9y1xgfLsKuB+gcS/5vJFS6lHWjFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775464897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpLNydfTyspq2Ps/yiY/PGpQxBX81uVkAkd06CjHbMM=;
	b=s0yW/C4PzUh+Go4b0wu+xU0GLlLE8etbz78LiImWV4lnHBz/1vH7XqDIljaQ9Fsn/o/voJ
	AdaMGNqJIwxrK3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 150D94A0B0;
	Mon,  6 Apr 2026 08:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TynRA8Fx02kOJwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 06 Apr 2026 08:41:37 +0000
Date: Mon, 06 Apr 2026 10:41:36 +0200
Message-ID: <875x64mqf3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: onyx: Update IEC958 sample-rate status for PCM playback
In-Reply-To: <20260403-onyx-spdif-pcm-rate-v1-1-dcfaf931cf83@gmail.com>
References: <20260403-onyx-spdif-pcm-rate-v1-1-dcfaf931cf83@gmail.com>
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
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]

On Fri, 03 Apr 2026 05:47:13 +0200,
Cássio Gabriel wrote:
> 
> onyx_prepare() accepts 32/44.1/48 kHz PCM playback, but it leaves the
> Onyx IEC958 sample-rate status bits at the driver's initial 44.1 kHz
> setting in DIG_INFO3. As a result, 32 kHz and 48 kHz PCM streams
> advertise a stale IEC958 sample rate unless userspace rewrites IEC958
> Playback Default first.
> 
> Update only the consumer sample-frequency bits in DIG_INFO3 from the PCM
> runtime during prepare, resolving the long-standing FIXME in the PCM
> playback path while leaving the other user-controlled IEC958 status bits
> unchanged.
> 
> Mark IEC958 Playback Default as volatile as well, since prepare() now
> changes the exposed register contents outside the control put callback.
> 
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Applied now to for-next branch.  Thanks.


Takashi

