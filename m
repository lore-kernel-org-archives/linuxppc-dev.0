Return-Path: <linuxppc-dev+bounces-21401-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95303CD5BB0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 13:59:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMRj416jBz2xFl;
	Fri, 22 May 2026 23:59:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779458360;
	cv=none; b=Akk65Q15yuw+I3ws8UI2P60gIeBtODaMmx6sUIh0X7qQVcTqwAqVd0+NcPSjBCJi+TxmUYcNmCUa63Fc8qLN09zx0cZDuUdll15Ea0g4JMvWpnqu3ywxZDB7cAX1wIjdJpWpZeDo66nP89a7lnH/WmHQpzejtNtdI0IiJr+VO6uJIqD8Hk0ssgrDOC2JTXhFBpaw0xmuSP7+gxGISdyccZwlIcwi43Bh1DNTkj8jQhSymV2rEf+uhfWxzYw+uwPkd5Y78XNF6A5Mn6vyHwfVDf0UJBa1/+f4LAKCSAKCXSJayp/BT9+Qx74rzl/sgk/hLRw5K2Vx1olAY/QUOT2rDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779458360; c=relaxed/relaxed;
	bh=KMvj1aWLuME+cEJb5+X2gqSdfvUyTzaMWJ39Wcv6FfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTR6gxGlT9OsOoOUPXBn+TP0LyycS/2s7aJ1mhlF+5mL142IVIhE0McKU+P57nicH88qakN/ep2E84JhIxjKscXfMqh30NIuEXMZpYRqmikmdRSwHvOhBv3viNtOxJ0IEUJQy+B2i786W+cHKk2cgUTCtus2t506u9ok3IV0uC5Ygfxo5alA1Q0+x8FLc4b7i17n0ANLes5G2A3YEvxwm3XWqPKkvZoE+TAmgB170VDSDD2lAODQe5/6HrJJ24JhVKZ/9XPQ4viMPNWjeR4t1DcI6MBBuz7fKeGkHePKib6F85ZM2h+nzVdQ7IXey1N+qaZVrRpxr5w6JRXL818Ajw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=qxWpXiyQ; dkim-atps=neutral; spf=pass (client-ip=212.227.17.21; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=lists.ozlabs.org) smtp.mailfrom=gmx.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=qxWpXiyQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.de (client-ip=212.227.17.21; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=lists.ozlabs.org)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMRj02KfVz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 23:59:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779458342; x=1780063142; i=deller@gmx.de;
	bh=KMvj1aWLuME+cEJb5+X2gqSdfvUyTzaMWJ39Wcv6FfE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qxWpXiyQJJzGuqGd10NL1vlIHWZm/Bg58XmQwseJvIJWeZ8Ow2GX55WiSbmWCvWc
	 UGdEEZvHo/xH3d9mKlyAt1IH8+cdd2/Np+qgqVZ+Bp5pN6eC2v0afLsGBaxouLOL4
	 1QasVKNjQgpIl7lu27JY77XP7jPRbdDlZ10VTteGS6nKZUzSrqscmrsI710KAuYIn
	 1hxk/7Nz2AfNtsmiWeAa+WIYI7aTxLSABJmRA1b56vdXGncUNv9L4Q2N1NaToxQLK
	 OADRb7kkuDo1tcLLQIf+97wxsQOYikUYPtmA+w1o3TTyGE3SSl2nKmsNk8tHKbBy4
	 DIN0y92xXAxtfRprMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5eX-1wjKjL17Th-00PZJY; Fri, 22
 May 2026 15:59:02 +0200
Message-ID: <8e37cd60-4886-4018-83bc-8c6720264ecd@gmx.de>
Date: Fri, 22 May 2026 15:59:00 +0200
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
Subject: Re: [PATCH v2 0/4] fbdev: Internalize fbcon
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260522123019.211059-1-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260522123019.211059-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PhttPxjbtarZX/dn2e5bcyXGol4bkp3O5paNGZSi5UW2R5YckDk
 ZueNxWYguIhBF4QUMwGeuF5Br4UBa7nMv5M/1Mw1GLep9V1OMKjYIi5KvbmcHh4xJVJKh68
 RRLm9wvk1ExDSkBYYU+INmpQULSoc2Z5hgWpqMVXnEq/GkcbxFAKMlgB+0hyzNfOg327Lxa
 GgX6rMtXrkKOgHx2LtuMw==
UI-OutboundReport: notjunk:1;M01:P0:z2frKFNg8Fo=;lNNosPOz9KzvwjKwcN0t64SnhBc
 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

On 5/22/26 14:28, Thomas Zimmermann wrote:
> Turn fbcon into an internal client of fbdev. Manage all interactions
> with graphics drivers within fbdev. Add helpers for these tasks and
> convert drivers.
>=20
> Fbdev's PS3 and SH-Mobile drivers update fbcon as part of user-invoked
> mode changes. Call the new helpers, which also fix inconsistencies
> among the various code paths.
>=20
> Vga-switcheroo remaps the fbcon terminals when switching physical
> outputs. For now, hide this in another helper. The call will later
> move into DRM's fbdev emulation.
>=20
> When all refactoring in place, fbdev manages fbcon interactions by
> itself. Remove the public interfaces.
>=20
> v2:
> - use '#if defined' (Helge)
>=20
> Thomas Zimmermann (4):
>    fbdev: Wrap user-invoked calls to fb_set_var() in helper
>    fbdev: Wrap user-invoked calls to fb_blank() in helper
>    fbdev: Wrap fbcon updates from vga-switcheroo in helper
>    fbdev: Do not export fbcon from fbdev
>=20
>   MAINTAINERS                            |  1 -
>   drivers/gpu/vga/vga_switcheroo.c       |  6 +--
>   drivers/video/fbdev/core/fb_chrdev.c   | 12 ++----
>   drivers/video/fbdev/core/fb_internal.h |  1 +
>   drivers/video/fbdev/core/fbcon.c       |  3 --
>   drivers/video/fbdev/core/fbcon.h       | 50 +++++++++++++++++++++++
>   drivers/video/fbdev/core/fbmem.c       | 35 +++++++++++++++-
>   drivers/video/fbdev/core/fbsysfs.c     |  9 +----
>   drivers/video/fbdev/ps3fb.c            |  5 +--
>   drivers/video/fbdev/sh_mobile_lcdcfb.c |  5 +--
>   include/linux/fb.h                     |  3 ++
>   include/linux/fbcon.h                  | 55 --------------------------
>   12 files changed, 98 insertions(+), 87 deletions(-)
>   delete mode 100644 include/linux/fbcon.h

series applied to fbdev git tree.
Thanks!
Helge

