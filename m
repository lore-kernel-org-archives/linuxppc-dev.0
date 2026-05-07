Return-Path: <linuxppc-dev+bounces-20547-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82002CD342C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 02:52:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9xcm1Prmz2xm1;
	Thu, 07 May 2026 12:52:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::435" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778122360;
	cv=pass; b=N4hWdbAQBGACMB0juds8OADhqY1XTx8fG6oTRUX7pvAkbjQ4bgpMT+nbJKHh2OQHXJ21DPnbRSs+kP6HKPw7dLJfiYhyflTfzq1Tg9C0G27meu9+ae49xIf/Nu/iBd4uRvBS5O0Ix9XZLUh03ISqryFPKHOx1Rf8Zmvoqza6+WaGXbQcwXGd6cXUqyDyrELNKNtvMdgrV2oyGXAoKvQ1C1MyNA1p/Ksvk3UUYQHNbsDMEztfBROT4/MRLvS2mEqqHmKOsG2CDghZyhRYRkkfcsL7P4Z5Kq31Tz6G5zTrk3ORZmKEwAgoiMb8l7wBkFaifElLQXeYpdyQ7o5Y4XAQRQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778122360; c=relaxed/relaxed;
	bh=uW6UXusY5B7wnfgwtpuv3i16n+MFEhNRrfK3KAuOPZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3Yboymv63zqtwoaQY3fE1arDtm3OmKn4x/Wc9oFzXwfm8mpt9AYamGeMASPxTu8fRjmLfCojqQUNvrOUruDp2msIa70ODQdm+EkZu7XT04oqXfJSi/dJmw0QQIZN97qZZG0W71HLOK6YcwPAgw38Cn7eWVLuAjSvPLNSM6fBhEp3/QxpuUno5J2xZ2rPrUlmB6HwH06kpsxL8UdqhCFvNhi530uWAEtsiLSPf7ztEGe++viLtLCRagQg6twyH7iy8WxPIE8TIFqWbgX38Dg6J14UQQhy66Q8nEJqWLDzMh5EelBDBFXEILHIlHCcUGilfw2q0N63XUW+kEg3+1qvQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gOiI68gL; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=adri.vero.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gOiI68gL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=adri.vero.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9xck2nwRz2xlm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 12:52:37 +1000 (AEST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so281289f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 19:52:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778122353; cv=none;
        d=google.com; s=arc-20240605;
        b=XxeEjiYYrY7wsRoWZ+B4yY30wlnZ8LoJmJIz/AgpWspSdtgq2vcDjMLrNmworymJLE
         T2iFDllKbb1aeq57g3U/szfGlGvJmSWU3Y+0qCsdqXbRP3cQOGkrda9ULvvvnpqd7UzU
         oxjTjmoG4pGWIlftPIj4XfJDOAup7f2aKQYd//P1tRLkWtTnRqWjeSS0RSSSdwWa2Byk
         JlKU37PUvhKDe4jCPZKKpu10yVUT6WfaD2Hi7dp0Hc+JBhOjLxM5cNsLu+vXPb10c5hb
         4LyCG1asykYT1mX5HRdUVLtHVO0ITTZmWFwO9YG3f8KqtdeaN+bnVf7T5rn3AJXOSsXf
         BjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uW6UXusY5B7wnfgwtpuv3i16n+MFEhNRrfK3KAuOPZ0=;
        fh=UXVajeaYl7jW+1cgTzR5jIC2jiVDjcrO5ah5XAA9hBM=;
        b=WToH0k9lUnWn6K4SXtOKqlYUovlLYd4WErRIeO3EmH2p7FfHoiT5uuO8W8TcELgF59
         FTdYToyQyMuipuQpZFMeocTogsgUjlsCjq9zTiEAKloO6/iErMDQPQea5LtXcfWXyrmJ
         J1Bo344/TLK1kHzD+HRTwljKlAuRNzXiRkVWfqAMbRNnqJPGZ81jjPoMP5t2OxZHzs3Z
         fVBF3dsg2Pb4S08PeXW7RMXXsAkNXCuqyCzDMrHCgEfqaHoFS0i8m7OnEJUM0k1YHtXM
         yggIlUbgICsn9hKpm9u3itDOPUjj/vBnXd3Aqig65npKiMQKFRh63LBGh8+OvAgxdlJf
         n3Wg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778122353; x=1778727153; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uW6UXusY5B7wnfgwtpuv3i16n+MFEhNRrfK3KAuOPZ0=;
        b=gOiI68gLWtudNR2bCphGNygNSX5gcXEcuK7h5XSo4cqw/Fldo4ZSEOu79txEcHALD5
         /xSTlRINJJE8FtQji5hnq6rChOEHdGw+RnyCPqFmNCgwMag9Vb4kfZJIvIQnxfF0W+E0
         5/5iR3MX00uwvyoqAgcXLlVS0vBu7lQFkPlknPWoAGw4QIVEDoP3UEgqJO3/2oQ1igcK
         9Hl/MfK+dDX6oERNeMtjjn89PZ+kR0uDFKeVMtEL27mGMqvdsSRNw8+cVuR9IJBC73NK
         zN4cDTbu/1K3rVJb3Wz1TyQ4ZbO4DDbQCIIbpPwrPUgEeHpWj50MuXeasaQC+1PDk51N
         AvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778122353; x=1778727153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uW6UXusY5B7wnfgwtpuv3i16n+MFEhNRrfK3KAuOPZ0=;
        b=Im2C1aAc7Jw/o8tS5aBqV/eAUTwbe+IWhqAhXjFrJqb6Z3933tAesNutARYXUVfyHF
         Yg9bPplbyvVCFpHyzDZdeIFNrpaVjNpoZXUlHlDLBs9ztIy9WkrYM1BZoLjBSxQaCrKx
         L9jS2/JaLik/XNNxCkJdIy/WgYYxUlpR2aPTnsyGrRaPxNcx1sONUoTvjCjhZQ7aH4s6
         ZhX6wypAoQ1gWR21V2wjwqEHYYyVNFg+n5hs55fniJPbQP+YWX6oSnelPd7AM4ABXg24
         3keNTq2pE5wLhFcI5sZuwL2vahrRrEjbIih4Ug6vvtkJdeV2WGqjDOBpY/ToUBUDUYeJ
         H24g==
X-Forwarded-Encrypted: i=1; AFNElJ/9BNvkTYhoJyPgD7XKceGfnqQ3yHljzVa4PwYPwSYxBL8QkMdMpwC4JFmTwoKJLyimIBiFW2QFOE4vJR4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywu7XuQ4sze03OOkbPR2EL4cv60mORykeVoOrnKYioZFsZtc6cQ
	j5vu09eLbiAjZ9mRt2Jtb13hR7OU+9wWYtbQgEYUg7z/lRppQyJQyFN+gzyVeWa5v8OqsIgGEAC
	BYYf6eRSNrkRviVIDyKXz0zvLFPCgmEM=
X-Gm-Gg: AeBDietvc4Qa5gBAqyBkA90mFSaIyNq24J6ganzejlEk12jhz6eAu/bjKdkuJfYoXBR
	gNJRpsPy2W3anzxdSHwUcrtfw1HxO4XuoKPjmrc7EYfdEGM1M3hr9m85cpMNKWGVS56mtyhx8SR
	Z6W7FKjgf8Y6u5RnvO4A3ogQHLNhBhShfOojo01LjXu5zYXFJe82VZGgsXtvCW3zP8U645Wlg3I
	Bq32bhMObISz2e2jIZrIJjCpEv1M/PjkxAE4ndFR9ubfaMw6DlN2Xis4fZKDJqLO5yxdWoIX9Sa
	1Up+MmDZ/5b05Y7lFer+n+3KELg=
X-Received: by 2002:a05:6000:2310:b0:43d:773d:7908 with SMTP id
 ffacd0b85a97d-4515d3dc438mr9631396f8f.32.1778122353253; Wed, 06 May 2026
 19:52:33 -0700 (PDT)
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
References: <20260406061542.22354-1-litaliano00.contact@gmail.com>
 <20260419065039.23495-1-adri.vero.dev@gmail.com> <7bef2ce2-1fd3-4648-8c78-d3c5e07a1f9f@linux.ibm.com>
In-Reply-To: <7bef2ce2-1fd3-4648-8c78-d3c5e07a1f9f@linux.ibm.com>
From: Adriano Vero <adri.vero.dev@gmail.com>
Date: Thu, 7 May 2026 04:52:21 +0200
X-Gm-Features: AVHnY4LgTIvR1AI6EIc-T4r21ztuWBHZNGBeQ7vGohG8sS8W5mspgVlodsa6JrM
Message-ID: <CAGKWbKuxRCfqZaixqo7L3uT0gtOssDo8-cWWvsVJkKEsaTumcg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/fadump: Add timeout to RTAS busy-wait loops
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sourabh,

Thank you for the review. v3 with your Reviewed-by tag has been sent.

Adriano


On Wed, May 6, 2026 at 9:22=E2=80=AFPM Sourabh Jain <sourabhjain@linux.ibm.=
com> wrote:
>
>
>
> On 19/04/26 12:20, Adriano Vero wrote:
> > The ibm,configure-kernel-dump RTAS call sites in
> > rtas_fadump_register(), rtas_fadump_unregister(), and
> > rtas_fadump_invalidate() polled indefinitely while firmware returned
> > a busy status. A misbehaving or hung firmware could stall these paths
> > forever, blocking fadump registration at boot or preventing clean
> > teardown.
> >
> > Introduce rtas_fadump_call(), a helper that wraps the common
> > busy-wait pattern shared by all three sites. The helper accumulates
> > the total delay and returns -ETIMEDOUT if firmware keeps returning a
> > busy status beyond RTAS_FADUMP_MAX_WAIT_MS (60 seconds). A pr_debug()
> > message is emitted on each busy iteration to aid diagnosis when the
> > timeout is hit.
> >
> > Signed-off-by: Adriano Vero <adri.vero.dev@gmail.com>
> > ---
> >   arch/powerpc/platforms/pseries/rtas-fadump.c | 80 ++++++++++++-------=
-
> >   arch/powerpc/platforms/pseries/rtas-fadump.h |  6 ++
> >   2 files changed, 53 insertions(+), 33 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerp=
c/platforms/pseries/rtas-fadump.c
> > index eceb32893..3bb4ac2ab 100644
> > --- a/arch/powerpc/platforms/pseries/rtas-fadump.c
> > +++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
> > @@ -179,9 +179,42 @@ static u64 rtas_fadump_get_bootmem_min(void)
> >       return RTAS_FADUMP_MIN_BOOT_MEM;
> >   }
> >
> > +/*
> > + * Helper to make an ibm,configure-kernel-dump RTAS call with a bounde=
d
> > + * busy-wait loop. Returns the RTAS return code on completion, or
> > + * -ETIMEDOUT if firmware keeps returning a busy status beyond
> > + * RTAS_FADUMP_MAX_WAIT_MS milliseconds.
> > + */
> > +static int rtas_fadump_call(struct fw_dump *fadump_conf, int operation=
,
> > +                         void *fdm_ptr, unsigned int fdm_size,
> > +                         const char *op_name)
> > +{
> > +     unsigned int wait_time, total_wait =3D 0;
> > +     int rc;
> > +
> > +     do {
> > +             rc =3D rtas_call(fadump_conf->ibm_configure_kernel_dump, =
3, 1,
> > +                            NULL, operation, fdm_ptr, fdm_size);
> > +             wait_time =3D rtas_busy_delay_time(rc);
> > +             if (wait_time) {
> > +                     pr_debug("Firmware busy during fadump %s, waiting=
 %ums (total %ums)\n",
> > +                              op_name, wait_time, total_wait);
> > +                     if (total_wait >=3D RTAS_FADUMP_MAX_WAIT_MS) {
> > +                             pr_err("Timed out waiting for firmware to=
 complete fadump %s\n",
> > +                                    op_name);
> > +                             return -ETIMEDOUT;
> > +                     }
> > +                     total_wait +=3D wait_time;
> > +                     mdelay(wait_time);
> > +             }
> > +     } while (wait_time);
> > +
> > +     return rc;
> > +}
> > +
> >   static int rtas_fadump_register(struct fw_dump *fadump_conf)
> >   {
> > -     unsigned int wait_time, fdm_size;
> > +     unsigned int fdm_size;
> >       int rc, err =3D -EIO;
> >
> >       /*
> > @@ -192,16 +225,10 @@ static int rtas_fadump_register(struct fw_dump *f=
adump_conf)
> >       fdm_size =3D sizeof(struct rtas_fadump_section_header);
> >       fdm_size +=3D be16_to_cpu(fdm.header.dump_num_sections) * sizeof(=
struct rtas_fadump_section);
> >
> > -     /* TODO: Add upper time limit for the delay */
> > -     do {
> > -             rc =3D  rtas_call(fadump_conf->ibm_configure_kernel_dump,=
 3, 1,
> > -                             NULL, FADUMP_REGISTER, &fdm, fdm_size);
> > -
> > -             wait_time =3D rtas_busy_delay_time(rc);
> > -             if (wait_time)
> > -                     mdelay(wait_time);
> > -
> > -     } while (wait_time);
> > +     rc =3D rtas_fadump_call(fadump_conf, FADUMP_REGISTER, &fdm, fdm_s=
ize,
> > +                           "register");
> > +     if (rc =3D=3D -ETIMEDOUT)
> > +             return -ETIMEDOUT;
> >
> >       switch (rc) {
> >       case 0:
> > @@ -234,19 +261,12 @@ static int rtas_fadump_register(struct fw_dump *f=
adump_conf)
> >
> >   static int rtas_fadump_unregister(struct fw_dump *fadump_conf)
> >   {
> > -     unsigned int wait_time;
> >       int rc;
> >
> > -     /* TODO: Add upper time limit for the delay */
> > -     do {
> > -             rc =3D  rtas_call(fadump_conf->ibm_configure_kernel_dump,=
 3, 1,
> > -                             NULL, FADUMP_UNREGISTER, &fdm,
> > -                             sizeof(struct rtas_fadump_mem_struct));
> > -
> > -             wait_time =3D rtas_busy_delay_time(rc);
> > -             if (wait_time)
> > -                     mdelay(wait_time);
> > -     } while (wait_time);
> > +     rc =3D rtas_fadump_call(fadump_conf, FADUMP_UNREGISTER, &fdm,
> > +                           sizeof(struct rtas_fadump_mem_struct), "unr=
egister");
> > +     if (rc =3D=3D -ETIMEDOUT)
> > +             return -ETIMEDOUT;
> >
> >       if (rc) {
> >               pr_err("Failed to un-register - unexpected error(%d).\n",=
 rc);
> > @@ -259,19 +279,13 @@ static int rtas_fadump_unregister(struct fw_dump =
*fadump_conf)
> >
> >   static int rtas_fadump_invalidate(struct fw_dump *fadump_conf)
> >   {
> > -     unsigned int wait_time;
> >       int rc;
> >
> > -     /* TODO: Add upper time limit for the delay */
> > -     do {
> > -             rc =3D  rtas_call(fadump_conf->ibm_configure_kernel_dump,=
 3, 1,
> > -                             NULL, FADUMP_INVALIDATE, fdm_active,
> > -                             sizeof(struct rtas_fadump_mem_struct));
> > -
> > -             wait_time =3D rtas_busy_delay_time(rc);
> > -             if (wait_time)
> > -                     mdelay(wait_time);
> > -     } while (wait_time);
> > +     rc =3D rtas_fadump_call(fadump_conf, FADUMP_INVALIDATE,
> > +                           (void *)fdm_active,
> > +                           sizeof(struct rtas_fadump_mem_struct), "inv=
alidate");
> > +     if (rc =3D=3D -ETIMEDOUT)
> > +             return -ETIMEDOUT;
> >
> >       if (rc) {
> >               pr_err("Failed to invalidate - unexpected error (%d).\n",=
 rc);
> > diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.h b/arch/powerp=
c/platforms/pseries/rtas-fadump.h
> > index c109abf6b..65fdab7b5 100644
> > --- a/arch/powerpc/platforms/pseries/rtas-fadump.h
> > +++ b/arch/powerpc/platforms/pseries/rtas-fadump.h
> > @@ -41,6 +41,12 @@
> >   #define MAX_SECTIONS                                10
> >   #define RTAS_FADUMP_MAX_BOOT_MEM_REGS               7
> >
> > +/*
> > + * Maximum time to wait for firmware to respond to an
> > + * ibm,configure-kernel-dump RTAS call before giving up.
> > + */
> > +#define RTAS_FADUMP_MAX_WAIT_MS                      60000U
> > +
> >   /* Kernel Dump section info */
> >   struct rtas_fadump_section {
> >       __be32  request_flag;
>
> Changes look good to me.
>
> Feel free to add:
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>
> While testing this patch I realized that fadump prints below message
> when registered is successfully
> <rtas/opal> fadump: Registration is successful
>
> But there is no message when fadump is unregistered successfully. I
> think it is good to
> log that event.  I will send a separate patch for this.
>
> - Sourabh Jain

