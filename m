Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA9606A333
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkGIp68v
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKKbZ2Zxgz2xK7;
	Wed, 04 Nov 2026 20:17:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793783866;
	cv=none; b=LRl8mYhnpZYAiUTUnLplOf/s9sRoh94YlW/u+XOpczyHt9pVA3YZPECwqOaptEKkKY3xBr/LayTINrQ8vNIszsSdDZhkg4tpO/HfEUuFALGwLwR+DvGzMbrxvOd8r3WiWjpil85+cDlEvXTUux9dGtoV+YJF/zrMYRB+cKQyxwdONswK0tYL4LZgUIQzb3ThiDoCrHY/ZCIrEApbTIsQb3o5lAl6K3DOOUW7vxN2M96ndqsuUl6deJiOHjUvLsD8QjKkNx3BHSijS2NmlkJfUpIHvtRjE5Q9DR8jOJxsKidBv5OqBn5nZsOL4IJZxd8aSAXPst2yOXLmVACXtS/QlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793783866; c=relaxed/relaxed;
	bh=vFLCfIpQzvj87maXuJncKjZMHxfbMjkVEErOwSrEMzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0Fq+qW2bFELL05TZkEBiG4PmPn6Y8VEgdqNqIH/lTns9RWHjwiM02Z/4biWd6dST3dMNhutqWkuIMaIfbh2F4dCVsHwV/j+9BjcTmO0AgQQy+BeoJ7YBWsNZO2f95qTReJl5LOxC8rdK5rZmvY/AWfBuuaSG5f6P5ngTLjNNsx47GZR9egnpdhk49SCs5GZ4pMu1y/Ix/8fVP80aFifow/oS48FS4IHNyiRpkfbVwMwSTv5g4qzmg3jHzlWxbVkTq5zEg2HKtHUK3tUSZOR3m3UDqh9oA5Cf7V1Dq06iCS/WEjInxMaflucfMl8iGzpySXaeNSYNzrFOoaNvjcuwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkGIp68v; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkGIp68v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKKbY3Mmpz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 20:17:45 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 33B61600CB;
	Wed,  4 Nov 2026 09:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9461A1F000C1;
	Wed,  4 Nov 2026 09:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793783862;
	bh=vFLCfIpQzvj87maXuJncKjZMHxfbMjkVEErOwSrEMzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AkGIp68vobiZwB2XixXdCJHgtF8bS2InhigVuwsdqp6n5/W+M82eXJQmgMDIXncGQ
	 ZsgLev6upKoTph4wRGMw/6Rt8tdd4yiEe0QTNTPemQ626tgZDkM1GcZGQlIINcGmX1
	 rweyg/M+elK322suBIlSSUF7Ca/phJp24NGzpraEYkCKjrptZL+chTq0rR5ps9q2f2
	 buSjg3t9Zzbjt9a55NJ2t3tMIsF7dtK6fdeAh04poa02hll2Rco50kbc8I+oEfsxAS
	 NzUPxVvIxDSaOzz7ERaAm3QpoNHvfOUNEKEQothQH0rTaYd4IAl0SGRh52pJdJDENe
	 eaiECSjcPGAaQ==
Date: Wed, 4 Nov 2026 10:17:28 +0100
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
	Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of
 config space accesses
Message-ID: <20261104-beugt-kapern-geehrt-19e2e2dd58f6@brauner>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
 <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
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
In-Reply-To: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 09:58:51AM -0800, Linus Torvalds wrote:
> I think this would actually be better with rw_verify_area() just
> checking a per-file maxbytes.
>
> We already have that logic for lseek and friends - using that fairly
> hacky combination of s_maxbytes and !unsigned_offsets().
>
> We should combine s_maxbytes and unsigned_offsets() at file open time
> into f_maxbytes and check that not just at lseek but in
> rw_verify_area.
>
> And then things like proc_bus_pci could set it's size limit in one single place.

Yeah, I like that.

Hm, maybe we should keep this and the isapnp thing small and do that
change on top.

This also might mean a change in behavior. Because a read past the end
returns 0 for proc_bus_pci and for a regular file past s_maxbytes. So
that would potentially need some more changes.

