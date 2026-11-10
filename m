Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75C560A3825
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MUVsr+ph;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zZopj+90;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MUVsr+ph;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zZopj+90
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP8Qm42s9z30V0;
	Wed, 11 Nov 2026 01:38:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794321504;
	cv=none; b=A2uZ7SpALYua4j2xEVCPX1bFXoviuTyzL2ah/kBJyWHvuJz7pOwgClnzAuwNveaf0zlmXvLKfaaGDGB8jxQJuNFWTrPOXZ5VcfpR72dulwHpBKyWmgkhjDmh7FIaiNzI+0Kys6eES/ALsEWyiEX1FtFi8gEQa5h1VB/kyI0KCEBvBGua+8NOtXR5toKuFHDxtMKVmOtMNfORCjkACRojdBh2JdWqNicAxhbT2J5WdDKI7uryRbAwLN4zbAw6nqcA0oNtDOensE8sLRI5FY++H/fkyEbJ4/vpWzQNhfA2KKn9/ZfSsoXFPjGxInldcxWz938FGo8Dwp8CZW4IgKYJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794321504; c=relaxed/relaxed;
	bh=Fh5qOtVM6KsLzFpIRsYYHC+bSYz/O+LnqFiFi3TOwW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlPAHUxks12qQ/r3HlBx+vxayMVYW9Lwx58OVLvBZmBkS0BYHkZEX66ZIuSpqeiVqc9w4r3XUD4Q3tS7tbo4hyz1VFK2buzHxCEIRWw4fzi4b784TigETr+ZK1JnnlqWkon3lfE0yaqZn00F/L0PlPyj/GKb6eHlh/7hJ3OybWS7DZ16CF288BkVeyd/ewhJwRkXKHzAgxGneZVyis8y+pnpOLymXwZWxJ98P96NRy/UivbU3Vm4ZrpZS2kJS/slXqgHb2TJ30loGrKKwrwtyu4lKAChVZ3xO6d0PfbpsPsXZFT2OzmXlsxaHWtuxaDRVtlYL++A9BxNKunCejKbxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MUVsr+ph; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zZopj+90; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MUVsr+ph; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zZopj+90; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MUVsr+ph;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zZopj+90;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MUVsr+ph;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zZopj+90;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP8Ql4gmMz2yCr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 01:38:23 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6600221E9C;
	Tue, 10 Nov 2026 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794321500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fh5qOtVM6KsLzFpIRsYYHC+bSYz/O+LnqFiFi3TOwW4=;
	b=MUVsr+phhfZbFW8xjR4b3N1UtGCeg+l0uYLOI5bLig6ZTedYwIElDXlSxhCLTjeiSHCd6k
	bg+NDUgRn4V4Cz63o4lwC/9gvtBeJXiSrYK+hYpxXqxLvSnhU0GeyZW39zoyzRQ0nyBJQY
	pyMpVSkOGDsd5a+gix4rvbt7CSWAcbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794321500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fh5qOtVM6KsLzFpIRsYYHC+bSYz/O+LnqFiFi3TOwW4=;
	b=zZopj+90aGJKBJGWq3ccQNKWjno338Dvu06+ctjiTjzqDLlDaVJHiPN7g0hSfMYZ4HR0wM
	fsnCVhe8MldfL9AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MUVsr+ph;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zZopj+90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794321500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fh5qOtVM6KsLzFpIRsYYHC+bSYz/O+LnqFiFi3TOwW4=;
	b=MUVsr+phhfZbFW8xjR4b3N1UtGCeg+l0uYLOI5bLig6ZTedYwIElDXlSxhCLTjeiSHCd6k
	bg+NDUgRn4V4Cz63o4lwC/9gvtBeJXiSrYK+hYpxXqxLvSnhU0GeyZW39zoyzRQ0nyBJQY
	pyMpVSkOGDsd5a+gix4rvbt7CSWAcbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794321500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fh5qOtVM6KsLzFpIRsYYHC+bSYz/O+LnqFiFi3TOwW4=;
	b=zZopj+90aGJKBJGWq3ccQNKWjno338Dvu06+ctjiTjzqDLlDaVJHiPN7g0hSfMYZ4HR0wM
	fsnCVhe8MldfL9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A3411339F;
	Tue, 10 Nov 2026 14:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w7B7OFss82qaLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Nov 2026 14:38:20 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 7F6FA22545; Tue, 10 Nov 2026 15:38:15 +0100 (CET)
Date: Tue, 10 Nov 2026 15:38:15 +0100
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
Subject: Re: [PATCH v2 34/51] proc: let proc_remove() remove the entry it was
 given
Message-ID: <gb7ibchjlghrlulokvwae7khr6w3uxutfbfq6kuvypmhiinha6@4557bv2sr4im>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
 <20261104-work-procfs-bugfixes-v2-34-bbf7d5546809@kernel.org>
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-34-bbf7d5546809@kernel.org>
X-Rspamd-Queue-Id: 6600221E9C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLpnapcpkwxdkc5mopt1ezhhna)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email]
X-Spam-Score: -11.51
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed 04-11-26 18:47:20, Christian Brauner wrote:
> proc_remove() looks the entry up by its name in its parent and removes
> whatever it finds there:
> 
>   remove_proc_subtree(de->name, de->parent);
> 
> If the entry was removed already, say along with its parent, that is
> either nothing or a different entry that got the same name in the
> meantime, and de->parent may well be gone. Two removals of the same
> entry are a bug in the caller, but going by the name turns it into
> removing an entry that belongs to somebody else.
> 
> Since commit 895b4c0c79b0 ("fs/proc: fix uaf in proc_readdir_de()")
> an entry that was unlinked has an empty rb node. So check for that
> under proc_subdir_lock and otherwise remove the entry itself, with the
> loop of remove_proc_subtree() moved into a helper both of them use.
> Nothing can help a caller that passes an entry that has been freed
> already.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: a8ca16ea7b0a ("proc: Supply a function to remove a proc entry by PDE")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/proc/generic.c | 78 ++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 51 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 588999058e66..9a0a2fcac7c7 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -818,33 +818,14 @@ void remove_proc_entry(const char *name, struct proc_dir_entry *parent)
>  }
>  EXPORT_SYMBOL(remove_proc_entry);
>  
> -int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
> +/*
> + * Remove @root, already erased from its parent, and everything below it.
> + * Called with proc_subdir_lock held for writing, returns with it dropped.
> + */
> +static int __remove_proc_subtree(struct proc_dir_entry *root)
>  {
> -	struct proc_dir_entry *root = NULL, *de, *next;
> -	const char *fn = name;
> -	unsigned int len;
> -
> -	write_lock(&proc_subdir_lock);
> -	if (__xlate_proc_name(name, &parent, &fn) != 0) {
> -		write_unlock(&proc_subdir_lock);
> -		return -ENOENT;
> -	}
> -	len = strlen(fn);
> +	struct proc_dir_entry *de = root, *next;
>  
> -	root = pde_subdir_find(parent, fn, len);
> -	if (!root) {
> -		write_unlock(&proc_subdir_lock);
> -		return -ENOENT;
> -	}
> -	if (unlikely(pde_is_permanent(root))) {
> -		write_unlock(&proc_subdir_lock);
> -		WARN(1, "removing permanent /proc entry '%s/%s'",
> -			root->parent->name, root->name);
> -		return -EINVAL;
> -	}
> -	pde_erase(root, parent);
> -
> -	de = root;
>  	while (1) {
>  		next = pde_subdir_first(de);
>  		if (next) {
> @@ -872,6 +853,34 @@ int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
>  	pde_put(root);
>  	return 0;
>  }
> +
> +int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
> +{
> +	struct proc_dir_entry *root = NULL;
> +	const char *fn = name;
> +	unsigned int len;
> +
> +	write_lock(&proc_subdir_lock);
> +	if (__xlate_proc_name(name, &parent, &fn) != 0) {
> +		write_unlock(&proc_subdir_lock);
> +		return -ENOENT;
> +	}
> +	len = strlen(fn);
> +
> +	root = pde_subdir_find(parent, fn, len);
> +	if (!root) {
> +		write_unlock(&proc_subdir_lock);
> +		return -ENOENT;
> +	}
> +	if (unlikely(pde_is_permanent(root))) {
> +		write_unlock(&proc_subdir_lock);
> +		WARN(1, "removing permanent /proc entry '%s/%s'",
> +			root->parent->name, root->name);
> +		return -EINVAL;
> +	}
> +	pde_erase(root, parent);
> +	return __remove_proc_subtree(root);
> +}
>  EXPORT_SYMBOL(remove_proc_subtree);
>  
>  void *proc_get_parent_data(const struct inode *inode)
> @@ -883,8 +892,23 @@ EXPORT_SYMBOL_GPL(proc_get_parent_data);
>  
>  void proc_remove(struct proc_dir_entry *de)
>  {
> -	if (de)
> -		remove_proc_subtree(de->name, de->parent);
> +	if (!de)
> +		return;
> +
> +	write_lock(&proc_subdir_lock);
> +	/* Removed already, maybe along with its parent. */
> +	if (RB_EMPTY_NODE(&de->subdir_node)) {
> +		write_unlock(&proc_subdir_lock);
> +		return;
> +	}
> +	if (unlikely(pde_is_permanent(de))) {
> +		write_unlock(&proc_subdir_lock);
> +		WARN(1, "removing permanent /proc entry '%s/%s'",
> +		     de->parent->name, de->name);
> +		return;
> +	}
> +	pde_erase(de, de->parent);
> +	__remove_proc_subtree(de);
>  }
>  EXPORT_SYMBOL(proc_remove);
>  
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

