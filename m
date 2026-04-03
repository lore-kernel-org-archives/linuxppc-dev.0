Return-Path: <linuxppc-dev+bounces-19262-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAFFD730BD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 08:11:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnBJ31TXkz2yVP;
	Fri, 03 Apr 2026 19:11:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775203875;
	cv=none; b=MZ+bYFL5d9fQGd0BsoXMaIUrp+hbsQ6jJmvrXkq/Ux9T2oIhfzQIPFCmn99ymjcArOBc+UsS9OsvJ9RSK/5LMkms8GjEacmSvkLCMPpf0X8Xwj7VjzR94PeLiNmTjCvpX3smp4VPm3RRZFooSwwx07GYGBKyvENpeLQScSb49e3VsSSZFOfkZ1uI+U0l2MeEs8i3w0EWFcF8nezeroDB7IiYjMo8ntCAMc2O9epgQwjn7vmodxLgCNhM2Zap2P/HXqznU81wUcZn9nJyqDfvx8ig3lW9K+411PbO4FiW36l6Ifuu9qB1CQNI6MXPbXNgO5O/v5+8BieSgy/x/x8v4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775203875; c=relaxed/relaxed;
	bh=pKTj+fuw+V2CSJJ06hFpU6rHWXveJU/kjg5LgshKBS4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LstxEKFzEaKZZtUvN+hnEQJkk6Oo84GzbR2jBFFurhjpYFolxGHSN/Aby72NSrABtetbHGaUejJwcOov15bWvl/Cpqf4Tt24kW921hhvThkrdGCDL8gezhcLxXgKJt1CinxSCuEMZ0UfWKlV2Z9ezvr+WKpjhZBhYYIHOnck9wMXTXSDIpZQjp2enGLlymTuEqeSfBLjD2uXfPwK5qF0Mzc6KJjug07By/X6UQJE4qpr0IAob/hykaijvwXYGrBKREjtiSoUQeXdv9sARY6mISHyLOifjrzvZniQA+kOf0wzDNWcNH/+gyMKXGU6cS3POXVfCZ6BxcT70UnzZeGOyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZjapW8jF; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lpDrm4gB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZjapW8jF; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lpDrm4gB; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZjapW8jF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lpDrm4gB;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZjapW8jF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lpDrm4gB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnBJ14PPXz2xln
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 19:11:13 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B207F5BD57;
	Fri,  3 Apr 2026 08:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775203869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pKTj+fuw+V2CSJJ06hFpU6rHWXveJU/kjg5LgshKBS4=;
	b=ZjapW8jFn+ffPxdody7EeAXjP3qFwL1hz3EpGCSf8VEImvuXSLJsUnhALORGFLXWTzEwmF
	qg6Uwvk7ByjPNIjFjrgJgT0j6coewIKlBOLSxJnJZ8+NwuzKEXxJ/m5gQIg4Pp5VAAcTHU
	zT+bP8PmtCGVRlHd2z3jZsQr1qNhkW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775203869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pKTj+fuw+V2CSJJ06hFpU6rHWXveJU/kjg5LgshKBS4=;
	b=lpDrm4gBQZVjSNqzwJ8u02Vc+sPyplzJwIgcIsNR5a//N8Hk/7iBMZZwlv2HzXUvd5XCrm
	E0Td6ppUMBEf4cCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775203869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pKTj+fuw+V2CSJJ06hFpU6rHWXveJU/kjg5LgshKBS4=;
	b=ZjapW8jFn+ffPxdody7EeAXjP3qFwL1hz3EpGCSf8VEImvuXSLJsUnhALORGFLXWTzEwmF
	qg6Uwvk7ByjPNIjFjrgJgT0j6coewIKlBOLSxJnJZ8+NwuzKEXxJ/m5gQIg4Pp5VAAcTHU
	zT+bP8PmtCGVRlHd2z3jZsQr1qNhkW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775203869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pKTj+fuw+V2CSJJ06hFpU6rHWXveJU/kjg5LgshKBS4=;
	b=lpDrm4gBQZVjSNqzwJ8u02Vc+sPyplzJwIgcIsNR5a//N8Hk/7iBMZZwlv2HzXUvd5XCrm
	E0Td6ppUMBEf4cCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C5A14A0A6;
	Fri,  3 Apr 2026 08:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L7wEHR12z2mfbQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 03 Apr 2026 08:11:09 +0000
Date: Fri, 03 Apr 2026 10:11:09 +0200
Message-ID: <87bjg0ihuq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: wangdich9700@163.com
Cc: johannes@sipsolutions.net,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: Re: [PATCH v2 1/2] ALSA: aoa/onyx: Fix OF node leak on probe failure
In-Reply-To: <20260403014736.33014-1-wangdich9700@163.com>
References: <20260403014736.33014-1-wangdich9700@163.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,kylinos.cn:email]

On Fri, 03 Apr 2026 03:47:36 +0200,
wangdich9700@163.com wrote:
> 
> From: wangdicheng <wangdicheng@kylinos.cn>
> 
> Add missing of_node_put() in the error path.
> 
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>

Applied to for-next branch now.


thanks,

Takashi

