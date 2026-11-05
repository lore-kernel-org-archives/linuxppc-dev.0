Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26136606D832
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 09:51:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKyJV3ZJfz2xLt;
	Thu, 05 Nov 2026 20:51:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793872314;
	cv=none; b=N2r3un/jxLy403c4+0+Dga1z4a55fESJAjSOp6LZ5Ei0KQ6WYQ4WFkwIpdvryNrP6mBev80ov+ozVFPMRx6ga1QBRFStjxBTKeroaBw5TqbyvcT/+ysT8HiteWKl1Tybd4GWxP8KYUzZr0tYjJZYvqsBxu9M1zLdh/P0bnYtD6DAFWVKanKqB69/5y2U13Ej87+TkX1O+AQ3u71QRt/KkvtI1GeCu8lTL87zHzNbZt1reoMFY8TIWDTO0rrR0r79GM/nhPbcAVvwvCzmJOVRmjf86mkiOshEHHVLMG6oKITJpczmoF8ClYPrq1oo99P1IsNhZG4x19KehyWLrGvQww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793872314; c=relaxed/relaxed;
	bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxwRXDk2/WnAz2HV9YU3CrQllc0zPq0fIlDTdiMtapy7WynoJM5fqejgNz5GJCiT9NPgKThzTS7Qf0lG2Jmp231yLk5yg1wajQFRirkU0meE1edYxB04MUmip5JPSy+u37oCZYu99JJJTuruGnYWElJaObmWelsatnYj1mp7yEU/RybbolAzYXhjCX5z9s23x2U1KhkxVwwI3UqWw/4XNKtXb0EYSnosEa+U02TOJ73/E6DDGWO3+NvcCDucBEMohI7hDnbq6FhcluFfLEDfEjTgPUgcNfG0Hilw3OWAg0JH/OpfdA3RZ7K3ghmQaoqyz4vYzxz7hFCziyTY9fA6zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.160.175; helo=mail-qt1-f175.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.160.175; helo=mail-qt1-f175.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKyJT45SWz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 20:51:52 +1100 (AEDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5365f9a04c5so23463021cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 01:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872309; x=1794477109;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
        b=y9H51MLu8COjpNImRpAcgFCrqKHQ+yTuWRwwIci28JxfarrhDzVhU91SEhFfNuf28k
         ZRaEm+QicnOZATDPULqEVzpzzbx68NaSw+ZObr50R0SJx6avB784zU19rOd4W9vNtE6G
         Sk8hu2T/VgnS8/4GRyJQWhk9YTmPAoXLToj3vmTnUxhmuH1w7POA2esoXcif9a5cmCPD
         QJFrJfePN8lGaXNYaSqHFLRvscc/nndkLykAY5GjtNKqxMLGNYGSsoL3rZ81Aw9S+Fae
         IZlzx3IjEujS9QRZv6cnr0ezNliT7oeZ03SdQdmXGZOe9kxFicJQrz/08VUJ36Z5lyoQ
         piwQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7Cnp1DgFcpmkY/QpBqxO604LZeyAHUx0whGQNI3RbqdO2krdMzpGL7oqoMXZk3ks/BFvUSv9WIOz9OiY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+yKOrEvMgJfc0NXXMhGowsQjZgI4GaNV/Aov7nMR773BWvA1Ws
	b/5Aw8kTUpnKFhyHkiLHqSR0HNsOYXBOZVjJUH62tTATgWHSxVoh9K069MbeT4tjfaY=
X-Gm-Gg: AYBFou3FUO5i3B0EKfp1knTZ7h14hrbIdficE/zqJkSo+BpfFOjBUZ4oefojF/6p+jn
	2QSnAYdBs5S1CfUH1L8imlbdn87uUmx91HjU3QI1pqnBji66lJGmtgfHzId2GPGsPPBZmlFhdUw
	AeGed9rLEuhRHHKVCHzm0kNSbU8QkGXgwNzrj7in21sy23fZd7nGaJ1Y63Sp+tZfy6racFAVj0I
	FL/suL3laGseZAC+f8Eb/bTTHLvGS7iUvZIuFD9deNc+dI3rKk3nM8MuSiIReCvHWvcKZKfsvqn
	T77kHHI615V0NFaW8D8OLdz+J/gQW2c8U2P9QHoElgqjKX6amuTMdrMbSU8qliC5ywc5c7PQL6J
	22R8ZcLsoVINjXKbUQxsFmpwdq8iW44nA12HM2zFHC6swuRLKiNnFgqiqg/iU7Q/Km01Nyadpnm
	9mPkxEqWTTBZNEMFxlXQarzoZk+whLEGtmL7FyIewf4jlco0nu9D3Vf80QKuPPy3dm18qPUGK/I
	zAWZjYBriWfCL1S1Aq87NTMJymL5TKxZmkAwdps4mjpbwYHoPC94MQMq4zTgberjptwhlrjalvz
	Rc5aTQHwJ2Gm56P/FXpl65gTtD/uyzHo2NRQL7YNC2MHX/mbAyILbRP2c0F65Wc05Q==
X-Received: by 2002:a05:622a:14cb:b0:531:164:fa73 with SMTP id d75a77b69052e-542b6d60bbemr322222301cf.32.1793872309274;
        Thu, 05 Nov 2026 01:51:49 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c4c4f3sm47936201cf.22.2026.11.05.01.51.49
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:51:49 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c7a0c1617so23262786d6.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 01:51:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByd3jCLYaKEEXB7tcWNhght/8Ge5O53kHzgcoI3igHK+FSZPYMXujC1jYhu2O0eA5PzABSBSIIWPwnjvLA=@lists.ozlabs.org
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
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
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they serve
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

