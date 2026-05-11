Return-Path: <linuxppc-dev+bounces-20788-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36F0CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 12:14:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFFr9412Cz2xlh;
	Tue, 12 May 2026 22:14:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::129"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778541619;
	cv=none; b=PPKhJR9rhMkv9oqL2sulByXHwjJDalA7rgydlVwxUYncurGje5Nowvkn1VZvVMgQEb5AWSv3byn8ID+YzCB44xvIqfAxa7rgh2+wwjXTBfFffSFWITvh61BtAXnOz1DDFA2rO9BllnFr0ixMP42NE+ydKmS9kiM0FGgt2IN1F6WUdwTcEhoidTufzAdJ4ECbiK4BM2GAxtDGlorPLUccs3Na+AF9WKskTEQ0ZtDhFxuKeAx6x2d3Rh1fXNBF8h5GyArSsR7jHtGPQltTNBTPhc5JUn2Xxt+NUcptyAsYz0ReUi6kU4qBx4rdoscHYnojjY1J+gXNaJKz/oGB2U+7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778541619; c=relaxed/relaxed;
	bh=eKeFaDyaApRaenceXFBzhlhr5RKF4sYAm+7+RMza1rM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7G2whQ8mlzxHQqgF7s22JAjydY1gf4N2l8PXARrgCIg8ncm/moavUexHOPwPG1bOcFhQ4WqkAtm83VvBrPfSLG+7PJl4YMeC0KayvaYjbC/kSsSyBNbM1k9MSqk68NxWryUpL8PuakAsBp+kG1eGBTXVn1qXNkxREIuGeeTXrtUL4xRQe/ZDTcZehAgYrd23B5Owt52lLPO7covGS5aD+0bQkwEadJegskNnMdE4EvmO6bmPYLaUA09VSqKTezpuZ2vw+9usyp+uP23Pk0pnHfAgd/UcvwSWOnouFAfPFPo0/fnx9gKlBbVb5pZc4d7c4j1Aoe6yTNpO0p+0VdwQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lv4BJklp; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com; envelope-from=michal.pecio@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lv4BJklp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com; envelope-from=michal.pecio@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDwgQ0NV6z2xLr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 09:20:17 +1000 (AEST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5a4113ab355so4573830e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 16:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778541612; x=1779146412; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKeFaDyaApRaenceXFBzhlhr5RKF4sYAm+7+RMza1rM=;
        b=Lv4BJklp/M54lZ6tRJRfm8NqEM4DxsGFu1i3WzJ4T3yQ/NiB5y586GC6vRRXgIcTme
         G97E5ZUBk4RG/gn2fP9NPjpsjoimeOV3pQrcvacGoztDbTrecv1lfJ6RfbC7liA5oRGP
         9loCe0XeWuX+9vD0gX4VLTPLvfhpXvyDoEcjMtkKFAOahSgk1ZTPI1adG9cepMDuXDDc
         2/M0JtbCK9pUt5UndimAjunVIZWzwiMU75rEbJa9hbfhr9CP41+4m4E3O9KZYTq6L8dr
         08e4hlaE5eMjlI5PEg74E27/TO2PYCO45dZjJHOR48VWKXOYx54T3lqdj5i7zn2kJ+Lu
         jWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778541612; x=1779146412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eKeFaDyaApRaenceXFBzhlhr5RKF4sYAm+7+RMza1rM=;
        b=K1DnuDeKSqEVf6PnSk5FXrDnmy50wnLdULJw2hzDUEJxcvTulAOYSwxWe8sJ6sd1Fv
         aIo6U+Qu5nEuYMRsxS4ndB0JAJATOjz7Ec1+W8G7e6Tpdr39U/atFNK6Wq8SAXFQJINf
         jmhf7nfKePnB9gJoLiIMB/6sWwVHL/8h1eeAeIAkr5wvo9uw9pJIlBtfaZtZ2Wcf6yFM
         N46VhpYcNLNNjwvlEEZDq8u4hbH5QyCHoKFcs8tPfq+1aCrephQ4VPU6R2ktRPVFwmB5
         Ixf3OeFiNU2zFD++IBwYjCqZsaZWidbddybpd63RNvZnH+nIBLg0RZE2Z7fT81AHTV2z
         IWiw==
X-Forwarded-Encrypted: i=1; AFNElJ9mjoBcUaZ9pqMEC0PBmiASSjSdTpfYogeSaKxuUVHAuqOv8E/p9PlyHiY1azZaWRP5pNas5KXxkBcogbE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzU66NWytmdoMbag7rVb7wmoMGdge+zqmTkYXwEe45QIzcW0pMA
	5u61intpXo5WSLcnzyXg1DLxyARZG+GQym8Wfkmptlpekjh1C5E8T0vp
X-Gm-Gg: Acq92OHTF1bLY5Qd8Q9Esx5uM3Zwlu7DiHVWihhRC41K0ViXxx/ncQ49FqKAz9PpGeN
	WmBaYqDMGNC2UKrUDAQD/AhR0GciYBhTiJdqFg3Xkk88VsZqdx0Ngah+R80zPZa2bUZNojB7wSa
	JP7FhHnPD8zah0tH1x8eDuvuceSA2modqBwkPauTt7V1zg3Yhcaj1FgDWPEnCLZkrPwYmM1FTzj
	+JNiVWta8r2+WmloNCNeBnlRnypgSz78HnEFd0vdZijKePwmE/ghOgztD9UtQUp0Yf1ZB6vbw9o
	F2TkCd8OLuX4UDsISpi8WxSTpBXFJo0YpSV4QnaOzzbb+JOoUgU3Vi5oiZYBucEeqSQ5CmjJktt
	eyyfosuKLGLHFEQc1+h6Bfn5HOWmSQDbe5RJW+a82sR4OAJuGfxVfSA9++gfw5kc1n0TgbfyQCp
	wqDT0iuYebv6byp4XNneMaj2xRsAXDzuoK
X-Received: by 2002:a05:6512:3d1a:b0:5a8:8222:7fbb with SMTP id 2adb3069b0e04-5a8a94c6b2cmr5792750e87.34.1778541611890;
        Mon, 11 May 2026 16:20:11 -0700 (PDT)
Received: from foxbook (bgw15.neoplus.adsl.tpnet.pl. [83.28.86.15])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db67esm29185641fa.24.2026.05.11.16.20.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 May 2026 16:20:11 -0700 (PDT)
Date: Tue, 12 May 2026 01:20:06 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: IBM Power S822LC: pci 0021:0d:00.0: xHCI HW did not halt within
 32000 usec status = 0x0
Message-ID: <20260512012006.66aeb0c5.michal.pecio@gmail.com>
In-Reply-To: <69fa1c3f-3ea9-42cb-a49a-7da39f72806e@molgen.mpg.de>
References: <fb68e15d-b8f2-42ac-aa65-0d9fedcfcdbd@molgen.mpg.de>
	<20260506193037.6de9e355.michal.pecio@gmail.com>
	<69fa1c3f-3ea9-42cb-a49a-7da39f72806e@molgen.mpg.de>
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

On Mon, 11 May 2026 23:57:33 +0200, Paul Menzel wrote:
> Am 06.05.26 um 19:30 schrieb Michal Pecio:
> > On Wed, 6 May 2026 18:06:20 +0200, Paul Menzel wrote: =20
> >> On the IBM Power S822LC (8335-GCA POWER8), rebooting into Linux 7.1-rc=
2+
> >> with kexec results in the warning below:
> >>
> >>       [    0.000000] Linux version 7.1.0-rc2+ (x@b) (gcc (Ubuntu 11.2.=
0-7ubuntu2) 11.2.0, GNU ld (GNU Binutils for Ubuntu) 2.37) #3 SMP PREEMPT W=
ed May  6 08:50:5
> >>       [=E2=80=A6]
> >>       [    0.000000] Hardware name: 8335-GCA POWER8 (raw) 0x4d0200 opa=
l:skiboot-5.4.8-5787ad3 PowerNV
> >>       [=E2=80=A6]
> >>       [    1.593760] NET: Registered PF_UNIX/PF_LOCAL protocol family
> >>       [    1.593859] pci 0021:0d:00.0: enabling device (0140 -> 0142)
> >>       [    1.627080] pci 0021:0d:00.0: xHCI HW did not halt within 320=
00 usec status =3D 0x0
> >>       [    1.627094] pci 0021:0d:00.0: quirk_usb_early_handoff+0x0/0x3=
00 took 32465 usecs
> >>       [    1.627123] PCI: CLS 0 bytes, default 128 =20
>=20
> > Does it work any better if kexecing other kernel versions? =20
>=20
> No, the problem goes as far back as 5.17-rc7. (I didn=E2=80=99t try anyth=
ing=20
> before.)
>=20
> > What if you increase XHCI_MAX_HALT_USEC by 10* or 100* ? =20
>=20
> I have to test this.

I missed your dmesg attachment previously.

This may not help if another halt attempt 200ms later fails too.
Per spec (5.4.1.1), the HC is supposed to complete halt in 16ms.

> > Does the controller work normally after this warning? =20
> It does not look like it. In the log attached to my report, later on=20
> there is:
>=20
>      [    1.739374] xhci_hcd 0021:0d:00.0: xHCI Host Controller
>      [    1.739431] xhci_hcd 0021:0d:00.0: new USB bus registered,=20
> assigned bus number 1
>      [    1.794727] Freeing initrd memory: 52928K
>      [    1.801984] xhci_hcd 0021:0d:00.0: Host halt failed, -110
>      [    1.801988] xhci_hcd 0021:0d:00.0: can't setup: -110
>      [    1.802137] xhci_hcd 0021:0d:00.0: USB bus 1 deregistered
>      [    1.802154] xhci_hcd 0021:0d:00.0: init 0021:0d:00.0 fail, -110
>      [    1.802250] xhci_hcd 0021:0d:00.0: probe with driver xhci_hcd=20
> failed with error -110

Right, this chip seems stuck and the driver fails to reinitialize it.

> PS: Claude Sonnet 4.6 cooked up the attached patch, which does *not*=20
> help though, but does get it to the return code 0x10, which Claude=20
> replied to with:
>=20
> > =E2=97=8F The status change 0x0 =E2=86=92 0x10 is meaningful: 0x10 is P=
CD (Port Change Detect, bit 4),
> >   HCHalted=3D0. The old-kernel reset (from our commit) did take effect =
=E2=80=A6 =20

Do you mean that running xhci_reset() before kexec() causes the new
kernel to see 0x10 instead of 0x0 in the status register? Is this
reproducible, not random or a one time fluke?

A little odd, one could expect reset to have the opposite effect.

Is there truly some machine firmware running during kexec() and using
the HC, as your LLM says?

I honestly don't know what to do with this. I think I would start with
looking whether xhci_shutdown() in the old kernel manages to halt it
successfully or if it also fails, and what's the USBSTS there.

It seems that you can get such information by enabling dynamic debug

  echo 'module xhci_hcd +p' >/proc/dynamic_debug/control

and capcturing old kernel's log up to kexec() through a serial cable.

Regards,
Michal






