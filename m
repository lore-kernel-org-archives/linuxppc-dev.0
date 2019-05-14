Return-Path: <SRS0=tOPa=TO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA7CC04AB4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 May 2019 19:15:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8572086A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 May 2019 19:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8572086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 453S7Y220hzDqQ9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 05:15:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.68; helo=mail-ua1-f68.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com
 [209.85.222.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 453S5G3ZsqzDqLq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2019 05:13:22 +1000 (AEST)
Received: by mail-ua1-f68.google.com with SMTP id e9so55425uar.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2019 12:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ey484zS6VT0M2Pei8ezvWLc9zrbpgGtkTWzKMtIHIxc=;
 b=ZJJbzfOAjyMAZobxvhYnxzUoFEeIGhYQY0vCJZcl4pjpYjaBrJ9XyCsIItHhXDEmZy
 5EyFnDLdStqSQORkL5RXXmYGF+kgzXGVCUihG+OyfnB7SkKkCbCAWxnfxRSw4l5TwSMJ
 pmFlP2vLVZW94mUgtoVNm0UN7qe+TxknlVdZhoMUnFx6ZqRKw4QSaycB+cSixhhFjRBj
 s/TcOcxg7Bey3HM8daJD3Psda1V/MYu7w2BTWC9rOgr5O1X3SiPaHpY33LljPtk3wD/I
 pzx1k1e1VQxxQE+q0/vUk4PLRva2y/G7uKMAjZBmXlomRqc/CojZp6AmDrd+TMnw/M2N
 8ssA==
X-Gm-Message-State: APjAAAWh+/+KrrLyjqO6CYWr6wWEQ3CIkEloxiU/m+jWaHrHm4VeZxV2
 tVyqubvOte977B8dQilRnXcUKVxEZM3j7ZwszUw=
X-Google-Smtp-Source: APXvYqwpNaVM9wRlHtOulRVzPKuMGHFU99WPEXTmHwABAVMr5sC13R5BhmyWg1OsGphA/1Wa/vebr7FJneAt0jS5OTs=
X-Received: by 2002:ab0:d89:: with SMTP id i9mr17498845uak.96.1557861198950;
 Tue, 14 May 2019 12:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home>
 <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
 <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
 <20190513091320.GK9224@smile.fi.intel.com>
 <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
 <20190514020730.GA651@jagdpanzerIV>
 <45348cf615fe40d383c1a25688d4a88f@AcuMS.aculab.com>
 <CAMuHMdXaMObq9h2Sb49PW1-HUysPeaWXB7wJmKFz=xLmSoUDZg@mail.gmail.com>
 <20190514143751.48e81e05@oasis.local.home>
In-Reply-To: <20190514143751.48e81e05@oasis.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 May 2019 21:13:06 +0200
Message-ID: <CAMuHMdUhy3uB+G23uXh__F2Y_Jsam5uS1Q5jJC95kWAOEM8WRA@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
To: Steven Rostedt <rostedt@goodmis.org>
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
Cc: Petr Mladek <pmladek@suse.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Michal Hocko <mhocko@suse.cz>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 David Laight <David.Laight@aculab.com>, Stephen Rothwell <sfr@ozlabs.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Steve,

On Tue, May 14, 2019 at 8:37 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 14 May 2019 11:02:17 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, May 14, 2019 at 10:29 AM David Laight <David.Laight@aculab.com> wrote:
> > > > And I like Steven's "(fault)" idea.
> > > > How about this:
> > > >
> > > >       if ptr < PAGE_SIZE              -> "(null)"
> > > >       if IS_ERR_VALUE(ptr)            -> "(fault)"
> > > >
> > > >       -ss
> > >
> > > Or:
> > >         if (ptr < PAGE_SIZE)
> > >                 return ptr ? "(null+)" : "(null)";
>
> Hmm, that is useful.
>
> > >         if IS_ERR_VALUE(ptr)
> > >                 return "(errno)"
>
> I still prefer "(fault)" as is pretty much all I would expect from a
> pointer dereference, even if it is just bad parsing of, say, a parsing
> an MAC address. "fault" is generic enough. "errno" will be confusing,
> because that's normally a variable not a output.
>
> >
> > Do we care about the value? "(-E%u)"?
>
> That too could be confusing. What would (-E22) be considered by a user
> doing an sprintf() on some string. I know that would confuse me, or I
> would think that it was what the %pX displayed, and wonder why it
> displayed it that way. Whereas "(fault)" is quite obvious for any %p
> use case.

I would immediately understand there's a missing IS_ERR() check in a
function that can return  -EINVAL, without having to add a new printk()
to find out what kind of bogus value has been received, and without
having to reboot, and trying to reproduce...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
