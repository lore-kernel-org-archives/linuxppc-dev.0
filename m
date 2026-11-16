Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB8606A331
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y1Ncqxja;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YE1dl6mj;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y1Ncqxja;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YE1dl6mj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSm0J5hQYz2yfS;
	Mon, 16 Nov 2026 22:31:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794828688;
	cv=none; b=QwsXNJcm+SNanbAdt51k5M8yr2X+CN11j9QhkmrMpSLaNbk9jsA9K/sfOgrwBHXvFFIDTlvv3pUicM10gxW9LbzYrao/jobEdr9lKY+gixphLVKxl25duoRTTh7uS2F0AHLa1owXe0gJpNobv3yNO0w75bytsvGLy9ylDRByXReemu62hBUuNJGzp6lgx1PB+xZDBFMUm+1/1T9oq3jh0/Lgfw7qARy5ggdA067C85SFZRN0hLhNmIbiH8sItIXEsfKlLKln2wv0sP+kYEUAQtj5SIlqtTxeBCfYYNNsj+gD5f0oJdXrxNzcHMdnJ/talfIRPcE0hB+bEnV2KAcWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794828688; c=relaxed/relaxed;
	bh=z0NfAU13XjWmlAo1rlpRgFlZWwAks7dSH1PU/xp7JUU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kz7MYAJ5B9bzRYzJaH+GWH7jtvGxUh870zk4Y+NTmrQNWvtq+EzSPcgupd2YhQnJpTksVNQ0HoPbjKfWdchZtQAru89L7mVlCGPeqSwk8N21HsS8EMHnhfZzCfr4ao/sfY0g6JAXbIVRJY9o1UZ8uhz5KCxxV6MCE+PZiPupXQR5Si0/GrPKIvw7W3E8teZLFewp/z85XQMKh1UtlEp8Ka5SvBt8v7kaQ6bdNGj2cu+JWaZNBBgZ7b4YK6AS5IdU3kJtvURH0hw8Q59hw1fkLyqymFjtZdyz27l4juz9+cxoGLtGqHti7BXilztQanqlhOTdfP47NtyTzCzZDMBLeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y1Ncqxja; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YE1dl6mj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y1Ncqxja; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YE1dl6mj; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y1Ncqxja;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YE1dl6mj;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y1Ncqxja;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YE1dl6mj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSm0H3T6Rz2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 22:31:27 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8848A1FD65;
	Mon, 16 Nov 2026 11:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794828683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0NfAU13XjWmlAo1rlpRgFlZWwAks7dSH1PU/xp7JUU=;
	b=y1NcqxjaiHBrCPuLMKR4v85WWVRxX9Hj/yKxKY4vTb3l+mgDjvgzQ5rTiSwuRqkIsS7J7H
	leBhRUxkUaCYKyUg+gGuomkTBPbuF66mifJHtD5CE5U5n0hack7kSgF+qTxHyMJBEeoTdh
	7xVyXSuyDkZuVKQtFQThiD0KAqhwa+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794828683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0NfAU13XjWmlAo1rlpRgFlZWwAks7dSH1PU/xp7JUU=;
	b=YE1dl6mjJa/IZnQUJpX4DFP1YnMgU7OintJKsYFXvL9zsGKyZhnzHZd4RHiPppckc1jk//
	xlc1dFt0B3PMh3CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y1Ncqxja;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YE1dl6mj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794828683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0NfAU13XjWmlAo1rlpRgFlZWwAks7dSH1PU/xp7JUU=;
	b=y1NcqxjaiHBrCPuLMKR4v85WWVRxX9Hj/yKxKY4vTb3l+mgDjvgzQ5rTiSwuRqkIsS7J7H
	leBhRUxkUaCYKyUg+gGuomkTBPbuF66mifJHtD5CE5U5n0hack7kSgF+qTxHyMJBEeoTdh
	7xVyXSuyDkZuVKQtFQThiD0KAqhwa+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794828683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0NfAU13XjWmlAo1rlpRgFlZWwAks7dSH1PU/xp7JUU=;
	b=YE1dl6mjJa/IZnQUJpX4DFP1YnMgU7OintJKsYFXvL9zsGKyZhnzHZd4RHiPppckc1jk//
	xlc1dFt0B3PMh3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3ACD813408;
	Mon, 16 Nov 2026 11:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wOvrBovp+mo/KgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 16 Nov 2026 11:31:23 +0000
Date: Mon, 16 Nov 2026 12:31:22 +0100
Message-ID: <87cxs5ypv9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Aibing Chen <chenaibing@cmss.chinamobile.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: size the codec reference property name buffer
In-Reply-To: <20261113103006.705-1-chenaibing@cmss.chinamobile.com>
References: <20261113103006.705-1-chenaibing@cmss.chinamobile.com>
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
X-Rspamd-Queue-Id: 8848A1FD65
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Spam-Score: -12.51
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 11:30:06 +0100,
Aibing Chen wrote:
> 
> check_codec() builds the device tree property name
> "platform-<codec>-codec-ref" in a 32 byte buffer with snprintf().
> A codec name may be up to MAX_CODEC_NAME_LEN - 1 (31) characters and
> the surrounding text adds 19 characters, so the full name can be 50
> characters plus the terminator.  Codec names longer than 12 characters
> are silently truncated, of_get_property() then looks up a property name
> that does not exist, and check_codec() fails the codec with "required
> property ... not present".
> 
> All codecs in the tree use shorter names today, but the buffer should
> match the documented maximum.  Size it from MAX_CODEC_NAME_LEN, which
> is already available through "../aoa.h".
> 
> Compiling with W=1 before this change reports:
> 
>   sound/aoa/fabrics/layout.c:780:36: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size 23 [-Wformat-truncation=]
> 
> Signed-off-by: Aibing Chen <chenaibing@cmss.chinamobile.com>

Is the string really truncated unexpectedly?

Otherwise it's just an incorrect compiler warning, and extending the
size doesn't make sense.


thanks,

Takashi

