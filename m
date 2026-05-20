Return-Path: <linuxppc-dev+bounces-21251-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9FDCD5BA4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 18:55:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLLNB3dyDz2xqv;
	Thu, 21 May 2026 04:55:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779303354;
	cv=none; b=bGRSJf/7V2glRlE/Uh3WQM/+bO/LNNZagVp+2pvLyK+uOXs8i0GYRqHtP6bbnaH2FgkrKJAzLsZoNFKq658Qz0CPLVjPR3glpPgQGzEOOPWoxzTy2bDYeJA6M2gxrFHcmDx29ea2MGPjgdQjxfOP6dT/SwNrNZvFp5oAZm/SWUSVMZd7UgCEAga3Ob0YRzBAwfEH3fuIHKYEd4V8pvRINuspsmipnVp1PDI5riEMB8+UiVWv0oF220xBCt0g8cw+ZpXz8P2x3wHsYG7xsxGK5cDE+9cGdklg5ZY8hBDEmZmCo/WAioqWFT+CflGcWaD0h8fNbTa8RlvfP5sW3521gA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779303354; c=relaxed/relaxed;
	bh=F35kee9xljIjjs+QrqI9vWZzAxuDXiLBx+EoTCwdTOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBezHKTq6nabWPLNzIsEt7IvwMhrKGkCvdn6r9K9hQ3VnNc3nHnADphHugaAZJL2zU158cQg9lTB4jqqnPU28Xr5MB5K5lR3nRReFYjkH8aFESk88woz10C6HvNLB4SOzlajjoqAHjdH+u3neN0XtpcpsRuqnwW3jDDMIAHvas7BVnSwIL/C0mblOOwYq/USAMAHqxu2jwDTnBXzRi6wwqW2qJTcit7FwU/KXCBF71sGk2YmudG8wCaRM8wOsyNn+k4RWhHZWU8pWx6SCxhFjLHO+IyH8HrwmnxclPQ0YWxc7e3wejx+TOYcallqnZRFHng5Px9q3p7nszPt0OPAPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=hH+FKyiq; dkim-atps=neutral; spf=pass (client-ip=212.227.17.20; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=lists.ozlabs.org) smtp.mailfrom=gmx.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=hH+FKyiq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.de (client-ip=212.227.17.20; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 350 seconds by postgrey-1.37 at boromir; Thu, 21 May 2026 04:55:52 AEST
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLLN82wNWz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 04:55:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779303338; x=1779908138; i=deller@gmx.de;
	bh=F35kee9xljIjjs+QrqI9vWZzAxuDXiLBx+EoTCwdTOc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hH+FKyiqijM3GpfFC1NbhNq8VajUiJ1CBf4M5SJmt1Zt5l368Rv53Z6C32Xb4KCs
	 OxKlxOkojW3eXp6ghZ48O8gri+fQvblBd02g4kKjek10TS0kZTUfQ3F0wA4P0bcgi
	 2WsDXfh2iURxs/NRqtyr9XEPkWEX/HMNC76LlvGxpySRCGJNc/zk0vsqd6v/M2fxk
	 plrbUazA3sYFrZCtlWoah/3/tKYHo+QOV7FCcoJ9/hlSe38lzzXEscoJkjbi0g2xt
	 PU2rni4s7l3OQh54NS20DaJspH34sbe9Q/NQ0V6KwH9DQYbeXowPbOwYe1Qs+9XdR
	 35G96dfxrKiq1oCMIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf4c-1x7OHB1cP4-00pRbB; Wed, 20
 May 2026 20:49:39 +0200
Message-ID: <a727f5cc-df21-4952-a24e-7d065abbb47c@gmx.de>
Date: Wed, 20 May 2026 20:49:35 +0200
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
Subject: Re: [PATCH 3/4] fbdev: Wrap fbcon updates from vga-switcheroo in
 helper
To: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch,
 airlied@gmail.com, lukas@wunner.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260520160744.130841-1-tzimmermann@suse.de>
 <20260520160744.130841-4-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260520160744.130841-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P7vQ+mxKVjb4yokUnXgbJdgAsnePPvVB9BDP5k4q8ysHz7ESqUa
 711LWotZfynYvbvKuwEkNRV9HVhQfLCqbB6RM/t7UJtazI5/RxTjzmeAW8gZ4vlEKPqDYoj
 bd+oltPb/71Gz4QV/XgS78vcEclpik8PFJ0VyESx+9iveTmoiwK2EKBgC2xmQV2YrJRMtdO
 FHFuW6z9K0xklTew07zIg==
UI-OutboundReport: notjunk:1;M01:P0:xiJnsDkr2uM=;PJ1cEv15+ObRIP6kfX5AkvNwVo3
 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
 oBCleY/ro0mgLkhBCM=

On 5/20/26 18:00, Thomas Zimmermann wrote:
> Handle console remapping in fbcon in fb_switch_output(). Vga-switcheroo
> invokes this functionality before switching physical outputs to a new
> graphics device. Open-coding fbcon state in vga-switcheroo exposed fbdev
> implementation details.
>=20
> Vga-switcheroo is used for switching physical outputs among graphics
> hardware. This functionality is only supported by DRM drivers. A later
> update will further move fb_switch_output() into DRM's fbdev emulation;
> thus fully decoupling vga-switcheroo from fbdev.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/vga/vga_switcheroo.c |  6 +++---
>   drivers/video/fbdev/core/fbmem.c | 10 ++++++++++
>   include/linux/fb.h               |  1 +
>   3 files changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_swit=
cheroo.c
> index 8fe1ae3c71bb..805953d0b941 100644
> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -31,11 +31,9 @@
>   #define pr_fmt(fmt) "vga_switcheroo: " fmt
>  =20
>   #include <linux/apple-gmux.h>
> -#include <linux/console.h>
>   #include <linux/debugfs.h>
>   #include <linux/fb.h>
>   #include <linux/fs.h>
> -#include <linux/fbcon.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
>   #include <linux/pm_domain.h>
> @@ -735,8 +733,10 @@ static int vga_switchto_stage2(struct vga_switchero=
o_client *new_client)
>   	if (!active->driver_power_control)
>   		set_audio_state(active->id, VGA_SWITCHEROO_OFF);
>  =20
> +#if CONFIG_FB

I think this should be
#ifdef CONFIG_FB

Helge

