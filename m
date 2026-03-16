Return-Path: <linuxppc-dev+bounces-18268-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1506F506D5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 13:55:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZGnc3RZdz2xlm;
	Tue, 17 Mar 2026 00:55:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1331" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773669332;
	cv=pass; b=eh/D/LVUvq/GU5lyMqU3XaTVpS7N3/E2prll0RiKhBjq9YREl8wy323/KaM+KtogIvrURBFXEzDhcHRD6Hc4vRxAajtMR9+/+YHneShCPMe7UCdyLDmxUXK4hieem2T5zhJVK9HuNK2SAm/5Nbvsm9VXMfDHRSXwegikWZzRlGAToMdv4QzGGwaTiMvh7hWB/lVpDYhMoH5dDvMxj+gEx5ZnE6Puui4PPq00EUIsTK5fIaFxrZWWQ0CvihpIaJzyi/rRFwMfzT6mGdpAMRp9PWMnJs2i1k41kQzVisVo7Z1Y7OM31ZXqCKpwyqlhwVwi70zgU+RNrayYh+OxE0/F0g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773669332; c=relaxed/relaxed;
	bh=FTI7NQgAEhMnCW1csRakxcCdxdVfEQWy93QY+u6DtxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kr+lKnGkh5lp4BVFVQ5hzN/ON2ArrnB7m+w/x5F159D7Y0rbHlko+uZCvaXmlbZQ+pNFytBKgwF+WvDsUdXQB/cohY01s5yTWUYBN5ZjaHKW/OzI/ONbXbbCl6yYzs04dC4MxRirpUj5lG3fRsLX5fwf17L96XkmyL/SjpPlOvvDHSSu17VqovNha3BmfQfy/9Lq71RF2BaHA2jlKokVgsB+V41JlE9NyelpW8+CUsqXjfDbSHydWm0auFbuXokwKT+aGKFAMjmvne7f8oa7fSV1cHPHgYA2xJXo+TRqylqFrGZZP6uylgaR5n5amjOktEZYZ9Kb6606+o978R9x5w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FsjPymeZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=alexdeucher@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FsjPymeZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=alexdeucher@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZGnZ2mh4z2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 00:55:29 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-2c0ba72d097so92856eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 06:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773669327; cv=none;
        d=google.com; s=arc-20240605;
        b=JGY8ejCOwc+Nt4/FI2/larClkM4wAHbFCHz96joJ+XXBPw0dn77vO1qrvk7HR/E3tz
         tTMTezMqbCusnO42MNxFpfLBFHymMixfM4QkyEkFb4CxDV1pACScV9s2/UX1ciPP2W0y
         oKWBUDmpadCCnBQ8TKD7eVoXuhwCnainZJPQuMamIOzBY+U1aOJuUMYCzT+EsC5FCXYM
         ek7boEVDGyvyPJTnJjNstSWLASf9PmxskyCPI05Dprt4hZlfmT8/eKhPpehRRS756fYd
         gnESKEqnMUoIaPx++tDwvRKJDMRYE30d1M7TplqeoiXDpKyslS4soxOoIRtnHFD9K0nn
         cXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FTI7NQgAEhMnCW1csRakxcCdxdVfEQWy93QY+u6DtxA=;
        fh=S5DhNwmRNJBnE7HJuOsOMlA42WDWubFtIS3FuK77mFY=;
        b=HjOGUBSot9ZnYvGzHmNmQj6hkgtdCDD0YbL/7OhyX4O237cx+JMOXrEW5ywcyRp7mc
         arjBle/fHHAwFo4VzYKt3S9NjygF+AaeaO2U/CLd/8PpRa5sCYIvuTKLC4iC4kce4CSe
         p+XPDWBTGqbtueVIgWGYSz0ykV+SwLIDdK0ACgvIcZqhkFCnNE4q5hrnaP7Dswbtl3RP
         0ckjchrI5wk58tziZZAXYE/wxkHfurGWdehL+jQ5P6HPTyTA6zlc7B9l9pwIHnOeKI27
         qBcCRcKvs5F786Ng1vqO5VhL9OVDPnxI+a4ZNqt74AqKF3KAPR6FGP1ZLNs1tZWA/gI9
         zwiA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773669327; x=1774274127; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTI7NQgAEhMnCW1csRakxcCdxdVfEQWy93QY+u6DtxA=;
        b=FsjPymeZiKomAhlyTgi/t3JP8jHFILOsjAJP05puugzUeWgyNDhMXtMz0Rq/UVvTUD
         5PvfUCHa4WVWCYAOb0VukZTrRwFZvsV0A6A/kpDCflXI8hAyf71DdiaNlCmK36b5iN6P
         k5W/+NhHoK4oDD2IKhZ58QvRRIEZc/c82w1DKpetTqSNpknAdzbCiCelBfarFouJK6EH
         uV92aFwDE8JX5gVYKbutgSYGmgMxbGN1ek7qeyalAjAv0mBB3GKKJb12Nf83xRDbNSEn
         xtHlJfecdg/l085eBTkdz1UZLIJyV8ZBHwW+RI5p4klFJCD2Rq9RcTiTwZBXCvbduBL5
         vjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669327; x=1774274127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FTI7NQgAEhMnCW1csRakxcCdxdVfEQWy93QY+u6DtxA=;
        b=CDwjpJ/I4LfATaTtQpvhpwSfb+lv3KXImX4//HkStaOkhBH5rVypossJn+pf0WbzG7
         d1MfG5/MgBg7fL7+cOz1vKYqWxf9/F1ifx8olF1LTgjEQ5Bu+VUIVcw8qv+gkNdQ1kuu
         iu5k06CZ0GY8G7OAJ4WT0TH10BFMNDesng/wdZN4PspzkxaYIQI2fqaT7M62dFPr2/FC
         6pnIZUNDlBJAFlhQH9MnktguWhwP2WIAZPp72oXVNQ1H5fdAySFRPGe+npYtYdaz620Z
         1hl4GhRLY6x35uJVTOg0oILiE6VDVtWIe9/ny64XURQPLesn+2VTLomGgwpF9jFjaJjQ
         QMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzi2Z8JywGRybgbqTpj5ghhXgVwOFSEQaIh+AWGrwZflOouQ/KdwBvA9cnLlG5vwKT1jWyFfRBhd5E1B4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxsI6jYwrQ4lc/xmPKTKJMFw31NDZ2m5z5bimP1ts4OIt7uUDpg
	EybIWM21h+QqzUbuGFTzHCwzEVSK+CzuD/J9LIRxA/14H5PIzoEHiPX74e8SaV9aLsXEEToV8sQ
	HvWjJ7Rd9BR6lithjquJ3A1/HLIC7N2Y=
X-Gm-Gg: ATEYQzyQY+lJyzR4WSbmU179tvx+GNDluLt0NGxV0p1LXiDy99uBggZT0Q9gPE06wyZ
	SWoonKg1GNHvN3SA7gBlZxT+DTSAYUurlatXHdFwH/owQFOZxCQNJWNELwIYwDW7pMIMJm9bA28
	58Y62gG2tm9OYgar7hIxfR2doZgZ3avt5dT8qlDmk5+WZbC1CPDT7233LuwTQknrGNKrThfs1Yw
	9r2f7YIOkgyMZl9IaqLYecWTiRt5cF9IjZptS1J1E5Bg1Ay10S/WOg+t7ERl/JuNFPHgCkd4zFo
	7lO8C4Fk4XLRO2PWH3B0BaSZxnPGICdAllBjjwW/huVaCB62yOqpZi9V9F8ajxe8GPwE4A==
X-Received: by 2002:a05:7300:5381:b0:2be:7eb2:2ed3 with SMTP id
 5a478bee46e88-2bea539bff3mr2901460eec.1.1773669326880; Mon, 16 Mar 2026
 06:55:26 -0700 (PDT)
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
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz> <1phlu3bs.ritesh.list@gmail.com>
In-Reply-To: <1phlu3bs.ritesh.list@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Mar 2026 09:55:15 -0400
X-Gm-Features: AaiRm53_ccrgezS35W1n8IrX8XVanOeDHAQj2R8ZIMS0L2p2PMNUMQSQA2nolFQ
Message-ID: <CADnq5_Mk+D5CSe61F6DewQjevjhsduiga21f8dVrLwR28zcwvQ@mail.gmail.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: =?UTF-8?Q?Dan_Hor=C3=A1k?= <dan@danny.cz>, linuxppc-dev@lists.ozlabs.org, 
	Gaurav Batra <gbatra@linux.ibm.com>, amd-gfx@lists.freedesktop.org, 
	Donet Tom <donettom@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 5:44=E2=80=AFAM Ritesh Harjani <ritesh.list@gmail.c=
om> wrote:
>
> Dan Hor=C3=A1k <dan@danny.cz> writes:
>
> +cc Gaurav,
>
> > Hi,
> >
> > starting with 7.0-rc1 (meaning 6.19 is OK) the amdgpu driver fails to
> > initialize on my Linux/ppc64le Power9 based system (with Radeon Pro WX4=
100)
> > with the following in the log
> >
> > ...
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: GART: =
256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
>
>                   ^^^^
> So looks like this is a PowerNV (Power9) machine.
>
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] =
Detected VRAM RAM=3D4096M, BAR=3D4096M
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] =
RAM width 128bits GDDR5
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu:=
 64-bit OK but direct DMA is limited by 0
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_io=
mmu_get_required_mask: returning bypass mask 0xfffffffffffffff
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  4096M=
 of VRAM memory ready
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  32570=
M of GTT memory ready.
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) =
failed to allocate kernel bo
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] =
Debug VRAM access will use slowpath MM access
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] =
GART: num cpu pages 4096, num gpu pages 65536
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] =
PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) =
failed to allocate kernel bo
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) =
create WB bo failed
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu=
_device_wb_init failed -12
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu=
_device_ip_init failed
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: Fatal =
error during GPU init
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: finish=
ing device.
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: probe =
with driver amdgpu failed with error -12
> > b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  ttm f=
inalized
> > ...
> >
> > After some hints from Alex and bisecting and other investigation I have
> > found that https://github.com/torvalds/linux/commit/1471c517cf7dae1a634=
2fb821d8ed501af956dd0
> > is the culprit and reverting it makes amdgpu load (and work) again.
>
> Thanks for confirming this. Yes, this was recently added [1]
>
> [1]: https://lore.kernel.org/linuxppc-dev/20251107161105.85999-1-gbatra@l=
inux.ibm.com/
>
>
> @Gaurav,
>
> I am not too familiar with the area, however looking at the logs shared
> by Dan, it looks like we might be always going for dma direct allocation
> path and maybe the device doesn't support this address limit.

The device only supports a 40 bit DMA mask.

Alex

>
>  b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: =
64-bit OK but direct DMA is limited by 0
>  b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iom=
mu_get_required_mask: returning bypass mask 0xfffffffffffffff
>
> Looking at the code..
>
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index fe7472f13b10..d5743b3c3ab3 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -654,7 +654,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size=
, dma_addr_t *dma_handle,
>         /* let the implementation decide on the zone to allocate from: */
>         flag &=3D ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
>
> -       if (dma_alloc_direct(dev, ops)) {
> +       if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
>                 cpu_addr =3D dma_direct_alloc(dev, size, dma_handle, flag=
, attrs);
>         } else if (use_dma_iommu(dev)) {
>                 cpu_addr =3D iommu_dma_alloc(dev, size, dma_handle, flag,=
 attrs);
>
> Now, do we need arch_dma_alloc_direct() here? It always returns true if
> dev->dma_ops_bypass is set to true, w/o checking for checks that
> dma_go_direct() has.
>
> whereas...
>
> /*
>  * Check if the devices uses a direct mapping for streaming DMA operation=
s.
>  * This allows IOMMU drivers to set a bypass mode if the DMA mask is larg=
e
>  * enough.
>  */
> static inline bool
> dma_alloc_direct(struct device *dev, const struct dma_map_ops *ops)
> ..dma_go_direct(dev, dev->coherent_dma_mask, ops);
> ....  ...
>       #ifdef CONFIG_DMA_OPS_BYPASS
>           if (dev->dma_ops_bypass)
>               return min_not_zero(mask, dev->bus_dma_limit) >=3D
>                       dma_direct_get_required_mask(dev);
>       #endif
>
> dma_alloc_direct() already checks for dma_ops_bypass and also if
> dev->coherent_dma_mask >=3D dma_direct_get_required_mask(). So...
>
> .... Do we really need the machinary of arch_dma_{alloc|free}_direct()?
> Isn't dma_alloc_direct() checks sufficient?
>
> Thoughts?
>
> -ritesh
>
>
> >
> > for the record, I have originally opened https://gitlab.freedesktop.org=
/drm/amd/-/issues/5039
> >
> >
> >       With regards,
> >
> >               Dan

