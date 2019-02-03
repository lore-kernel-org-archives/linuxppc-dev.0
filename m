Return-Path: <SRS0=4FME=QK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788B4C282D7
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Feb 2019 02:49:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D61B2084A
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Feb 2019 02:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdTP3ifq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D61B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43sZzp0gCHzDqJR
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Feb 2019 13:49:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=deepa.kernel@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KdTP3ifq"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43sZxy1RwFzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Feb 2019 13:47:33 +1100 (AEDT)
Received: by mail-it1-x142.google.com with SMTP id m62so15601903ith.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 Feb 2019 18:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZMYtRmKOONVnZU74jVMCYosr4pKhEho8RsInAYHkIrU=;
 b=KdTP3ifqajYxvYkJWRnrvGBZSyEmIgYA39UHfnYk43VDQd72q/DV+y/VS2iwKEvIkD
 mRWvndEEKv+NBrz/qbRD85E925sBQ+IdLiJtyf/bxgXkDN+2I4U/UbTP3ge/SkftkHvi
 GGUUf6ZdBiWJsU2bA6GkH0nb4DRfPa+pYyD98P75tcaruSBdAeaHiVtmv6LUWquk0sOv
 XzMaN1E0rPVqGlR/n3j6dgNpYZCtUWuTmavMClfuH1J0jVhRwgSzMOLwALcUqNtOBph7
 t1pfsH7SLZ1Gu0xrDf7kQL91744p180NWBVbA7IAICl1QNu57omX10tU5p7iajd7hCz1
 2EHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZMYtRmKOONVnZU74jVMCYosr4pKhEho8RsInAYHkIrU=;
 b=e9liDECujtpmWbIRonLXLfGG4LKGn1PKULFbHLX3grvH75GqqX02EV0TSNrHGczdMi
 iut5XPvkIag4MXs/hFBaRBVtVckuJEVOF6L8HGu9C51d9/aa2LCnAj7+l2OeFeybe1Gc
 On6RCW/5mR47mGlVHEbyigRLmwqFBj90HwtzUkxHIh4ziqzNVvNKqMhhvKKcpTlwS5NV
 G8US/lp/iUk4j5YkFBfsULbSckudiexy3rd93KIwxP1oWXpMf8zWRUcQuWsLJYRCnjxO
 +LPhjk5fwae5DwAbLo4WABbiEte/IqDGmNc+r8nuYV94AR/jEuO6+NynJsTTZPdic3DQ
 Y4wQ==
X-Gm-Message-State: AHQUAua8EgoHJtm8z64QN2scCpaGY1Cj7/iCQdXkoa/BPA1jouHsMMtg
 VRxLT9V1WyFFak7NKIEHj9d4p6Ufrll1Pwn34JE=
X-Google-Smtp-Source: AHgI3IYS2NBXv2myRee69tHGYtSoIzUX3ZpjIGORvAD+gSqnvHnb8wwPrS8ntV2W3anTchzcRl2E0ikoXcP4hPviPoE=
X-Received: by 2002:a24:3dd1:: with SMTP id n200mr5846603itn.61.1549162051879; 
 Sat, 02 Feb 2019 18:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
 <20190202153454.7121-13-deepa.kernel@gmail.com>
 <0fad3f4d-4c0e-d9f2-1af0-7890d40c19c0@hartkopp.net>
In-Reply-To: <0fad3f4d-4c0e-d9f2-1af0-7890d40c19c0@hartkopp.net>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Sat, 2 Feb 2019 18:47:20 -0800
Message-ID: <CABeXuvrf_s_LzwYy5p_gqw+PU70OnFAntdtyazN+CBAbyS07TA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 12/12] sock: Add SO_RCVTIMEO_NEW and
 SO_SNDTIMEO_NEW
To: Oliver Hartkopp <socketcan@hartkopp.net>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux Network Devel Mailing List <netdev@vger.kernel.org>,
 Helge Deller <deller@gmx.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
 cluster-devel <cluster-devel@redhat.com>, ccaulfie@redhat.com,
 Paul Mackerras <paulus@samba.org>, linux-alpha@vger.kernel.org,
 sparclinux <sparclinux@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>, Richard Henderson <rth@twiddle.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Feb 2, 2019 at 9:15 AM Oliver Hartkopp <socketcan@hartkopp.net> wro=
te:
>
> Hi all,
>
> On 02.02.19 16:34, Deepa Dinamani wrote:
> > Add new socket timeout options that are y2038 safe.
> (..)
> >
> > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/=
uapi/asm/socket.h
> > index 9826d1db71d0..0d0fddb7e738 100644
> > --- a/arch/alpha/include/uapi/asm/socket.h
> > +++ b/arch/alpha/include/uapi/asm/socket.h
> > @@ -119,19 +119,25 @@
> >   #define SO_TIMESTAMPNS_NEW      64
> >   #define SO_TIMESTAMPING_NEW     65
> >
> > -#if !defined(__KERNEL__)
> > +#define SO_RCVTIMEO_NEW         66
> > +#define SO_SNDTIMEO_NEW         67
> >
> > -#define      SO_RCVTIMEO SO_RCVTIMEO_OLD
> > -#define      SO_SNDTIMEO SO_SNDTIMEO_OLD
> > +#if !defined(__KERNEL__)
> >
> >   #if __BITS_PER_LONG =3D=3D 64
> >   #define SO_TIMESTAMP                SO_TIMESTAMP_OLD
> >   #define SO_TIMESTAMPNS              SO_TIMESTAMPNS_OLD
> >   #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
> > +
> > +#define SO_RCVTIMEO          SO_RCVTIMEO_OLD
> > +#define SO_SNDTIMEO          SO_SNDTIMEO_OLD
>
> Maybe I'm a bit late in this discussion as you are already in v5 ...
>
> I can see patches making the transition in different steps where it
> might be helpful to name them *_OLD and *_NEW to understand the patches.
>
> But in the end the naming stays in the kernel for a very long time and I
> remember myself (in early years) to name things 'new', 'new2', 'new3'.
>
> In fact SO_TIMESTAMP_OLD should be named SO_TIMESTAMP32 and
> SO_TIMESTAMP_NEW should be named SO_TIMESTAMP64.

Hmm. SO_TIMESTAMP_OLD uses 64-bit time_t on a 64 bit machine. In fact,
there is no difference between the two options on a 64 bit machine. So
using  SO_TIMESTAMP_32 is just wrong.

Likewise, SO_TIMESTAMP_64 naming somehow indicates that the existing
one was not, and that is also not true on a 64-bit machine.

Further, userspace will still continue to use SO_TIMESTAMP and the
macros take care of which option to select internally.

Moreover, these macros have been there for more than ten years
(introduced before 2.4) and there has been no change. I doubt you will
ever have NEW2.
I think this argument is similar to saying don=E2=80=99t name these macros
SO_TIMESTAMP because there might be SO_TIMESTAMP1 some day. There is
never a perfect name. SO_TIMESTAMPING is also not really descriptive.

> Especially as it tells you what is 'inside', the naming of these new intr=
oduced constants should be replaced with *32 and *64 names.
> The documentation and the other comments still fit perfectly then.

I would prefer not to do this, for reasons mentioned above. Since you
point out that it is easier to use this naming for intermediate steps,
I suggest that we leave the series as it is.
If you feel strongly to post a follow-on renaming patch, you could
discuss it with the subsystem maintainers, if you think there is a
correct but more descriptive naming.

-Deepa

> Regards,
> Oliver
