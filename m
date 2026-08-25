Return-Path: <linuxppc-dev+bounces-26083-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D032DC61DB6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2026 07:59:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTgDN6Y6lz2xKh;
	Tue, 25 Aug 2026 17:59:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787644788;
	cv=none; b=JNXCcMtT27s+NZkyeRJMT+nt8WaXy7Y+RIcWO9iH1PT2vc/xkoBlZ+jKtxQsdunNiYbsnFoeeCA5CQTp6MccjTMNVPtEdefepK0W9kpq1LhVWtx3LZiEQ/Dh5lJDrvuWNAKtW3LrLbxCskTTRyNrUcAlmiKyM/SiIoqlKDwsrmWpjoLOOOgGFHf7p2ax9gUCP492coKPklNKpLw7L08VBpySUBUDBHZeAcsYiYYSclNpYBGf6mUezBAWOT6e5rCEvX1hVv9Lrr+3QWtgjgsr1zUiQaxDQqA31K+wl/zYUbsE3Fk2kJ+rq9kf2B4xswPeHMT08JkxZaiDtl2UfNF9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787644788; c=relaxed/relaxed;
	bh=rMWaJJRYuPPY8Ps5wum1jNYqSkp8y1Vg3ryyqNdrmhQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIWUYtQz+gpOhFNvTT6jcKI8kMmIP+g9me4gkqCSVTy1mm1XtL2/VU+vR80G+/puvI1QvjbOMbqdnBlNhGiPMv/C2j3Kr2pLRDvfNAqFfuS7/SufRc6yvNWXQMGxNTrQ443GOuHSIXzWFyiJ9xUrz/wJdQ+VWhwmzhnVoOf+fuom1glOkudgOCnNDh4hwvNBbvxC2jz3u3u/RIMY5qukvGfloiVCJpVKWhc3qwb8jCAtBLPsTM7OFTImWGL/B7HCF/LiJ4kjxDp+SXycBAgtQYxT3DUi8UP3o7pBU9C0JTUOuEo0Aw6KzJQ4VmPvqlk2g8yrsQuXulj6Qeq5GUSMfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=o+4pjZ6b; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oMSnqea4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tRDr5KNG; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1aKU7Hgx; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=o+4pjZ6b;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oMSnqea4;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tRDr5KNG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1aKU7Hgx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTgDJ0jcDz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 17:59:43 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4906D1F78B;
	Tue, 25 Aug 2026 07:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787644764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rMWaJJRYuPPY8Ps5wum1jNYqSkp8y1Vg3ryyqNdrmhQ=;
	b=o+4pjZ6birxJPBdb5zckW5WhBPKl++aN2F1lJMfwro3F4Q2iIEgAc3p3c8D1Ol2QBHmQSX
	LmnoK1AEEKzazmzdd8muTqZYleO/f0X5l4odFnI+e99ZpOiLyE3yzwWTQG0JDCwxsMjDDK
	WmRjfvRlzYnVPwO/w6uOl/wwqIXfDu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787644764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rMWaJJRYuPPY8Ps5wum1jNYqSkp8y1Vg3ryyqNdrmhQ=;
	b=oMSnqea40b2d6Jidv/yVi6DzKq+shXY6WVzvH5iIJ1SJr9xasUYSzoxouoe4fi7GJ9H1no
	Ceup0Rgp3a5Di1Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787644760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rMWaJJRYuPPY8Ps5wum1jNYqSkp8y1Vg3ryyqNdrmhQ=;
	b=tRDr5KNGjHavQ7NZk/b8jL4k/91wyJtO3iOcXkvdZvn9fRlRcDqKgQMVaz0twTShKA3WI/
	bkv6VDR3iE8ZV2W0KxxA5r6nIH7hKIat32xg3bd0RcN/M5bI7v1l8ZRriURvRw+oY5AqzG
	/w63KZ+5RMnOjBd80LKzURIxT0dt8gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787644760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rMWaJJRYuPPY8Ps5wum1jNYqSkp8y1Vg3ryyqNdrmhQ=;
	b=1aKU7Hgx2tA8yv/KXDLuO5QIgr0zQttp403GLXXrHPJzFLUaoO74S5geAwrJl9Rr/TUFCU
	TmzIFCCfFEszFDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0652513332;
	Tue, 25 Aug 2026 07:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B741AFhLjWrybwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 25 Aug 2026 07:59:20 +0000
Date: Tue, 25 Aug 2026 09:59:19 +0200
Message-ID: <87ik4ytyug.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: phucduc.bui@gmail.com
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	cassiogabrielcontato@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: i2sbus: Check IRQ before requesting it
In-Reply-To: <20260824100730.31601-1-phucduc.bui@gmail.com>
References: <20260824100730.31601-1-phucduc.bui@gmail.com>
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
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,perex.cz,suse.com,kernel.org,linux.dev,gmail.com,lists.ozlabs.org,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On Mon, 24 Aug 2026 12:07:30 +0200,
phucduc.bui@gmail.com wrote:
> 
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> irq_of_parse_and_map() returns 0 when parsing or mapping an IRQ fails.
> The return value was passed to request_irq() without checking for
> failure.
> 
> Check the return value before passing it to request_irq().
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Applied now.  Thanks.


Takashi

