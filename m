Return-Path: <SRS0=Yz/e=7O=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D85C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2020 09:15:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3984206E2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2020 09:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3984206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49b8fN4tVXzDqRW
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2020 19:15:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49b8bQ4GLDzDqDd
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2020 19:13:06 +1000 (AEST)
Received: by mail-ot1-f67.google.com with SMTP id g25so7392663otp.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2020 02:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZlOPT56h6/JCVyC/ykPNuYWjyEpIi1l0BN1rPEqbUPk=;
 b=n2ZS+pWugogaMTQmMAlaCKyAlyGs11bCJq6seszaM0KcS8+wjMsmeu1pAmxMioTFoX
 wsAZES6TQxdckQ0bL9hO/zrQUn097DNFftBpF9MlNdlrWsVHTVX00sJIwAT+OLa/sBtP
 bCbTxa2W6d2AgofjVOTIumwv8F+m93hQhtOoBL74DzN35VfnHBeAsH/r+jOYEWO0uLCY
 R9/Mm8MSDmGnnlJBMze33Pb7uXVer3z0tRS50HCKuiZ9loFZ8cox0ipB5RYO3rnDE1Gd
 OMXz+jdrg39AqcKePsyQ8oE3XmRWDkPpd4rlE0IcVP2v/E5BsYP8bcpgAutlF65kswoH
 xyDg==
X-Gm-Message-State: AOAM532dqv0jK0DS74nNU+VwuRu6hLUCruj6qFEn0KvcsMjJtJyyakbR
 z1AiijpdJ4RtrOXt6tNMyxdpAJ5HrXcmNhsKF/M=
X-Google-Smtp-Source: ABdhPJycnrO6S08ZVNAUz71DZKIbHz0tp5g1FNVtTPGR441oaBdHIHUOnsXiHZ992Gann3uIDUPazeuir0lHRiVw2fo=
X-Received: by 2002:a9d:7e92:: with SMTP id m18mr15598801otp.145.1591002784675; 
 Mon, 01 Jun 2020 02:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590880623.git.fthain@telegraphics.com.au>
 <0fb7fdcd99d7820bb27faf1f27f7f6f1923914ef.1590880623.git.fthain@telegraphics.com.au>
 <CAMuHMdUjrFDob01EWC4e04tAkj5JTm_2Ei5WsPqN1eGDz=x3+Q@mail.gmail.com>
 <alpine.LNX.2.22.394.2006011006080.8@nippy.intranet>
In-Reply-To: <alpine.LNX.2.22.394.2006011006080.8@nippy.intranet>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Jun 2020 11:12:52 +0200
Message-ID: <CAMuHMdVs8ur9pWWEFbYmPLRgdH67coSSrPO0QE8RqFvKjhgyYg@mail.gmail.com>
Subject: Re: [PATCH 8/8] macintosh/adb-iop: Implement SRQ autopolling
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
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Finn,

On Mon, Jun 1, 2020 at 2:15 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Sun, 31 May 2020, Geert Uytterhoeven wrote:
> > On Sun, May 31, 2020 at 1:20 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > >  arch/m68k/include/asm/adb_iop.h |  1 +
> > >  drivers/macintosh/adb-iop.c     | 32 ++++++++++++++++++++++++++------
> >
> > As this header file is used by a single source file only, perhaps it
> > should just be absorbed by the latter?
>
> Sure, it could be absorbed by both asm/mac_iop.h and
> drivers/macintosh/adb-iop.c but I don't see the point...

asm/mac_iop.h doesn't include asm/adb_iop.h (at least not in my tree,
but perhaps you have plans to change that?), so there's only a single
user.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
