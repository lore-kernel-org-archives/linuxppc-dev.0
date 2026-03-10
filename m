Return-Path: <linuxppc-dev+bounces-17971-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDD5EB1060
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 15:07:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVcgm3RZLz3bmM;
	Wed, 11 Mar 2026 02:07:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773155268;
	cv=none; b=mdDCtzRGdR5gYTOtmgg5HB3+LBJ9NFmlIS/uX3dUVr8bjUUB0pQP/kHGq0js/THb5knG1+SokzPlTokZo0RGDK7bN2SPw0D9QpocnYmBixFNmolCtOLy0sKf3OmatClfZPUMgSJeD5dzZ6Ym7pjTBJnJalHWMb4Asz9XVqsphlkKE2gCcFtdEwuJt1APXyAviNssHAQVi/aG2cSFC6pBaJ12fcwmMbVZtYwONh/OlP9wENOs2N092mDHxM/7J5LV2ZiyB4VpYzsOn7FVRsKCRZZJTXbISkozpWxxEgMMrP+tDDvf4BhDE6hF1cNSxX6kk57dP8Px8v15rPtquK/CCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773155268; c=relaxed/relaxed;
	bh=gMxUZjTf0fkPqQOSMlmI9PQkeO5iBltUcV8wio/rEnE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lplvrraah+ZUh46xlHhZOQKBqPQWuwEzxLBFK1E29f+CcO6SGL6sluNEKo9EeZVWdRnXd7aB6nqnRHkpKqRufmWTNyFuwWyIvhcRtAkKNIBB67owiP0Y4TH8p71bA/iXuTcRwDPJxT7ws2uQFwgTixLnbPEroonCHf2NOJqynAkjPUCQ2QCA4GVRSmBNYu1nS/DD/7l6IKQSAITKh/cPc0RGXghL4FKV5NmpSD3WzGpMhCp8jHDHPoaUeA63WBNXz/eb5MzUAhMKGSaUoqnX4uUp284pIUTWf0V+GcplFKiYMSS0FRhHDenRkzplOfu5mi6k4nbhC9doEyUdNeCRag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gt5oTT6q; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Y0zwAQzE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=B8KBkKIG; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EnJ+ZysA; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gt5oTT6q;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Y0zwAQzE;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=B8KBkKIG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EnJ+ZysA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVcgk3WF7z30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 02:07:46 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E0835BCFF;
	Tue, 10 Mar 2026 15:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773155263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMxUZjTf0fkPqQOSMlmI9PQkeO5iBltUcV8wio/rEnE=;
	b=gt5oTT6qwuntLkeowNMdA8iXmLMS5caVPTKEtfsJrUqmq0lhjmdkv063RGZ4r0ZaMe4eBi
	F/iDFTX/re5MLkamm5YhlI20HNlooLD326Mbr8aAVwIq+NtZR2yEgeOIjQBLK/yCB5dr7F
	tU1R5g7v7fAv0WWAChw6snt126YxTgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773155263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMxUZjTf0fkPqQOSMlmI9PQkeO5iBltUcV8wio/rEnE=;
	b=Y0zwAQzENQUhHJU79wwJodOb+PiIZNNMRz2R5nqfW0/nEcFGcHub7Ajv8gTWo9JNIt89lX
	+4eJQ+0TkHaP8PCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=B8KBkKIG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EnJ+ZysA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773155262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMxUZjTf0fkPqQOSMlmI9PQkeO5iBltUcV8wio/rEnE=;
	b=B8KBkKIGC1jlMt6mWQXGlSnUURmAa6Fg34C8DnNpPdK8HauOqDCLGkHiI22HqjTDAxocEU
	k4QdOnf6YA5VWwt/8lJqjt8SKKDyu2PJap1VKOv5eDaY5+xYLzgOLvdAdvedqMJ7Ap43kM
	q+uYZMGo1Me4nvIYfZ1T4NJlQM0nC/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773155262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMxUZjTf0fkPqQOSMlmI9PQkeO5iBltUcV8wio/rEnE=;
	b=EnJ+ZysAzSrNqsl0CMa1GmScbFVyqMBTTVBVge6hKFrNiD69EFyZExt/ajsyTn3Yfzjp4W
	odvxkXAtWfhPK8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAD723F4FB;
	Tue, 10 Mar 2026 15:07:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xsiqNL0zsGmmPwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 10 Mar 2026 15:07:41 +0000
Date: Tue, 10 Mar 2026 16:07:26 +0100
Message-ID: <878qbzradt.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v2] ALSA: aoa: Skip devices with no codecs in i2sbus_resume()
In-Reply-To: <20260310102921.210109-3-thorsten.blum@linux.dev>
References: <20260310102921.210109-3-thorsten.blum@linux.dev>
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
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 0E0835BCFF

On Tue, 10 Mar 2026 11:29:20 +0100,
Thorsten Blum wrote:
> --- a/sound/aoa/soundbus/i2sbus/core.c
> +++ b/sound/aoa/soundbus/i2sbus/core.c
> @@ -405,6 +405,9 @@ static int i2sbus_resume(struct macio_dev* dev)
>  	int err, ret = 0;
>  
>  	list_for_each_entry(i2sdev, &control->list, item) {
> +		if (list_empty(&i2sdev->sound.codec_list))
> +			continue;

This can be even outside the loop and immediately return 0, as the
remaining part is also the loop of codec_list.

  	int err, ret = 0;
  
 +	if (list_empty(&i2sdev->sound.codec_list))
 +		return 0;
 +
  	list_for_each_entry(i2sdev, &control->list, item) {
  		/* reset i2s bus format etc. */
  		i2sbus_pcm_prepare_both(i2sdev);


thanks,

Takashi

