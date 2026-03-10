Return-Path: <linuxppc-dev+bounces-17975-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82964FD4F07
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 17:21:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVgdh5Ss8z3bjb;
	Wed, 11 Mar 2026 04:21:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773163272;
	cv=none; b=f3iRor76PrN1ZdbP+hyjjtxgKTyFgIeJt/N7PDVY9Tej5PHOFtfIdd+Sq3mMg77WfRf7Bzi5qhXQKOFtzFYctT1pUq2FHtIDEaw7S1pIV+r3UeQrPMfZUFhwtOt5okHgrkzySrjTOZrvUBNNFBZjRPf5WFSyHTR1Ou3xa7WRQv/BNZHiLFmAgwOZhp6uExmCpR92pL88gUFq7FS3l6ZmG9g8nI0WvTUP+jBTazOiOOop4m0/fGhAv/U1cpCiRUaMQRwCKZZiuUNeJ5mqSla9Nc1wp0PAkv3AQ9765evpHT6noTww2OULjFQwPHdnGASfs++HxNTpB5HmATikXu73Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773163272; c=relaxed/relaxed;
	bh=nd4HCw16AO/h0kHzWXcAUQ225vWTAP/sWpAzSj5/tKk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JS8VKwHEydT5s/qzbauHVFmKMrEyuEGdyxi+dpBR1xg5DLl+JHB5WMoexqS13c1+1DgPMVgsJPVxCc3futNYM1bP+wfmurCvpa+YPRz44siAmvD6ExkVsNajihNVEp9kC83gX0nUyP0NHHIBOtP0WB9WzvhAge10wTByt5O421PScr79g1h1z7jcBnKCTDwvd0aDfdxLaJUINQYyMpkaNSDD95JWLN7mIFS7Gpz2BI7IbpcppyQ4qey/R/Do+1WPohKiEUTO81vMjh6h17i8QnWQom6ZjmQugdHYDG0Uex76OCTSM397uaMPmF8oYycbo8vkdAdM3kSTNqxhE8lQ9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uLi3m8uE; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lmZvTPXk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uLi3m8uE; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lmZvTPXk; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uLi3m8uE;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lmZvTPXk;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uLi3m8uE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lmZvTPXk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 101288 seconds by postgrey-1.37 at boromir; Wed, 11 Mar 2026 04:21:11 AEDT
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVgdg4bpGz2xSB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 04:21:11 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65F5A4D284;
	Tue, 10 Mar 2026 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773163263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nd4HCw16AO/h0kHzWXcAUQ225vWTAP/sWpAzSj5/tKk=;
	b=uLi3m8uEruaUUhwUyaLTSMGbRT4y3yBVsIWYMeiUXG5iLKKyBtxDKlTGkBXSSkFY1XkcTE
	VP+ZO50LbDnrpU0DtlfZbMuwnfD+v4wNZSsL6k4cicAHf1VFzfaASUX7lckHb+xs1F7PN+
	UrG/XLFceNkWGRl+aZ2z4C1PeC/190g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773163263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nd4HCw16AO/h0kHzWXcAUQ225vWTAP/sWpAzSj5/tKk=;
	b=lmZvTPXkWQgzHmoANvB8p+i3TUbr1VU54OrAinVMc2iQhNQzbdOOiL1VKu5naHMb9OiAFZ
	CHe0+EAbtKdLx0Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uLi3m8uE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lmZvTPXk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773163263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nd4HCw16AO/h0kHzWXcAUQ225vWTAP/sWpAzSj5/tKk=;
	b=uLi3m8uEruaUUhwUyaLTSMGbRT4y3yBVsIWYMeiUXG5iLKKyBtxDKlTGkBXSSkFY1XkcTE
	VP+ZO50LbDnrpU0DtlfZbMuwnfD+v4wNZSsL6k4cicAHf1VFzfaASUX7lckHb+xs1F7PN+
	UrG/XLFceNkWGRl+aZ2z4C1PeC/190g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773163263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nd4HCw16AO/h0kHzWXcAUQ225vWTAP/sWpAzSj5/tKk=;
	b=lmZvTPXkWQgzHmoANvB8p+i3TUbr1VU54OrAinVMc2iQhNQzbdOOiL1VKu5naHMb9OiAFZ
	CHe0+EAbtKdLx0Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAFAE3F581;
	Tue, 10 Mar 2026 17:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t8XWN/xSsGmyTAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 10 Mar 2026 17:21:00 +0000
Date: Tue, 10 Mar 2026 18:21:00 +0100
Message-ID: <87y0jzppmr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Takashi Iwai <tiwai@suse.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: aoa: Skip devices with no codecs in i2sbus_resume()
In-Reply-To: <933E291B-23F2-4144-80F0-EC5730F65B75@linux.dev>
References: <20260310102921.210109-3-thorsten.blum@linux.dev>
	<878qbzradt.wl-tiwai@suse.de>
	<933E291B-23F2-4144-80F0-EC5730F65B75@linux.dev>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 65F5A4D284

On Tue, 10 Mar 2026 17:30:01 +0100,
Thorsten Blum wrote:
> 
> On 10. Mar 2026, at 16:07, Takashi Iwai wrote:
> > On Tue, 10 Mar 2026 11:29:20 +0100, Thorsten Blum wrote:
> >> --- a/sound/aoa/soundbus/i2sbus/core.c
> >> +++ b/sound/aoa/soundbus/i2sbus/core.c
> >> @@ -405,6 +405,9 @@ static int i2sbus_resume(struct macio_dev* dev)
> >> 	int err, ret = 0;
> >> 
> >> 	list_for_each_entry(i2sdev, &control->list, item) {
> >> +		if (list_empty(&i2sdev->sound.codec_list))
> >> +			continue;
> > 
> > This can be even outside the loop and immediately return 0, as the
> > remaining part is also the loop of codec_list.
> 
> The i2sdev pointer is only assigned by the outer list_for_each_entry(),
> which iterates the controller's device list. Since each device has its
> own codec list, list_empty(&i2sdev->sound.codec_list) must be checked
> inside the loop; before the loop i2sdev is uninitialized.

Ah indeed.  Now I applied to for-next branch.


thanks,

Takashi

