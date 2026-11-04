Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FF606A32F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QF98rpjB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKKY80y7qz2x9c;
	Wed, 04 Nov 2026 20:15:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793783740;
	cv=none; b=Az25MKWoviqMieCpe8KAnyE3bFb/VTtzCP13HzmC0Qy0l5qIUV9hspeSW9md2opWWODVIbK/9Pnlcxp0w+5loTN9wDP62Sd/kruOfRqAUhLT7l8bExNGklWluW2hX0cj4vbRLCtmQ23ffdjMH6UzSlFrEZB4i2lRU3GAIWsOYu/dpLXcqbvDgGbbtYqST81bdoB6J+8tCZKPp/Yb8/N6pJgRrZV+W4YN+4hrTo8UJ8n2OWQr/3PzFDHArfDxLK3SX142HjOyVcVkgxdseXSGcDtUhOpGskfNPVlOb495RduElXmDPRjnAJqQY800XGcpEqiElZc+BPjTHZUDfM6VmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793783740; c=relaxed/relaxed;
	bh=tun3DxnivT6n8ykyvHDle1jgjloMyn9wMMyaVwUBJtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHqQWSzHscZkP6qPSlMRr3I9HjmMIyUx+ojP1ty7l9WpHZg8gpu0Hb4nE4G4SGD2DWDWe+JA5hJvfvLM0Gwt7RDKDJVISLz4xx4DG+zhh5UlF4CHqHDh4iVSMHDbt4ZOOcKy4ns3kcSTuliqB4eGUjjWF2JNQOZpNnHCGnV1KZoAhq2BXx4jV0+TZF4NpXrmOomT7INuUDkKjZctxKufkxvbL1mk9wNtsfyMr1pb50ib2/xd2DMgDpVQoPKAEWdFCIGv2ZUMwxr5SoSQt/7UsLsAbJV3aTMBz7Mn7mB/XghaOL1gYU7ndmt3ZAEq57SCIVX7XKhfDa5qkiPj3bMQiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QF98rpjB; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QF98rpjB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKKY674yVz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 20:15:38 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A35A0602BE;
	Wed,  4 Nov 2026 09:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786C51F000C1;
	Wed,  4 Nov 2026 09:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793783735;
	bh=tun3DxnivT6n8ykyvHDle1jgjloMyn9wMMyaVwUBJtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QF98rpjBzH7nX1jmz4Zo8ykeu0WPbxz0HGt6XxCXrOQ4V4PB3P/wbn5sluIzZ3bgP
	 woOpkCVq06Ek6V7bKkHEP2phdvrGGARxXAl1OBE0IhgkRUa/IQ935AFbXxh1YUY5bJ
	 utfjbIjp7LtybAhtZNGHqFcIoDw2mhpfxaUaUe5IHuBCvHt5tgYAPu/YfrtEAf4jWd
	 v5zbJS1rE1Hby/io2vM2SNwmccLVR3w7pjdFYCtf7rR4Wu4skeBeZ5GH0Q1ajKmHHR
	 yetiYqpJqieJOdcKUSYdWCjNW5p22mqd+bHsoVYbOTO4y8Ft2ybe6f5kRc5h/hiSzc
	 /PiiXfUYZ7Gcw==
Date: Wed, 4 Nov 2026 10:15:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Florian Westphal <fw@strlen.de>
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
	Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH RFC 03/38] netfilter: xt_recent: don't remove the proc
 entries under a spinlock
Message-ID: <20261104-entgangen-nettigkeiten-intuitiv-f39521735261@brauner>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-3-59422ed3e465@kernel.org>
 <auig_zhd3L0HEis3@strlen.de>
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
In-Reply-To: <auig_zhd3L0HEis3@strlen.de>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 03:41:03PM +0100, Florian Westphal wrote:
> Yes, but note that this change is already part of a pending nf -> net
> merge request.

Dropped.

