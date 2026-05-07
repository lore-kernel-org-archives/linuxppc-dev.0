Return-Path: <linuxppc-dev+bounces-20558-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13A0CD3442
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 08:08:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gB4dd167lz2yrD;
	Thu, 07 May 2026 18:08:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::332" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778141333;
	cv=pass; b=oHK91njOGO1eWzFmFtvSFRNb9Pd2ySbp7u1eZbwoe/t3GlVru3P6+RM4NKN0KvrcsxEdWfjHbMW5F9iZ4/HJ5P/WlBPAYnf0ZLG5vY9wonKmEemnhj6g5ThsAaePv69tbma7ASkqBf/g30bTHxC/+CWEfYK6GQmT7FDvIdoSF5YEgaQa2CZPtwG5tkx5WTZSNfIqqjz+EqSirAncaolp2nvhP+pGp3a1dEgPL7JAS9jQT7snKXA0t3aN7wnhMnCoV28Ko5WrpA9Hon6BWsrNdj6EWOiwG2DFq7C61i9L4DZaneV56m1v86UKjTLS5zbJ5fCMnumyWDLUONlE4McVRg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778141333; c=relaxed/relaxed;
	bh=bH18x2Bwp1QntCq+a0wK+QUNAj3ZgG+unSQ0n2RRfDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZypNpc9PFPzDnR7lXdYVnG7tpt8SLGTTDPUvCTMTXIHtcgCaGAtiKawn4ssArsH9cbKv9BU8P1vSdXY9WRnusAKy700xB6pjM0pANi8yI0UyfbJXdkyCLifr9rHesYy0Y0lObzN0qMSBZdTAkUaL3N7IzL4JxeoOuvXPOEEAswsehb22gB2qAW4DHUSIGfi55VEsEY0E+y0L1aY+oA+MAma4fyseG1dRE/f+QzdfmLBsf1zDrper9JAFPkqOPF5LgOnnvq6L6xoLXikt+Fqo/ONGOcXJwA2dyvttq7fKFAUzcEo7CEwR80kIThjXFxuuO7EydsIVA9Tg5mvraZH90w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lRUu7/Os; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=adri.vero.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lRUu7/Os;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=adri.vero.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gB4db4DZ9z2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 18:08:50 +1000 (AEST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-488ad135063so4736185e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 01:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778141327; cv=none;
        d=google.com; s=arc-20240605;
        b=kqzSKmt3wACD8kTJnYMDqeY14HWtjyJCjpdwPWLSxhheJ+XD3Q8aGZ4029ZnTf85tF
         s3yRIGMizQu+I9kGNl2Ih6rMRO231DIsleSDXpfEIp4fM+opxcAY5w7qZf5mAaoGn3/5
         41ECZ69IyLQPbVgXWhncwffAkRwt/DBtxYMUJMprt+qKCw+Keexwr4/dcqQOwHATO48I
         C4vgLat86JyXSBrLJFrkNje3sDkeF4myMSerk3Ya2cpi4yVg2RgqHbqqjLeDfPYMzBwb
         J47gZCTZfehx4RWsv+luRgRUa1VaZlc40gW/uf7KNzEwHASJGeFVE+2YkiNuBz9Luw3J
         RWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bH18x2Bwp1QntCq+a0wK+QUNAj3ZgG+unSQ0n2RRfDQ=;
        fh=CKRmAZr1pgauo+1kqzpiMxYUbeiyYh2mQo6T2dW0v98=;
        b=KVDVW/2/+SF0RbbBjPbi43lYPeVRVx9yADM/wMdm+XCPz4XDM5ObowKFZGRLbvOHU5
         qxdvxzdzCStzCdU/IHhNxSrk8qjla0WSViayzyGk0UB4aC9821TX8dk3bMpf70qrRGj2
         bfA6hCk99wYgEtBxYZAtEUj3cOvsOTyFso9eZXL8mIjbCV5F1tZcHFR5msIMBlpZ0P0I
         ztU7OXAZV4KEAerGZZQhvQHHKWhc5nvDewmOXAf7JIl0us3e/krtwKyThFsQxtnNg9QV
         kqmzwHqopnA6caZhfPVtcW0Qo+9W18psWdmqJky1XfTanS2oW7hnlZVq3VvD8lAwS9Id
         sqLg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778141327; x=1778746127; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bH18x2Bwp1QntCq+a0wK+QUNAj3ZgG+unSQ0n2RRfDQ=;
        b=lRUu7/OsAW9jmhGV2QNkerG8W7+m0mWJ7zNuA6aR/VA79MNwwxyZNgzqRls2PyhrPs
         /GO7OWyE0QxEeGowzH+VaY9FvJUva+6myg5BB7en47ce6aswt2yxAxPIFnK1Az0Afg37
         zttwbqOy2gMdJ5kL4LT4lXcGrjVBBSgB64aIfpNhseJ8iLbDm6rhA5G99WoDYb7MBtw5
         eRxBUt1unq09zoxuantAMdqziHimQZ1Gwqm1K2nzgodHq5y5Frz9RKQNEL1qPGBdL7aW
         CXqPOvSUa5tRjq/buHkfLGY10rWh3eQCehm9uNmjLc2b7bCn4brjZpZwXO41VDFUQbjo
         v4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778141327; x=1778746127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bH18x2Bwp1QntCq+a0wK+QUNAj3ZgG+unSQ0n2RRfDQ=;
        b=PAx0GsOhmDLXssX/+kmVA8PfFiPtKobDghzy4gKUpDWrFCHKc8VB0qRdwUQQi7cts4
         AqdbhdffSpmtyfV4szVuFZKEZ0kCaL2WR5pPBI6JydAnS5XaQUHpUGe0KMfAj7yptfIe
         PKNYjWx9wtOdWobZ4Mg4EWu+KXI5tTvgiM2EiecZnP0WLqE02XonEbPTu8G3EnfNvkqS
         fs9B5Qwxgja8yi9ItjKWCZzh+CtDlr+gRYL3tDmOvmK4fzq3RLbhojxmJJTUVdvC2Hfd
         RE2phqHKKo6EgLxVNJcsad3XKBhmC37vempk4diDzU98i/NG2FFuYCPmkvz9k7X4wt51
         KS1A==
X-Forwarded-Encrypted: i=1; AFNElJ9i0PlyJTcZCLfrpKIWaEjD01MSV0cWpqLTh/riv/xcL2dpbuRh28hq4QcLRiRIeide3POeJMyMqdAkrlI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyMRfGkEJRkff0f6pzLpWsr1RB5NPKlrOmZfOx4EihQR9iuiXGw
	LcxlZHB2jbucd5hB4GfNQHXsbP+NoOO7wNjD5nqkL5pabPZOVabfaPHjIZW0VLX85XTdNL/xxyr
	dcOku3C0IKezYUcTOE85MOk4OMQpGM5A=
X-Gm-Gg: AeBDievtPR8vAk5jZKf78Mb9IeuANhy7jkSMdmIWTruWhNXKdvVRHVZsFAZ2C0gU0aA
	CsPrSLxOizRZF2nTJl1XsChd3TYxX6Z6i2sEwOnKjH+kv9DxaQ5ReGdNxr9KQjE8YHZLDObGogH
	chsjvUOfKOnZ2RsNioZVOVXYuSznrmszQzL1r5w48gLbfHzdrdjhiCh2reVstkd+MVgzYXP+1MK
	mrb5mpoPHV+SEt5Kmd4IHUJGpPgbr/CUokSWJnIxBEXtufsiGky1H80zWjXb+t14dwARTM094Fi
	eOuVxsU061ynE3O47PKFt+gq0pc0JTVWCx70bw==
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id
 5b1f17b1804b1-48e51f32aebmr107126475e9.16.1778141326456; Thu, 07 May 2026
 01:08:46 -0700 (PDT)
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
References: <20260419065039.23495-1-adri.vero.dev@gmail.com>
 <20260506222024.30352-1-adri.vero.dev@gmail.com> <a582e27b-fb51-473a-802c-6ffb83e7ce63@linux.ibm.com>
In-Reply-To: <a582e27b-fb51-473a-802c-6ffb83e7ce63@linux.ibm.com>
From: Adriano Vero <adri.vero.dev@gmail.com>
Date: Thu, 7 May 2026 10:08:34 +0200
X-Gm-Features: AVHnY4Kd6NSLwhFQc5XF1aHq5CWYDfsURZw01Tpgb-2OCAv1tKESDDiwS-ZmRo4
Message-ID: <CAGKWbKsA7-8yiPuYdNXrpXkideqpCtfXFaz62yDqAKizgYT_CQ@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/fadump: Add timeout to RTAS busy-wait loops
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sourabh,

Understood, I'll keep that in mind for future patches. Thanks for
the guidance.

Adriano

On Thu, May 7, 2026 at 6:16=E2=80=AFAM Sourabh Jain <sourabhjain@linux.ibm.=
com> wrote:
>
> Hello Adriano,
>
> On 07/05/26 03:50, Adriano Vero wrote:
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
> >
> > Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>
> New line between tags is unnecessary.
>
> Including a Changelog in subsequent versions of the same patch is
> helpful for the maintainer and reviewers to understand what has changed
> in this version compared to the previous version.
>
> For example:
> https://lore.kernel.org/all/20260407124349.1698552-1-sourabhjain@linux.ib=
m.com/
>
> Thanks,
> Sourabh Jain
>
> > ---
> >   arch/powerpc/platforms/pseries/rtas-fadump.c | 80 ++++++++++++-------=
-
> >   arch/powerpc/platforms/pseries/rtas-fadump.h |  6 ++
> >   2 files changed, 53 insertions(+), 33 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerp=
c/platforms/pseries/rtas-fadump.c
> > index eceb3289383e..3bb4ac2ab6cc 100644
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
> > index c109abf6befd..65fdab7b5b8d 100644
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

