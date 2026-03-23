Return-Path: <linuxppc-dev+bounces-18620-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828E1EC01C5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:31:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffTwZ16FPz2ySc;
	Mon, 23 Mar 2026 21:31:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774261870;
	cv=none; b=m/laLHrstxaDy5DOusNZNtIFZ+RfpeYYIr0femDJZuf74Vk0PqksDOkSk+BTR/3CAx96woSARSflsE8ek5QajiLJa+MOGZKidlJt/CCzmqIIL1NPBmvvZBLcdlLp1cO9o9XlFZ9oa5K7cigdELXGj3guw3pNagRrIvzowYgddPOruadj+6zPDvGR8buGwhP4v29+uTQfrNJbgstvIVdggsJDKjaVkVu4NVKwBmTy7DZmkZPXTbA+z/2iOXncSSxG/YyXDRdGxhV3FCuvpIE8x6XS7u4wvZcWGQGbVvbC6eRVg32lHTwsV1XJCUxR4RPegEyAfcJp/UbQ9OdIbD4mQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774261870; c=relaxed/relaxed;
	bh=TWnmeTBWsnuBRyqHM3IEo7BcmdfaeD508UOpxwkLPTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct9+vcVcCkzb9ny3FrUOfwYyxtg5QqCJBt4eCXNIISXu/sH56ktIfQw1TvkhDK7jwEFDQJyPMR000T6Y/NSKRNq5G+xYhEKqP808b9NxORbm071Ystsd59QqAcHbcqeOzuQevLdWRtyPe+eOGTOvMFHK8MhEFphKD8wumE7UiW63Q7Rq7xGgQUV1rAbBegXOXJ2mT5tjo6pPtz0rhjoGLyBZ9OfJtemYi5X+dx5bnKvzwWQEdp+q+Xxr8zJDAyEx2NljiAVxeJQJ1x7ZW3ET8VBbKoO6lzCvnNo/g6UZCw74vHuKbwGSCC3ZK2B8OGeAeT1tD5MYeVZGO4IWAiTcrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
X-Greylist: delayed 123 seconds by postgrey-1.37 at boromir; Mon, 23 Mar 2026 21:31:08 AEDT
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffTwX6n1Tz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 21:31:08 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F8845BDB4;
	Mon, 23 Mar 2026 10:31:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65C044381A;
	Mon, 23 Mar 2026 10:31:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j7rTGGoWwWnAIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 10:31:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2EBF2A0B2E; Mon, 23 Mar 2026 11:31:06 +0100 (CET)
Date: Mon, 23 Mar 2026 11:31:06 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH 3/3] fs: remove do_sys_truncate
Message-ID: <yggi6tpu3uptzwe4an55ufkqgrrxkhu6e3sftlmgmny74c5w2m@4hapz3ee6kqv>
References: <20260323070205.2939118-1-hch@lst.de>
 <20260323070205.2939118-4-hch@lst.de>
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
In-Reply-To: <20260323070205.2939118-4-hch@lst.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 6F8845BDB4
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon 23-03-26 08:01:46, Christoph Hellwig wrote:
> do_sys_truncate ist only used to implement ksys_truncate and the native
> truncate syscalls.  Merge do_sys_truncate into ksys_truncate and return
> int from it as it only returns 0 or negative errnos.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/open.c                | 8 ++++----
>  include/linux/syscalls.h | 8 +-------
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 181c1597e73c..681d405bc61e 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -126,7 +126,7 @@ int vfs_truncate(const struct path *path, loff_t length)
>  }
>  EXPORT_SYMBOL_GPL(vfs_truncate);
>  
> -int do_sys_truncate(const char __user *pathname, loff_t length)
> +int ksys_truncate(const char __user *pathname, loff_t length)
>  {
>  	unsigned int lookup_flags = LOOKUP_FOLLOW;
>  	struct path path;
> @@ -151,13 +151,13 @@ int do_sys_truncate(const char __user *pathname, loff_t length)
>  
>  SYSCALL_DEFINE2(truncate, const char __user *, path, long, length)
>  {
> -	return do_sys_truncate(path, length);
> +	return ksys_truncate(path, length);
>  }
>  
>  #ifdef CONFIG_COMPAT
>  COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length)
>  {
> -	return do_sys_truncate(path, length);
> +	return ksys_truncate(path, length);
>  }
>  #endif
>  
> @@ -222,7 +222,7 @@ COMPAT_SYSCALL_DEFINE2(ftruncate, unsigned int, fd, compat_off_t, length)
>  #if BITS_PER_LONG == 32
>  SYSCALL_DEFINE2(truncate64, const char __user *, path, loff_t, length)
>  {
> -	return do_sys_truncate(path, length);
> +	return ksys_truncate(path, length);
>  }
>  
>  SYSCALL_DEFINE2(ftruncate64, unsigned int, fd, loff_t, length)
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 8787b3511c86..f5639d5ac331 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1285,13 +1285,7 @@ static inline long ksys_lchown(const char __user *filename, uid_t user,
>  
>  #define FTRUNCATE_LFS	(1u << 0)	/* allow truncating > 32-bit */
>  int ksys_ftruncate(unsigned int fd, loff_t length, unsigned int flags);
> -
> -int do_sys_truncate(const char __user *pathname, loff_t length);
> -
> -static inline long ksys_truncate(const char __user *pathname, loff_t length)
> -{
> -	return do_sys_truncate(pathname, length);
> -}
> +int ksys_truncate(const char __user *pathname, loff_t length);
>  
>  static inline unsigned int ksys_personality(unsigned int personality)
>  {
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

