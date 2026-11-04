Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082EC606D804
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+guEyix
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKgXP1bzRz2xSR;
	Thu, 05 Nov 2026 09:46:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793832373;
	cv=none; b=IJ+LLsI081flpiK+M05zUJNBsHfCQH04VpPySfALzD/f9aUpnOWcIjH8JQkKq3kPGl2BaTlncbxgt444UVtOvkrAX9GTyrUfT2VEFfp5+sfqULgMiRcR7YCsbwlzTeclgypJKuVbW18r4gznFOIDotf+dzyodHJjUtQLKEnHp70//o/BbgDIGG1NZG8hXfMg2R5pu3f1ogUI7eaaph4EePm2q5FudxWoLCg8ruPkvZlc6s1FS5y8DZLPJc02Dvwhg7Glx/Uj3LOG7UGHdTZsegFGzgMAVbf94xXJd+z1syfgijNByNj0pCmE815KaxVWghh56stOnpf9UBiOhFj5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793832373; c=relaxed/relaxed;
	bh=XBOw8umZc0PSygGL6ZhSsNEhyMPfzoczgqWFX+5YDNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqVnupfMEHDGwQ9fj9k6WdL36isKbNhHGZVbIwZpBvXisMY3jV23jvvmMZd8hy0dO3uu6nmdelMPAGCoe/M9k6VwzfxP4sel6GznFNHP8bUmZb5VF323zv5i0i9NMj1TPvS5o18YI8kGuYA24h1aq3YFWvR02eHxs2mU3B0x9HHKIE/QiaWVDAUgsigKkdcPYQBAA8cbpQudo/gmCmv+P3DHdzguSD9l9PEc9hDy2EToG+DKbDP99+vr/tE7wP3WNuQeyzE4G91pDPT3H3iRFAcYcLGKTXdA/aar1bS0SuuVQOn3yD8bvNmEJAfAgpulJTaQPBe/7or3tqbQmEVqhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+guEyix; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+guEyix;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKgXN3f65z2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 09:46:12 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E931605D5;
	Wed,  4 Nov 2026 22:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C1B1F000C1;
	Wed,  4 Nov 2026 22:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793832369;
	bh=XBOw8umZc0PSygGL6ZhSsNEhyMPfzoczgqWFX+5YDNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y+guEyixDVYqpS8g3d4FmlRYq/qp1tQeGL16K2BSxNthPOaRsDL0VFTK+tjHByNf5
	 UG3G3TR4IbDk5BaZwlgwVySr0HiRvL1WeYdDEujyS+zzG35LMJqu1Pm8BzfQ5Z+w4F
	 3DGZwBGiTOYlKSVRIgaBstWj6LtjUlnMrGUfTY6AgB7LPx3pVl/0nxTfWzl1eRWVeu
	 9SzZPPQ7yLUIbBzvzOD5olkzaVc7Od6fJQ93jvoDvEvbyLIezG28vK5PJuGqQJ/Zu+
	 C/TFnkMniWMHftytXgdebgJiyvQu099dnGFvQXlwnwRKY6VGKt0bkFzVDUexAPr+Sm
	 GvRbuyQmKti0Q==
Date: Wed, 4 Nov 2026 23:45:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
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
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
Message-ID: <20261104-allein-bepacken-hitzig-5e517d3c129f@brauner>
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner>
 <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
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
In-Reply-To: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 12:05:08PM -0800, Linus Torvalds wrote:
> On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2
> 
> Christian - way too many patches, re-sent much too often, cc'd to way
> too many people.
> 
> Nobody is going to read these repeated resends, and all you are doing
> is clogging up peoples mailboxes.

I resent once after I cleaned things up post RFC and I don't plan on
resending (one failed attempt due to my network dropping).

