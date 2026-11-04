Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE702606D816
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJoHVIVR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKZ5G1Fp3z2xf8;
	Thu, 05 Nov 2026 05:40:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793817650;
	cv=none; b=Ly24l0K9ScaxmVk12Y0j2XLfXNC/Xmx8kBQaWlvnuePXpBrdN8JOq99FEC5+QKwq3aRyRao7G5+OhUymAwWQy1n2fUJb/+5yDbMMBZM6CJai1R8ErTt4OSWF2kdaSpE++7cHGRF2qadsx6WgBp2NzhxV2xbT0EjXU2TM8k1V8+sipSLuZRwQNBZphEbVT2G34mInRTud54hximqr6vMNhNdqXf0eu2e5dqYOeimnxb9CW6df6RS2lGzcGB1qOl6l3o7JvEZyABSvrl1CigECexuqFT4/z8ULXcG5tEOzQI+uadzl72jumFddsDFhvC2mT8uJM+6y7ib+KHOEXZZS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793817650; c=relaxed/relaxed;
	bh=QZrg0qNWaXbTo0/xGfjrSEZ0b4f34qk5jOb+FqN16uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctxCJcugsF+wGjkRGDrZpLo6Sq+Dk4sMO2oTt5zzA0fU37qYOvXuBBX8rDBqai9zeW9i2E13kUYlPC2avNOzU0eRmZhZOypzFgBWfX1vlc8hiT55jmJKQ8xFa5S07lG0wRL5EonIJ0cV+Sojqe6FBAsmHenFWETw19n5rycidmwcMvXHtPcxfMqZOqVOEAYQ4aTKLr9xRIim3V4Cags8YHmWJ4ru8gE4e+YIde6pwMVl3ZlHfebV6p+Ncv0VsyCnBYcJR7z/wRPShTgIouhTUkDFFZ0xuiD89HzUQ6KSiViCGCI74M0asabifAmkzWslwrlaHYg3vnGs25Fvhfxt1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJoHVIVR; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJoHVIVR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKZ5F3HtVz2xRv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 05:40:49 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E54560AA6;
	Wed,  4 Nov 2026 18:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B5D1F0093A;
	Wed,  4 Nov 2026 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793817647;
	bh=QZrg0qNWaXbTo0/xGfjrSEZ0b4f34qk5jOb+FqN16uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kJoHVIVRMDhMBnXEsnAe5u7zpLjzd7+MCZ16TzVPzknEMkH+SygeGbLr1cB1EuFHJ
	 xRsFziB7AYKd6Mhhpn+XaIqvh4Cx6oR0IF5YD5hTWVK9qdGzZGqDtB09vA04e4GNIh
	 gmvf+qmzc//ytZnlzvHO/6/uft/CaHdB0hsuAjqYwVhLfB3Ks7yJAR1O6zCQCoILM7
	 7FSNmR//3JsJPL/FoNc85lYWK2E4ao7D0Q2RNB19ZXpttBP2DbzKEnPZ+uDd2qb6Jz
	 UP+h4VZmlPCoaJVRtTyuBLxhzxSpg0j7ZPL1vwlCOQ73t7T4+hY/7Q5mBk/u31yY6C
	 vajKYZo3usCaQ==
Date: Wed, 4 Nov 2026 19:40:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
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
	Chuck Lever <chuck.lever@oracle.com>, Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, 
	linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org
Subject: Re: [PATCH v2 00/51] proc: fix a few old bugs in /proc handlers
 (Part 1/7)
Message-ID: <20261104-zermalmen-pechschwarz-hafen-b8a1cb79bac4@brauner>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Please ignore this. Network dropped halfway through and the umbrella
went out under a broken message-id and so this doesn't reference the
actual complete series.

I'll resend.

-- 

