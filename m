Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7487606D81B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zKdaPvru;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+uc+qZw3;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zKdaPvru;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+uc+qZw3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL1B134xhz2xqh;
	Thu, 05 Nov 2026 23:01:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793880089;
	cv=none; b=agwWNKDg+GaZaIGN3tlqAa6fnj/9AhRFxPrV8etKk0rB5Zs61nZz8/84Zc7vHrT24pEBcl1nyp2raabLBci8ywGaHbdhrYSD1OiMw145G7G5RKKgAnBdrWvYjFxiQxIYLrUW4gawpZkuHRhA7IKtHZC24mjuaa2Plyh2H8xD8M6jOzjp0zTvCvBiZvcSWGC9fSWNQZx0Su7F5ndPLldApLekj5GwK6947fHbu77r3vWXfZfD8k7XNI9OpCI6x4GfW9BX1HdEj9ECAw8jIfx5oTd3uRAZgb04Cg+W9pRpXCOoQCW5bmFvX3BT92wFxQnOx9HLWylZ2s6O/DPWuhMv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793880089; c=relaxed/relaxed;
	bh=ydEBthkRs6BZObliZ1gT2wAgcRxzGDvP2U6ol5rQ5PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/7RVYAZKhClJZca5KrWC3RaaWxu4y9Onq4Rs17TCG55xKwqzfo84Qrb9BduUetrHiewrRKFB/1OFj6u25GBsP+4zhVjw3Q3pxoLeTX2OrhIhXxYQRhMgFP9rD2lyPRUDMzT+wb6fHkcpw4QxWSCaBC5r9fnKalOz2ngrOBMgW9KjFXoNN36xDSLU+6hYpo+PL1U1Bx8FvIdYbtNkbTBl5hu/KA35u2eYUFgAL5FE1rQQoz5o+5ImHMIKXwkX2YkF1kUiaZUUAFt39gmPyWiW788fwpe0uxs6OolyLrp0p3O7To5ODIfU4HCq69kGY0lnuR5/qBLzRcQJBYltuyT+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zKdaPvru; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+uc+qZw3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zKdaPvru; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+uc+qZw3; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zKdaPvru;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+uc+qZw3;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zKdaPvru;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+uc+qZw3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL1B01Q9dz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 23:01:28 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BEBF1F458;
	Thu,  5 Nov 2026 12:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793880085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ydEBthkRs6BZObliZ1gT2wAgcRxzGDvP2U6ol5rQ5PQ=;
	b=zKdaPvrudlEHgyITmejXQi3+WEthu23zAhtaC4wlV1I+hXSgPiexsjmLFu1qh71WxuTvlT
	ARkMP8UQiajwFiw0ySWzxzHwRkZEWMAKyzObyadFrA67Wur7o+Z+UVM154e3cOB7CjiawI
	imrU8hYglnU+jCMNSZsIpEWx2uVUTS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793880085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ydEBthkRs6BZObliZ1gT2wAgcRxzGDvP2U6ol5rQ5PQ=;
	b=+uc+qZw3PRgs4loXkF5BQEEjgjHYTq/Pxk3lICcuGM1eGhyr0Lyzls8vFsrIzuyzyWfGJs
	aH9F2Y5/1DsdM5Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zKdaPvru;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+uc+qZw3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793880085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ydEBthkRs6BZObliZ1gT2wAgcRxzGDvP2U6ol5rQ5PQ=;
	b=zKdaPvrudlEHgyITmejXQi3+WEthu23zAhtaC4wlV1I+hXSgPiexsjmLFu1qh71WxuTvlT
	ARkMP8UQiajwFiw0ySWzxzHwRkZEWMAKyzObyadFrA67Wur7o+Z+UVM154e3cOB7CjiawI
	imrU8hYglnU+jCMNSZsIpEWx2uVUTS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793880085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ydEBthkRs6BZObliZ1gT2wAgcRxzGDvP2U6ol5rQ5PQ=;
	b=+uc+qZw3PRgs4loXkF5BQEEjgjHYTq/Pxk3lICcuGM1eGhyr0Lyzls8vFsrIzuyzyWfGJs
	aH9F2Y5/1DsdM5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A3B5134F6;
	Thu,  5 Nov 2026 12:01:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mtf0BxVw7GrtCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Nov 2026 12:01:25 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id DAC97B6CA; Thu, 05 Nov 2026 13:01:20 +0100 (CET)
Date: Thu, 5 Nov 2026 13:01:20 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
	Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Eric Dumazet <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados <joel.granados@kernel.org>, 
	Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	netdev@vger.kernel.org, ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
	coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, samba-technical@lists.samba.org, 
	sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, 
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH RFC 22/38] proc: warn about entries left in /proc/net of
 a dying namespace
Message-ID: <25dhmtf2n4u4d3ubwk3e3yjzpk7tb7ixo6fd37342zuscxlj2k@d3odfj43qazy>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-22-59422ed3e465@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-work-procfs-bugfixes-v1-22-59422ed3e465@kernel.org>
X-Spamd-Result: default: False [-11.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLpnapcpkwxdkc5mopt1ezhhna)];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -11.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 7BEBF1F458
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 02-11-26 15:21:37, Christian Brauner wrote:
> proc_net_ns_exit() runs after all the other pernet exits and frees
> net->proc_net right after removing "stat" from it. An entry that some
> pernet exit forgot to remove is left with a freed ->parent, and so
> PDE_NET() hands seq_open_net() and single_open_net() a freed struct net
> when the entry is opened through a file descriptor that someone kept.
> 
> There is no such entry in the tree that we know of, but nothing would
> tell us about one either. So warn about it like remove_proc_entry()
> does for a directory that isn't empty.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: e9720acd728a ("[NET]: Make /proc/net a symlink on /proc/self/net (v3)")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

OK, why not. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/proc/proc_net.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> index dbcf87a257e1..df5484813d5d 100644
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c
> @@ -410,7 +410,13 @@ static __net_init int proc_net_ns_init(struct net *net)
>  
>  static __net_exit void proc_net_ns_exit(struct net *net)
>  {
> +	struct proc_dir_entry *left;
> +
>  	remove_proc_entry("stat", net->proc_net);
> +	/* Whatever is left still points at net->proc_net and so at net. */
> +	left = rb_entry_safe(rb_first(&net->proc_net->subdir),
> +			     struct proc_dir_entry, subdir_node);
> +	WARN(left, "/proc/net: leaking at least '%s'\n", left->name);
>  	pde_free(net->proc_net);
>  }
>  
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

