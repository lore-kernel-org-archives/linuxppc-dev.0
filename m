Return-Path: <SRS0=LDiU=PI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51425C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 12:19:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B4221738
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 12:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B4221738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43SxF76Z5bzDqKM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 23:19:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.194; helo=mail-qk1-f194.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43SxBH1tRGzDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 23:16:38 +1100 (AEDT)
Received: by mail-qk1-f194.google.com with SMTP id n12so15592146qkh.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 04:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UVT+VfMStcHdKtf7fNwd4LBoX1A0p8UlQm2STswVEBw=;
 b=TUa8kVR9uzGcsfLAozHLvA/I4Dj8TEKxHAj6Kr+NP7/qpd7qEB4XkJR6eiRZUDzMLu
 iSOc0l21xiv9w0kC/SDyywHCGwnb6XSZiXL0Kzb2L4CcRt+Od9TEn4hLUFVbLsjCVZ56
 l0Vx2Wei4hV6htFPVH1TwXQRXfZ77wAaDU97GKQZ/momLFe+fuoaNIfqswXAWcIvI7C3
 hpOq82NZUFGbsuSyXemgBpy2uNmiBDrcmxbnYFrSXxETwaWWrHIbhDJXxZDnRShMaZZT
 s5w2gGtWBenEkJTPP5iRxbcLlrYsWK//dD76sdCDLurHjLxFv0RiZNqHWiHuFb+Gy/US
 odhw==
X-Gm-Message-State: AJcUukcFhB9f2aBru9j6q5R4JKYI9xwlnHJI6AtfcNywyVkcCokARsvF
 5/2Kx0zhnhrhiAI1WZ1V3iX/YcI5fktf4gcEuys=
X-Google-Smtp-Source: ALg8bN6hmSV6LuVJERub18YLmv7Nc/ghydOwZZJjR9aMvu3Yi8wRSQB8ndXoq9D/PhINUnGoS+Dr2TETcA57AASd4KM=
X-Received: by 2002:a37:bdc6:: with SMTP id
 n189mr33366179qkf.330.1546258596087; 
 Mon, 31 Dec 2018 04:16:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <3ba1dd965c1097e00463eafe7c7d5fd93bbed836.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a0-4vGuCR4aCq0=D1Du1K=f5MtnB9fyCBnOsF+4Na5dMg@mail.gmail.com>
 <alpine.LNX.2.21.1812301744540.424@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1812301744540.424@nippy.intranet>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 31 Dec 2018 13:16:19 +0100
Message-ID: <CAK8P3a1rkdMXGOt90SDhBkVvFeNsqdoMKQAu4nLfk_Eg+_CB6g@mail.gmail.com>
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

On Sun, Dec 30, 2018 at 8:25 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> On Sat, 29 Dec 2018, Arnd Bergmann wrote:
>
> > > --- a/drivers/char/nvram.c
> > > +++ b/drivers/char/nvram.c
> > > @@ -48,6 +48,10 @@
> > >  #include <linux/mutex.h>
> > >  #include <linux/pagemap.h>
> > >
> > > +#ifdef CONFIG_PPC
> > > +#include <asm/nvram.h>
> > > +#include <asm/machdep.h>
> > > +#endif
> > >
> > >  static DEFINE_MUTEX(nvram_mutex);
> > >  static DEFINE_SPINLOCK(nvram_state_lock);
> > > @@ -331,6 +335,37 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
> > >         long ret = -ENOTTY;
> > >
> > >         switch (cmd) {
> > > +#ifdef CONFIG_PPC
> > > +       case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
> > > +               pr_warn("nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
> > > +               /* fall through */
> > > +       case IOC_NVRAM_GET_OFFSET:
> > > +               ret = -EINVAL;
> > > +#ifdef CONFIG_PPC_PMAC
> >
> > I think it would make be nicer here to keep the ppc bits in arch/ppc,
> > and instead add a .ioctl() callback to nvram_ops.
> >
>
> The problem with having an nvram_ops.ioctl() method is the code in the
> !PPC branch. That code would get duplicated because it's needed by both
> X86 and M68K, to implement the checksum ioctls.

I was thinking you'd just have a common ioctl function that falls
back to the .ioctl callback for any unhandled commands like

    switch (cmd) {
    case NVRAM_INIT:
         ...
         break;
    case ...:
         break;
    default:
         if (ops->ioctl)
                 return ops->ioctl(...);
         return -EINVAL;
    }

Would that work?

       Arnd
