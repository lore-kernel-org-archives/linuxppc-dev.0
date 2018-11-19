Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47697C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 23:18:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F70020823
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 23:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="CNkWPg3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F70020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zPrx6V1czF3Sn
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 10:18:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="CNkWPg3y";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="CNkWPg3y"; 
 dkim-atps=neutral
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zPpD0YpvzF3Ly
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 10:15:47 +1100 (AEDT)
Received: by mail-qk1-x744.google.com with SMTP id n12so51578092qkh.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 15:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sMKv0EDRSSdVLMabsvvUNiO4XEWj5jNrZTXXnxzULb8=;
 b=CNkWPg3y7JsuZ2jnjnpNU1TGoiwNwhHy140KFUjdhFXctheMPXX8oH15BUdmDEResh
 Hen1+tp/aDSCmLQ6D5WWUgN0kLWJBVNs+yoj3TCApRn3tHe1e9Cz6pAgvsa6cWUcXqbg
 2Wmex+TOkqohSDbW/yWHlzfblmKZ5oPMzmV0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sMKv0EDRSSdVLMabsvvUNiO4XEWj5jNrZTXXnxzULb8=;
 b=AR0ncGBxMnloFkDkK7COlGauUwTuKbkr5dq/5N/Y3RzXC6g018RM6TNLU1E9x2BYZD
 73KU6Ik3vDBzWu5wnLr/Vp8WhgKaTKuVSKpRueg2dVAVWoJl4bVJFwBFzGqPIyWa6d0P
 Cfgq9b4UWtw9OwreerF4xVsksqWvHx7M7gSBS9e6hQHdb+cinAc/14eAQN/8FZExWF+6
 NXjrbCMWRI3hBzG2pdOx5CEunbFjajrdbmNHs6hnAV7O2PHbGrBAP088Me6zzFmm1pM3
 G8nKOKIvgFKSTnQTbxqx+zWxihScnwRWALFzIrzat977308J32kftbtChEsCx3SGHpTH
 KcgQ==
X-Gm-Message-State: AGRZ1gJ2IA7amisPD4Xd28z1jE73UTn91/z2aTPxcvDZlHQEpBsv7q8G
 0crGFWnUVdoHYqePlualiTNI8+dxRNsTuZg0X/Y=
X-Google-Smtp-Source: AJdET5dnw+HIBANKQHfOz+YTyR0DF6z5YGIrrKQYhOP44a0uIQp2b4U0Lp09kb/6jC/AS9fZCPCMh3eH/HD1wa5NfCQ=
X-Received: by 2002:ac8:748:: with SMTP id k8mr22803257qth.235.1542669344932; 
 Mon, 19 Nov 2018 15:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20181114024412.19368-1-joel@jms.id.au>
 <CAKwvOd=P6eQsysnhYVjekbKzVMiGZH8K2nO=Y2gNaH6j+yAhSQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=P6eQsysnhYVjekbKzVMiGZH8K2nO=Y2gNaH6j+yAhSQ@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 20 Nov 2018 09:45:33 +1030
Message-ID: <CACPK8XcdMgrnUQsHH4-fHX2Cw7=zXPBhsDJUNGQJ1=hjh0P4CQ@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/math-emu: Update macros from gmp-6.1.2
To: Nick Desaulniers <ndesaulniers@google.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 20 Nov 2018 at 05:24, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > The only functional change I noticed was this in udiv_qrnnd.
> >
> >     __r1 = (n1) % __d1;
> >     __q1 = (n1) / __d1;
> >
> > Becomes this:
> >
> >     __q1 = (n1) / __d1;
> >     __r1 = (n1) - __q1 * __d1;
> >
> > This is equivalent as it instead of calculating the remainder
> > using modulo, it uses the result of integer division to subtract the
> > count of 'whole' d1 from r1.
>
> I don't understand this; why was this functional change made?

I couldn't see why. It pre-dates GMP's mecurial history that  .
                                              \
> > -    (q) = (UWtype) __q1 * __ll_B | __q0;                               \
> > +    (q) = __q1 * __ll_B | __q0;                                                \
> >      (r) = __r0;                                                                \
> >    } while (0)
>
> This appears to now differ from the upstream source:
> https://github.com/gcc-mirror/gcc/blob/f7289f563a5e447ac21a5901ed75aad0dbd37732/include/longlong.h#L1679

AIUI the upstream source is GMP:

 https://gmplib.org/repo/gmp/file/tip/longlong.h

> If we're going to borrow implementations from GCC, let's borrow the
> same implementation. Otherwise it's hard to have confidence in this
> part of the patch.

I agree we should use the upstream source.

Segher, which tree contains the One True Upstream for longlong.h?

Cheers,

Joel
