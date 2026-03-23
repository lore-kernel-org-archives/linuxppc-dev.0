Return-Path: <linuxppc-dev+bounces-18618-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A188EC01C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:27:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffTr025y3z2ySc;
	Mon, 23 Mar 2026 21:27:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774261632;
	cv=none; b=RdFPx7DHfnmXSa/Z6K+qAuLZbut5Ejzmq0u8G35zg5hGpf0ZwDfuY0tc2Qa+ffbCbmkWEZdPAoZX0qHxrhblG2zeGMIb5qUtPgb+wQazESq/r8JLHZN8Qou/bgc0B4Nk9OpJR28goO/nol8SuwYuF26skzfa/fiqTM42EQLHY7Wnf/ZRRYGw9QPQbtulLN8iep8y62DcOMxIiE58YdBGeeXdQL5VaIA69WF8IAIYC67+WbsClmS60nEegb76+zyW5KOYRF6Zkh0rkapwKvMVLiJLU/FR/9GHfqaW35zPSFJcKbNGKwfVRZAdzoUezFrrwwLtEO34vJv7eZFFZK+Xlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774261632; c=relaxed/relaxed;
	bh=Qds2uJ32pRLlQJWAzNsHGeIq2mrVMscPUZYgB/FLRhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMtmL8G/FVxVEj7CKk+BslCO521/VaMVCKf/xIYqN+ZO1ZExT1Hrx/V1mzua9QDK3oeqAB87+VyFYEBa5KD6t4W7ftL/IbUe0lhvzRTA8H0y3Iqc8OWpu0pZMGcrtZqaJ/sig5c0HtrhqkJ5zVyomRX1xWMAm+iXp1DHLf8WJXyOjhfghPEIUBxHKRoWiV+s6CTlkoP3uV7w1Ol/9T/BYMmxB8BKVQRAJbFmxv38vKB62nyWiZEA36jWgQ96Z1pf0mmxyc2fHnDPwzqoKKpH/9wObULHp5ztxr2yEz5H8dulZNLss/DssFOIoh04wVn8ON2/6pRhZMqV0ABy8CXLsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=trinx4GO; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6/90Tqg4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=trinx4GO; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6/90Tqg4; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=trinx4GO;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6/90Tqg4;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=trinx4GO;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6/90Tqg4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffTqy2bZLz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 21:27:09 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9257D4D2BA;
	Mon, 23 Mar 2026 10:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774261626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qds2uJ32pRLlQJWAzNsHGeIq2mrVMscPUZYgB/FLRhk=;
	b=trinx4GO6i5sN4372NxLM4qCkPoaMj3kHn/Hhmz4fVIp58zBTue1ljOfnzf6S2A+7CCD68
	1T+FZ6lbU0b7dsTPRkvLONny46JsvVyg/lVzj5kkijn710li1mJzPVn+DcZoeKfj6nEzKC
	+6VVDk++EusnvpSCFBb1BRJ+kp24xf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774261626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qds2uJ32pRLlQJWAzNsHGeIq2mrVMscPUZYgB/FLRhk=;
	b=6/90Tqg4lLELhwZvxNqHMe1fk8jlJRaVsgM+Rn7IbjqqBHkGNsAps03gV0Pf2NYZDHl+6Q
	gMPbBd9+VSEtksCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774261626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qds2uJ32pRLlQJWAzNsHGeIq2mrVMscPUZYgB/FLRhk=;
	b=trinx4GO6i5sN4372NxLM4qCkPoaMj3kHn/Hhmz4fVIp58zBTue1ljOfnzf6S2A+7CCD68
	1T+FZ6lbU0b7dsTPRkvLONny46JsvVyg/lVzj5kkijn710li1mJzPVn+DcZoeKfj6nEzKC
	+6VVDk++EusnvpSCFBb1BRJ+kp24xf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774261626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qds2uJ32pRLlQJWAzNsHGeIq2mrVMscPUZYgB/FLRhk=;
	b=6/90Tqg4lLELhwZvxNqHMe1fk8jlJRaVsgM+Rn7IbjqqBHkGNsAps03gV0Pf2NYZDHl+6Q
	gMPbBd9+VSEtksCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8508F43819;
	Mon, 23 Mar 2026 10:27:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pt12IHoVwWlGHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 10:27:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4A3E5A0B2E; Mon, 23 Mar 2026 11:27:06 +0100 (CET)
Date: Mon, 23 Mar 2026 11:27:06 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: fix archiecture-specific compat_ftruncate64
Message-ID: <47ovbvveajcppkfgjc3sqbfzuozmvyivz32fbvwoq444lny6eg@45awkyuwcmrx>
References: <20260323070205.2939118-1-hch@lst.de>
 <20260323070205.2939118-2-hch@lst.de>
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
In-Reply-To: <20260323070205.2939118-2-hch@lst.de>
X-Spamd-Result: default: False [-7.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,lst.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Mon 23-03-26 08:01:44, Christoph Hellwig wrote:
> The "small" argument to do_sys_ftruncate indicates if > 32-bit size
> should be reject, but all the arch-specific compat ftruncate64
> implementations get this wrong.  Merge do_sys_ftruncate and
> ksys_ftruncate, replace the integer as boolean small flag with a
> descriptive one about LFS semantics, and use it correctly in the
> architecture-specific ftruncate64 implementations.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 3dd681d944f6 ("arm64: 32-bit (compat) applications support")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  arch/arm64/kernel/sys32.c       |  2 +-
>  arch/mips/kernel/linux32.c      |  2 +-
>  arch/parisc/kernel/sys_parisc.c |  4 ++--
>  arch/powerpc/kernel/sys_ppc32.c |  2 +-
>  arch/sparc/kernel/sys_sparc32.c |  2 +-
>  arch/x86/kernel/sys_ia32.c      |  3 ++-
>  fs/internal.h                   |  1 -
>  fs/open.c                       | 12 ++++++------
>  include/linux/syscalls.h        |  8 ++------
>  9 files changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
> index 96bcfb907443..12a948f3a504 100644
> --- a/arch/arm64/kernel/sys32.c
> +++ b/arch/arm64/kernel/sys32.c
> @@ -89,7 +89,7 @@ COMPAT_SYSCALL_DEFINE4(aarch32_truncate64, const char __user *, pathname,
>  COMPAT_SYSCALL_DEFINE4(aarch32_ftruncate64, unsigned int, fd, u32, __pad,
>  		       arg_u32p(length))
>  {
> -	return ksys_ftruncate(fd, arg_u64(length));
> +	return ksys_ftruncate(fd, arg_u64(length), FTRUNCATE_LFS);
>  }
>  
>  COMPAT_SYSCALL_DEFINE5(aarch32_readahead, int, fd, u32, __pad,
> diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
> index a0c0a7a654e9..fe9a787db569 100644
> --- a/arch/mips/kernel/linux32.c
> +++ b/arch/mips/kernel/linux32.c
> @@ -60,7 +60,7 @@ SYSCALL_DEFINE4(32_truncate64, const char __user *, path,
>  SYSCALL_DEFINE4(32_ftruncate64, unsigned long, fd, unsigned long, __dummy,
>  	unsigned long, a2, unsigned long, a3)
>  {
> -	return ksys_ftruncate(fd, merge_64(a2, a3));
> +	return ksys_ftruncate(fd, merge_64(a2, a3), FTRUNCATE_LFS);
>  }
>  
>  SYSCALL_DEFINE5(32_llseek, unsigned int, fd, unsigned int, offset_high,
> diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
> index b2cdbb8a12b1..fcb0d8069139 100644
> --- a/arch/parisc/kernel/sys_parisc.c
> +++ b/arch/parisc/kernel/sys_parisc.c
> @@ -216,7 +216,7 @@ asmlinkage long parisc_truncate64(const char __user * path,
>  asmlinkage long parisc_ftruncate64(unsigned int fd,
>  					unsigned int high, unsigned int low)
>  {
> -	return ksys_ftruncate(fd, (long)high << 32 | low);
> +	return ksys_ftruncate(fd, (long)high << 32 | low, FTRUNCATE_LFS);
>  }
>  
>  /* stubs for the benefit of the syscall_table since truncate64 and truncate 
> @@ -227,7 +227,7 @@ asmlinkage long sys_truncate64(const char __user * path, unsigned long length)
>  }
>  asmlinkage long sys_ftruncate64(unsigned int fd, unsigned long length)
>  {
> -	return ksys_ftruncate(fd, length);
> +	return ksys_ftruncate(fd, length, FTRUNCATE_LFS);
>  }
>  asmlinkage long sys_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg)
>  {
> diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
> index d451a8229223..03fa487f2614 100644
> --- a/arch/powerpc/kernel/sys_ppc32.c
> +++ b/arch/powerpc/kernel/sys_ppc32.c
> @@ -101,7 +101,7 @@ PPC32_SYSCALL_DEFINE4(ppc_ftruncate64,
>  		       unsigned int, fd, u32, reg4,
>  		       unsigned long, len1, unsigned long, len2)
>  {
> -	return ksys_ftruncate(fd, merge_64(len1, len2));
> +	return ksys_ftruncate(fd, merge_64(len1, len2), FTRUNCATE_LFS);
>  }
>  
>  PPC32_SYSCALL_DEFINE6(ppc32_fadvise64,
> diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
> index f84a02ab6bf9..04432b82b9e3 100644
> --- a/arch/sparc/kernel/sys_sparc32.c
> +++ b/arch/sparc/kernel/sys_sparc32.c
> @@ -58,7 +58,7 @@ COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, path, u32, high, u32, lo
>  
>  COMPAT_SYSCALL_DEFINE3(ftruncate64, unsigned int, fd, u32, high, u32, low)
>  {
> -	return ksys_ftruncate(fd, ((u64)high << 32) | low);
> +	return ksys_ftruncate(fd, ((u64)high << 32) | low, FTRUNCATE_LFS);
>  }
>  
>  static int cp_compat_stat64(struct kstat *stat,
> diff --git a/arch/x86/kernel/sys_ia32.c b/arch/x86/kernel/sys_ia32.c
> index 6cf65397d225..610a1c2f4519 100644
> --- a/arch/x86/kernel/sys_ia32.c
> +++ b/arch/x86/kernel/sys_ia32.c
> @@ -61,7 +61,8 @@ SYSCALL_DEFINE3(ia32_truncate64, const char __user *, filename,
>  SYSCALL_DEFINE3(ia32_ftruncate64, unsigned int, fd,
>  		unsigned long, offset_low, unsigned long, offset_high)
>  {
> -	return ksys_ftruncate(fd, ((loff_t) offset_high << 32) | offset_low);
> +	return ksys_ftruncate(fd, ((loff_t) offset_high << 32) | offset_low,
> +			FTRUNCATE_LFS);
>  }
>  
>  /* warning: next two assume little endian */
> diff --git a/fs/internal.h b/fs/internal.h
> index cbc384a1aa09..2663823e273a 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -199,7 +199,6 @@ extern int build_open_flags(const struct open_how *how, struct open_flags *op);
>  struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
>  
>  int do_ftruncate(struct file *file, loff_t length, int small);
> -int do_sys_ftruncate(unsigned int fd, loff_t length, int small);
>  int chmod_common(const struct path *path, umode_t mode);
>  int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
>  		int flag);
> diff --git a/fs/open.c b/fs/open.c
> index 91f1139591ab..412d0d6fbaa7 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -197,7 +197,7 @@ int do_ftruncate(struct file *file, loff_t length, int small)
>  				   ATTR_MTIME | ATTR_CTIME, file);
>  }
>  
> -int do_sys_ftruncate(unsigned int fd, loff_t length, int small)
> +int ksys_ftruncate(unsigned int fd, loff_t length, unsigned int flags)
>  {
>  	if (length < 0)
>  		return -EINVAL;
> @@ -205,18 +205,18 @@ int do_sys_ftruncate(unsigned int fd, loff_t length, int small)
>  	if (fd_empty(f))
>  		return -EBADF;
>  
> -	return do_ftruncate(fd_file(f), length, small);
> +	return do_ftruncate(fd_file(f), length, !(flags & FTRUNCATE_LFS));
>  }
>  
>  SYSCALL_DEFINE2(ftruncate, unsigned int, fd, off_t, length)
>  {
> -	return do_sys_ftruncate(fd, length, 1);
> +	return ksys_ftruncate(fd, length, 0);
>  }
>  
>  #ifdef CONFIG_COMPAT
>  COMPAT_SYSCALL_DEFINE2(ftruncate, unsigned int, fd, compat_off_t, length)
>  {
> -	return do_sys_ftruncate(fd, length, 1);
> +	return ksys_ftruncate(fd, length, 0);
>  }
>  #endif
>  
> @@ -229,7 +229,7 @@ SYSCALL_DEFINE2(truncate64, const char __user *, path, loff_t, length)
>  
>  SYSCALL_DEFINE2(ftruncate64, unsigned int, fd, loff_t, length)
>  {
> -	return do_sys_ftruncate(fd, length, 0);
> +	return ksys_ftruncate(fd, length, FTRUNCATE_LFS);
>  }
>  #endif /* BITS_PER_LONG == 32 */
>  
> @@ -245,7 +245,7 @@ COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, pathname,
>  COMPAT_SYSCALL_DEFINE3(ftruncate64, unsigned int, fd,
>  		       compat_arg_u64_dual(length))
>  {
> -	return ksys_ftruncate(fd, compat_arg_u64_glue(length));
> +	return ksys_ftruncate(fd, compat_arg_u64_glue(length), FTRUNCATE_LFS);
>  }
>  #endif
>  
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 02bd6ddb6278..8787b3511c86 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1283,12 +1283,8 @@ static inline long ksys_lchown(const char __user *filename, uid_t user,
>  			     AT_SYMLINK_NOFOLLOW);
>  }
>  
> -int do_sys_ftruncate(unsigned int fd, loff_t length, int small);
> -
> -static inline long ksys_ftruncate(unsigned int fd, loff_t length)
> -{
> -	return do_sys_ftruncate(fd, length, 1);
> -}
> +#define FTRUNCATE_LFS	(1u << 0)	/* allow truncating > 32-bit */
> +int ksys_ftruncate(unsigned int fd, loff_t length, unsigned int flags);
>  
>  int do_sys_truncate(const char __user *pathname, loff_t length);
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

