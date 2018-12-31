Return-Path: <SRS0=LDiU=PI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECA7C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 12:21:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4F721738
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 12:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4F721738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43SxJC5Vs4zDqHJ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 23:21:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.196; helo=mail-qt1-f196.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43SxCg2qjzzDqJP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 23:17:51 +1100 (AEDT)
Received: by mail-qt1-f196.google.com with SMTP id d19so29126932qtq.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 04:17:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/TrCEGBSRshBH4A9wwGkDALkxyybXabTiBiAMJ5ITDw=;
 b=kCJrpJLfjV8/vsyLHQkDaLhv4woBGnhB5vmL1DjoAK4HKe1EngwUmd8/LhfHP69+T+
 9OBSv0uUte96VfRlgZl3HOzL3EpC+fI8LmDEtFjhZXbxaFCAaV1pNwl96oceUnlfWpZ4
 YLhyrDjXv3O0f41t/aE6Sg2meVVb2wDOlp85SNMusKmQS63mUfrgy+SVcXCRarf4UHiC
 dHGyOzv39yk3uz1VgvDhWjFRqH/nzSwqW7RVk49pbpmD+83TNTJk/a+vItrgpnm6j3Cy
 UbHcM5dD8o2jowiZy8CQ6yu4dQ8G37l1gcnCBDnhvygjV+QLp/5pFf7zDiRqOzV8UJPz
 gpFA==
X-Gm-Message-State: AJcUukdwW7z0i0HCcbMeeRfp9tBSashawV6gWpLKTpDVzexhGVeES6Lb
 xwnQwLe3a9qoC300iU++732K0/wTTkylUmXHWrY=
X-Google-Smtp-Source: ALg8bN45meDN7E3v+xhLS+DgQpPmWVBnyURZMJOYQl6VJ57mQFA4G73Em24t5QbMjTv8xBlIXqgQ2BOp1xxdSoyQScQ=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr34786484qvl.180.1546258669025; 
 Mon, 31 Dec 2018 04:17:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <3ba1dd965c1097e00463eafe7c7d5fd93bbed836.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a0-4vGuCR4aCq0=D1Du1K=f5MtnB9fyCBnOsF+4Na5dMg@mail.gmail.com>
 <alpine.LNX.2.21.1812301744540.424@nippy.intranet>
 <alpine.LNX.2.21.1812311006040.444@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1812311006040.444@nippy.intranet>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 31 Dec 2018 13:17:33 +0100
Message-ID: <CAK8P3a0w5hGFJQv6hPgWFNruKjirjBCrviQS8W03KC4jd=Ldnw@mail.gmail.com>
Subject: Re: [PATCH v8 18/25] powerpc: Implement nvram sync ioctl
To: Finn Thain <fthain@telegraphics.com.au>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 31, 2018 at 12:13 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Sun, 30 Dec 2018, Finn Thain wrote:
> > > > diff --git a/include/linux/nvram.h b/include/linux/nvram.h
> > > > index b7bfaec60a43..24a57675dba1 100644
> > > > --- a/include/linux/nvram.h
> > > > +++ b/include/linux/nvram.h
> > > > @@ -18,8 +18,12 @@ struct nvram_ops {
> > > >         unsigned char   (*read_byte)(int);
> > > >         void            (*write_byte)(unsigned char, int);
> > > >         ssize_t         (*get_size)(void);
> > > > +#ifdef CONFIG_PPC
> > > > +       long            (*sync)(void);
> > > > +#else
> > > >         long            (*set_checksum)(void);
> > > >         long            (*initialize)(void);
> > > > +#endif
> > > >  };
> > >
> > > Maybe just leave all entries visible here, and avoid the above #ifdef
> > > checks.
> > >
> >
> > The #ifdef isn't there just to save a few bytes, though it does do that.
> > It's really meant to cause a build failure when I mess up somewhere. But
> > I'm happy to change it if you can see a reason to do so (?)
> >
>
> I think the problem with these #ifdef conditionals is that they don't
> express the correct constraints. So, at the end of this series I'd prefer
> to see,
>
> struct nvram_ops {
>        ssize_t         (*read)(char *, size_t, loff_t *);
>        ssize_t         (*write)(char *, size_t, loff_t *);
>        unsigned char   (*read_byte)(int);
>        void            (*write_byte)(unsigned char, int);
>        ssize_t         (*get_size)(void);
> #if defined(CONFIG_PPC)
>        long            (*sync)(void);
>        int             (*get_partition)(int);
> #elif defined(CONFIG_X86) || defined(CONFIG_M68K)
>        long            (*set_checksum)(void);
>        long            (*initialize)(void);
> #endif
> };
>
> Is that okay with you?

My preference would be no #ifdef here, but the compile time
error you mention is a good enough reason, so I'm fine with
either version you pick.

       Arnd
