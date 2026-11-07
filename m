Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D87606EEBF
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iW02CE60
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMB860R1Mz2xLf;
	Sat, 07 Nov 2026 20:48:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794044933;
	cv=none; b=nHHxn8jMb/6avLYTKr42uaN7ZLegYJNmS0Hv1qayzicgPki7LGjMBsgol6/fTr49Knrs27beSaJuJBIqYWDVSfZERLNkGF5kuryHnu3LNcehjB7DXZAXBk8gKtilB4UAqB4Ubwwi2nGevDZOBY2JwudQfGEO0I3+Yf/HeC7WHKXCuJDueJsjrYY3rB6FqeCKLilFWHjHwgcyoiTVckAcTg6S62IqUzl+DS2vixJcUJDPRILPZHIfbandwgfwoOVeuxqqOrIDUXYm0WnlGcuBFJ8Pvj3gu/KLlZqTj4Pje4eqHfHRLuPEGms1kwqoZWwmpLK+z10+I8d9z6lDgkMp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794044933; c=relaxed/relaxed;
	bh=rorNI1UIic/55wFWIBl0e+Ri75FN+PnMt9WvbEXwkRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQyOeTmRxUsg38mw0uM1OJWXZHyxH7DMnicvM0F6STYOz82nWETuJV/pLyvckzOgNpIpsvZAmRfTsDaP1briz9VZJUp4IWhrRnDQ27kpI93fWCP8mZQW5Hm19jjV1gFkmE8VLuCnrMC6KeuZPiNTVQjCLdmmCEUQvfPp15i9VOk7dfXzzxpv/6PUGFXCT1CmcRIroG99Rhp4rrzh4XuxulTMfdC0g6RjteCrnoutwkCQjF4ds2GQFgml6mTVuzAg25HzuGP6DqjEozuXr2NMq0LihbUkjNFXEwsf91UU5fN4D2p4BhZdDdVSHRPSW08L9Q8HVPKIcznwUlH2hhgvHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iW02CE60; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iW02CE60;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMB85030rz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 20:48:52 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B777605DC;
	Sat,  7 Nov 2026 09:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328FB1F0089F;
	Sat,  7 Nov 2026 09:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794044929;
	bh=rorNI1UIic/55wFWIBl0e+Ri75FN+PnMt9WvbEXwkRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iW02CE60RHF02fEuqPqKcJf6i4V3KTjWDHzo9DZbo95gORtH0ZrmCJDxrNOCnD4Id
	 9WnOBlB++VD4fZIWQsCzrQhJIry0nbljvHblYH3quGITH2PJSiPvwUzFopDT7DZDt2
	 EHHmNwDws2w9I0dTG1wwVA0PVma1a6Hmr9kUmUnaP/d8oN+oH0kQjwhxNPRQPPwlA4
	 xw0Rt/uXRWnSdUas9IyJY6YU5S7A3WpR700rHxBipZTWxfOwImozcBkuV3AdARVDwJ
	 t+x6t7k7LiUG553yMU1QgCJYHr0hUKV7+ybnwND/Tl+BQydELSVgjRpI3YK5OOLnj3
	 agc3DJMfrldDA==
Date: Sat, 7 Nov 2026 10:48:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 11:07:32AM +0100, Geert Uytterhoeven wrote:
> > +       ssize_t (*proc_write_buf)(struct file *, char *, size_t, loff_t *);
> 
> "const char *"?

I prototyped this to have a detailed reply. It's not worth it.

* The buffer is the entry's private copy.
  procfs creates the copy for this specific call and frees it
  afterwards.

  A bunch of handlers modify the buffer in place and it's documented as
  allowed:

  - afs_proc_cells_write()
  - afs_proc_sysname_write
  - a chunk of the sunrpc cache channel ->cache_parse() implementations
  - thinkpad_acpi's ->write() methods
  - SCSI devinfo file
  - dyndbg
  - cio_ignore
  - the pseries ofdt parsers
  - two more hand the buffer to a char * interface:
    - the SCSI host ->write_info()
    - simple_strtoul() in proc_scsi_write()
  - four strip a trailing newline in place

All ways to make that work suck.

(1) Copy in the handler. That means eight kmemdup_nul()s and a
    kvmemdup() for every nfs downcall.
    IOW the copy this series just removed comes back as a copy of a
    copy which is not acceptable.

(2) Make the parsers work on spans which also sucks and doesn't solve
    all of them.

(3) Leave the buffer writable. Costs nothing, nobody else can see it.

So (3) I think char * stays.

> While at it, I think it would be good to use this conversion as an
> opportunity to replace "char *" by "void *", which will probably let
> you drop several casts from users.

So I tried that too. The thing is it drops exactly one u8 * cast in
ntfs3's label write. And to get this done we need to introduce a whole
range of local char *foo = arg assignments. So I decided against this.
It just doesn't add value.

Thanks for taking a look!

