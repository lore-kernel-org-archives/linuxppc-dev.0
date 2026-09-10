Return-Path: <linuxppc-dev+bounces-27049-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A627C88E45
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 23:19:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgttW3QSBz2yft;
	Fri, 11 Sep 2026 09:19:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::536" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789058468;
	cv=pass; b=LS08+n4gXevffj65pd0O9+Q3D6FUiWPfW/Tmg2hmyY6YK/pm3VCtzr1jdK/rdi0DKx+nb+KqeIV1J9HuMVyGq/tTDMLFZU7grIlV+if+MdSxBBeZB7oykqtfJqUsxE4tCTA7wEvpY0KNYVUarjZcEN6WSKJhVQJlRkmd11d+kk2ALaap6+FSWLEVKq759s9W1tF6n94bDERLWQtVMdlkVFonZ3mG7qi7LvH1h3iNuYLqNv8o4gejQowyg4SbdlcmGhHRvjYlCAU5FZTtOo4M1NBAnXtVZ3uHW/orWKl61Y0Wb7/MBT/pqXqNzYGlVifyx4M0EO53bf8fgr5b7Aztpg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789058468; c=relaxed/relaxed;
	bh=2oL5fyjdR6Zmk0agIF1JvjVurb3Fe9NMiEU7RpdYqcg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YWXbFJUQom+4t1FgriJb0QHbXcuRPsqEAvp6lKi1NvqPD+DKdRmAG3i9htiHDUz7Giq2cRgPv6qVmC2Pyg0egoEYZu7F1Zjs6QGGujtWZm1eDPWgl4W0+/YWXyg9w7zIHUMGTvm8yODln1rADXr6uA1HZKdt49YoAjinjhnur1OFN5KMoWe23wWlDY6DPndbnlh0LjytY3zj8+uOZFGT5vHXAveS1Bzjze5ebhYxbfJ/Aeuh/p4BidTFZZ4eaZ6u7Y3g8nCjfHGSsJzkbh6ghmIAXSw9XGkqszCSVneAYUv9cKwf+MlDQuqPY33p7JPJ/Uj+wjHw2NWiNuTTditX1g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VxAodLS5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=clamor95@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VxAodLS5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=clamor95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgk2W5t4Pz2xJJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 02:41:06 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-cc149372c14so31609a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 09:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789058464; cv=none;
        d=google.com; s=arc-20260327;
        b=YJyUy/vR9A+Qf0pPsDYUbI3WUMXbgfmVJrPasTHb1lSDYGybGHFCbsmtGItMv4cf+A
         CS9bvqQJnG8l4Wmtur+LWEPeY5sVJpmAoVkZ854F9qwF8fjMyzEXP7ZOqQD1Gql6wKBS
         DrcOPmQbqfWgIUat6uPCP1l5+KNpn346waw8xONx1XbSmtE4qEQZLF0YPidzlOAgFUdF
         DiF/kSmfmfkeQQu1YvieJ18PRDDzLtoSvGeEsQHisnBIVfeEXDAzz+CwOM8TKkCIevP7
         CBZtQoaw3sdlmbXs3k8yNQYL3EdACnOtu/5Q0VNvWRaf5d/J3bq45NbQLU9HXEOHuF97
         EFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2oL5fyjdR6Zmk0agIF1JvjVurb3Fe9NMiEU7RpdYqcg=;
        fh=CNmkPNdmjH8eEk+GQ+L/ccrwH9PARu+yez9bpBIUgPg=;
        b=EYDIiAtk3mr3L9FDOv1h860osfCOkd2PM2L9v9BlKib/oFtIgrhWEUq7OtEkoezMIW
         zdnoY+YblImmR8Imwtn4dIc5qEjWrf0LsvKLJBwkMwCXFJ486yID4ogGlUAV/6pdXNa/
         KXTu7eOISIFw2W2V/W74V0btQ/kxeDoOOoRjDPMGKrMhnXjO3MjPkrhOjbUPr/3CSVxJ
         gWqGHGbU3my93gIEebACp47VgiqCB1Ek2IGoqQeKeH9vQJHJZjDqYbyW2kpG2BqQN0Oo
         EJjgLmeqDinzk6aVmgz7oX1I8/bRAv07XQZUqG7NbJdJYDQsV6eOq9BrHe6Y/3RyML98
         DUJg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789058464; x=1789663264; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2oL5fyjdR6Zmk0agIF1JvjVurb3Fe9NMiEU7RpdYqcg=;
        b=VxAodLS5TvknSFXosK87mCTEvyuq22EQaK5/T72dxgDKrWrl1GPqeqa6OcfD4A/CZV
         ZCLv8Za+crv5OMdGN6Moz/0Pj6eYNxpvCbgFn73jUK+nsaRrQZOxNE54i2Owr1SEz05J
         /YvKZCuWiXBNZ6Dl9WbmAjo69HUONYuOlPmY4Jhm4mxjE4k2rc3dtJZZK9NlvAHxXP3d
         3Zfaytluuy7YRG3wn+Al8TEkxRiNGjuOWRsH4IWRtCvOfOaBSIS/TzBREKVIxtjshjWQ
         Lld+Ge3vbZijz9pXLjYDv1+SpwcVkPQDZlnaIO4fZDdhnYUCxLdaz8EnS7gJkxIE2bmE
         RpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789058464; x=1789663264;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2oL5fyjdR6Zmk0agIF1JvjVurb3Fe9NMiEU7RpdYqcg=;
        b=XQMqPgYuWWnMXLI8oUVoe5ut8VL86TlFNHpTukNIdjexQVEZHkzlJ1lTovcRE4+Hnj
         3nc20uAYCwMU4no62R5K+ZBj8s6tvLyEOsUm24HDz0oSZwNmYpNU7J5dDdG0rlRV3+af
         jhJkeZAhapJIFpucaLePQXjSWjIJgxUo0e04avsycjSrtzTdpgDi6DZrja0yLtVF9S32
         pXVglK8L+AAWTrK5Q54oJgXDxXxjwghksV5cb6PapkM68g2IX7whuy7xRRd3d80uhpeq
         +g1Ee9CUBpd1d7FT58pvPQPKGquqXrqUySWyGlk/McPYDYEATUaMAYTf+negNV0SozV/
         9TPg==
X-Forwarded-Encrypted: i=1; AKwUvBxlZ/zLys7Cr3WP3T6iWzsZohPOUKk7H+tMJfyjuOFyGagzXCEhIuOHNwJOjYdMEbbZEY1ktlgmJ5TSh4U=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mpCOviZzr3IWRHD/QFBHhx1cmlaS/Ng3dzgx50OTknzbse3dW0
	uL8bz238seEGYiBOMR7u1r/K9+4RMhAyD9q/cnfuNy/RIR5aVQP5LU4iaoaZwhxs+NDoQ1GD9Kj
	0AqKR/SaoVPQJvfAI4Oe3sRogx/ZYws8=
X-Gm-Gg: AYBFou1LkZBt41TROhqgvk3C9bDwStEFkhfrBPKnmBQy1ErWaXC1hqlWakIZr+eh553
	tybutH157yjIAHFLhQxYj4ASYNNs+s3NmRvqRDFw8foIzY7Dg6xBuZrxgtNATBgEWD70fKYsQ+H
	joG4oWhvNxmUeQtAPY4k465LWpTPwWjMpKL59fIQBdD4OVJeMMjnrsinsKeKEVlTqUdCqCWej84
	rnhF9uC+lxXN+8i8Yu+WDyuPzYvCTxrVIrtYaKcMy4pcBedLUZwJMJqzX2eeFDWEuRx8oqwKEbx
	inUeR4VonLVbvbj7F9pIYHz5LrqEfnUUZET6gzxnnkpJxMfiOnRBfejW7BcVoq/kqFeFEKKxfzD
	L1DRYc0evZ7HN
X-Received: by 2002:a05:6a20:4388:b0:3da:1e2f:3be9 with SMTP id
 adf61e73a8af0-3da3a0b0070mr69030286637.22.1789058464290; Thu, 10 Sep 2026
 09:41:04 -0700 (PDT)
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
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 10 Sep 2026 19:40:52 +0300
X-Gm-Features: AcwNN1W4_hjYZnmcEHRG7pGvN7c5hDgMskFtPJT5Q7EoYoaMGm933k45arNi9hc
Message-ID: <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
To: arnd@kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bartosz Golaszewski <brgl@kernel.org>, Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, Helge Deller <deller@gmx.de>, devicetree@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
	Jonathan Cameron <jic23@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, mfd@lists.linux.dev, michael.hennerich@analog.com, 
	patches@opensource.cirrus.com, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, support.opensource@diasemi.com
Content-Type: multipart/alternative; boundary="0000000000003f1e49065b23a2bc"

--0000000000003f1e49065b23a2bc
Content-Type: text/plain; charset="UTF-8"

Hello Arnd! May you please spare AAT2870 from being removed? I have a
device which uses aat2870 (LG Optimus 2X P990 Tegra 2, not upstreamed yet,
but in process as well) and atm I am working on converting this driver to
use OF. Thank you!


P. S. If you are planning to remove more old drivers, please CC me in since
I may be interested in some additional driver upgrades for devices I own.

--0000000000003f1e49065b23a2bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><u></u>

 =20

   =20
 =20
  <div>
    <p>Hello=C2=A0<span style=3D"color:rgb(0,0,51);font-size:13px;white-spa=
ce:pre-wrap;background-color:transparent">Arnd! May you please spare AAT287=
0 from being removed? I have a device which uses aat2870 (LG Optimus 2X P99=
0 Tegra 2, not upstreamed yet, but in process as well) and atm I am working=
 on converting this driver to use OF. Thank you!</span></p><p><br></p><p>P.=
 S. If you are planning to remove more old drivers, please CC me in since I=
 may be interested in some additional driver upgrades for devices I own.</p=
>
  </div>

</div>

--0000000000003f1e49065b23a2bc--

