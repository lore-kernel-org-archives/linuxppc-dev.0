Return-Path: <linuxppc-dev+bounces-28980-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E462CA5FED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 21:49:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzqfd6Qt4z2yjN;
	Wed, 07 Oct 2026 08:49:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791323385;
	cv=none; b=l3DEwwI9AdsZITUB76mwnEVUoVjRGqk/NY7mU4+8vUGudf/uDp2KQMPlz5E1iNYeLBBf53Mfqi0ftTMCv2YIShLp7txpxZBvK0VDtqLKj0UXOpuOb1MkXmVeD1vCMu9KIyRrmNfzM1l+eQJPeZejZERhTgcfZPVautVIyMpJDiqedcl84mJcsFUyeo6xNCyVFqTMqhN21ERC0vyjQy6nwez0aMo3M+MMZ1f6YMIZm4YQezmZuy/b6ydrOxjSP+aEIF0QITQwmEl7kq1eLCEXEmbMM3R/r03ZGmtY3KsqmI/4g/0Wpb9LwXXTFLA9P7r5SKNAMTtQRUFaOenCSfjMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791323385; c=relaxed/relaxed;
	bh=Cu+GVkCajxPYQmFp/AWJCNy8qQQm8s58jI6EnwyitRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHQ1BGnMXllEQPhB3yU4WE7T04VOKz9gOuPZVcjxkzAYyyqez1mn9yrk7O6KSul0WGute5STQgmWNJlCdJE5edLA+SLVDgwxzisM8QSV1Ocy15mk+HanQ3+9FS837VGqp/9544WPAKUta/0G1K6H4Yuopt2NqtgAGbkzsYZr3yAKyGrHMASquBN6Hv0rWsTHSz/OurN2Vo+k/YM2pNiS0nAak4BEXLtfjnS3rgfI2YIR1QF3uDEx2KnlyfnV/YpYM2N5hy+ErJ9JJBDl4qqqFFoPdLMlBqB71R3IrbDLvuI5Cn5xtdMOBn6LKId7lpB/XIIYJ/kv1S+kTUVA7WvmDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aHE/l+nJ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=michal.pecio@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aHE/l+nJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=michal.pecio@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzqfc0SWRz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 08:49:43 +1100 (AEDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso7940055e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 14:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791323379; x=1791928179; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cu+GVkCajxPYQmFp/AWJCNy8qQQm8s58jI6EnwyitRY=;
        b=aHE/l+nJEjBkF/+hFbE3wc5hR8Ujm5/1w67tEiaRz8TaBMNUO5uoZCSFMyJcyCI/HS
         kZAYHq31P5wh0kcPxNekoKjqvh9/CPHYd7j2/fKk2TC/kaErHZMuURYUXoEycsPdxUcj
         7v8IbtGQbBHzcsm+EcJeQwylMf2e0gz/ylvUWko0izunKiB+jBFp1p36wftCiMoEVuMm
         p1aAzp5t24VgiJxrBPhph1F+LPdx9CW7axENFnsNyCE7FYL60Eh1qsqT2MmgNbrE7Rmh
         Ij5E54o3tbdVWeDyJHRm1CuECuXzPNk+NGLWVBIqqb2XNTgQmCqkgyHPKSkVs9Hwx456
         on5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791323379; x=1791928179;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cu+GVkCajxPYQmFp/AWJCNy8qQQm8s58jI6EnwyitRY=;
        b=WldOLskdsAN1p3R2G4yFKdio8VQmXTAd8FnMKX5AhVYB39wzzAg9zGZlijUViiJF3N
         9b2VEK2XLvnwPD/GGHfHpFucGa+4qw2H9oI+YBMNTgCXkSB6CJpnoJaBM64GMfbwnIWQ
         VQ5/rcjnmljQ6Op/r4acYPFa7Pb7iailGhfj8Xt96c+AfR0QFXZgmKy7D7Mu+HJyjk07
         BZJjkT9+W4A/+xbH+0jxr0uGqAQe317x3132/2Zube+soBtVIhFJc653huesAz5EF5JA
         yj2HM1tzxXhhqDlZNl7iLpmhw11B0tXzQ2TuCXycAlmC39n8pvuMdQmzqhPdWc6ND13O
         oH6w==
X-Forwarded-Encrypted: i=1; AKwUvBwKqFOGshTVgt5qDSmHjqwoKBuiI4yLcQCC+KZv8xtXU1XTKxMAfKymjunodZZ7No+PH6mQ6k2pNI3oYD4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nGPbdkv/al4QmEulx/DBKkcjZhg1lgnhCOq2ydkhIXGiTl2i/D
	Tk10kCJAzF/R90LJp2fyySsbNjr8vBHJFuPCpRrHACsDXchFAiaHvvX4
X-Gm-Gg: AYBFou1MYr4ZLfwEzvvHJmto5cbIxmRuV6kvHmG15ou/cptmTBNaj76ahLieAE3FTRe
	lknWbYtTaeClcKWGtgIqNo6ozhg33lFaTaQvA/7edR+elKx876WeZ/fb81v80Te2MVfdvUUPz5H
	hk088EEjJIYqWIxVvA6OJFWSotXw2o6FT6tvtpmT2yKQXFSzp+9hNWQ/Bph8BhQDacaDxy8ibvY
	Jg5MPV2Q80dda6QK97GyX7jT/0cZjcxQrWFV+uC1wXBRdnCWzedC9aMkbU5ENFqPy3UoC9gk4BW
	gzmPtzJdUqo1sLBvgOM/GTSgBMvqs/MvRi1GUoUf0qcbZjv8d5J4Mt1BP4OIw39FF9HZVZiZZ2C
	a9j0vUzlNBkblQMUKgOa7Nta26Vsv1blaHkqIfcR2WvzyWL7ZIkubH5g17IYg4YT1bWoKa90dmH
	RzeK+Xnq5sZXnDy0XhPzzZiid1drqGvUguIy/vTpXEqxdunmSFcGIfeH52lVPbpYiuD6jSPfALD
	ZRSjCLr3g==
X-Received: by 2002:a05:600c:154c:b0:4a1:6282:1cf3 with SMTP id 5b1f17b1804b1-4a18043b284mr2285345e9.9.1791323379475;
        Tue, 06 Oct 2026 14:49:39 -0700 (PDT)
Received: from foxbook (bez186.neoplus.adsl.tpnet.pl. [83.28.37.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17a0fc2e4sm97768435e9.3.2026.10.06.14.49.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Oct 2026 14:49:39 -0700 (PDT)
Date: Tue, 6 Oct 2026 23:49:35 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: IBM Power S822LC: pci 0021:0d:00.0: xHCI HW did not halt within
 32000 usec status = 0x0
Message-ID: <20261006234935.0c40c635.michal.pecio@gmail.com>
In-Reply-To: <eff5ca07-26a9-40bd-8668-6e6ed69fe587@molgen.mpg.de>
References: <fb68e15d-b8f2-42ac-aa65-0d9fedcfcdbd@molgen.mpg.de>
	<20260506193037.6de9e355.michal.pecio@gmail.com>
	<69fa1c3f-3ea9-42cb-a49a-7da39f72806e@molgen.mpg.de>
	<20260512012006.66aeb0c5.michal.pecio@gmail.com>
	<6106b5b9-17d2-48be-8215-3320f3d1d261@molgen.mpg.de>
	<20260512102233.290d3665.michal.pecio@gmail.com>
	<eff5ca07-26a9-40bd-8668-6e6ed69fe587@molgen.mpg.de>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 17:32:09 +0200, Paul Menzel wrote:
> As a further data point, adding `ppc_pci_reset_phbs` to the command line=
=20
> also gets xhci_hcd to initialize the TI xHCI host controller:
>=20
>      $ lspci -nn -s 0021:0d:00.0
>      0021:0d:00.0 USB controller [0c03]: Texas Instruments TUSB73x0=20
> SuperSpeed USB 3.0 xHCI Host Controller [104c:8241] (rev 02)
>=20
>=20
>      [   14.050249]   Issue PHB reset ...
>      [=E2=80=A6]
>      [   19.339822] ehci_hcd: block sizes: qh 144 qtd 96 itd 192 sitd 96
>      [   19.339919] ohci_hcd: block sizes: ed 112 td 96
>      [   19.340538] xhci_hcd 0021:0d:00.0: xHCI Host Controller

Hi Paul,

Are you still interested in this issue, or happy with your workaround?
Maybe both?

I have some updates:

We learned that the kernel does dodgy things with the FW handoff
protocol, particularly with TI chips. This may possibly matter if
FW is involved. I could supply patches to test this hypothesis.

A suspiciously similar case has been reported here:
https://lore.kernel.org/linux-usb/b43b9d21-4134-4e4c-89d8-f867207b125e@linu=
x.intel.com/T/

There is a new workaround: PCI device reset before kexec. Weird.

> No log `xHCI HW did not halt within 32000 usec status =3D 0x0` (or 0x10=20
> with the other patch). In `arch/powerpc/platforms/powernv/pci-ioda.c`,=20
> reading the comment in `pnv_pci_init_ioda_phb()` suggests, that PHB=20
> should be reset also in the kexec case:
>=20
>          /*
>           * If we're running in kdump kernel, the previous kernel never
>           * shutdown PCI devices correctly. We already got IODA table
>           * cleaned out. So we have to issue PHB reset to stop all PCI
>           * transactions from previous kernel. The ppc_pci_reset_phbs
>           * kernel parameter will force this reset too. Additionally,
>           * if the IODA reset above failed then use a bigger hammer.
>           * This can happen if we get a PHB fatal error in very early
>           * boot.
>           */
>          if (is_kdump_kernel() || pci_reset_phbs || rc) {
>                  pr_info("  Issue PHB reset ...\n");
>                  pnv_eeh_phb_reset(hose, EEH_RESET_FUNDAMENTAL);
>                  pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
>          }
>=20
> At least, I=E2=80=99d assume that kdump and kexec are similar, that both =
do not=20
> shut down PCI devices? (Commit 361f2a2a1536 (powrpc/powernv: Reset PHB=20
> in kdump kernel) from 2024 adds (some) the code above.)

Apparently, we try to shut down PCI devices on kexec, unless loading a
crash dump kernel on panic. So as I wrote in the new thread, we already
call xhci_halt() before kexec, the xHC should be halted, and for new
kernel xhci_halt() should be almost a no-op with guaranteed success.

It seems that we are failing to actually halt it, or something (FW?)
touches the chip during kexec, or something else is quite weird.

Regards,
Michal

