Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E93606A33F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 09:34:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKxwm0zW9z2xLt;
	Thu, 05 Nov 2026 20:34:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793871288;
	cv=none; b=G7ZTuFovAsPO4A+hjWwZBzNd6CN39EZJLAC4U2qrB5GVcd4oko14MxJHlVrr/ssItQ6eJa/ZQitk2m1KxZnvZEPM1NAl2XC1lUmdEaKM85OyZ8Vy/4KgUo3AO34aRSt3JoS5vvVVtUGqjchMITMUMlg6+DSR+22G4dVBWgvATO6Bglb6aT09v2HFctytrTX4fazWRbhjp/SFtcwpHDCKYw2boarX0OG+sTtvKSktFU/fSvoRUDKeFMHk+nH7+P0aHC1JxyZeCNFUf2xjkI4fxF0pRysBDDxAqDT4F1us4AmtXauHNpYyCqZK5mzSA3ckOsH5LAIVRGB5miC1BTZfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793871288; c=relaxed/relaxed;
	bh=DpLYJIWgXoS5zQrloj/RgE/cGCpS34NjW3pzuN6S6xY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djb2H2D8AnoeniNNxi8aseVu0FvbB2+6AU3QFZXnp1SgkK0yjueHT+31y/vfToEJXL86W5Sj5TVICJ8oNfFn/zT1CVNpr9rIi5mt/7j+xeh03cEYgUGPqL1V/VesL72rO2oBjY99LCZAQA4BvLKg/HcjuoRyUgcDv3oJ+e/DiKS09o9/J8TiYlrLZleiQ9X9M8snW78sAfMWwYsI6txKwTWhaxJOOO16KDCMBrMa3qxTlTaoACOlrgkiQT9itDbgIeYqW6kV7WFLFYyPUyF/ZzbUk9Shq8UeYeJLEzTiMhNz9mtv3UU9ht93maKQHZqPp9jl8S73Kmv/1CTrl+xvRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.222.52; helo=mail-ua1-f52.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.222.52; helo=mail-ua1-f52.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKxwl0XyXz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 20:34:46 +1100 (AEDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-99806b7d89aso451618241.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 01:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793871283; x=1794476083;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DpLYJIWgXoS5zQrloj/RgE/cGCpS34NjW3pzuN6S6xY=;
        b=YErG+e2SFEJbSHezTsAUeRI3sXkXE88WJirsPABhkMsYHQg2EX5ffbxvrNCrfYSza0
         bawPH5DwauGuOQWooPKDWkUQwJ3ztiyo6O2F2/00dQY3GLTAubjR+YA44hejBMtEKDiT
         5B4bJsPx302JzbA+nv/X/9U4TKgUDoEi+v+bUMqpSxiI75JfyNjyY+TK7NMRdJe4y8tV
         9Wz0GwM4mj1BtncSVDmsr43XX1bz22kjoljFd6eOhdBJE8pNRDGhyDVzxXWBs0D5/sEF
         661sVxy6hqByE9zZyx8tOZsIOpXTyBHroL88ZGKTgHmSsRXI4ikLFjyphbplZk0zeOjA
         l/2A==
X-Forwarded-Encrypted: i=1; AKwUvBwSqcZ+c4Ew0dPAkhixn+5XUHtqjd5w9yT7bB/7oH9ol0z48eUZX6u1V1YzLfzw6rIgda18sbf7L4pl8zA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8rQxHPhLTLK0KKH0gxPkgRGm4N5kGi2lcBlbvhvfZ65RmHEZ7E
	4nfiCWd0YC3+hB+r1vi/GKWUS3TcD4nZqmU1ZC4y6GFLAzInxfrYSfEyJY32UR8+JlE=
X-Gm-Gg: AYBFou3gc+Xyfp2QhWs11j12wbSdrJWQJlzc90HToSc/uR/4TG+0dpcjnvqVcb64kz1
	fFlpnKFzvu6XW5iXVnAJhbKAiXn10W1Cn4OJzr6Axc8bP+0sRihJsoPhSuRIQd55fMSV9pjtjTZ
	u6Dks0/x57YAGfYGyOF4my8JPHhwhfE2Z/p1+W94pzIQXVO8VHtA2HfY3Um63n826+asOmxH4Hx
	agI93Vk2VERdybzQqS/wFT8hf63p15OsvsyqR3PyCslHC3PVl7X6+SRbr2TT86GthZpIrqzuBrT
	FB+mSH1u4ob+vlA79TLk8xLqN4nCrW+AfppDbX7ZcB0m14dkhnXFDIOGt57Uu/mvVhIISAwjNEA
	CwWOdPjtNlNcnmCLR1VANjacTrZm6BsQJ2XvOuAOoAtgrhq1ubXEYqo6SOU9dtj2JXlsIWyH8+j
	q3lghZMz5sPCRGC7Ip18Bhp1Vcm2P9XYe08c+NIYoO7S5ifl1eb7DM4QJ5CVZlvwQzA8f3nkunw
	yjCF60KmbxEniB8ST5cCfjSi19gYOX6Q29B1KTNSTgr/dWbCdvZW0jfVv716d32L7Y3TR+Jcs9M
	6SBAt4mqwV081hLkfsK9ZPpmo9oIGZdro5RCTEAGFb6au3pzmCOyUtKKbwUErwSDguo=
X-Received: by 2002:a05:6102:83cb:b0:7c4:613b:2e22 with SMTP id ada2fe7eead31-7d2868f21acmr880932137.10.1793871283602;
        Thu, 05 Nov 2026 01:34:43 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2829d28d0sm2255350137.2.2026.11.05.01.34.43
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:34:43 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-78fb1fb9508so345511137.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 01:34:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByibr7b3zPqHxlBo6CNcLt6juDmza5TDd7ZaCs8Qk2AzOivoGLkO9VLwtOT/3YzxvuJHcMrvYuWHL/MlW8=@lists.ozlabs.org
X-Received: by 2002:a05:6102:3709:b0:7ca:5626:11e with SMTP id
 ada2fe7eead31-7d286b7fa17mr1126485137.36.1793871283167; Thu, 05 Nov 2026
 01:34:43 -0800 (PST)
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
References: <20261105044046.52180-1-dennylin0707@gmail.com>
In-Reply-To: <20261105044046.52180-1-dennylin0707@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:34:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWzY9YRnGz1Y_60RYP7TH67q8fxi1VNWwkhhc0EUeSCFw@mail.gmail.com>
X-Gm-Features: AclHuK8PYnqOIDpZItZg042mTleQ6jUe2E1wddINt5GGmEiia8n8vhGDZzRowiM
Message-ID: <CAMuHMdWzY9YRnGz1Y_60RYP7TH67q8fxi1VNWwkhhc0EUeSCFw@mail.gmail.com>
Subject: Re: [PATCH] omfs: remove the filesystem
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: me@bobcopeland.com, willy@infradead.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, tsbogend@alpha.franken.de, 
	maddy@linux.ibm.com, linux-karma-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 05:41, Hungyu Lin <dennylin0707@gmail.com> wrote:
> OMFS supports the on-disk format used by the long-discontinued Rio Karma
> music player and ReplayTV DVR. While reviewing a fix for incorrect block
> mapping on writes starting beyond EOF, Matthew suggested removing the
> filesystem instead of continuing to maintain it.
>
> Existing OMFS media can still be accessed using an older kernel with OMFS
> support.
>
> Remove the driver, its documentation and build configuration, the
> defconfig entries, and its name from the statmount selftest's filesystem
> list.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

>  arch/m68k/configs/amiga_defconfig             |   1 -
>  arch/m68k/configs/apollo_defconfig            |   1 -
>  arch/m68k/configs/atari_defconfig             |   1 -
>  arch/m68k/configs/bvme6000_defconfig          |   1 -
>  arch/m68k/configs/hp300_defconfig             |   1 -
>  arch/m68k/configs/mac_defconfig               |   1 -
>  arch/m68k/configs/multi_defconfig             |   1 -
>  arch/m68k/configs/mvme147_defconfig           |   1 -
>  arch/m68k/configs/mvme16x_defconfig           |   1 -
>  arch/m68k/configs/q40_defconfig               |   1 -
>  arch/m68k/configs/sun3_defconfig              |   1 -
>  arch/m68k/configs/sun3x_defconfig             |   1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

