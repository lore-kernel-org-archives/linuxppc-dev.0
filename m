Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785C606A324
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=U3F9Ri+f;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kLVZ4wM0;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=U3F9Ri+f;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kLVZ4wM0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJgZg4kKrz2xK7;
	Tue, 03 Nov 2026 18:44:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793691883;
	cv=none; b=cN0GmX8cGlQoVg5QbvaO2lRkmSMQ+ia9eNWUlJHMHY0VzxNxgbifu5Yoz6q+U5MtV8cwNZO3I/nzAB1PER41Q2PM54oWvVb6tUB9Stng0mFyKBIQPCAzDUfFLl6ygnz2OWOHc7gaXOcO3Jhy4Cy3g9llrThfvYEJpdo6D3OZnOx1en1b5rNyUMxzi1ce9ag60NXKzkfR86m4r/rYyrJ1GM/c4LXjFBgTItCtamvRNvbr8LSHns1FPdobsSmgZ7HYefLS/XD/80SaUfj18nt1chTHeQTM8MecIwvdOvO/xfaQ3d84bp0AB/Rag9ux5lkU0lFIBX1qL8yNW6oqojw3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793691883; c=relaxed/relaxed;
	bh=I4rnc0MrED3dJqv3cesE4ZCBRNeo7kH0Pr29AAl4OT0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTjykZeOzq1UbGCwJn7N/cu53E/u8Ck9bA3mOrR64rSmgDPJAFBqrtOUL07DabjLCqEJS5xYf8mYOIVE17bmMwm3JMwvgglqVmm4xXjqN3Cn45p9ACh8vk+PNxbu5PtJRFM4h+NmaJ53W9orrerjw8X/V6ZTkRzfn7meCrfZC9uWXRDRrRH1nbOaKGm/hNryUF8COO0rh2quZMmsP+/yOkzHcRIjE115PLBSj68Y3REYM1TcYZU2+uSiLqTWBTqohW39rw7xTyhjJuuWpATI0nrnIl2q9PbMHX2HwOkI5ZG3r5NniY3OoGEY3eXCUh6CcPNxV8pTI/1g2qPYtYlHeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=U3F9Ri+f; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kLVZ4wM0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=U3F9Ri+f; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kLVZ4wM0; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=U3F9Ri+f;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kLVZ4wM0;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=U3F9Ri+f;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kLVZ4wM0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJgZf1fmjz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 18:44:41 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 955C02201A;
	Tue,  3 Nov 2026 07:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793691878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4rnc0MrED3dJqv3cesE4ZCBRNeo7kH0Pr29AAl4OT0=;
	b=U3F9Ri+fuhrCCVY/Iuw+7yLPxm6BDrrnhThFHCzrTSFe1dO8kJFcZsKEFI8HToafUmzPPJ
	kWV+nRaWtheVdWMe8btMrRenxZ7rDH8pVtSZ4NAyWLD2oDBOmqxPmh4/s6pg7nDaQMQovS
	4L4/a95WLqVrZtJ8jbys6FB7QvL9vPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793691878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4rnc0MrED3dJqv3cesE4ZCBRNeo7kH0Pr29AAl4OT0=;
	b=kLVZ4wM0gkg+gFYo0zSo/np2aYadkvHBtEIYgBTToUFow6LjTcM3X3KALp6fXpicMttqVO
	AKaD+R+1z9Lh4HAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=U3F9Ri+f;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kLVZ4wM0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793691878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4rnc0MrED3dJqv3cesE4ZCBRNeo7kH0Pr29AAl4OT0=;
	b=U3F9Ri+fuhrCCVY/Iuw+7yLPxm6BDrrnhThFHCzrTSFe1dO8kJFcZsKEFI8HToafUmzPPJ
	kWV+nRaWtheVdWMe8btMrRenxZ7rDH8pVtSZ4NAyWLD2oDBOmqxPmh4/s6pg7nDaQMQovS
	4L4/a95WLqVrZtJ8jbys6FB7QvL9vPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793691878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4rnc0MrED3dJqv3cesE4ZCBRNeo7kH0Pr29AAl4OT0=;
	b=kLVZ4wM0gkg+gFYo0zSo/np2aYadkvHBtEIYgBTToUFow6LjTcM3X3KALp6fXpicMttqVO
	AKaD+R+1z9Lh4HAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D165134B8;
	Tue,  3 Nov 2026 07:44:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xtyNAeaQ6Wr0WwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 03 Nov 2026 07:44:38 +0000
Date: Tue, 03 Nov 2026 08:44:37 +0100
Message-ID: <874idy2wbe.wl-tiwai@suse.de>
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
In-Reply-To: <DFCEA32C-0340-46B0-BADF-839E8C675FE9@xenosoft.de>
References: <87mrrspo7n.wl-tiwai@suse.de>
	<DFCEA32C-0340-46B0-BADF-839E8C675FE9@xenosoft.de>
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
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 955C02201A
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,xtra.co.nz,yahoo.com.au];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,perex.cz,vger.kernel.org,lists.ozlabs.org,xtra.co.nz,yahoo.com.au,xenosoft.de];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -12.51
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 03 Nov 2026 08:34:52 +0100,
Christian Zigotzky wrote:
> 
> On 01 November 2026 at 04:26 pm, Takashi Iwai <tiwai@suse.de> wrote:
> 
> Hm, could you verify whether the below oneliner recovers from your
> problem or not?
> 
> -- 8< --
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -965,7 +965,8 @@ static int snd_pcm_hw_refine_user(struct snd_pcm_substream *substream,
>    if (IS_ERR(params))
>        return PTR_ERR(params);
> 
> -    err = snd_pcm_hw_refine_with_lock(substream, params);
> +    //err = snd_pcm_hw_refine_with_lock(substream, params);
> +    err = snd_pcm_hw_refine(substream, params);
>    if (err < 0)
>        return err;
> 
> -- 8< --
> 
> If this works, clear this change again, and figure out which check in
> snd_pcm_hw_refine_with_lock() gives the error.  The function has three
> preliminary checks: PCM_RUNTIME_CHECK(), snd_pcm_buffer_access_lock()
> (& unlock()), and hw_parms_state_check.  The first one must be
> harmless, and the real problem must be either
> snd_pcm_buffer_access_lock() or hw_params_state_check().
> 
> ```
> static int snd_pcm_hw_refine_with_lock(struct snd_pcm_substream *substream,
>                       struct snd_pcm_hw_params *params)
> {
>    struct snd_pcm_runtime *runtime;
>    int err;
> 
>    if (PCM_RUNTIME_CHECK(substream))
>        return -ENXIO;
>    runtime = substream->runtime;
>    err = snd_pcm_buffer_access_lock(runtime);
>    if (err < 0)
>        return err;
>    err = hw_params_state_check(substream);
>    if (err)
>        goto unlock;
> 
>    err = snd_pcm_hw_refine(substream, params);
> 
> unlock:
>    snd_pcm_buffer_access_unlock(runtime);
>    return err;
> }
> ```
> 
> OTOH, if the oneliner above doesn't change the behavior, something
> else overlooked obviously.
> 
> Oh wait, it might be the 32bit compat path?  If so, the call at
> snd_pcm_ioctl_hw_params_compat() needs to be tested, instead.
> 
> 
> thanks,
> 
> Takashi
> 
> 
> - - -
> 
> Hi Takashi,
> 
> Thank you for your patch.
> 
> I tested your patch today but unfortunately it doesn¢t solve the issue with PulseAudio on Void PPC.

Have you tried changing the call of snd_pcm_hw_refine_with_lock() in
snd_pcm_ioctl_hw_params_compat(), too?  Or check the call in
snd_pcm_hw_refine_old_user(), too.

If it doesn't change even if you replace all callers of
snd_pcm_hw_refine_with_lock() with snd_pcm_hw_refine(), something
wrong in the test itself.


Takashi

