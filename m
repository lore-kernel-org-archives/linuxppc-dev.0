Return-Path: <linuxppc-dev+bounces-19947-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395D4F9EDC4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 13:17:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g10C159lMz2yr8;
	Wed, 22 Apr 2026 23:17:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776863869;
	cv=none; b=nX0cUuwkHDTCujASDU1TLC8C6YpeXWUna9GoW13yhGIoUeIhpSuT3Yu9J/MqkaW4WdKvOcWWpe9LIpupI62a07WkakFO0oqhIJDM8CAQyX0xwDHRRAX8PAxAr13XPn9xox/t+Kn586Fqql+ehWiA3/SRRMVu0W8+AK3xbATgKel0yA8DWUrbMHXHPBP6Kodj4oe06fWOOEhV7Wc4Jcjm66GbBLP80iEaqZuOY2u+pVU/fNZC6LWGh780qD5VZ2/o20WD2CcdsMCqHcwAdoh5evHgbvVJ2SjOR6cwkMko0dW8AN2gPIVS/hhzarMoQNr00zFcvBPvu9bx0XGxnjVQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776863869; c=relaxed/relaxed;
	bh=5JlgsJdPL7wtu5Mt7X6K/pCay7xHXG85EOpMzec21jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGdK7LttK17Id4VN4nHpAvyBl69Xx/AhWg4OFgK4rcv41IEVqrs1xr8HhidRNPxPkQ0u2O9nr9G/Px+Zipo7zpNKmNnyHMbFd9vKaO+fjhXb+vidgv8z5STCgoFW1Jvnl3vyjHsuBVPfFmazXM5gPTytLObrCLqgC4ZbfpjRXkAHMCYbk8Nct69aLalm9/fAKoIvGS4aJBQAueZbmH4PDe/2ze2fdEi8aSjqzLgnlwuc27hW/hgHkoXD0b2IOlZenlJe75IrQQjxOihQqJgr8f/EfcYjqNzDz7pXm8VNpSeP1J97GnIGJSbFEBqUZ/4kH+WX92SRdjDcM6HrPleTdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=blackwall.org; dkim=pass (2048-bit key; unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=WicZ1TYB; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=razor@blackwall.org; receiver=lists.ozlabs.org) smtp.mailfrom=blackwall.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=WicZ1TYB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=blackwall.org (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=razor@blackwall.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g10C01bZkz2xpg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 23:17:47 +1000 (AEST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso31900605e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1776863860; x=1777468660; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JlgsJdPL7wtu5Mt7X6K/pCay7xHXG85EOpMzec21jg=;
        b=WicZ1TYBJnSf30huG12+qwSWYmJYoT8B1zWz2wT5P+W3UIW5G/yLqGbikn679QlDfm
         lT5XngC9DBoqwT+LptFFpL1UOYnTMhSVcm6mEs21IV/o3jPfmP19Nd0sVwI5EDRIkOng
         ekCG79CVgxUvxfum7RbdSrHLFAvSPJq3rU8ihj/Nn8AZ1fmKR5uhdaanAdiRpfHQ8lyG
         VKl0wsDRXQlPTo+uJTLcrf364yV2M6Dnt+kqY6uJ6mpVngszfX0xz2/gT2LJ6HMP7mCz
         3EWAGu9c4YqVhbdN5KjY4PHZiTstkOZlaQ/Wx0aOZzKIwbkAHsLLlk8ZhGtrNH7wcwDE
         CFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863860; x=1777468660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JlgsJdPL7wtu5Mt7X6K/pCay7xHXG85EOpMzec21jg=;
        b=V66V3ArXTDONUWmDYM3cwALWDVk4DT60961QWDJSe6GUxZAScyKlymAwJB4ty8Oo8J
         mqD9+jMbGkaPAHvbxr9wNWhdMuYfH0IiV6aIL9NwN11EYf8R1MSRBuUtOEIYTAV7mSWY
         lyfWPuxgx8F8Ek0ovfBXV6gGjMDIAnOGd/WU5nu4c8RlVD6BsawgpXAyjlmT0xw8moEK
         67VNso8lKRcwP1G7je4JgBfuDAXAbgrPlzhHA9sSS4jz/Z77+efRlwUDz34Q07bldvx2
         w/oSmz7EHAknQRq5WxbUgmVHt0EKm+wmuZXqfZEyMFdnAXGGUgXsHyRJIxK2+vCL59dB
         18yQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dB/kwQPdWQ6+6Nz97HLAFB3pvSpq8jrAuKvBDQbN87DdMwjrFVyTZWlauRbHZ3pf5M/eWRd03s4IWcx4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzioaKRpwC9pn7JCUz+JCERv4kYfNPB7SFjLNlGzj51fbUTDRpA
	6SL8G9Mde5brxmmG0DzGAtBemtQOY3173AF+yax3W1Dny/QMEjEtz3B2kDbxl2wk1zo=
X-Gm-Gg: AeBDievbt4a78tJc9KROMoy3vHN1EP+SAwA/lTdIl1V8bCyahv2QAhPuvk9fIgWSdCQ
	Me+G0kiEjPgEpB2gs3dZ+Uh7Fserm1ZH99EZr7Pry8av6RFQJkEK6MEYVVEp1VEOVknB45uic3j
	2EEZmVdNhWsZzHna2qeo/m5dLpxazeKScFpQTwyc2BlTvqycs6ckFQPeGYOoXbJUtwBNI4Iqw9m
	FgDHqCI3RYjKoh22e7nPVUuNkBrtgvU67yq+XgZ9/Bkw4dpwrvjo/fIQjGqfIKgLFaMMotbq8Ba
	EeOfkc4FfqzrdCYmdpuebdsIIPoHsPJ28TxwyY12BE1ExBuL4YLGAhkpXRH4VVXnkOrnPMb/HxS
	iRnku8b7dERkNnJ+YMhW8BChGR/tftB5238QWpR1VL7LepZz4GWAkN0SvYGFzwLRW3GTul1UNjv
	NLMYebFEGiu3CZnDm9JmPOWdOtGgcIL/UjGSm1IP/TdxhgtKJ0DR9hKNjk+IZobvLL
X-Received: by 2002:a05:600c:890c:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-488fb739cd9mr265621335e9.1.1776863859192;
        Wed, 22 Apr 2026 06:17:39 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d6casm41495844f8f.32.2026.04.22.06.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 06:17:38 -0700 (PDT)
Message-ID: <46196178-51e0-4744-9154-bbad895568d6@blackwall.org>
Date: Wed, 22 Apr 2026 16:17:36 +0300
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
Content-Language: en-US, bg
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, linux@armlinux.org.uk, tsbogend@alpha.franken.de,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, 3chas3@gmail.com, idosch@nvidia.com,
 jani.nikula@intel.com, mchehab+huawei@kernel.org, tytso@mit.edu,
 herbert@gondor.apana.org.au, geert@linux-m68k.org, ebiggers@kernel.org,
 johannes.berg@intel.com, jonathan.cameron@huawei.com, kees@kernel.org,
 kuniyu@google.com, fourier.thomas@gmail.com, andriy.shevchenko@intel.com,
 rdunlap@infradead.org, akpm@linux-foundation.org, linux-doc@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bridge@lists.linux.dev, dwmw2@infradead.org
References: <20260422041846.2035118-1-kuba@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260422041846.2035118-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/04/2026 07:18, Jakub Kicinski wrote:
> Remove the ATM protocol modules and PCI/SBUS ATM device drivers
> that are no longer in active use.
> 
> The ATM core protocol stack, PPPoATM, BR2684, and USB DSL modem
> drivers (drivers/usb/atm/) are retained in-tree to maintain PPP
> over ATM (PPPoA) and PPPoE-over-BR2684 support for DSL connections.
> 
> Removed ATM protocol modules:
>   - net/atm/clip.c - Classical IP over ATM (RFC 2225)
>   - net/atm/lec.c - LAN Emulation Client (LANE)
>   - net/atm/mpc.c, mpoa_caches.c, mpoa_proc.c - Multi-Protocol Over ATM
> 
> Removed PCI/SBUS ATM device drivers (drivers/atm/):
>   - adummy, atmtcp - software/testing ATM devices
>   - eni - Efficient Networks ENI155P (OC-3, ~1995)
>   - fore200e - FORE Systems 200E PCI/SBUS (OC-3, ~1999)
>   - he - ForeRunner HE (OC-3/OC-12, ~2000)
>   - idt77105 - IDT 77105 25 Mbps ATM PHY
>   - idt77252 - IDT 77252 NICStAR II (OC-3, ~2000)
>   - iphase - Interphase ATM PCI (OC-3/DS3/E3)
>   - lanai - Efficient Networks Speedstream 3010
>   - nicstar - IDT 77201 NICStAR (155/25 Mbps, ~1999)
>   - solos-pci - Traverse Technologies ADSL2+ PCI
>   - suni - PMC S/UNI SONET PHY library
> 
> Also clean up references in:
>   - net/bridge/ - remove ATM LANE hook (br_fdb_test_addr_hook,
>     br_fdb_test_addr)
>   - net/core/dev.c - remove br_fdb_test_addr_hook export
>   - defconfig files - remove ATM driver config options
> 
> The removed code is moved to an out-of-tree module package (mod-orphan).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>   - keep BR2684
>   - correct the claim that Traverse Technologies is defunct,
>     I'm still deleting the solos driver, chances are nobody uses it.
>     Easy enough to revert back in since core is still around.
>     The guiding principle is to keep USB modems and delete
>     the rest as USB ADSL2+ CPEs were most popular historically.
> v1: https://lore.kernel.org/20260421021943.1295109-1-kuba@kernel.org
> 
> CC: corbet@lwn.net
> CC: skhan@linuxfoundation.org
> CC: linux@armlinux.org.uk
> CC: tsbogend@alpha.franken.de
> CC: maddy@linux.ibm.com
> CC: mpe@ellerman.id.au
> CC: npiggin@gmail.com
> CC: chleroy@kernel.org
> CC: 3chas3@gmail.com
> CC: razor@blackwall.org
> CC: idosch@nvidia.com
> CC: jani.nikula@intel.com
> CC: mchehab+huawei@kernel.org
> CC: tytso@mit.edu
> CC: herbert@gondor.apana.org.au
> CC: geert@linux-m68k.org
> CC: ebiggers@kernel.org
> CC: johannes.berg@intel.com
> CC: jonathan.cameron@huawei.com
> CC: kees@kernel.org
> CC: kuniyu@google.com
> CC: fourier.thomas@gmail.com
> CC: andriy.shevchenko@intel.com
> CC: rdunlap@infradead.org
> CC: akpm@linux-foundation.org
> CC: linux-doc@vger.kernel.org
> CC: linux-mips@vger.kernel.org
> CC: linuxppc-dev@lists.ozlabs.org
> CC: bridge@lists.linux.dev
> CC: dwmw2@infradead.org
> CC: herbert@gondor.apana.org.au
> ---
>   MAINTAINERS                                   |    3 +-
>   Documentation/.renames.txt                    |    2 -
>   .../device_drivers/atm/fore200e.rst           |   66 -
>   .../networking/device_drivers/atm/index.rst   |    2 -
>   .../networking/device_drivers/atm/iphase.rst  |  193 -
>   drivers/atm/Kconfig                           |  325 --
>   drivers/net/Kconfig                           |    2 -
>   net/atm/Kconfig                               |   37 -
>   drivers/Makefile                              |    1 -
>   drivers/atm/Makefile                          |   32 -
>   net/atm/Makefile                              |    4 -
>   drivers/atm/eni.h                             |  136 -
>   drivers/atm/fore200e.h                        |  973 -----
>   drivers/atm/he.h                              |  845 ----
>   drivers/atm/idt77105.h                        |   92 -
>   drivers/atm/idt77252.h                        |  816 ----
>   drivers/atm/idt77252_tables.h                 |  781 ----
>   drivers/atm/iphase.h                          | 1452 -------
>   drivers/atm/midway.h                          |  266 --
>   drivers/atm/nicstar.h                         |  759 ----
>   drivers/atm/suni.h                            |  242 --
>   drivers/atm/tonga.h                           |   21 -
>   drivers/atm/zeprom.h                          |   35 -
>   net/atm/lec.h                                 |  155 -
>   net/atm/lec_arpc.h                            |   97 -
>   net/atm/mpc.h                                 |   65 -
>   net/atm/mpoa_caches.h                         |   99 -
>   net/bridge/br_private.h                       |    4 -
>   drivers/atm/adummy.c                          |  202 -
>   drivers/atm/atmtcp.c                          |  513 ---
>   drivers/atm/eni.c                             | 2321 ----------
>   drivers/atm/fore200e.c                        | 3012 -------------
>   drivers/atm/he.c                              | 2861 -------------
>   drivers/atm/idt77105.c                        |  376 --
>   drivers/atm/idt77252.c                        | 3797 -----------------
>   drivers/atm/iphase.c                          | 3283 --------------
>   drivers/atm/lanai.c                           | 2603 -----------
>   drivers/atm/nicstar.c                         | 2759 ------------
>   drivers/atm/nicstarmac.c                      |  244 --
>   drivers/atm/solos-attrlist.c                  |   83 -
>   drivers/atm/solos-pci.c                       | 1496 -------
>   drivers/atm/suni.c                            |  391 --
>   net/atm/clip.c                                |  960 -----
>   net/atm/lec.c                                 | 2274 ----------
>   net/atm/mpc.c                                 | 1538 -------
>   net/atm/mpoa_caches.c                         |  565 ---
>   net/atm/mpoa_proc.c                           |  307 --
>   net/bridge/br.c                               |    7 -
>   net/bridge/br_fdb.c                           |   29 -
>   net/core/dev.c                                |    7 -
>   arch/arm/configs/ixp4xx_defconfig             |    5 -
>   arch/mips/configs/gpr_defconfig               |   13 -
>   arch/mips/configs/mtx1_defconfig              |   13 -
>   arch/powerpc/configs/ppc6xx_defconfig         |    9 -
>   drivers/atm/.gitignore                        |    5 -
>   drivers/atm/nicstarmac.copyright              |   61 -
>   56 files changed, 2 insertions(+), 37237 deletions(-)
>   delete mode 100644 Documentation/networking/device_drivers/atm/fore200e.rst
>   delete mode 100644 Documentation/networking/device_drivers/atm/iphase.rst
>   delete mode 100644 drivers/atm/Kconfig
>   delete mode 100644 drivers/atm/Makefile
>   delete mode 100644 drivers/atm/eni.h
>   delete mode 100644 drivers/atm/fore200e.h
>   delete mode 100644 drivers/atm/he.h
>   delete mode 100644 drivers/atm/idt77105.h
>   delete mode 100644 drivers/atm/idt77252.h
>   delete mode 100644 drivers/atm/idt77252_tables.h
>   delete mode 100644 drivers/atm/iphase.h
>   delete mode 100644 drivers/atm/midway.h
>   delete mode 100644 drivers/atm/nicstar.h
>   delete mode 100644 drivers/atm/suni.h
>   delete mode 100644 drivers/atm/tonga.h
>   delete mode 100644 drivers/atm/zeprom.h
>   delete mode 100644 net/atm/lec.h
>   delete mode 100644 net/atm/lec_arpc.h
>   delete mode 100644 net/atm/mpc.h
>   delete mode 100644 net/atm/mpoa_caches.h
>   delete mode 100644 drivers/atm/adummy.c
>   delete mode 100644 drivers/atm/atmtcp.c
>   delete mode 100644 drivers/atm/eni.c
>   delete mode 100644 drivers/atm/fore200e.c
>   delete mode 100644 drivers/atm/he.c
>   delete mode 100644 drivers/atm/idt77105.c
>   delete mode 100644 drivers/atm/idt77252.c
>   delete mode 100644 drivers/atm/iphase.c
>   delete mode 100644 drivers/atm/lanai.c
>   delete mode 100644 drivers/atm/nicstar.c
>   delete mode 100644 drivers/atm/nicstarmac.c
>   delete mode 100644 drivers/atm/solos-attrlist.c
>   delete mode 100644 drivers/atm/solos-pci.c
>   delete mode 100644 drivers/atm/suni.c
>   delete mode 100644 net/atm/clip.c
>   delete mode 100644 net/atm/lec.c
>   delete mode 100644 net/atm/mpc.c
>   delete mode 100644 net/atm/mpoa_caches.c
>   delete mode 100644 net/atm/mpoa_proc.c
>   delete mode 100644 drivers/atm/.gitignore
>   delete mode 100644 drivers/atm/nicstarmac.copyright
> 

FWIW,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



