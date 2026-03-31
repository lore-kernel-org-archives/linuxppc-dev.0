Return-Path: <linuxppc-dev+bounces-19098-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80AA109B474
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 14:28:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flVpD3TcJz2ydQ;
	Wed, 01 Apr 2026 01:28:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774967284;
	cv=none; b=AXHb09QtwBUBUIOk2+4WF27bbXnjJYhgxMJyiiyIiFlWxRCKBYoFcDbyIR2lepGUD346or1PM3ac5pTzoqZL+VsK7NqznfLy+ko4lyWMBGF7cH/UCBSulemvRi7F13Cyz8e6300M7/Vjk2aPHxZNiiU+CRBCvTzT4yHXm1x2+JSPz6UqUbjCbOS02T4xQTHcQhO/6647nN/+shLnIbzKqR6uoqoQcZSvNsXfgCj+/JL3HOAF828EwrZD3H47hlnsVIimZ5gQ6oPvE4w4sE7ziSJs9mP2TCR/9wSxTyUD6mzWnP19OoRTv7W8FWP9hypcYHc1thhnPph2nTX1NPghJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774967284; c=relaxed/relaxed;
	bh=0HqKpU3qn80efCu2LyflGJS5zncivPfp3CASz23aZ0M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=now2Csa4RDkYqqvZQ2wVPtTQbLn9+t3Z5dU8nnZV9eqW7+pHDq7Xd5GUur3ZV458j81w+HIS5DLiQQtpyXhghNT19CWQcHPd3Q6cir49838jlf8l4FrlAe5xPP6AEvd8AugHmUenrNuv/UoACSbCyl5b78ul/O1H6PJRPONidsaKq2KdU5bFV7U0HdF3gbYr5aqDb5HKBvPPO72fSYocsA/TM1NCr7n/NdBq2Mc6dYgDS2JK0Q7D3TkVnkDppDUqSX0O5dNbne5cx2XqJ4vbmsm3+tqVrpwNKgsmdRRIs6G0OEvA+Y0vgPUtQ+Z48Am4AzDEWkIE4g+mQ0xij6CyHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LJUu95iO; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SMIi5VxY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LJUu95iO; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SMIi5VxY; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LJUu95iO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SMIi5VxY;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LJUu95iO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SMIi5VxY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flVpC09V4z2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 01:28:02 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7ABAD4D27D;
	Tue, 31 Mar 2026 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774967279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HqKpU3qn80efCu2LyflGJS5zncivPfp3CASz23aZ0M=;
	b=LJUu95iOK+E2XRq+yk9t2EWvbAHiuhyYgcdHQ8SKUrK8k/0jqIChVxbA4162VvBErm3cSx
	Z7gMVIciNgXODHAzxlnREGJ9GlP65V7+i9FaKWpG6nsMh7iqhlE7cuOKYXLFE6AgaP8xkz
	7iliEMeS+K9J2QzZNf7jJJOx3Oprlbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774967279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HqKpU3qn80efCu2LyflGJS5zncivPfp3CASz23aZ0M=;
	b=SMIi5VxYppR2hqgelmmhmlr14VloaOgLpuDKNZJJnSEeKi6nDBgberrVHgX9wfVxCKysim
	0ndmqMiMHCKgePCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774967279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HqKpU3qn80efCu2LyflGJS5zncivPfp3CASz23aZ0M=;
	b=LJUu95iOK+E2XRq+yk9t2EWvbAHiuhyYgcdHQ8SKUrK8k/0jqIChVxbA4162VvBErm3cSx
	Z7gMVIciNgXODHAzxlnREGJ9GlP65V7+i9FaKWpG6nsMh7iqhlE7cuOKYXLFE6AgaP8xkz
	7iliEMeS+K9J2QzZNf7jJJOx3Oprlbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774967279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HqKpU3qn80efCu2LyflGJS5zncivPfp3CASz23aZ0M=;
	b=SMIi5VxYppR2hqgelmmhmlr14VloaOgLpuDKNZJJnSEeKi6nDBgberrVHgX9wfVxCKysim
	0ndmqMiMHCKgePCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56E084A0A2;
	Tue, 31 Mar 2026 14:27:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kZJtFO/Zy2kUGgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 31 Mar 2026 14:27:59 +0000
Date: Tue, 31 Mar 2026 16:27:51 +0200
Message-ID: <878qb8rs48.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: i2sbus: clear stale prepared state
In-Reply-To: <20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com>
References: <20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com>
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
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.984];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]

On Tue, 31 Mar 2026 00:27:28 +0200,
Cássio Gabriel wrote:
> 
> The i2sbus PCM code uses pi->active to constrain the sibling stream to
> an already prepared duplex format and rate in i2sbus_pcm_open().
> 
> That state is set from i2sbus_pcm_prepare(), but the current code only
> clears it on close. As a result, the sibling stream can inherit stale
> constraints after the prepared state has been torn down, or after a new
> prepare attempt fails before completing.
> 
> Clear pi->active when hw_params() or hw_free() drops the prepared state,
> clear it before starting a new prepare attempt, and set it again only
> after prepare succeeds.
> 
> Replace the stale FIXME in the duplex constraint comment with
> a description of the current driver behavior: i2sbus still programs a
> single shared transport configuration for both directions, so mixed
> formats are not supported in duplex mode.
> 
> Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
> ---
>  sound/aoa/soundbus/i2sbus/pcm.c | 53 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
> index 97c807e67d56..47a89da43cff 100644
> --- a/sound/aoa/soundbus/i2sbus/pcm.c
> +++ b/sound/aoa/soundbus/i2sbus/pcm.c
> @@ -165,17 +165,16 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
>  	 * currently in use (if any). */
>  	hw->rate_min = 5512;
>  	hw->rate_max = 192000;
> -	/* if the other stream is active, then we can only
> -	 * support what it is currently using.
> -	 * FIXME: I lied. This comment is wrong. We can support
> -	 * anything that works with the same serial format, ie.
> -	 * when recording 24 bit sound we can well play 16 bit
> -	 * sound at the same time iff using the same transfer mode.
> +	/* If the other stream is already prepared, keep this stream
> +	 * on the same duplex format and rate.
> +	 *
> +	 * i2sbus_pcm_prepare() still programs one shared transport
> +	 * configuration for both directions, so mixed duplex formats
> +	 * are not supported here.
>  	 */
>  	if (other->active) {
> -		/* FIXME: is this guaranteed by the alsa api? */
>  		hw->formats &= pcm_format_to_bits(i2sdev->format);
> -		/* see above, restrict rates to the one we already have */
> +		/* Restrict rates to the one already in use. */
>  		hw->rate_min = i2sdev->rate;
>  		hw->rate_max = i2sdev->rate;
>  	}
> @@ -283,6 +282,22 @@ void i2sbus_wait_for_stop_both(struct i2sbus_dev *i2sdev)
>  }
>  #endif
>  
> +static void i2sbus_pcm_clear_active(struct i2sbus_dev *i2sdev, int in)
> +{
> +	struct pcm_info *pi;
> +
> +	guard(mutex)(&i2sdev->lock);
> +
> +	get_pcm_info(i2sdev, in, &pi, NULL);
> +	pi->active = 0;
> +}
> +
> +static inline int i2sbus_hw_params(struct snd_pcm_substream *substream, int in)
> +{
> +	i2sbus_pcm_clear_active(snd_pcm_substream_chip(substream), in);
> +	return 0;
> +}
> +
>  static inline int i2sbus_hw_free(struct snd_pcm_substream *substream, int in)
>  {
>  	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
> @@ -291,14 +306,25 @@ static inline int i2sbus_hw_free(struct snd_pcm_substream *substream, int in)
>  	get_pcm_info(i2sdev, in, &pi, NULL);
>  	if (pi->dbdma_ring.stopping)
>  		i2sbus_wait_for_stop(i2sdev, pi);
> +	i2sbus_pcm_clear_active(i2sdev, in);
>  	return 0;
>  }
>  
> +static int i2sbus_playback_hw_params(struct snd_pcm_substream *substream)
> +{
> +	return i2sbus_hw_params(substream, 0);
> +}
> +
>  static int i2sbus_playback_hw_free(struct snd_pcm_substream *substream)
>  {
>  	return i2sbus_hw_free(substream, 0);
>  }
>  
> +static int i2sbus_record_hw_params(struct snd_pcm_substream *substream)
> +{
> +	return i2sbus_hw_params(substream, 1);
> +}
> +
>  static int i2sbus_record_hw_free(struct snd_pcm_substream *substream)
>  {
>  	return i2sbus_hw_free(substream, 1);
> @@ -335,7 +361,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
>  		return -EINVAL;
>  
>  	runtime = pi->substream->runtime;
> -	pi->active = 1;
> +	pi->active = 0;
>  	if (other->active &&
>  	    ((i2sdev->format != runtime->format)
>  	     || (i2sdev->rate != runtime->rate)))

Do we need to clear the active flag here?  It must have been cleared
by hw_params call.  Or is it the case for errors?


thanks,

Takashi

