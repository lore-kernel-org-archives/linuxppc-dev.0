Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F7606A329
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FHvB8WeM;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xqce2axH;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Y9MRsZzA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Iae+n5Xu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJrmS1CCxz2xSZ;
	Wed, 04 Nov 2026 01:38:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793716728;
	cv=none; b=F1bzRTSNCdcTNkIk4c/MQNSTh/QTAGHFQUJPLS/5T+HvBtE0g+lIO1vw14hnjvOfoLT599ms5EfOIEyzDYmUZxr6ICeD+snXYZ91NA/cYXBfMQ4hHv8FTZf6olAcTgEvsdQJp+TPdAHkBsXqb8MqQ0vCgWbrMrzU42bAziWs2UDFzrLjgkritkfm80ilpER/YJj1PRQ78bdyvne/PNq9wRtEzI+8gTsyiI/MagOFbaaAlvALz5O19LG2Yqod4ely8byTKxVt/nx6dUShCoGyGhBqwYbGLn5uRg7pI870AxgWhdAGrflGwUxZ5ICv9JaQFnnTb+VzUeEwc0Q02/0jow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793716728; c=relaxed/relaxed;
	bh=kVH6lEoMeQpH1Hape2ngmhAinE+qo6gyJ4nEWWBRqGg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PThpAt6x5D+tUP5GUmb1Dg3HKdPJVGGXXDZJiFLrnq79eGXjhHVD3ZnTdatGlh38u4gMiXC2S8raFsMj/Pk3Tmn7Ct2nNJLUChB5yw++7RPJ8XdIO3lgwM+7s24TBnchNtDJ1ejQxgh1jkexuYOuBaQmMzSi67JsEXsQ8Uhl8doDNUf+CTDG7m/tEmTbEtxPJ/Ybh5zyMFkcbT3rFGfAykmtWxebEBEZg/uIlDhIVbnuSHKtNRAleHtKRhVGbHqPqazwEqRb4mR7yoK6p9Ebk53Sg1BE7hiRFWyHSRgTkG3rVFfUhZRekmcHRCktYBitq+GnQd2VHNeA7HQ2UyY6mA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FHvB8WeM; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xqce2axH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Y9MRsZzA; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Iae+n5Xu; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FHvB8WeM;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xqce2axH;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Y9MRsZzA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Iae+n5Xu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJrmR0WK8z2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 01:38:46 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 072641F745;
	Tue,  3 Nov 2026 14:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793716723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVH6lEoMeQpH1Hape2ngmhAinE+qo6gyJ4nEWWBRqGg=;
	b=FHvB8WeMZdOjok91qroXbmiaOz8sEf1MXAFOXnJg4Ea8D0A4Fg+8LdSesvChbPooqalcIV
	ST29QKJYltPF2nK1tyYLhBA2LJEdTLzg6G8DIwkKhVydzUMA2xFuGq1A4fwU+WIrtya4KN
	9NcqzPtWK/ABJzAbdoQK8pRyJsZpRfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793716723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVH6lEoMeQpH1Hape2ngmhAinE+qo6gyJ4nEWWBRqGg=;
	b=xqce2axHdSZUsEr2hDsSQFVCS8v0rFocryoBxxeO89U0Ej4iRZMwv94j9vzUcmm5yuTPKC
	e4ecci23oWyfsmCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793716722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVH6lEoMeQpH1Hape2ngmhAinE+qo6gyJ4nEWWBRqGg=;
	b=Y9MRsZzAjf3A0fR3Rl2drD0DfMh8qQFSAfCJBtUgm4GceAQMs0omC68vfkgw9tDjyqBvep
	XDAi7oK3ocrRq5mEvbhJ/xLi5L0411+it1deRI6ppJUlKT0NnQfwsamWFpGTO4npXR8QDj
	fOazgHK9qamwnjbABZmwSfsZvebj7zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793716722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVH6lEoMeQpH1Hape2ngmhAinE+qo6gyJ4nEWWBRqGg=;
	b=Iae+n5XuNO+uwvoL8np7L1pCpgWWYc9hzaXqmRfxIRUTHCK1Zsljyv7L2sVAKhDHK42mMD
	puoI8wK3JK2zqNCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3D81134B8;
	Tue,  3 Nov 2026 14:38:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DKqlIvHx6WoYCQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 03 Nov 2026 14:38:41 +0000
Date: Tue, 03 Nov 2026 15:38:37 +0100
Message-ID: <874idyx9n6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Takashi Iwai <tiwai@suse.de>,
	zzzccc427@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	mad skateman <madskateman@gmail.com>,
	Damien Stewart <hypexed@yahoo.com.au>,
	Christian Zigotzky <info@xenosoft.de>
Subject: Re: Void PPC: PulseAudio issue with sound updates 7.4-rc1
In-Reply-To: <BD226162-844C-449D-A486-8888184DEBF0@xenosoft.de>
References: <874idy2wbe.wl-tiwai@suse.de>
	<BD226162-844C-449D-A486-8888184DEBF0@xenosoft.de>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,perex.cz,vger.kernel.org,lists.ozlabs.org,xtra.co.nz,yahoo.com.au,xenosoft.de];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,xtra.co.nz,yahoo.com.au];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -12.30
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 03 Nov 2026 13:00:24 +0100,
Christian Zigotzky wrote:
> 
> On 03 November 2026 at 08:44 am, Takashi Iwai <tiwai@suse.de> wrote:
> 
> Have you tried changing the call of snd_pcm_hw_refine_with_lock() in
> snd_pcm_ioctl_hw_params_compat(), too?  Or check the call in
> snd_pcm_hw_refine_old_user(), too.
> 
> If it doesn't change even if you replace all callers of
> snd_pcm_hw_refine_with_lock() with snd_pcm_hw_refine(), something
> wrong in the test itself.
> 
> 
> Takashi
> 
> - - -
> 
> I have tried it and sound works again.

Then please figure out which replacement of
snd_pcm_hw_refine_with_lock() actually matters.
(You can keep snd_pcm_hw_refine_with_lock() definition there.)


thanks,

Takashi

> 
> My modifications:
> 
> diff -rupN a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
> --- a/sound/core/pcm_compat.c	2026-11-01 22:26:31.000000000 +0100
> +++ b/sound/core/pcm_compat.c	2026-11-03 10:01:54.228010513 +0100
> @@ -252,7 +252,7 @@ static int snd_pcm_ioctl_hw_params_compa
>  		return -EFAULT;
>  
>  	if (refine) {
> -		err = snd_pcm_hw_refine_with_lock(substream, data);
> +		err = snd_pcm_hw_refine(substream, data);
>  		if (err < 0)
>  			return err;
>  		err = fixup_unreferenced_params(substream, data);
> diff -rupN a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> --- a/sound/core/pcm_native.c	2026-11-01 22:26:31.000000000 +0100
> +++ b/sound/core/pcm_native.c	2026-11-03 10:02:24.836343549 +0100
> @@ -932,29 +932,6 @@ static int snd_pcm_hw_params_user(struct
>   * this one should be used for ioctls and other external paths instead of
>   * direct call of snd_pcm_hw_refine()
>   */
> -static int snd_pcm_hw_refine_with_lock(struct snd_pcm_substream *substream,
> -				       struct snd_pcm_hw_params *params)
> -{
> -	struct snd_pcm_runtime *runtime;
> -	int err;
> -
> -	if (PCM_RUNTIME_CHECK(substream))
> -		return -ENXIO;
> -	runtime = substream->runtime;
> -	err = snd_pcm_buffer_access_lock(runtime);
> -	if (err < 0)
> -		return err;
> -	err = hw_params_state_check(substream);
> -	if (err)
> -		goto unlock;
> -
> -	err = snd_pcm_hw_refine(substream, params);
> -
> - unlock:
> -	snd_pcm_buffer_access_unlock(runtime);
> -	return err;
> -}
> -
>  static int snd_pcm_hw_refine_user(struct snd_pcm_substream *substream,
>  				  struct snd_pcm_hw_params __user * _params)
>  {
> @@ -965,7 +942,7 @@ static int snd_pcm_hw_refine_user(struct
>  	if (IS_ERR(params))
>  		return PTR_ERR(params);
>  
> -	err = snd_pcm_hw_refine_with_lock(substream, params);
> +	err = snd_pcm_hw_refine(substream, params);
>  	if (err < 0)
>  		return err;
>  
> @@ -4247,7 +4224,7 @@ static int snd_pcm_hw_refine_old_user(st
>  	if (IS_ERR(oparams))
>  		return PTR_ERR(oparams);
>  	snd_pcm_hw_convert_from_old_params(params, oparams);
> -	err = snd_pcm_hw_refine_with_lock(substream, params);
> +	err = snd_pcm_hw_refine(substream, params);
>  	if (err < 0)
>  		return err;

