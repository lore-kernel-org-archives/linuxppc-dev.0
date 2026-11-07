Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBEC606A335
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8yIPgkH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMMPr5rwCz2y2K;
	Sun, 08 Nov 2026 03:46:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794069984;
	cv=none; b=Ypldv2n6+OPF6M7IMfiG1Nn0lJf60tAQaMzXTzMMxRFyfnzATXDq8Vf+IuCZzznjkPAvCrlE6cbAdsdACMj2HDO3FaHDWxTuksobFM3CEWw7cAn+idFjWt/A8BuPWLoskAuu+7sbC53Nh/BJysmJdyCvfVPf6c5TAEV8VQCF92ww0TZxi6AR4xQqFZ91BjbPeG194VLba1JnkoaOYRgqpI9NsPCMjL4ucvRzy9hx9mNwNbA+8L/oiOjTdx3ncA3HFEqKBd4BBoFkPOCZdJMvJzBud5Jds/c6vrvWXyPZuhDyCYMcrLPNaSWemJcVs1ncSBDW3w+tqaCMrZGa6noN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794069984; c=relaxed/relaxed;
	bh=iQPFcguwJfJnGIUghj3vW2cnp0ZTKsyoI6OiYKG+trA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TZSNvutIIFD353Sk3ylOVy4YuKy4xm38OhkztZHVV+w7aKnl4jkUrtPOsstkWyD4zEeZToHDkzz1MJOTOpkP0/Ht3bI7BTyZ/LPrnBz+KBCSklPhfL4I8uvx2D8kxzkuOyaz6RoE4M5uziOCKrX4M/10O2/hp80oqIfI4MoCcXhPvDZKWAykPgHObtOmp+Y4vm0P+qjzQjwDJRQax9QkzcqStrfKUxM6loO5FwsmlSdN5n67nKM393kckREvvp1RY3fdkrrdTEqJgenABVwt8vr7i5D6AsvQQRfiTyqiGKmmqG96zivVHZYFCHjAKQYpQLMSTM0jga6tq0o+sxoKQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8yIPgkH; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8yIPgkH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMMPq6dL2z2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 03:46:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 78A9C60D42;
	Sat,  7 Nov 2026 16:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4077E1F008A4;
	Sat,  7 Nov 2026 16:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794069981;
	bh=iQPFcguwJfJnGIUghj3vW2cnp0ZTKsyoI6OiYKG+trA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=d8yIPgkH6TUg6Xjvbp1GuMQux6u0MKmdQeb4+5MYqtqzGdrQplV1hB5nlNkFOfe/o
	 mdxyrTpo1AD8LJsdAfk7umrK2hjD5YezaKqdvRiYIxS+Tg2D99O2Pgab5PkMJ4yb/C
	 GlBx58XhbCsnzSHi10Moxtb96yir5u5wjc/UwdATnAKDoR1yJEtZSdsMDDJDQ8JwUA
	 iyV8cBKr3nKRA33dw/sG4GB5ZwB3xl9BSDy4MTE5rJJxANBHJ3jeYeuHYDVxrfonN1
	 4kkeVnQ5duc0cwReYUWCg8CsEFjHDE4/lXrtneIvM6UcQvi4e3En8m5uB+d9ztvg2X
	 Oj0H+4HupSpIw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8E1DEF40067;
	Sat,  7 Nov 2026 11:46:19 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 07 Nov 2026 11:46:19 -0500
X-ME-Sender: <xms:21Xvams7wVEmHspjWmbwhLpib2xNIptoVYE-80X8WqZqZcb1XPT-CA>
    <xme:21XvamRC29Zg9ykNiW0vwrANU0AC0j8D3WACLizfxgWZ2OLmopVNcj-qyZCZTBqLn
    FnUPDv24PUXWdCZGoMgnY4GISxXuJoqj_FJTWVyN8AgQyPiOZVj9Iah>
X-ME-Proxy-Cause: dmFkZTEtlYS0+TY9rHJo1vCDNDBgG/0TlQu1ZgAaexztyT5e7mSb39t8Qfa0vTeatlfpwP
    5ATotugI+S69Aq5UXpsB8wdUtjDvDqFpA717Gwij4u69sZUh6KSv9WWk6Jq//TgMNLfNVi
    Uz7LSIH08qzFkhYYh9/35LIN1zJWwwarlCDU1iQg4wt21opJj09VkTQ37+xtOv284TX8B8
    yl81LC5xmVZyo6A9GjLU5A0F5I2dYlaICl6rU5kYsMelZGpwWY/AOYhI+JMNgaonKgFQaK
    ku+gQcY5aJl2LKRp0R1zioHZwwCKpV/Rgf4D5rEiKrG8xxXM/BULju0eld0dqqIZyyKUfJ
    GW19ru42mbqsCpPSyXWqDBJxl5bN5OUlD62byk006CGbw520QKU/yBNHckj8/a7Aw/pswE
    cEiGWvUnIlIDfqqhyBtbUxKdieVFtOg/Nh7ULYvIP/0NmKpXY6WcXU9anidEQ88SbIQjDc
    p8Yn7T3r8Bo4iwmbKTgS1vVIcIOOKv75MyWqZv/+HCroxzEXbbFU7dyYNipmhzrf5va650
    CqAuf2hfcDqsbABPPTHxkCEDCl/Z7jZw9/P1SXCFxyI0OJaeowmrBr44zHzsSCW7ueEBOE
    v4mcadw/NREalORTbhxI6N8vjS1sruRGJ2ATEo0TnxHIE3AAjUR+ONXu5PSg
X-ME-Proxy: <xmx:21XvanTCUxiRZL_4tn_RpzN8CzyhB8rLiSKq-UOIyotAbmuEjI7sGA>
    <xmx:21XvaurCk3dCumlVKotKWDf68V8MDwwzlx-dEeK7pWGM9HqcR4oZkQ>
    <xmx:21XvavRZiOL5frHmdBkAVeJ6cjpU89f7VYn1Ikw-RN984COqc-2ICA>
    <xmx:21XvaoJKJLPj7VOMrYps6zuTHuKL8ZgDDK4Gr4RreYxXio5VOww0yA>
    <xmx:21Xvag3Tq78e8w_19g2SFkvau64M8X7d5PUoh2FKftcFG01vhemSEsb1>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5E62D782738; Sat,  7 Nov 2026 11:46:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
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
X-ThreadId: AjxZksNfZZQV
Date: Sat, 07 Nov 2026 11:45:59 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jann Horn" <jannh@google.com>, "Josef Bacik" <josef@toxicpanda.com>,
 "Chris Mason" <mason@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jonathan Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>,
 "Greg Kroah-Hartman" <gregkh@suse.de>,
 "Joel Granados" <joel.granados@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-s390@vger.kernel.org,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org,
 "Linuxppc Dev" <linuxppc-dev@lists.ozlabs.org>, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org,
 coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org,
 linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 "Takashi Iwai" <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org
Message-Id: <a1e2d05f-08c6-41ac-a8f9-6985ee00dc97@app.fastmail.com>
In-Reply-To: <20261104-work-procfs-net-v2-10-221e2437fed1@kernel.org>
References: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
 <20261104-work-procfs-net-v2-10-221e2437fed1@kernel.org>
Subject: Re: [PATCH RESEND v2 10/13] SUNRPC: let procfs own the wait queue of the
 procfs channel files
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Wed, Nov 4, 2026, at 4:13 PM, Christian Brauner wrote:
> cache_poll() sleeps the poller on queue_wait, which went back to being
> a static queue so that a poll() on a procfs channel file can't be left
> on the queue of a cache_detail that its network namespace freed. procfs
> owns the queue poll() uses now and it outlives the file, so the procfs
> channel files leave the poll_wait() to procfs and an upcall wakes their
> pollers through proc_poll_notify(). The channel entry is remembered in
> the cache_detail for that and forgotten before the entries are removed.
> The rpc_pipefs files keep sleeping on queue_wait, procfs has nothing to
> do with them.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

