Return-Path: <linuxppc-dev+bounces-17892-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDE1EFCD9B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 12:00:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTwYZ3m7bz309P;
	Mon, 09 Mar 2026 23:00:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773057602;
	cv=none; b=lcOgp3kgVvDwYdUiIsf4L8iffgBw0R5LcFzAE6dYV+ARVUa6g6D2skEttsP2j0EW70FwVVqTF3w0wVROu781hUASh0OXlyvWO48ZnOeWLj29CnHUlqj28+iMGrMJ23ezGTZ+829lcjo5OxVqKIMdbFqEItF0JTAJNVPD1OF012HPRm3VUH6Bh70Z6MyztNYn+tll4CqrwTDto6ljrWnARjYDsL9E116iBKV7cylt3uywBxZgbHK3e0TRn0fa2z2PyOEnCZ5I5VCFHv4+lyBf0VbLXux2yVrEhOuJ7WBnU8PeJOClreqWsI4YZjuldJUvxuuDqJpQ/RuDHsIJ80KruA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773057602; c=relaxed/relaxed;
	bh=Y2XKH/glVvKIHxkYZx605ZSWZPl5fwhHS9csfxByePA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xe/6nE3Ba16oXeHLie3U0gXZHhXp1KPnn/AXf+5QS19zNaPHGI0qgmTs0fmzqm9uZLNyD02+UDHYh5k5dp1Qy+xltddao4Lo31on1U3DHClP3BSl0OqafL5ifFtMYGPpYybGzgLke2y982wFoFsZnERqVx8taLXxCPoxnbxNsUK1XHacHUfRQNbpQN+as4xQCH84TwGgGicnZdSY2bd+qXuEJDkv5zv2JWZ6CdnxtogNRISn5yENcU5k1PWG3POjjhZxCcepYtIgO066KljWPZaR1Dps+BJHszX852PSIhVX/w+z4bTBtnghaEg8tttKqlJjjuzrPEMiku/lvz50Qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qZYEnqzK; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iqg9jVsT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qZYEnqzK; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iqg9jVsT; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qZYEnqzK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iqg9jVsT;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qZYEnqzK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iqg9jVsT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTwYX51GJz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2026 23:00:00 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72E635BDE4;
	Mon,  9 Mar 2026 11:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773057596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2XKH/glVvKIHxkYZx605ZSWZPl5fwhHS9csfxByePA=;
	b=qZYEnqzK1ikbR4BBvUHdBv6bvyU7unV1bvQVy1rkjjWBoyibGQGLKF0ThiTVEJYbSpxlfA
	QtdToMFPyvsISRgEJsm3Acdfhd6t98dwveMR4Hm5aRSE08pH2IpAZFuTOT9U2el/8g0hp4
	SCp8Kxu4wGRp+XLhRV12tw39Ro7J8ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773057596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2XKH/glVvKIHxkYZx605ZSWZPl5fwhHS9csfxByePA=;
	b=iqg9jVsTGgYSE3XjbD39+BsLT+VLoJYPcMqfLmN+wW6odLoUsiFSrpWuPIr1BxsKQy55we
	4BWoayVgXwkdC0Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773057596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2XKH/glVvKIHxkYZx605ZSWZPl5fwhHS9csfxByePA=;
	b=qZYEnqzK1ikbR4BBvUHdBv6bvyU7unV1bvQVy1rkjjWBoyibGQGLKF0ThiTVEJYbSpxlfA
	QtdToMFPyvsISRgEJsm3Acdfhd6t98dwveMR4Hm5aRSE08pH2IpAZFuTOT9U2el/8g0hp4
	SCp8Kxu4wGRp+XLhRV12tw39Ro7J8ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773057596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2XKH/glVvKIHxkYZx605ZSWZPl5fwhHS9csfxByePA=;
	b=iqg9jVsTGgYSE3XjbD39+BsLT+VLoJYPcMqfLmN+wW6odLoUsiFSrpWuPIr1BxsKQy55we
	4BWoayVgXwkdC0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B0E33EEB0;
	Mon,  9 Mar 2026 11:59:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8bgzCTy2rmkFHgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Mar 2026 11:59:56 +0000
Date: Mon, 09 Mar 2026 12:59:55 +0100
Message-ID: <87zf4hmcw4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: Handle empty codec list in i2sbus_pcm_prepare()
In-Reply-To: <20260309114159.765304-3-thorsten.blum@linux.dev>
References: <20260309114159.765304-3-thorsten.blum@linux.dev>
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
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]

On Mon, 09 Mar 2026 12:41:59 +0100,
Thorsten Blum wrote:
> 
> Replace two list_for_each_entry() loops with list_first_entry_or_null()
> in i2sbus_pcm_prepare().

Hmm, I guess both can be simply list_first_entry(), as the codec list
in this code path is guaranteed to be non-empty (it's called after
i2sbus_pcm_open() which has the check of the valid codecs).

> Handle an empty codec list explicitly by returning -ENODEV, which avoids
> using uninitialized 'bi.sysclock_factor' in the 32-bit code path.

Which 32bit code path are you referring to...?


thanks,

Takashi

