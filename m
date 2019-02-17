Return-Path: <SRS0=hR0M=QY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC24C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 23:21:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F0B20C01
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 23:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzI2iiR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F0B20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442jgF1VN9zDqL2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 10:21:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MzI2iiR1"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442jdS2q98zDqKt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 10:19:55 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id d125so10332227ith.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 15:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5BrFe3KtkPwWuVJxrKOjqgqHEW70i0TOr06ZsMLZSP0=;
 b=MzI2iiR1EI8X9zvs1YUIIj+PnK0yNV0nnfwCaYQ3F3oE4RdW/ZhFAxYFXwZF4U7V8s
 QmULltcn9ClaEbrZpEGxn7ybXvB2MuAz0W38n+4TkwhCdE04NeJvHxSUS0kSiP5Uk6lm
 /lfkNXp6395PvHEqZGL4REoqsP48+2pLTQ+8GyPKm5LeBA05blhhCzExi0iLuYEK9eSh
 ZEdOIaRsDxhK6dP1B/HD1OairI2cfjbrnn75yttjBLpU9VJPxQc4GZtnYKxnaTVliY+Z
 jxsOYY4pa+fxlMAGmU+ROQ2wnBnSd4rAuwDcuyPaszrSF0/iJVu3s7m92y74cgOhr2Ob
 hkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5BrFe3KtkPwWuVJxrKOjqgqHEW70i0TOr06ZsMLZSP0=;
 b=KgxMQ3XM4dn6eOw4poD4xudHnbb1bD2LNsZm5TKlG2Iri8qRmQKbah7S3isgMy9tRs
 +gpSJrUJ74XcoQg7OL1MHww5GqCiKbQFp0zpoe6GRfwnS/w1WXi/DJbxrnNAB7gLGMLe
 ldgadPCWghYFT4aVdEUyi+twg1cNICgwH4S/oY3QJfIpP6n3Hv+h4HxI3gIriXEw0PYg
 ug9VrfS8sPJ41kQ4nlzwP5se9jcxVD/k2hy7WFJNYvwnabQNt/64dq01ZNuiKFcbTR2u
 b5jcxHxyfcMKS4gAFt81Db/kK6ydB4oIFhWrSXuxdIrUeqdK/lL7/C0KNoc8bOesVg3V
 VTfA==
X-Gm-Message-State: AHQUAuZGBm/xMmO0tg2dDM0mfZuRZZrr6OicbufsuJv54eiwFGDXr3T0
 kSonXCjPvrW8cc7ZHBKpZHyJKbU284ZR4c27BcmnNQ==
X-Google-Smtp-Source: AHgI3IagC5eT6hCu35iotcxv3Xas0aCh8Db9gRblEnWKhZOmsxmDIZll8DygY5gKoHbKecZF7pjtU/c5APns4fQcagE=
X-Received: by 2002:a6b:7941:: with SMTP id j1mr12112661iop.262.1550445593385; 
 Sun, 17 Feb 2019 15:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20190215004817.19961-1-oohall@gmail.com>
 <20190215004817.19961-6-oohall@gmail.com>
 <20190215055805.GF8338@tungsten.ozlabs.ibm.com>
In-Reply-To: <20190215055805.GF8338@tungsten.ozlabs.ibm.com>
From: Oliver <oohall@gmail.com>
Date: Mon, 18 Feb 2019 10:19:42 +1100
Message-ID: <CAOSf1CFdO+8pf0bMPJroScX1WxZqC5LCcbfqbep9mLdHa4j3LA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] powerpc/eeh: Allow disabling recovery
To: Sam Bobroff <sbobroff@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 15, 2019 at 4:58 PM Sam Bobroff <sbobroff@linux.ibm.com> wrote:
>
> On Fri, Feb 15, 2019 at 11:48:16AM +1100, Oliver O'Halloran wrote:
> > Currently when we detect an error we automatically invoke the EEH recovery
> > handler. This can be annoying when debugging EEH problems, or when working
> > on EEH itself so this patch adds a debugfs knob that will prevent a
> > recovery event from being queued up when an issue is detected.
> >
> > Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> > ---
> >  arch/powerpc/include/asm/eeh.h  |  1 +
> >  arch/powerpc/kernel/eeh.c       | 10 ++++++++++
> >  arch/powerpc/kernel/eeh_event.c |  9 +++++++++
> >  3 files changed, 20 insertions(+)
> >
> > diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> > index 478f199d5663..810e05273ad3 100644
> > --- a/arch/powerpc/include/asm/eeh.h
> > +++ b/arch/powerpc/include/asm/eeh.h
> > @@ -220,6 +220,7 @@ struct eeh_ops {
> >
> >  extern int eeh_subsystem_flags;
> >  extern u32 eeh_max_freezes;
> > +extern bool eeh_debugfs_no_recover;
> >  extern struct eeh_ops *eeh_ops;
> >  extern raw_spinlock_t confirm_error_lock;
> >
> > diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> > index 82d22c671c0e..9f20099ce2d9 100644
> > --- a/arch/powerpc/kernel/eeh.c
> > +++ b/arch/powerpc/kernel/eeh.c
> > @@ -111,6 +111,13 @@ EXPORT_SYMBOL(eeh_subsystem_flags);
> >   */
> >  u32 eeh_max_freezes = 5;
> >
> > +/*
> > + * Controls whether a recovery event should be scheduled when an
> > + * isolated device is discovered. This is only really useful for
> > + * debugging problems with the EEH core.
> > + */
> > +bool eeh_debugfs_no_recover;
> > +
> >  /* Platform dependent EEH operations */
> >  struct eeh_ops *eeh_ops = NULL;
> >
> > @@ -1810,6 +1817,9 @@ static int __init eeh_init_proc(void)
> >                                          &eeh_enable_dbgfs_ops);
> >               debugfs_create_u32("eeh_max_freezes", 0600,
> >                               powerpc_debugfs_root, &eeh_max_freezes);
> > +             debugfs_create_bool("eeh_disable_recovery", 0600,
> > +                             powerpc_debugfs_root,
> > +                             &eeh_debugfs_no_recover);
> >               eeh_cache_debugfs_init();
> >  #endif
> >       }
> > diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
> > index 227e57f980df..19837798bb1d 100644
> > --- a/arch/powerpc/kernel/eeh_event.c
> > +++ b/arch/powerpc/kernel/eeh_event.c
> > @@ -126,6 +126,15 @@ int eeh_send_failure_event(struct eeh_pe *pe)
> >       unsigned long flags;
> >       struct eeh_event *event;
> >
> > +     /*
> > +      * If we've manually supressed recovery events via debugfs
> > +      * then just drop it on the floor.
> > +      */
> > +     if (eeh_debugfs_no_recover) {
> > +             pr_err("EEH: Event dropped due to no_recover setting\n");
> > +             return 0;
> > +     }
> > +
>
> I think it might be clearer if you did the 'no recovery' test at the
> call sites (I think there are only a few), instead of inside the
> function (and then the next patch wouldn't need to add a wrapper).

I don't think adding boilerplate at all the call sites is an
improvement. It's just a recipe for adding bugs.

>
> >       event = kzalloc(sizeof(*event), GFP_ATOMIC);
> >       if (!event) {
> >               pr_err("EEH: out of memory, event not handled\n");
> > --
> > 2.20.1
> >
