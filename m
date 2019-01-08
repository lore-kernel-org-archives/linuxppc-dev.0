Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B58C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 21:21:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4BB20883
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 21:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghmn3qhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4BB20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Z4td5z5JzDqc8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 08:20:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d43; helo=mail-io1-xd43.google.com;
 envelope-from=deepa.kernel@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ghmn3qhS"; 
 dkim-atps=neutral
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Z4rh6SZwzDqR3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 08:19:16 +1100 (AEDT)
Received: by mail-io1-xd43.google.com with SMTP id k7so4316371iob.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2019 13:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ibgn2ja9DPSjoCLaCz4JNN4D7ZA8GQekBZ91JKB3zuA=;
 b=ghmn3qhSlP7NQXplHU42RRnPA1PCepRM28qA+tmdD8QIPpn42XfcYgJN8Rwi1cDe3D
 SgvN0NzowdC26HvIxUfSA4mdckICd4N8QO+65QUa8fY0TT1b3YVk6LMyEh6+OYdWOx3t
 xrzsoYuRPJV99XNn1NFAZrg7gO9hhAdW3NlLBZ24pSktFL2QxLMGiZB/Msxcm7oUiCNG
 YoGF5BuVDUmgSCV7SnNyD4PB4jAS9Noq3wPOdr9jKMeavrJovli4Jd/3ADJqgJbv4tAD
 OxiilpxK9sTU2JaBDgSckTBjULYHv1C2JbWD96FUjt19fkwsFdzGiHGr+6QSlbmVA5MT
 ZgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ibgn2ja9DPSjoCLaCz4JNN4D7ZA8GQekBZ91JKB3zuA=;
 b=AUGR5jg2TooU01AMeUB+oJneXeAuzifNd3uNx1U3BvrQgaQ7Q+xW6hM7Xx23POFEGv
 1eXUlIYJG8OqARiu+2EUoyh+vQgFmFDCncum7uLcmW369S3zdgiCP+4ht3Pq9ZUdWYVT
 Vc85f45/Bo47CpDC6cIgQ3h7Nu/4LvcocpRInRWeJG5d1+Y/Ag2fhGWKNmIpEoDsqd2m
 XyAHd2ULykt4cTkVdgGe4swu4xJXu+iXwDDcsKaPikHbQ6ZB6iLvIUaJLBFYw/0Pjo+x
 SEcqylvTiQOq+ZJfRUT7g2c9BGwGw14vkW4ZZexHtsNbuTTcwDPEG/vcUHuf0ebC6Xgt
 8sRQ==
X-Gm-Message-State: AJcUukcZt2qucG8ZvYfScaifS9fqECTabzSglMwaZOy4Tt5AAcudb5m2
 lvsF+m+AV8yNKhGf6Wl98TFyzF/eTsZATspoKFU=
X-Google-Smtp-Source: ALg8bN6Tz+pkGgutIWKW1h822b4sZZTiDSM7H9AvKKU1zUDyLSOADmYRLqEl8nWUpneIQlyjD7fIPuzSPw6LlUpgYlM=
X-Received: by 2002:a6b:8b4e:: with SMTP id n75mr1997376iod.184.1546982354763; 
 Tue, 08 Jan 2019 13:19:14 -0800 (PST)
MIME-Version: 1.0
References: <20190108052255.10699-1-deepa.kernel@gmail.com>
 <20190108052255.10699-3-deepa.kernel@gmail.com>
 <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
In-Reply-To: <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 8 Jan 2019 13:19:05 -0800
Message-ID: <CABeXuvptd3G0kZ7K7j78cSGOnxBOkCoDe8Tzhfu4BQcYVtJNPg@mail.gmail.com>
Subject: Re: [PATCH 2/3] socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD
 suffixes
To: Arnd Bergmann <arnd@arndb.de>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Networking <netdev@vger.kernel.org>, Helge Deller <deller@gmx.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
 cluster-devel <cluster-devel@redhat.com>, ccaulfie@redhat.com,
 Paul Mackerras <paulus@samba.org>, linux-alpha@vger.kernel.org,
 sparclinux <sparclinux@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>, Richard Henderson <rth@twiddle.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 8, 2019 at 12:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jan 8, 2019 at 6:24 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > SO_RCVTIMEO and SO_SNDTIMEO socket options use struct timeval
> > as the time format. struct timeval is not y2038 safe.
> > The subsequent patches in the series add support for new socket
> > timeout options with _NEW suffix that are y2038 safe.
> > Rename the existing options with _OLD suffix forms so that the
> > right option is enabled for userspace applications according
> > to the architecture and time_t definition of libc.
> >
> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>
> Looks good overall. A few minor concerns:
>
> The description above makes it sound like there is a bug with y2038-safety
> in this particular interface, which I think is just not what you meant,
> as the change is only needed for compatiblity with new C libraries
> that work around the y2038 problem in general by changing their
> timeval definition.

Right, there is y2038 safety issue, just the libc part that needs to be handled.
I will fix the commit text.

> > diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> > index 76976d6e50f9..c98ad9777ad9 100644
> > --- a/fs/dlm/lowcomms.c
> > +++ b/fs/dlm/lowcomms.c
> > @@ -1089,12 +1089,12 @@ static void sctp_connect_to_sock(struct connection *con)
> >          * since O_NONBLOCK argument in connect() function does not work here,
> >          * then, we should restore the default value of this attribute.
> >          */
> > -       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
> > +       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
> >                           sizeof(tv));
> >         result = sock->ops->connect(sock, (struct sockaddr *)&daddr, addr_len,
> >                                    0);
> >         memset(&tv, 0, sizeof(tv));
> > -       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
> > +       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
> >                           sizeof(tv));
> >
> >         if (result == -EINPROGRESS)
>
> It took me a bit to realize there that this is safe as well even if
> we don't use SO_SNDTIMEO_NEW, for the same reason.

Correct.

> > --- a/net/compat.c
> > +++ b/net/compat.c
> > @@ -378,7 +378,7 @@ static int compat_sock_setsockopt(struct socket *sock, int level, int optname,
> >                 return do_set_attach_filter(sock, level, optname,
> >                                             optval, optlen);
> >         if (!COMPAT_USE_64BIT_TIME &&
> > -           (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
> > +           (optname == SO_RCVTIMEO_OLD || optname == SO_SNDTIMEO_OLD))
> >                 return do_set_sock_timeout(sock, level, optname, optval, optlen);
> >
> >         return sock_setsockopt(sock, level, optname, optval, optlen);
> > @@ -450,7 +450,7 @@ static int compat_sock_getsockopt(struct socket *sock, int level, int optname,
> >                                 char __user *optval, int __user *optlen)
> >  {
> >         if (!COMPAT_USE_64BIT_TIME &&
> > -           (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
> > +           (optname == SO_RCVTIMEO_OLD || optname == SO_SNDTIMEO_OLD))
> >                 return do_get_sock_timeout(sock, level, optname, optval, optlen);
> >         return sock_getsockopt(sock, level, optname, optval, optlen);
> >  }
>
> I looked at the original code and noticed that it's horrible, which of course
> is not your fault, but I wonder if we should just fix it now to avoid that
> get_fs()/set_fs() hack, since that code mostly implements what you
> also have in your patch 3 (which is done more nicely).

I did think of getting rid of set_fs()/ get_fs() here.
But, I wasn't sure as the maintainers seemed to prefer to leave to the
old code as is in the other series for timestamps.

> I'll follow up with a patch to demonstrate what I mean here. Your third
> patch will then just have to add another code path so we can handle
> all of old_timespec32 (for existing 32-bit user space), __kernel_old_timespec
> (for sparc64) and __kernel_sock_timeval (for everything else).

Cool, I will rebase on top of your patch.

Thanks,
Deepa
