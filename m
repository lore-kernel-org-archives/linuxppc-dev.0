Return-Path: <linuxppc-dev+bounces-21252-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36022CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 18:57:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLLPb6953z2xqv;
	Thu, 21 May 2026 04:57:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779303427;
	cv=none; b=Lk5KbiG3ZlQOsjWdJ/xyUPX182Ls7qRMboSIVtoR1Xxa0jxKxFD9mRsGpb17Lun2O+QLwEIwnimFJ9yMJ3n5faxO7Jwki5i0o4YnGQN596PNGJD3ybaIiL1PVMos1Cf+ah3ELqg98S4RrOL3nhJX8XunvnELPdnxBDlASh3Mt5CabmO/wGgAsIoZm2AgbeHaNJU34XVH9NC6s+n5BGvFH41ZGyX3Cldh/hdJncd1MrXdkUOj+74qE/CvcmV9P0NBObiKMahy1IctN9M3iRosXEhhiDoXgt9Bbe8fwjZyf1OuZZ6edEFjq3ywy6alkqD3510JyRdhJTaHZ30Mlx+JOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779303427; c=relaxed/relaxed;
	bh=G6xkkVjlI6ZoUREp2X+ZLC+Szjc4sFX7UNAAEsOkTGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPhNxzwudw/BtqNdB2OMGCcPk9yhPlz3Q6V6e/Ccr0mO6SusdKrTTkCKoxEso9RrfXT1VURW5naM5Emn5grO9pfCmA61cBZ/6ErAMz2B+fkN48IyIqsNby6VkJSTPT/wCLZDxiyEcaTytkWSv2ztZH/d8kQz0N8SkTb34iODskvptgGrSjOaGwQmnbo6PlobYfqkVd07ph2pcTxLdu4zVnbA7pOPN4AXRUcCcXjd9+ngFDyIOoEaWI3kOdlVv9tqvHE6BqZNR9zCQn0fk8BghestTvrh7Z0594VzV8qRZ+MRByAuBWY5eXJgCM6+JGpDjlfkGCbeQ7+xwk7grRLWKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=UU+m+prl; dkim-atps=neutral; spf=pass (client-ip=212.227.17.22; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=lists.ozlabs.org) smtp.mailfrom=gmx.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=UU+m+prl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.de (client-ip=212.227.17.22; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=lists.ozlabs.org)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLLPZ2BZfz2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 04:57:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779303408; x=1779908208; i=deller@gmx.de;
	bh=G6xkkVjlI6ZoUREp2X+ZLC+Szjc4sFX7UNAAEsOkTGc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UU+m+prlXzag2iq8bbaox2LE+WvbBC43KhdRWw5vSIgmvrRiFcKKZxEnVfesaqJ+
	 nuGPmHac8MbKpmfT2yBKosIH8yWvQIjlFYRduxSMtxzVnGG1OrvNAVhJFbsvV/Er7
	 gRNi+4hsLE7I14MvEpzUgwpz20kG1EPi/P7j8nYl5kmwltPui93MNwIQIbyjUejNZ
	 UeDTCieGpDVOC3FvhiXa5KHifSJXSAos+4kTDa3bifFcZzPVX/1SfsCjYi6QRXfKe
	 4q28VowPNGmqg5tHPzjC7u7qnwWCcM01vl08qr8fANLc28BjGGKRaudoR9ozOJGa7
	 38jo+1k0pglCG5LZ5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGyxX-1wckR60HOV-00BhCl; Wed, 20
 May 2026 20:51:23 +0200
Message-ID: <0ce59eaf-1124-48c5-b812-c8e6b58e01d0@gmx.de>
Date: Wed, 20 May 2026 20:51:21 +0200
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
Subject: Re: [PATCH 1/4] fbdev: Wrap user-invoked calls to fb_set_var() in
 helper
To: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch,
 airlied@gmail.com, lukas@wunner.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260520160744.130841-1-tzimmermann@suse.de>
 <20260520160744.130841-2-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260520160744.130841-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jm03I80AqYIndy30iKmD9r+Zdl1AZUWrFuuaTiPwTD5+T9Gv6Fp
 /bgCo74En7A+U1Usqe61DP4SHiqLU5GSdGdPJpFdscsyY0a7H0bwughL+L7yshfQhbzXL4k
 v9bYMVNzG6Y9PoDfQyGPAZp3ptZ80KHOPO29ALVLOqE4eQBhrOklUJHZtgKuhxZjp+s1gRs
 XbX9Nta0usANYD4JkI3Ww==
UI-OutboundReport: notjunk:1;M01:P0:q1oNmOBachQ=;UPqfw0/vItfi4EJd70XbRwBYM+T
 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
 SVP7Cw==

On 5/20/26 18:00, Thomas Zimmermann wrote:
> Handle fbcon during display updates in fb_set_var_from_user(). Check
> with fbcon if the mode change is possible, update hardware state and
> finally update fbcon. Update all callers.
>=20
> Only the FBIOPUT_VSCREENINFO ioctl currently does all steps. Other
> mode-changes callers in sysfs and driver code are missing fbcon-related
> steps.
>=20
> With the new helper, ps3fb and sh_mobile_lcdcfb no longer maintain
> fbcon state themselves.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/video/fbdev/core/fb_chrdev.c   |  6 +-----
>   drivers/video/fbdev/core/fbcon.c       |  2 --
>   drivers/video/fbdev/core/fbmem.c       | 13 +++++++++++++
>   drivers/video/fbdev/core/fbsysfs.c     |  4 +---
>   drivers/video/fbdev/ps3fb.c            |  5 +----
>   drivers/video/fbdev/sh_mobile_lcdcfb.c |  5 +----
>   include/linux/fb.h                     |  2 ++
>   7 files changed, 19 insertions(+), 18 deletions(-)
>=20
>...
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 5178a33c752c..88680a7cabd5 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -533,6 +533,8 @@ extern int fb_set_var(struct fb_info *info, struct f=
b_var_screeninfo *var);
>   extern int fb_pan_display(struct fb_info *info, struct fb_var_screenin=
fo *var);
>   extern int fb_blank(struct fb_info *info, int blank);
>  =20
> +int fb_set_var_from_user(struct fb_info *info, struct fb_var_screeninfo=
 *var);
> +

"extern" int fb_set_var_from_user(...) ?

Other than that the series is a nice cleanup!

Thanks!
Helge

