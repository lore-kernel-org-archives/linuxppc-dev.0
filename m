Return-Path: <linuxppc-dev+bounces-17897-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BD3F3C24C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 13:13:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTy9v232Sz309P;
	Tue, 10 Mar 2026 00:13:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773061987;
	cv=none; b=Aooa5UsX/caTOKaQoQq63QTxnzr2wFfpS1kvNx+XB9YCo+O11pkBvTyaQiTOS8Ij+3iFndhzdBos3deZ7kjOga4EPrqcAcYhnXqAG+7Zc5dQiuc0RpecnyrkRrwscCnr1Y5iVDYzmrWzzsc81CaySNzV1S3dFuGPc3XLFJ8/42odI8iUGyaY2iqyc1VVpuuZcdPkq/ps7g8BYbU9TUMmRdH3WqbwPPHw78zNN4FgveJkitHrKuFRkItQHUgQOQrcY8zYtMIqvTAqUE55fsPytQEgz0jDIXkIeQAt143AmmczS/7rk8qAAmMTKoVYl17GPrS4htLA/4Xd2njxrmzhPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773061987; c=relaxed/relaxed;
	bh=p/mpyUcRZQKYxJsqsX7qmzCtlxE5JWQH7vYuTxoKxpA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vca0vvVGiujMX4+UJs+nTLt1pRLmtLHCmGZN8Xb3xbjBIu5Q/EtfIQcfx1AC1zhjOmyWYd+4MGuW5kCowUy2H8PFBrNQAjU4+ale1a1XiVuV7M3S1K3VzIgQyuHQYHBXTNNAcnRc1j1Ru14VlhRpkzbJocdxcJc5QBhz2CkHCEy1GKpcd+eQVf6OxVcSg5Sn9TUveAf4yEek2qhMKeoOB/t1hgS4B/nuzKR6LVsW4DD6ZZZbVfI0zdRyQrewq/Ddff+4iKcvFWdFVGgMkYUCFxdtqYSePORAx7dTz9G4evsAKCp8ZcCIUZpgTfvjtJMxdJVjKSpy56NfqG7eTSW9fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTy9t1hmmz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 00:13:06 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E68B5BD8F;
	Mon,  9 Mar 2026 13:12:59 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44AC73EEFA;
	Mon,  9 Mar 2026 13:12:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MoN8D1vHrmm9dgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Mar 2026 13:12:59 +0000
Date: Mon, 09 Mar 2026 14:12:58 +0100
Message-ID: <87o6kxm9id.wl-tiwai@suse.de>
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
Subject: Re: [PATCH] ALSA: aoa: Handle empty codec list in i2sbus_pcm_prepare()
In-Reply-To: <CFB7A246-8C9D-4F49-8143-2883030C1135@linux.dev>
References: <20260309114159.765304-3-thorsten.blum@linux.dev>
	<87zf4hmcw4.wl-tiwai@suse.de>
	<CFB7A246-8C9D-4F49-8143-2883030C1135@linux.dev>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 8E68B5BD8F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon, 09 Mar 2026 13:55:02 +0100,
Thorsten Blum wrote:
> 
> On 9. Mar 2026, at 12:59, Takashi Iwai wrote:
> > On Mon, 09 Mar 2026 12:41:59 +0100, Thorsten Blum wrote:
> >> Replace two list_for_each_entry() loops with list_first_entry_or_null()
> >> in i2sbus_pcm_prepare().
> > 
> > Hmm, I guess both can be simply list_first_entry(), as the codec list
> > in this code path is guaranteed to be non-empty (it's called after
> > i2sbus_pcm_open() which has the check of the valid codecs).
> 
> That guarantee only holds for open/prepare, not for i2sbus_resume() via
> i2sbus_pcm_prepare_both(). It's probably uncommon in practice, but
> i2sbus_pcm_prepare() should still handle it safely.

Then we should fix i2sbus_resume() instead.  It can simply bail out
when the codec list empty.  Ditto for i2bus_suspend().

> >> Handle an empty codec list explicitly by returning -ENODEV, which avoids
> >> using uninitialized 'bi.sysclock_factor' in the 32-bit code path.
> > 
> > Which 32bit code path are you referring to...?
> 
> The SNDRV_PCM_FORMAT_S32_BE/SNDRV_PCM_FORMAT_U32_BE branch.

The description is confusing :)  It's about 32bit PCM *format*, not
about 32bit code path.


thanks,

Takashi

