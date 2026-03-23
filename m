Return-Path: <linuxppc-dev+bounces-18619-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297C0EC01C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:29:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffTtD6Drrz2ySc;
	Mon, 23 Mar 2026 21:29:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774261748;
	cv=none; b=l91EHXz/DqMBtphJwN2BSPHX5VqwalgsqQ4gpamrq/R36nfebYwBrPrpQhxxWGSfCYkjhO+XW0xbKk3Htf/NTCuK01IS9YLpjrs/ru6i3pnij95nfm0k5AOQjaRJxMnR4hehitcn6XJPC0aPbc5CRG+EbwkKtO1AYrj5clP/V+j8UcrWN5NN/ujuPH078kXSjzWroWGbPw6cOJDB1zE3MIrQ171Rc0syHLxkimz4rowjmWZRPbhkQ1vuls59+fwGLxTfnihQoMRd6Xw5fL4b4FTpMnF7NtssshPkjjtWQoEUatDUh1HcivyOiW5T8saztc7nakReI7SyeMwM8Q1uWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774261748; c=relaxed/relaxed;
	bh=3Ab1W5iDfJ5ZhI+KleEyBGCm8hMtIT7U/8ivEBr2rmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4y1ixGieXFesJvpqwhUAwyeZHoMLaNddEBswqhPgKI02tfYIyKRBnGJ8cMrNI66HDWahYv9BihxE2UZQQIs1GqrHZf/Qnp5lW5pAmSyqscFWk0Oe70lZIN9Mtc28jlwGzStEmyiLrQfpKdh2xD/VgIdYtuwIuBfwETpDckifuUkp+pcVZciYqWsNQpHyf8x8b813n/xkqXC2NqFHiRVio1JSClsWqbJQr0GI3HJo0m8HgZnsyQ2xlIdcS688s3BxJ8DiMnp66LqyMEIx7aRLziHb/Q/d7HB0I3jDyiVUHClefFHomyXts2Heum/K23noF6GdkzbtxvX9lSVpThiGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=lpONrdMy; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FJJXGn4w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zKbNlz/j; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wBA7ZXfc; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=lpONrdMy;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FJJXGn4w;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zKbNlz/j;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wBA7ZXfc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffTtD0WrZz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 21:29:08 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 421645BDC8;
	Mon, 23 Mar 2026 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774261741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ab1W5iDfJ5ZhI+KleEyBGCm8hMtIT7U/8ivEBr2rmg=;
	b=lpONrdMyQqW/R8+PKsRCthVwMwzNBq0RFoEGUDoladnMqzPdKfhiuB5QEYRGHFXsoqZbvX
	t5UREbiTDzejJVl5hepGOtE14DerQXoIlpksctRWAKCjKAqhUlLRaCqZHyXpizWn727r89
	+ctnvO7HDGmHbMNoD3oDF7eDOd7iO1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774261741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ab1W5iDfJ5ZhI+KleEyBGCm8hMtIT7U/8ivEBr2rmg=;
	b=FJJXGn4wtBLaGaEBPArhMiYcy5645dhR2+Zssii/2y20lGOHIceoY1P+OJxsRJ7yCBEQX/
	MjrZpGILZ/Iv4YCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="zKbNlz/j";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wBA7ZXfc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774261740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ab1W5iDfJ5ZhI+KleEyBGCm8hMtIT7U/8ivEBr2rmg=;
	b=zKbNlz/jq0hoa1hKAraTGS755e9ZPFHqqoJEQKYHCNRzLU5h9CdZbMrBHvg88k9UJIIdkQ
	JFhEuWzEaNN1FR/575NeCdfGRQAQL26W3pQ2FgCtHKlGkyyQ8EZ/jsODANadEdrObJYZRq
	lAYt4//pu/HeGemwLk0iftltMfgEzuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774261740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ab1W5iDfJ5ZhI+KleEyBGCm8hMtIT7U/8ivEBr2rmg=;
	b=wBA7ZXfcM52/N2RW1VdFyUDx3NUsGkGwfXzalxvRw7P1fPmUrDin9nkJFhInK1OnZOTmov
	P2q8k7ZNlZUniuAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38D9B4381A;
	Mon, 23 Mar 2026 10:29:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bj7dDewVwWlaIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 10:29:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EDAD2A0B2E; Mon, 23 Mar 2026 11:28:59 +0100 (CET)
Date: Mon, 23 Mar 2026 11:28:59 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH 2/3] fs: pass on FTRUNCATE_* flags to do_truncate
Message-ID: <xyngoavkugrr3iib3se7pkd4h72tu6iwhmr37ro63qnytlr7s7@g6mspo2kgwzp>
References: <20260323070205.2939118-1-hch@lst.de>
 <20260323070205.2939118-3-hch@lst.de>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323070205.2939118-3-hch@lst.de>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,lst.de:email,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email,lst.de:email]
X-Rspamd-Queue-Id: 421645BDC8

On Mon 23-03-26 08:01:45, Christoph Hellwig wrote:
> Pass the flags one level down to replace the somewhat confusing small
> argument, and clean up do_truncate as a result.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/internal.h       |  2 +-
>  fs/open.c           | 22 ++++++++++------------
>  io_uring/truncate.c |  2 +-
>  3 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index 2663823e273a..52e4c354e7a4 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -198,7 +198,7 @@ extern struct open_how build_open_how(int flags, umode_t mode);
>  extern int build_open_flags(const struct open_how *how, struct open_flags *op);
>  struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
>  
> -int do_ftruncate(struct file *file, loff_t length, int small);
> +int do_ftruncate(struct file *file, loff_t length, unsigned int flags);
>  int chmod_common(const struct path *path, umode_t mode);
>  int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
>  		int flag);
> diff --git a/fs/open.c b/fs/open.c
> index 412d0d6fbaa7..181c1597e73c 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -161,23 +161,21 @@ COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length
>  }
>  #endif
>  
> -int do_ftruncate(struct file *file, loff_t length, int small)
> +int do_ftruncate(struct file *file, loff_t length, unsigned int flags)
>  {
> -	struct inode *inode;
> -	struct dentry *dentry;
> +	struct dentry *dentry = file->f_path.dentry;
> +	struct inode *inode = dentry->d_inode;
>  	int error;
>  
> -	/* explicitly opened as large or we are on 64-bit box */
> -	if (file->f_flags & O_LARGEFILE)
> -		small = 0;
> -
> -	dentry = file->f_path.dentry;
> -	inode = dentry->d_inode;
>  	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
>  		return -EINVAL;
>  
> -	/* Cannot ftruncate over 2^31 bytes without large file support */
> -	if (small && length > MAX_NON_LFS)
> +	/*
> +	 * Cannot ftruncate over 2^31 bytes without large file support, either
> +	 * through opening with O_LARGEFILE or by using ftruncate64().
> +	 */
> +	if (length > MAX_NON_LFS &&
> +	    !(file->f_flags & O_LARGEFILE) && !(flags & FTRUNCATE_LFS))
>  		return -EINVAL;
>  
>  	/* Check IS_APPEND on real upper inode */
> @@ -205,7 +203,7 @@ int ksys_ftruncate(unsigned int fd, loff_t length, unsigned int flags)
>  	if (fd_empty(f))
>  		return -EBADF;
>  
> -	return do_ftruncate(fd_file(f), length, !(flags & FTRUNCATE_LFS));
> +	return do_ftruncate(fd_file(f), length, flags);
>  }
>  
>  SYSCALL_DEFINE2(ftruncate, unsigned int, fd, off_t, length)
> diff --git a/io_uring/truncate.c b/io_uring/truncate.c
> index 487baf23b44e..c88d8bd8d20e 100644
> --- a/io_uring/truncate.c
> +++ b/io_uring/truncate.c
> @@ -41,7 +41,7 @@ int io_ftruncate(struct io_kiocb *req, unsigned int issue_flags)
>  
>  	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
>  
> -	ret = do_ftruncate(req->file, ft->len, 1);
> +	ret = do_ftruncate(req->file, ft->len, 0);
>  
>  	io_req_set_res(req, ret, 0);
>  	return IOU_COMPLETE;
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

