Return-Path: <linuxppc-dev+bounces-20690-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B473CD37B5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 06:42:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDVX85RjPz2xl6;
	Mon, 11 May 2026 16:42:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778481752;
	cv=none; b=TtNbm3LX/vc+fdfcV96GhojT9enIRvGjFYgpqgT3XcKmtM5BUAMC9Xw+cwNcGN0KmkzO7wDruiQYFECfoLJVCqiFwA8Hv6dwEfoccFBTikbjkv50EH8941DT8dzjZsZ1nPkiSOsvuw+tp1469TnXz2KVjEwmfH2lyR4E8m3Kjk4vNbrfsinP1rUcPVeJWQsM6bC6re+S/AoNlVaxNiFRt7Cxmgrzqg/ZBuUGlvVGt0fFoXGDFFZ3nAMQiAiSjd6fT8KuQTF7A1eJsRZI+/UPlmNiO+EN0q5cg1SNcIL3dE5DsSTtkRX5f+4cKruD8EkxcYDwY+GsEOJIaCljaN4QNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778481752; c=relaxed/relaxed;
	bh=nmM7uPcTxOtt/CXqxfbtSzgj1ys1bMpqCcKcPX8L8Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxGP91oRJ9rgEdZQ+WeXSR0qg1YAJvkylNfQHe6jIvvu6dc3R0yd+vZXeoDaNKw7L25kH2xT+Ydr9jx3zmOjdDgu+9S1UE20n1GY8kS6ema2V7KP6XYo6WgDTFc9IMS0wN3zwzhBsJiJwU0Vc7w8VIwT5szFhoKbGRUvTnnB1r8KHe0yRrqEtneF5KNbteqmvvQ21Yc/DvcKkdL5EokkrYqGeYs9gJHtydT4Z8nvRBT9Kz8eMcUdcZwBWqyTs9NAUmlUNcU3FPNcdtSFUPNtqT1H5ZZcH71ktL55+MVSTnC35/tX2JI0r61NWccL3fzE2Zu4NZnl/GmqQJKEh8oYZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.173; helo=mail-vk1-f173.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.173; helo=mail-vk1-f173.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDVX66d98z2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 16:42:30 +1000 (AEST)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-575320e6f2aso2896104e0c.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2026 23:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778481747; x=1779086547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmM7uPcTxOtt/CXqxfbtSzgj1ys1bMpqCcKcPX8L8Aw=;
        b=GwmglrGqskGaNnG7KFehjD2quo1BUh2WE5+POEeJWc/2Q3f5bKrWT4iL9AR6hWhmPF
         b44fWeamAZpbquXC1s4dM6r7RXdr58iAvwmg9WdNVAhtjHQoHYgd1tcezkU+gr402U3/
         9WmZcpTu6kdKGYnYrwJ00h/3lhcGaZbiUgy1ksHunnqDTYxRHfqeFP4BKJPdMET/KUWh
         X2IV5BKNOme7AcUi0VwjP95aq5gK8aKx1XUkXVrqRy42AvmjdwYNqOYhWOvkRJTc4q0+
         /VMdmtb82Q2MPYfVVcAtmBT1stSE9FCDbSBuoATJHxpNZRtCVhF5FkvihKAEgDRSGfpL
         fPgg==
X-Forwarded-Encrypted: i=1; AFNElJ+QN0QI/qJGuAGVD4i/BcBT6FqCZybHmv2vZ23Z4k7ivo6xtR4T3eL8gAnIchPVneGxTey3qNIOQN0MM0Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx7V53klEThQqIyZcF1HTfsvyCyQ54Oio5ig9kixi757Npj/H27
	VbXXLzZMhAR45IVLvvSFcOJK0+7cOplzgPreN9o19uxU0kqMfKYHlITU8+K5YGSk
X-Gm-Gg: Acq92OHr9/aLPLdg/GxheNrbOs2jUCti9IjCs8Oe1smzUbgNdb8Zdo7yoC8puI8xHmd
	B+teYdNIJbNVKT34u6KnCY4+znRvKCxIytWjEOOhL68sMpeRjS/mRY/xP0+8t3L65fzr1qEhV8O
	i2NfDuZdwfuT0lpmVPI9eJZV/woPLd2gfUDNS1O32dOrpVy0GcYAd2vGtvqIlqK24q17nBj6fRj
	6JPSBcGbk3B3fMOIpHNXPc5ldU3x8jgeNakRy6bME0pptS9c5gdkPDMOwSw+w+RJIyfGQYR6N+L
	fzqPoyi5MET/r1FbyLbfukq2KdXzGegPRO+HsDGHiCYSntrucbjnNsVCnHwG1D4O1WwhMSjERj2
	np62hqy3REg37KTlZXBCJPS9RfQ0kaZHZuUhfPcsVbHOfPOUamDwi2JaJut8oDhl6OkTJsgBh+3
	kUvnd6AS8Y90SgSJ9Uizdc1r+z7/vCGkY6nmH28ty2GDsOWLiDWqJbLATJjmQSv9jswXWcR0w=
X-Received: by 2002:a05:6122:915:b0:56b:5893:d042 with SMTP id 71dfb90a1353d-5755962d507mr11074903e0c.12.1778481747008;
        Sun, 10 May 2026 23:42:27 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5752425a19csm15049569e0c.10.2026.05.10.23.42.26
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 23:42:26 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-631466587e9so1607507137.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2026 23:42:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+el50Xer5Ovkaoc5TMDv5bV929FURM2h0qIVoYg/VV0WfTKWHPq6Jk2OhL+hv/Ak2ow+iR2aM/Ouo30hI=@lists.ozlabs.org
X-Received: by 2002:a05:6102:2ac7:b0:633:c6c4:b32c with SMTP id
 ada2fe7eead31-633c6c4b990mr1428757137.15.1778481746411; Sun, 10 May 2026
 23:42:26 -0700 (PDT)
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <202605100125.l4JVHppO-lkp@intel.com>
In-Reply-To: <202605100125.l4JVHppO-lkp@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 May 2026 08:42:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXPeUnjN__PvY+HQg+cSxKe-RLnyT-A5KGe=4cmjnUNbg@mail.gmail.com>
X-Gm-Features: AVHnY4LhC2w7Nls0eAOnAROXGmHfJhM8ihUdL8l1JwrVFRMxvNzDPSpVspNG9hQ
Message-ID: <CAMuHMdXPeUnjN__PvY+HQg+cSxKe-RLnyT-A5KGe=4cmjnUNbg@mail.gmail.com>
Subject: Re: crypto/ahash.c:1073:1: warning: the frame size of 1040 bytes is
 larger than 1024 bytes
To: kernel test robot <lkp@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 May 2026 at 19:07, kernel test robot <lkp@intel.com> wrote:
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ec89572766744e844df24c27d31c97b4c00f4e07
> commit: 9d9b193ed73a65ec47cf1fd39925b09da8216461 crypto: hash - Increase HASH_MAX_DESCSIZE for hmac(sha3-224-s390)
> date:   9 months ago
> config: mips-eyeq5_defconfig (https://download.01.org/0day-ci/archive/20260510/202605100125.l4JVHppO-lkp@intel.com/config)
> compiler: mips64-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260510/202605100125.l4JVHppO-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Fixes: 9d9b193ed73a ("crypto: hash - Increase HASH_MAX_DESCSIZE for hmac(sha3-224-s390)")
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605100125.l4JVHppO-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    crypto/ahash.c: In function 'crypto_hash_digest':
> >> crypto/ahash.c:1073:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     1073 | }
>          | ^

This is one of the few defconfigs that still use CONFIG_FRAME_WARN=1024.
The default value for 32-bit systems was lifted from 1024 to 1280 in
commit 32115734c0ed8b46 ("Increase the default 32-bit build frame size
warning limit to 1280 bytes") in v6.18, so perhaps the downgrade to
1024 should be dropped from the following defconfigs:

$ git grep CONFIG_FRAME_WARN=1024
arch/mips/configs/eyeq5_defconfig:CONFIG_FRAME_WARN=1024
arch/mips/configs/eyeq6_defconfig:CONFIG_FRAME_WARN=1024
arch/mips/configs/eyeq6lplus_defconfig:CONFIG_FRAME_WARN=1024
arch/mips/configs/lemote2f_defconfig:CONFIG_FRAME_WARN=1024
arch/mips/configs/loongson2k_defconfig:CONFIG_FRAME_WARN=1024
arch/powerpc/configs/fsl-emb-nonhw.config:CONFIG_FRAME_WARN=1024
tools/testing/selftests/wireguard/qemu/arch/arm.config:CONFIG_FRAME_WARN=1024
tools/testing/selftests/wireguard/qemu/arch/armeb.config:CONFIG_FRAME_WARN=1024
tools/testing/selftests/wireguard/qemu/arch/i686.config:CONFIG_FRAME_WARN=1024
tools/testing/selftests/wireguard/qemu/arch/m68k.config:CONFIG_FRAME_WARN=1024
tools/testing/selftests/wireguard/qemu/arch/mips.config:CONFIG_FRAME_WARN=1024
tools/testing/selftests/wireguard/qemu/arch/mipsel.config:CONFIG_FRAME_WARN=1024
tools/testing/selftests/wireguard/qemu/arch/powerpc.config:CONFIG_FRAME_WARN=1024

I am not sure about the wireguard selftests: they might use the lower
value deliberately for testing?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

