Return-Path: <linuxppc-dev+bounces-24119-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92F0C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 14:20:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzPjm13R1z2yYq;
	Tue, 14 Jul 2026 00:20:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::52d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783952444;
	cv=pass; b=JkkFN0BWNPo2YcoQyhN0m6bXly3Dc/9PKrujMja8QR6kX/AyU2s//1d6cA2b5koc+veq6yTKPIP/LQ0w+3IaNWhqdtRE/qXLRs9OnMHKDIsCXOJ4WyMB0a/oMh2wwdXsFE9+TOeq6zp4LW1DZx7k9FCEJiCxKsvDTr0utts6vGq39N+HNCEogNhsnh3RWuWzUBrzIs7iugME71h+jl+3xOBx4GSJ/nH6PC6U6hYmxQvYJ6PTny5pDruQYEtKKy73bR7MhUYUCcSKtczIINhnTDSxayIvr8xy7To3xeSPvsh0XdJh/MTZDTMl2c7IuZ1XJHtMuRVsmCld33HEhpCM7A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783952444; c=relaxed/relaxed;
	bh=w4ixAGYQ3iLxgjQfDz+/RUCZM5NtPQu9ZWh2FbDKX/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnNnO5+xILXJmMj3Up8BZV4rjWVwUxIq00uBa1gQYR48M3CIVZc7mHMPpuygLEj63YU9/MtzIidSPZLEgVdKdfrrzN8yD8wEtD3ll73mpbv57gW+TEzDYYVPj5LqDLXHfVoAvCw85maTujyXJNjHlTMeyjYJeQ3dC+Ko6aapuamEkEKR6+Y44YwJxKIPOop3T1yUTsZ3lpMZGw7ctrBHD2ufChGAjHmZBs3nAYBFF6I+pOfxAys4/6u9dcaGPXMZcn6TJ1GLOyf76agFspBf4a6Bq7Wy4SELkPR+z8E7gXDOG4r0VQ0EjpwW/676ClTWX85X+mTNBV47uZFJ5j3EZQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YF42+fst; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=alexdeucher@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YF42+fst;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=alexdeucher@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzPjk5cTPz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 00:20:42 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c9e3c0b6480so132665a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 07:20:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952440; cv=none;
        d=google.com; s=arc-20260327;
        b=eRwPWrw7dZt32+p/TOJ+l07CBxELiOvWgh9fe9JssSnz48F51S+dSM/YA0iLJ+0RsY
         Wa4qCQkh681nrmnfliT1WfpyEa5CzNRsJ7dDNZ5bSJqj2etKBO/uL0jTJ5nzUjrfOV3f
         BEDQmBknkTWXh40wKBYIXO6ez9pwLGmOaBJ62RVouK9SonAMkF4GyT5vUh86Z2eednN+
         YrSbxddWhWGc/wysows5jIBghunrhmevdR/jFUIyPGLM17HLiuk+Rjywm00cZep2HwCd
         CeW4wg3LrfqCOdNNfNKk1mGVMKix9XnGcai+LES5pwqoCgy9FDZ7na8Ks0F6Ot/xsOo/
         52qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w4ixAGYQ3iLxgjQfDz+/RUCZM5NtPQu9ZWh2FbDKX/Q=;
        fh=TiE6TuY5ES0z91jG4nkE9mt5TALyD61Z6uB4hWjs0dQ=;
        b=jLC0lrdTM/JH5ZguHmUZoYZJ/0A0oCkWCJOWha+Z3Rt6APFj8T8leho93mdu2orNga
         awoz052OkdV/63s9EApu+adHxNToKXEwlKeXEs7ekyqdiT2c/k4TlTU4iVneKnjXo7WB
         tc6rJgC7GxVRds4aLsmePA6vvVaAsQMvhPRsTVQz5VaRjwwf89FpL8cJqWZNZbHI1l2K
         ua4Kl/6dKL51rAFyBTuUFai95Elb+QOoogfC16dTmUj36gup3V3FyGAJmcFPKl41qCNQ
         7vvxVTrOYW8+cXSUss78Y9yqtkVuF2c2TMdrU5AmZ3q7EaafWsOvKEza9ARLeNy+rF+y
         YGEw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783952440; x=1784557240; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w4ixAGYQ3iLxgjQfDz+/RUCZM5NtPQu9ZWh2FbDKX/Q=;
        b=YF42+fstOBw0A2Ac18/uydi0TYiMWxFZ7nXjKL7AZPqmxg1X/lIf4eNYXlDXpqVG2R
         VE6PuyqtEVIlPcZccWOz9qejfK9Z5KH9f2YvMgmg08hFdd2OcYmsUQACU9MDvta9mqk6
         QifwUnUw7c/8Nk/+JPYnDk02Ey78pAKUKUZ3nROgtmvolK/D0Evguha63wc2WpJSHQUH
         4r8/6VlGa1El0sfATVUbR+dUCDz0vUcgxgG+DM9msiTS7h6Ear+OhMgFP8y6MKydb9iJ
         2Dg7f/0AhMF5kmji0lXpVt1LPfPao7ZbNTmCc/5s3Cz2amfud9TAhndLYrGmXfT8vUow
         Lwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783952440; x=1784557240;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4ixAGYQ3iLxgjQfDz+/RUCZM5NtPQu9ZWh2FbDKX/Q=;
        b=naHfnSmKFllzfBPIPxh47oTMpPC69IOpKFx8mVrYQIzZZL8jcMKYOECBbR6x97axjy
         usm7WtNeQop4BSPNo6FJE4RCb47PtjNHJrjSHg4NBpAHdpWqyyorZAr8vx7tI8h9MRpc
         mpAybGG9DlRt1m8Ts1to7KHiX+SFnnDevMsnJXcqpvHdBLsc+7O7SqTzczr8rduAfrGB
         StYf5V+lwaER2vSn0f+71zGJUmdffCrgWZAoHJy7QZ1Fw2o2mZxvKXkl4iohcoYOyd86
         z7yKORV0RI3RbSE3QvuswWo/wvMqCFwfhpT2sffk3Bxc992RbcAOjAhoR4vaE4BmBWRk
         lZXg==
X-Forwarded-Encrypted: i=1; AHgh+Rp8Lmalqt9H+osC1RNlgRUE3uEZly1ZCKNP0m4oouF6Z9RBOs3TR3ZZkHgJyoYgvrC3ZMmqFu33Jd8DBp4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx5SPaQgR6W8oB3jk3QwlZnOrFVIdyRFhy1g5t8tdvT00INQeK/
	z7+hAH0UZ9Hypf/k/WRFjyVKjO5DOB8KSYj8oS7OL4gq28h3Vs3kdH3HFyC/ZBeQsCRXscpzYjV
	sSnYDVTuUvK0+pfHMUzUu+tpc/4BrDSs=
X-Gm-Gg: AfdE7cmiyyRyhKCiuDItK9syAbIcPpInkaRPrLPYz/SinkH/xltkwU4c8Hg+zy5Xy/a
	kHQXits376wTe8LK6Vky++Z0JkGwt+KlWBDN1YkzBQqderYC15dn6mfqy4Sfn/FGVyD3wmaqnbo
	doV1U40bByYXjLpyLfF0jQ8WH4fzkXtlKsWrF428WFvvL53bAPZCeMX4T8b5xNrrpAZON/wGE7L
	E94gG2fEZYOtmWxhm51BSHVowLphmzX/d3TvxGPL3r0mINmrDo72mnHdYjBlauaNuZ9H/HW5AIb
	iCtneFbYS63tbbq0BmSAzilawQahTCMejDU9zZoG8/baZncLozIBQzewfvI=
X-Received: by 2002:a17:903:b85:b0:2c0:db23:4a6 with SMTP id
 d9443c01a7336-2ce9e2a0fb6mr71886975ad.1.1783952440035; Mon, 13 Jul 2026
 07:20:40 -0700 (PDT)
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
References: <20260711032956.87948-1-venkat88@linux.ibm.com>
In-Reply-To: <20260711032956.87948-1-venkat88@linux.ibm.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 10:20:26 -0400
X-Gm-Features: AVVi8CcB2dqpTs105ob76x_imqEEzPY-WD1QMD_DNLZ4L-_LJeV3UARqjaSdjqw
Message-ID: <CADnq5_Ncims12dEqPybVFS0Hgi3Aqc798nxnFQ+ygm0-om2aFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Shorten KUnit exported symbol names
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: alexander.deucher@amd.com, chleroy@kernel.org, alex.hung@amd.com, 
	maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, harry.wentland@amd.com, 
	sunpeng.li@amd.com, christian.koenig@amd.com, siqueira@igalia.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Sat, Jul 11, 2026 at 10:09=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
> The KUnit exported helpers
>
>   amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers()
>   amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers()
>
> exceed MODULE_NAME_LEN and cause modpost to fail with:
>
>   ERROR: modpost: too long symbol
>   "amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers"
>
> Shorten the helper names while preserving their functionality.
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Link: https://lore.kernel.org/all/fde3656e-9e22-4e4c-937f-7e8cb918da6b@li=
nux.ibm.com/
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c  | 12 ++++++------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h  |  4 ++--
>  .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c   |  8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 1b564cfe2120..b58225338bc4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -328,7 +328,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_validate_dcc(str=
uct amdgpu_device *adev,
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_plane_validate_dcc);
>
> -STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_mod=
ifiers(struct amdgpu_device *adev,
> +STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(stru=
ct amdgpu_device *adev,
>                                                                          =
      const struct amdgpu_framebuffer *afb,
>                                                                          =
      const enum surface_pixel_format format,
>                                                                          =
      const enum dc_rotation_angle rotation,
> @@ -378,9 +378,9 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx9_plane_=
attributes_from_modifiers(s
>
>         return ret;
>  }
> -EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifier=
s);
> +EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers);
>
> -STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_mo=
difiers(struct amdgpu_device *adev,
> +STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(str=
uct amdgpu_device *adev,
>                                                                          =
       const struct amdgpu_framebuffer *afb,
>                                                                          =
       const enum surface_pixel_format format,
>                                                                          =
       const enum dc_rotation_angle rotation,
> @@ -419,7 +419,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx12_plane=
_attributes_from_modifiers(
>
>         return ret;
>  }
> -EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifie=
rs);
> +EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers);
>
>  static void amdgpu_dm_plane_add_gfx10_1_modifiers(const struct amdgpu_de=
vice *adev,
>                                                   uint64_t **mods,
> @@ -927,14 +927,14 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(st=
ruct amdgpu_device *adev,
>         }
>
>         if (adev->family =3D=3D AMDGPU_FAMILY_GC_12_0_0) {
> -               ret =3D amdgpu_dm_plane_fill_gfx12_plane_attributes_from_=
modifiers(adev, afb, format,
> +               ret =3D amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(a=
dev, afb, format,
>                                                                          =
        rotation, plane_size,
>                                                                          =
        tiling_info, dcc,
>                                                                          =
        address);
>                 if (ret)
>                         return ret;
>         } else if (adev->family >=3D AMDGPU_FAMILY_AI) {
> -               ret =3D amdgpu_dm_plane_fill_gfx9_plane_attributes_from_m=
odifiers(adev, afb, format,
> +               ret =3D amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(ad=
ev, afb, format,
>                                                                          =
       rotation, plane_size,
>                                                                          =
       tiling_info, dcc,
>                                                                          =
       address);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> index 911fb2d73e22..55c33e051aee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> @@ -92,7 +92,7 @@ int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_d=
evice *adev,
>  int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
>                                       const struct dc_plane_cap *plane_ca=
p,
>                                       uint32_t *formats, int max_formats)=
;
> -int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amd=
gpu_device *adev,
> +int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgpu_device =
*adev,
>                                                               const struc=
t amdgpu_framebuffer *afb,
>                                                               const enum =
surface_pixel_format format,
>                                                               const enum =
dc_rotation_angle rotation,
> @@ -100,7 +100,7 @@ int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_m=
odifiers(struct amdgpu_devi
>                                                               struct dc_t=
iling_info *tiling_info,
>                                                               struct dc_p=
lane_dcc_param *dcc,
>                                                               struct dc_p=
lane_address *address);
> -int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct am=
dgpu_device *adev,
> +int amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(struct amdgpu_device=
 *adev,
>                                                                const stru=
ct amdgpu_framebuffer *afb,
>                                                                const enum=
 surface_pixel_format format,
>                                                                const enum=
 dc_rotation_angle rotation,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_=
test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
> index 46c9af432e37..fc84f5a08596 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
> @@ -579,7 +579,7 @@ static void dm_test_fill_gfx12_plane_attributes_from_=
modifiers(struct kunit *tes
>         plane_size.surface_size.height =3D 1080;
>
>         KUNIT_EXPECT_EQ(test,
> -                       amdgpu_dm_plane_fill_gfx12_plane_attributes_from_=
modifiers(
> +                       amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(
>                         adev, afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
>                         ROTATION_ANGLE_0, &plane_size, &tiling_info, &dcc=
, &address),
>                         0);
> @@ -623,7 +623,7 @@ static void dm_test_fill_gfx9_plane_attributes_from_m=
odifiers(struct kunit *test
>         afb->base.modifier =3D DRM_FORMAT_MOD_LINEAR;
>
>         KUNIT_EXPECT_EQ(test,
> -                       amdgpu_dm_plane_fill_gfx9_plane_attributes_from_m=
odifiers(
> +                       amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(
>                         adev, afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
>                         ROTATION_ANGLE_0, &plane_size, &tiling_info, &dcc=
, &address),
>                         0);
> @@ -1187,9 +1187,9 @@ static struct kunit_case amdgpu_dm_plane_test_cases=
[] =3D {
>         KUNIT_CASE(dm_test_get_cursor_position),
>         /* amdgpu_dm_plane_format_mod_supported() */
>         KUNIT_CASE(dm_test_format_mod_supported),
> -       /* amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers() *=
/
> +       /* amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers() */
>         KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_from_modifiers),
> -       /* amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers() */
> +       /* amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers() */
>         KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_from_modifiers),
>         /* amdgpu_dm_plane_helper_check_state() */
>         KUNIT_CASE(dm_test_helper_check_state_viewport_reject),
> --
> 2.45.2
>

