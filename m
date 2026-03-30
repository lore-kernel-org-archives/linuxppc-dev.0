Return-Path: <linuxppc-dev+bounces-18998-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9017FF495C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 07:36:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkjjq6WrTz2xpt;
	Mon, 30 Mar 2026 18:36:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774856191;
	cv=none; b=nGzID6Ujvu6nVXWll3g+Jr48ULPgiS6t/VsaKdTyJgD/ExZ6dVEFkY8JWW0TRak2oU8yav8jdmwUR9dYQ5+xK1Go9bS6Vib7m4kMyyqr+4M76W6lSDGl25aEjEtotzmzaIwJsQ7S6ihm1Kvxqr6QGAtgoxyDOV4RxiNP+CB4fLXK6fRileRQF2fOh9CKP2XH4sWjAzJCjpmGSJ5LpllueFAMcRo7Y/oua6tnD73WTjgtJbEV1miAdh5DrArLV1JbEk87us9jhx3etXUleMUcacw9fP/jjxpxBufbpTJEqlBszUNWERKjt5dJaSOq4atGJahIeHqrtIMZlUKxWEx2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774856191; c=relaxed/relaxed;
	bh=rrMnCznqNgri+NjrieBtsBBOPjrP13zJo0LHVEjqXgg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrSRGrTtiH2xPWyhmV7WeAUYIptuJd8RNCV0uNPdUo7c4yaS/z3iNF0CyK6UTSxNH84CwBlDFGX4IxsyTUaTqZhQRCyGTookEesZ5iGhhJvKywjtGEENfQhx2wRS+AG+Xg4hWA9zmxNttBBGX7ARBLRHkj6XQy42Vs8KKUvzmy6yzam4GEo7/CsLTdrYEiTGRXESFA1bY+B9mukRMYrLmqJnktXRhjQDshfsXuzgeelPIxYqbo0Iy1Z+giWCp+B0utoie9xq/0ViaXtkTL4aF0wHTT7OmHqotzJUpXhFitRgLlzjMYIZzHIDouyvAiaP/ib5FJiap6Jk/5VjL1v7yQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2YkWa7ta; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oCbPaxCI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Q9ylU2Ra; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HHYrvATc; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2YkWa7ta;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oCbPaxCI;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Q9ylU2Ra;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HHYrvATc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkjjp0X1jz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 18:36:29 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 210045BE85;
	Mon, 30 Mar 2026 07:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774856181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrMnCznqNgri+NjrieBtsBBOPjrP13zJo0LHVEjqXgg=;
	b=2YkWa7taW/14fNONVbgTmYca2TdvpOZ180cJXbSoIaxUAjVQulC4+kWOuBkysTuKHnnzIe
	jRXYjT5XNBjbrZ6CV/jqOYgaOdRMiH+H+iBHhiS+jwI0m7tcgCo4uFnawdM0smBy2KbrFD
	QIFBMTG+LrRqP12P9/LiDbbp0ZMXfaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774856181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrMnCznqNgri+NjrieBtsBBOPjrP13zJo0LHVEjqXgg=;
	b=oCbPaxCI3NKXEjbd0F0HX/af3nAlPk/DSi+3U7m/dT3iQHe8V1iVKDqLkJsmjo6c2G8ppf
	gnX/vp8aOAvU/2Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774856180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrMnCznqNgri+NjrieBtsBBOPjrP13zJo0LHVEjqXgg=;
	b=Q9ylU2RaADVGsYJiaCg792mXhv89cIQ2IpVUq3AmUz8QUXYwHkRinvWpdjS5agJoV8Mvyu
	zGXZZhc1g/I3dSx1AtP7Jbu3yebggLzZJ2si5lgWD4BB6aKu1u+aE4lYE53snqNuMhUpeV
	dpG8cP6GO5sFYZ0592P4VfIBDfXcD4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774856180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrMnCznqNgri+NjrieBtsBBOPjrP13zJo0LHVEjqXgg=;
	b=HHYrvATcnDzLbS8y7ZaPV0MbM9VOHpc9c18J2RyXPXbx0PogjR7JlAM3ea0KaoiHbdzT3G
	6E4NFSpnRMu6kpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5F6B4A0A2;
	Mon, 30 Mar 2026 07:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /I33MvMnymkaKAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Mar 2026 07:36:19 +0000
Date: Mon, 30 Mar 2026 09:36:19 +0200
Message-ID: <87o6k5u5u4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: i2sbus: fix OF node lifetime handling
In-Reply-To: <20260330-aoa-i2sbus-ofnode-lifetime-v1-1-51c309f4ff06@gmail.com>
References: <20260330-aoa-i2sbus-ofnode-lifetime-v1-1-51c309f4ff06@gmail.com>
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
X-Spamd-Result: default: False [-7.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]

On Mon, 30 Mar 2026 06:00:34 +0200,
Cássio Gabriel wrote:
> 
> i2sbus_add_dev() keeps the matched "sound" child pointer after
> for_each_child_of_node() has dropped the iterator reference. Take an
> extra reference before saving that node and drop it after the
> layout-id/device-id lookup is complete.
> 
> The function also stores np in dev->sound.ofdev.dev.of_node without
> taking a reference for the embedded soundbus device. Since i2sbus
> overrides the embedded platform device release callback, balance that
> reference explicitly in the local error path and in i2sbus_release_dev().
> 
> Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Applied to for-next branch now.  Thanks.


Takashi

