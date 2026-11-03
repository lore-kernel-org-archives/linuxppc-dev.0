Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C526606A812
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 10:41:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJlVW2k3Rz2xK7;
	Tue, 03 Nov 2026 21:41:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793702483;
	cv=none; b=UjhRIdaLJSlDUTUpg+auwC6vZcH6+QgOxuwLzCOEZlYMaAd5AbZKLnWhEBDo+mY594uiHoj6tJC05TmdrCFQ+BObXL2WEx3zfkZ/mkVcu1t4dRv24I0TyP/lXVVdFsXeANrCu/pIQTiQHSsjNsdPPk/ra2JfGCTak2uU3zZEIZT7utgdQPUvShonlsLDz/ZK1OWgDUtS5szrIFXdlCorREaX7tH0DVLP6INhwPkn1tQCJYTK/KRadlYhaD9Y6U00KfUgNt6AwXHYhza05EO67+ZAVMn6UV3350rSjrsQWj6Dw1N26znRxz6vL3H0KfnrxvwTHQ89spJwN3KE67cUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793702483; c=relaxed/relaxed;
	bh=n3928gBIWqHxVcE0Q0TQTSHKUQ5+JmJrD1oVco54lEw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDB5mVRCagay/jkSiYjl309OLs8KwbgA5S4NtnldIIZo1IMs/3DacyqUrciXnZYqClhQZR2Fv/w4daCWHrESn2E65dSS20pnNcJV7pOGIap0b0TreH4FEP7FBTVV6dX7dgl6tpSCpaWcKaZ1pZSZfFLz2GbyslrD3rySx9eLoHNPhYZVwkkKAjsbrxjbGf+10FehtJpgraLN22ppYFwOluNIDLSoXXPP36mMdAYfbLZ02aw+Z+LFTIZj+go8g5daN7Czu2a9TDl5/DxjW6ItS/fb5U30yV9fq49CwI+6UsdyIRIhwCMfI3eyBPpeLmkLwrEruWHYHvgEeL6A0Xrj5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJlVV3cktz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 21:41:22 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8017122D12;
	Tue,  3 Nov 2026 10:41:18 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A98D41350A;
	Tue,  3 Nov 2026 10:41:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fPJkIE266WqxEgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 03 Nov 2026 10:41:17 +0000
Date: Tue, 03 Nov 2026 11:41:09 +0100
Message-ID: <87ik2exkmy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Eric Dumazet <edumazet@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jan Kara <jack@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	ntfs3@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	coreteam@netfilter.org,
	kexec@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	ibm-acpi-devel@lists.sourceforge.net,
	jfs-discussion@lists.sourceforge.net,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sh@vger.kernel.org,
	linux-usb@vger.kernel.org,
	samba-technical@lists.samba.org,
	sparclinux@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-doc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	Takashi Iwai <tiwai@suse.de>,
	linux-input@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	Chuck Lever <cel@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH RFC 09/38] ALSA: info: don't write past the end of a data entry
In-Reply-To: <20261102-work-procfs-bugfixes-v1-9-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
	<20261102-work-procfs-bugfixes-v1-9-59422ed3e465@kernel.org>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 8017122D12
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 15:21:24 +0100,
Christian Brauner wrote:
> 
> snd_info_entry_write() clamps the count to what is left of the entry
> by computing entry->size - pos as a size_t. For a position past the end
> that wraps and the write goes to the driver unclamped, for opl4 into
> sample memory outside of what the entry covers. At the end of the entry
> the driver gets a count of 0 and vmalloc(0) warns. Before the clamp
> moved into the common code the driver ignored such writes. Fail them
> with -ENOSPC instead, like a block device does at the end of the
> device. Returning 0 would make writers that use stdio retry forever.
> 
> Fixes: d97e1b78239c ("ALSA: info - Check file position validity in common layer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

> ---
>  sound/core/info.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/core/info.c b/sound/core/info.c
> index c4d57d0809ad..982087bc8575 100644
> --- a/sound/core/info.c
> +++ b/sound/core/info.c
> @@ -171,6 +171,8 @@ static ssize_t snd_info_entry_write(struct file *file, const char __user *buffer
>  	pos = *offset;
>  	if (!valid_pos(pos, count))
>  		return -EIO;
> +	if (pos >= entry->size)
> +		return count ? -ENOSPC : 0;
>  	if (count > 0) {
>  		size_t maxsize = entry->size - pos;
>  		count = min(count, maxsize);
> 
> -- 
> 2.53.0
> 

