Return-Path: <linuxppc-dev+bounces-12060-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB60CAC582
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Sep 2025 05:55:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cNNv26rNdz2xnM;
	Fri, 12 Sep 2025 15:55:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757656526;
	cv=none; b=CHSxDTYkouIyFDQKUop1Cqt7P79VkMxVrv3cPzx1M98+tGPjKqXe0ULnTvN9gpExX4BLeqlmyod3jCGyRUHbjKKXdXrNfpIJk85enf0z4UnDiocMmlIPLoqO+Yav9HWGhtU6FvOIgjqPUh9t7tmW1ILm0WPJnEyBOryu+VBDu2dNSb/n/2U4LQibHxsklWRYUWRRkWS3BtI6/NrywVziwXr55FuEyZZphwY+UHXvmS6ixvpiW6HGQQtVJCsWS13xn4M1VMCtXqtlL55qj4JdEejfAkAsKOqErL5JSBiMcxCztEJz2JK8V5UPBfHk5hYKBG2kTNfceeFH38RyGzEjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757656526; c=relaxed/relaxed;
	bh=/xQEp3B25Gx2dkBzqDFJpJ6L/oyw2iAMxDoyI8L6eok=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyJOAj5OGf9VAb9t59V41U3nUG5wTPMraZymjewVfFXFpFm2DCHTusc+hESDOb+nkpAT7wA4GW2+im9/+bHdY5tG5PWmRE+zE9SxbzVrKC6hajRhF7iMJo/pGGLXrcgxw/7ivJ5VCxRMbtOOU8NqjQPXBNlSyLPa9bODZFimTaT4oPD62EtRVwM2gS+fUKT1tuokf8iaVeHapC1W8IDX2A8XDc+kNa0sPFQaq8ZwfYWe16L7eAHyRdih/FTkvoum83ueChsDv9wm7rroYT6qt3HE/8T+sEH9XvMgl7pv/azNq4obD2N0An3Ny329RDcvxBtr/HQgiiAaFe5q6d2xIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yOn4bTL8; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=u2zUVx2h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yOn4bTL8; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=u2zUVx2h; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yOn4bTL8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=u2zUVx2h;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yOn4bTL8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=u2zUVx2h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cNNv124PTz2xQ2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2025 15:55:25 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6B7F5BE38;
	Fri, 12 Sep 2025 05:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757656520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xQEp3B25Gx2dkBzqDFJpJ6L/oyw2iAMxDoyI8L6eok=;
	b=yOn4bTL8JcA9wBlmvO/SmwRFTxUq82yFBx+dfm6uJiUiTkwzZLADyt+CcwxH6QgtF30x1V
	qXe6Fihi6X1ubicgPlGPd8l9/n+QUM3KxF2/otBOKQN7Y0r3zB3rpuEWUN9sHusx2KNhfJ
	BUwgz3ekMdR1L2JgKbhHCN/ceXIyHzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757656520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xQEp3B25Gx2dkBzqDFJpJ6L/oyw2iAMxDoyI8L6eok=;
	b=u2zUVx2hD7kB0HMlkgtor8CkvGkatKWoigZaUlnKgprjZ3y9upehqYVrQN93nO6ZwLQTpP
	letyluOB2yvt0QAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757656520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xQEp3B25Gx2dkBzqDFJpJ6L/oyw2iAMxDoyI8L6eok=;
	b=yOn4bTL8JcA9wBlmvO/SmwRFTxUq82yFBx+dfm6uJiUiTkwzZLADyt+CcwxH6QgtF30x1V
	qXe6Fihi6X1ubicgPlGPd8l9/n+QUM3KxF2/otBOKQN7Y0r3zB3rpuEWUN9sHusx2KNhfJ
	BUwgz3ekMdR1L2JgKbhHCN/ceXIyHzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757656520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xQEp3B25Gx2dkBzqDFJpJ6L/oyw2iAMxDoyI8L6eok=;
	b=u2zUVx2hD7kB0HMlkgtor8CkvGkatKWoigZaUlnKgprjZ3y9upehqYVrQN93nO6ZwLQTpP
	letyluOB2yvt0QAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86A77136DB;
	Fri, 12 Sep 2025 05:55:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2CaiH8i1w2i+ewAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 12 Sep 2025 05:55:20 +0000
Date: Fri, 12 Sep 2025 07:55:20 +0200
Message-ID: <87cy7wrz93.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Johannes Berg <johannes@sipsolutions.net>,	Jaroslav Kysela
 <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Uwe =?ISO-8859-1?Q?Klein?=
 =?ISO-8859-1?Q?e-K=F6nig?= <u.kleine-koenig@baylibre.com>,	Takashi Iwai
 <tiwai@suse.de>,	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: Remove redundant size arguments from strscpy()
In-Reply-To: <20250911214334.1482982-2-thorsten.blum@linux.dev>
References: <20250911214334.1482982-2-thorsten.blum@linux.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
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
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]

On Thu, 11 Sep 2025 23:43:22 +0200,
Thorsten Blum wrote:
> 
> The size parameter of strscpy() is optional if the destination buffer
> has a fixed length and strscpy() can automatically determine its size
> using sizeof(). This makes many explicit size arguments redundant.
> 
> Remove them to shorten and simplify the code.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks, applied now.


Takashi

