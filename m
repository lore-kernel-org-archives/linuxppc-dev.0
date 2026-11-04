Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB98606A335
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDU8EuhU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKZ4H322Fz2xf8;
	Thu, 05 Nov 2026 05:39:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793817599;
	cv=none; b=QepILsCwCYv7pUjKET5wp8fQxxNYbiaFZprKGeNIp7X4CDGScZJb01v6Ox5vQK02L/b4cNipGnc+mdyv9fMOKV5Qksrj99uMVNEOSSVUUwWZ60x0X+inNu/TJcIJgq86mOtYVsO3IbR2uVLGD+7szEpQ0RgTUazQECLtAOoTd5vVv5iDZ6n6nY8VutRz6VXKXdvm60Wi/SJH8lOFi5nXNjuXZPJFtQN5XygD5TPktcCSq+/77tt3iz5Z9Ev285BEXeeOxe3xyKWbP133GY+2soXyedKf+S8K1qBocjtJsh73J679a/7Rvja9+wz48H0w/rEqtnVFg6hL39q1YfC54w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793817599; c=relaxed/relaxed;
	bh=cfX+RSDf63q8RdYOSefxL9B17eZvLgT/fF9r72R8ItM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+refudFEuBzG/6Es5wFmku7w70AHNenwTx2YauZYoAd378D95gIunbGvpSkPsrnlqTfWRYLh0LkvQ/S7asug0uxZl1ZI8u2JhMnNv+kmwfZnnSuUfVADjU4M30qbzwoYySd2DVOtaXcsf8quJ21W0eqwNzf69q59o8/3vDPH/3jJjk0/ZCO2p0m/8KoCFcVHBD/gWClE5UEBbbfKekTlTAC9CDz5jTN42UK+kEap/Kg7YPTPbdPOrQEKaNUJG/Cx2tuVbjRlp22ruDuRMIGp0eckQZNSFqF6cU6/UUxc7LghkW2OrGwePOSYaO4O9Jq35j+e/Fbx/moyrLN4hIhHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDU8EuhU; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDU8EuhU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKZ4G4ZGFz2xRv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 05:39:58 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9485D60A87;
	Wed,  4 Nov 2026 18:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D94A1F000C1;
	Wed,  4 Nov 2026 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793817595;
	bh=cfX+RSDf63q8RdYOSefxL9B17eZvLgT/fF9r72R8ItM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GDU8EuhUF/10B5PY7Ge41gK5xPnjrcLHs7feXWHlvH4fq+/JLsc6ePLzmMcenBTV8
	 F8DU2mNIqG7yMOIN0gPqiAwJM3jV9nVVVUEYkA/ePBSooGTee00ROqhKBnF1Bqim3H
	 1MIVC6ndCg4IYSs9ehay5xqAR6tGspnn8txoZnqUV3a/rwlemC2StvUcjU4rBzRdDh
	 smT5Fi28DptI2/GHQw2s7uG8id08IW1enmMV0ZcuUo2Xf6u9ciNae6b4/FwizkvKf5
	 0O5jZIOLbbQIYlYObNdALqLNo9VEtQX1aZ+lQxJHqEn6uUf5MjI2wjNp8uWWy07SZL
	 e+KRVPYe7/Ndw==
Date: Wed, 4 Nov 2026 19:39:40 +0100
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
Subject: Re: [PATCH v2 0/7] proc: move procfs to what kernfs does
Message-ID: <20261104-angriff-abgewandelt-ohnehin-e5ba30d31576@brauner>
References: <20261104-trompete-gejagt-raddampfer-9fb5640a6102@brauner>
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
In-Reply-To: <20261104-trompete-gejagt-raddampfer-9fb5640a6102@brauner>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Please ignore this. Network dropped halfway through and the umbrella
went out under a broken message-id.

I'll resend it all correctly.

-- 

