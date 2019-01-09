Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292C0C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 15:18:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9BA206B6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 15:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VLI1IOjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9BA206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZXpK5XT5zDqd7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 02:18:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::e43; helo=mail-vs1-xe43.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="VLI1IOjL";
 dkim-atps=neutral
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com
 [IPv6:2607:f8b0:4864:20::e43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZXmR4QK7zDqby
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 02:17:11 +1100 (AEDT)
Received: by mail-vs1-xe43.google.com with SMTP id n10so4923962vso.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jan 2019 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wQyqmC0gu61Qarv1hQhLAtGsvcLURGacNluwzCkEZB0=;
 b=VLI1IOjLXvqruH3GGhbDAxUssjVcLPNDHV1Sxeo1aWKVJClMYuwbgsEacK2It5QT25
 vgQhF6AxLYK4B+Ep90NS4VVylbzey3+I8PkaclGMpKVDaZ8ms4cHw7HBvSCZF4ogW0MJ
 pswXBtnEST6VZhAlWdjNRTY6aI6ttFLo2qW1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wQyqmC0gu61Qarv1hQhLAtGsvcLURGacNluwzCkEZB0=;
 b=KWPPyFvwIoIZLF82KMwqfYxLd05CuCJRXNaB57b+EJ4T8rwf37ZRrf0rGca/BJhFMZ
 zAd+ZIhlwXoykWSk8QVyCGMYzm9ZvBEvESbYQnKEJvPH6Iy93iJahbTVt3a/H5C5ms2r
 l5OQGPN43xRdmRu9mWYWWCyK36MjE6+gobpcjOrp1ajX4RZMS08oqo5EES7Pe4lEhloD
 oA3wJHLkSW4fiuQs4w29ZRIXZS7MqFwMAXNblzq1UpglvoInNP+enGQYsD5yqHzhRo4P
 A6S+sWxRbLqoTytGoW0ma90mbzFAtX4gmaSkmAyoS9CJZr0rwKc5ns/Yb+kTyrhe7KyY
 ZNtg==
X-Gm-Message-State: AJcUukcQv2laAb/AgAewFtZqE8gJ/7gFY9t0kBxaY4p1nobY7zMRm5ts
 fTWZ9wKqOTaI3bILtPyyUD/i+xaW8T0=
X-Google-Smtp-Source: ALg8bN7u1sE29Ot/DNzGIB6541zqmGV5LArwCNFdqaQfVTlnLzMsd/q0WD+njy+6xGG7C3+hQTPGxA==
X-Received: by 2002:a67:75c5:: with SMTP id q188mr2728378vsc.146.1547047028373; 
 Wed, 09 Jan 2019 07:17:08 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com.
 [209.85.217.44])
 by smtp.gmail.com with ESMTPSA id v193sm17327675vke.1.2019.01.09.07.17.06
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 07:17:07 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id y27so4989379vsi.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jan 2019 07:17:06 -0800 (PST)
X-Received: by 2002:a67:2c13:: with SMTP id s19mr2629580vss.172.1547047026185; 
 Wed, 09 Jan 2019 07:17:06 -0800 (PST)
MIME-Version: 1.0
References: <8593f7faf89812a9987d44d9ae615d64dca4d77f.1544800744.git.christophe.leroy@c-s.fr>
 <CAGXu5jKeGp_z_69SybtkSaE381Ui7aXCxp9yBxv=TS0=hSsm-A@mail.gmail.com>
 <2d2e8cef-dd12-75e8-4779-fe4437e2169c@c-s.fr>
In-Reply-To: <2d2e8cef-dd12-75e8-4779-fe4437e2169c@c-s.fr>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 9 Jan 2019 07:16:55 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKUArQAkirjTTrPM-xayT1aYEGzmyveDZwrLuqmvRqD+A@mail.gmail.com>
Message-ID: <CAGXu5jKUArQAkirjTTrPM-xayT1aYEGzmyveDZwrLuqmvRqD+A@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: Add a tests for NULL pointer dereference
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 8, 2019 at 10:31 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 09/01/2019 =C3=A0 02:14, Kees Cook a =C3=A9crit :
> > On Fri, Dec 14, 2018 at 7:26 AM Christophe Leroy
> > <christophe.leroy@c-s.fr> wrote:
> >>
> >> Introduce lkdtm tests for NULL pointer dereference: check
> >> access or exec at NULL address.
> >
> > Why is this not already covered by the existing tests? (Is there
> > something special about NULL that is being missed?) I'd expect SMAP
> > and SMEP to cover NULL as well.
>
> Most arches print a different message whether the faulty address is
> above or under PAGE_SIZE. Below is exemple from x86:
>
>         pr_alert("BUG: unable to handle kernel %s at %px\n",
>                  address < PAGE_SIZE ? "NULL pointer dereference" : "pagi=
ng request",
>                  (void *)address);
>
>
> Until recently, the powerpc arch didn't do it. When I implemented it
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D49a502ea23bf9dec47f8f3c3960909ff409cd1bb),
> I needed a way to test it and couldn't find an existing one, hence this
> new LKDTM test.
>
> But maybe I missed something ?

Okay, gotcha. You're getting more complete reporting coverage. Sounds
good to me. Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

>
> Christophe
>
> >
> > -Kees
> >
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >> ---
> >>   drivers/misc/lkdtm/core.c  |  2 ++
> >>   drivers/misc/lkdtm/lkdtm.h |  2 ++
> >>   drivers/misc/lkdtm/perms.c | 18 ++++++++++++++++++
> >>   3 files changed, 22 insertions(+)
> >>
> >> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> >> index bc76756b7eda..36910e1d5c09 100644
> >> --- a/drivers/misc/lkdtm/core.c
> >> +++ b/drivers/misc/lkdtm/core.c
> >> @@ -157,7 +157,9 @@ static const struct crashtype crashtypes[] =3D {
> >>          CRASHTYPE(EXEC_VMALLOC),
> >>          CRASHTYPE(EXEC_RODATA),
> >>          CRASHTYPE(EXEC_USERSPACE),
> >> +       CRASHTYPE(EXEC_NULL),
> >>          CRASHTYPE(ACCESS_USERSPACE),
> >> +       CRASHTYPE(ACCESS_NULL),
> >>          CRASHTYPE(WRITE_RO),
> >>          CRASHTYPE(WRITE_RO_AFTER_INIT),
> >>          CRASHTYPE(WRITE_KERN),
> >> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> >> index 3c6fd327e166..b69ee004a3f7 100644
> >> --- a/drivers/misc/lkdtm/lkdtm.h
> >> +++ b/drivers/misc/lkdtm/lkdtm.h
> >> @@ -45,7 +45,9 @@ void lkdtm_EXEC_KMALLOC(void);
> >>   void lkdtm_EXEC_VMALLOC(void);
> >>   void lkdtm_EXEC_RODATA(void);
> >>   void lkdtm_EXEC_USERSPACE(void);
> >> +void lkdtm_EXEC_NULL(void);
> >>   void lkdtm_ACCESS_USERSPACE(void);
> >> +void lkdtm_ACCESS_NULL(void);
> >>
> >>   /* lkdtm_refcount.c */
> >>   void lkdtm_REFCOUNT_INC_OVERFLOW(void);
> >> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> >> index fa54add6375a..62f76d506f04 100644
> >> --- a/drivers/misc/lkdtm/perms.c
> >> +++ b/drivers/misc/lkdtm/perms.c
> >> @@ -164,6 +164,11 @@ void lkdtm_EXEC_USERSPACE(void)
> >>          vm_munmap(user_addr, PAGE_SIZE);
> >>   }
> >>
> >> +void lkdtm_EXEC_NULL(void)
> >> +{
> >> +       execute_location(NULL, CODE_AS_IS);
> >> +}
> >> +
> >>   void lkdtm_ACCESS_USERSPACE(void)
> >>   {
> >>          unsigned long user_addr, tmp =3D 0;
> >> @@ -195,6 +200,19 @@ void lkdtm_ACCESS_USERSPACE(void)
> >>          vm_munmap(user_addr, PAGE_SIZE);
> >>   }
> >>
> >> +void lkdtm_ACCESS_NULL(void)
> >> +{
> >> +       unsigned long tmp;
> >> +       unsigned long *ptr =3D (unsigned long *)NULL;
> >> +
> >> +       pr_info("attempting bad read at %px\n", ptr);
> >> +       tmp =3D *ptr;
> >> +       tmp +=3D 0xc0dec0de;
> >> +
> >> +       pr_info("attempting bad write at %px\n", ptr);
> >> +       *ptr =3D tmp;
> >> +}
> >> +
> >>   void __init lkdtm_perms_init(void)
> >>   {
> >>          /* Make sure we can write to __ro_after_init values during __=
init */
> >> --
> >> 2.13.3
> >>
> >
> >



--=20
Kees Cook
