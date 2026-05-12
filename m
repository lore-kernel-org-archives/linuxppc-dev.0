Return-Path: <linuxppc-dev+bounces-20786-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7696FCD4F21
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 12:08:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFFjK0KlZz2xnQ;
	Tue, 12 May 2026 22:08:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::230"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778574164;
	cv=none; b=AeJaiJsgEeXXYf4ysb5GV724JMCq83tzQEQLzg0sqSeiIKDsI8Zbxf/OI043PWIfp+G/q9wB2dvUHD+P/Oo5CQp1JenUTUZeJAaM30IDRKAEngTij4ZI0lxgdNRKeAeSgeHTgDY8fvtgs+//8tNt57dwcy7kBBaVxAJb54PKG++2WnzyoVk9HG7W4vnzNsDC8kQvPesCriM48fCoCrz2TRlwS3nDiaY3L8PH0eSMJMTB12Im+wiNKK+fVVNlruWeYUL48qGZfUubhx+GjAG61eX+tMKuir3r2jQ+GGiiUQZudEGbcb6boLHIGTlo2dBMKrT+a4HKnp2tFxNrCDHV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778574164; c=relaxed/relaxed;
	bh=PvJeMgbrCU82xcWyDwUyahfaQJD8+fqAy//y7uYzovo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6TMr386hB2LPB0acdbWHrSUp/q9I0pEfnDdQpkr9Yq5KnLlaWotGJwiuPC5McPNdwA+/hSACScitbrg8GXuYaeQr2PF5k7clN95H/Ty5uTgthMsC8SRx0/fnE8MnTsaS7rtRSGh78ngY9bonIzsywHUU2sBDg0kwVWto1O6aoBjqxHa7UVMHQ294JINvbpS9NTDJbMcDlTmX2uXo7Gec+Cr2t3usNV95eukd9MnUg9TxvoXlDLcWBCkW7+FAoFGMRkDDMjYdI8vejQi6VC2EQxwGnQOwiGfE16OqVqmvC3BxLeogEYs6BG+CFzHU+KS8hiRAnBGRoDZbeF5tQMxEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RV29LrZp; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::230; helo=mail-lj1-x230.google.com; envelope-from=michal.pecio@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RV29LrZp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::230; helo=mail-lj1-x230.google.com; envelope-from=michal.pecio@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF8jG6lsyz2yCL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 18:22:42 +1000 (AEST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-38e7d983f79so45585901fa.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778574159; x=1779178959; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvJeMgbrCU82xcWyDwUyahfaQJD8+fqAy//y7uYzovo=;
        b=RV29LrZp2rxbbPu5W+V89q/24ADsuzf9iV3sgCTuRTk+dJj9R9hBKEfgjNpvWcJiCv
         zDQTlZWOPIPX+ha6FBjXarnlnfRiby7muZ36bqQeG9x/8c5GquGxIiVobPTy1TOh6ejz
         CK5zbwpBEGO6QT6d4jW5Z7hSI8WWoOxjtdMSXEE00/M+xABlmgQrDmICYBpjEpW2cEnr
         jfHsUv8ao2DOCzS3/SHlTfLMn8W/5Jd7x77FauaY1nqSImsJKCLM7bpXgRhCeY+usWpt
         0jY0gjWbHHhcN/GupOJkuFJyo3ytmy0qK6sofjRtk97DegEMhno9Mx+rHyZeM5PawjXG
         1INw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574159; x=1779178959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvJeMgbrCU82xcWyDwUyahfaQJD8+fqAy//y7uYzovo=;
        b=bNLvWKfJQSfS8GQc2NsThGDd47vacDBAUksM8gsKtyapWKluXoOM4C5KzRCjAk7tvM
         EClpQ6I7pmar+Js96cprxqKmdal6EFNzbLvVqep7IJ3i1BJ0sRsKFOm3Xi1JpZZMM8nU
         rQqKFSLppMjxfs7WqIx+L9XF6b5v7JJtiUqja3ETKqB3fUVSIJc39K/TdwwFdUvhFkPR
         GMRPTsAVqRg6mxz2yXabaG94DQhvRPTom9DV1izMNBsWAx7s1t05+XiDxYjcdCJ2Wf4B
         sBpQjkxYphXCm4AEqy5p6+rganyHvEBBdSyAYKZamtnmiAtMD+VvF5MMpDbTEAeU7ROr
         HoOA==
X-Forwarded-Encrypted: i=1; AFNElJ8vfL6631o6wB1APaz0rCR/im6Ppi4SlWEZ6kIqb+oPqOtLxA5mfc7RdlDdrAwO3hvwG0AHkEOsW/3AQUk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyttVUuM1wfxch7yYnuPpm4cxX9mdb0+q+/zycnWBTfYEN6jxzq
	Pfr4BdUwZB3ALelfP2D7neio71MSoYCFjbCjATVFxa1W1oF5lKZmD+Qd
X-Gm-Gg: Acq92OE0MdWRM8vpYXKHS1Z+6c1DEusN8wiBtucmZRKqeO136i9l5G+j5qXAWEUX2ur
	8qwjcAuzjrxJoKjdMyjYasrEr2ntdIk7WJucsWzn4Y7fy2cM89+Ww0P3gA63BHbCNLDx72eD4Lo
	o3dHKRgYUO1NtS7JfxuwPOv0/LaWEmnN6IATHUHBCXwZzixTXA9sjum0JSXKnefio01BtFSUsNE
	sc7clY7X/T2zYfEv7mG4U+DudqQVra9Ts6kwb/Y7uOBpana7ibJ4OdFLhTyEOBUFtiYNVlvIAuf
	tBLOIgvzDOPn553hJbOhgJX4Y+527+nouxKuXPC8NT5Jyiidxl1BfpI6e7Trh+laiEThc7TkmZx
	CtyKncFTrB6xT3RR8oYEk3x5Jk4kBXprpv/vMj+PcIotYc7Nut8lNGJudLSy3DIqf5SIBXkm0i9
	Z01vheO+2ZHJIDHOFU1NBszgCIvgYh+UKY
X-Received: by 2002:a05:6512:128d:b0:5a8:6b81:6694 with SMTP id 2adb3069b0e04-5a887ce5e99mr8550473e87.30.1778574158311;
        Tue, 12 May 2026 01:22:38 -0700 (PDT)
Received: from foxbook (bgw15.neoplus.adsl.tpnet.pl. [83.28.86.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a955df99sm3246603e87.45.2026.05.12.01.22.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 May 2026 01:22:38 -0700 (PDT)
Date: Tue, 12 May 2026 10:22:33 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: IBM Power S822LC: pci 0021:0d:00.0: xHCI HW did not halt within
 32000 usec status = 0x0
Message-ID: <20260512102233.290d3665.michal.pecio@gmail.com>
In-Reply-To: <6106b5b9-17d2-48be-8215-3320f3d1d261@molgen.mpg.de>
References: <fb68e15d-b8f2-42ac-aa65-0d9fedcfcdbd@molgen.mpg.de>
	<20260506193037.6de9e355.michal.pecio@gmail.com>
	<69fa1c3f-3ea9-42cb-a49a-7da39f72806e@molgen.mpg.de>
	<20260512012006.66aeb0c5.michal.pecio@gmail.com>
	<6106b5b9-17d2-48be-8215-3320f3d1d261@molgen.mpg.de>
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

On Tue, 12 May 2026 08:17:08 +0200, Paul Menzel wrote:>=20
> > I honestly don't know what to do with this. I think I would start with
> > looking whether xhci_shutdown() in the old kernel manages to halt it
> > successfully or if it also fails, and what's the USBSTS there.
> >=20
> > It seems that you can get such information by enabling dynamic debug
> >=20
> >    echo 'module xhci_hcd +p' >/proc/dynamic_debug/control
> >=20
> > and capturing old kernel's log up to kexec() through a serial cable. =20
> Unfortunately, nothing is logged over the serial console (BMC SOL) after=
=20
> running `sudo kexec -e` or `sudo systemctl reboot`. I just see:
>=20
>      [69530.180531343,5] OPAL: Switch to big-endian OS
>      [69538.407292205,5] OPAL: Switch to little-endian OS
>=20
> Which is the OPAL firmware, so it might be involved? No idea, if it=20
> touches the xHCI controller.

So some FW involvement is potentially possible.

BTW, another method of doing kexec is to setup a crash kernel and
then trigger panic with /proc/sysrq-trigger.

This probably won't run xhci_shutdown(). Not sure about OPAL FW.
Is the outcome any different?

> But strangely no xHCI messages are there =E2=80=93  also after booting wi=
th
> Petitboot and initialized xHCI controller? No idea, if it points to,
> that during kexec or shutdown nothing is power off?
>=20
> With `sudo systemctl reboot` only the line below are logged:
>
>      [  121.811384] libvirt-guests.sh[3366]: Running guests on default UR=
I:
>      [  121.811988] libvirt-guests.sh[3376]: no running guests.
>      [ =E2=80=A6 (systemd service stop notifications)]
>      [  136.254846] systemd-shutdown[1]: Waiting for process: watch_ldcon=
fig
>      [  218.549684] reboot: Restarting system
>      [69760.484679183,5] OPAL: Reboot request...
>        3.55778|Ignoring boot flags, incorrect version 0x0
>        3.59881|ISTEP  6. 3

Only "reboot: Restarting system" looks like it's kernel. Maybe you need
to tweak loglevel before rebooting or kexecing? Try to get more kernel
messages showing over serial during operation, then kexec.

Regards,
Michal

