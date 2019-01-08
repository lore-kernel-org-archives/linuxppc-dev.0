Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC1DC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:26:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6DF20675
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6DF20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Z3hD0hzzzDqbC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 07:26:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.195; helo=mail-qt1-f195.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Z3B51PrzzDqSn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 07:04:12 +1100 (AEDT)
Received: by mail-qt1-f195.google.com with SMTP id t13so5836674qtn.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2019 12:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CkW7W76SxHhQT+R7Cgs1jTueM/y+bXON9Vp9PBD6KUk=;
 b=TR+McgZ8jQAB1CM0IlZdHdGQ5R6FTysAsC+Xye688FEFloe1RSitn0TxwHgvNSZ5Kb
 l34LXGEq1mnN/ZlZM1uYB9qLqMYBszlDpEyK/Tz80j0JUxm0O64lRtZid6YDxI5LysPJ
 Wq9GJKbzP3g2KZSV5tbKuRU21K/mcyXpWriXo6PWvZ3r2svIwCfdbHF9SNgErNLCRhbI
 O5sOyGKMzlFlrZQPqzopPObAdlK9KW7kE1OkxliFzSrc7Sv07K0NHEeWiq6ANshf6FHv
 WA0N+Ck2Vy1ljLPEtQmkQy/ooSPdKVsXZZTdyFaERm6dyF7aUC3M+uBgHrKCXBBq+pMt
 4jkQ==
X-Gm-Message-State: AJcUukemv+hCBaK2+6hI0s8+56OwXyxHpXb4aT8nH2/2kskwTGhllPmd
 ihcBB7rGuHBmMSq38VaLnQI6GUj1/lZj02LKOtM=
X-Google-Smtp-Source: ALg8bN5tuqki2dVs4i6/g+wZOfwMue6nI3pGVupEcrtN/5VTklHmEP3RtEfeqtDa92ooEaFfMQvnuR6VEWedHRQyI4o=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr2955555qtl.343.1546977848238; 
 Tue, 08 Jan 2019 12:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20190108052255.10699-1-deepa.kernel@gmail.com>
 <20190108052255.10699-3-deepa.kernel@gmail.com>
In-Reply-To: <20190108052255.10699-3-deepa.kernel@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 8 Jan 2019 21:03:49 +0100
Message-ID: <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
Subject: Re: [PATCH 2/3] socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD
 suffixes
To: Deepa Dinamani <deepa.kernel@gmail.com>
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
 cluster-devel@redhat.com, ccaulfie@redhat.com,
 Paul Mackerras <paulus@samba.org>, linux-alpha@vger.kernel.org,
 sparclinux <sparclinux@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>, Richard Henderson <rth@twiddle.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 8, 2019 at 6:24 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> SO_RCVTIMEO and SO_SNDTIMEO socket options use struct timeval
> as the time format. struct timeval is not y2038 safe.
> The subsequent patches in the series add support for new socket
> timeout options with _NEW suffix that are y2038 safe.
> Rename the existing options with _OLD suffix forms so that the
> right option is enabled for userspace applications according
> to the architecture and time_t definition of libc.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Looks good overall. A few minor concerns:

The description above makes it sound like there is a bug with y2038-safety
in this particular interface, which I think is just not what you meant,
as the change is only needed for compatiblity with new C libraries
that work around the y2038 problem in general by changing their
timeval definition.

> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 76976d6e50f9..c98ad9777ad9 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -1089,12 +1089,12 @@ static void sctp_connect_to_sock(struct connection *con)
>          * since O_NONBLOCK argument in connect() function does not work here,
>          * then, we should restore the default value of this attribute.
>          */
> -       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
> +       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
>                           sizeof(tv));
>         result = sock->ops->connect(sock, (struct sockaddr *)&daddr, addr_len,
>                                    0);
>         memset(&tv, 0, sizeof(tv));
> -       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
> +       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
>                           sizeof(tv));
>
>         if (result == -EINPROGRESS)

It took me a bit to realize there that this is safe as well even if
we don't use SO_SNDTIMEO_NEW, for the same reason.

> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -378,7 +378,7 @@ static int compat_sock_setsockopt(struct socket *sock, int level, int optname,
>                 return do_set_attach_filter(sock, level, optname,
>                                             optval, optlen);
>         if (!COMPAT_USE_64BIT_TIME &&
> -           (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
> +           (optname == SO_RCVTIMEO_OLD || optname == SO_SNDTIMEO_OLD))
>                 return do_set_sock_timeout(sock, level, optname, optval, optlen);
>
>         return sock_setsockopt(sock, level, optname, optval, optlen);
> @@ -450,7 +450,7 @@ static int compat_sock_getsockopt(struct socket *sock, int level, int optname,
>                                 char __user *optval, int __user *optlen)
>  {
>         if (!COMPAT_USE_64BIT_TIME &&
> -           (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
> +           (optname == SO_RCVTIMEO_OLD || optname == SO_SNDTIMEO_OLD))
>                 return do_get_sock_timeout(sock, level, optname, optval, optlen);
>         return sock_getsockopt(sock, level, optname, optval, optlen);
>  }

I looked at the original code and noticed that it's horrible, which of course
is not your fault, but I wonder if we should just fix it now to avoid that
get_fs()/set_fs() hack, since that code mostly implements what you
also have in your patch 3 (which is done more nicely).

I'll follow up with a patch to demonstrate what I mean here. Your third
patch will then just have to add another code path so we can handle
all of old_timespec32 (for existing 32-bit user space), __kernel_old_timespec
(for sparc64) and __kernel_sock_timeval (for everything else).

       Arnd
