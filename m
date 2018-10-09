Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8F1C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 16:07:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3710920C0A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 16:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3710920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V2DM0qrwzF3PB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 03:06:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.221.196; helo=mail-vk1-f196.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com
 [209.85.221.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42V13S319szF3Mc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 02:14:12 +1100 (AEDT)
Received: by mail-vk1-f196.google.com with SMTP id l123-v6so460938vkl.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 08:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vAGqBbSA1RSQkPwWyc/kNxdcUaFy54e8ph6hVOVfms4=;
 b=Q/IWkAE2p2yNURWhOYgNdsbvRpzUjRMUrJhh2rU9iLvyH/2vymCIQt6DALL1sMl95o
 2k1rQNJDkFeYN/r3/ipMlf+rbNdCWPUshE5J59gcrOiyTTP2m0I3pjEs9g2God6Qr5eP
 xEl3JRSYyiCrVh6/KpUNMA9bZtRqA23gT87vtOJSKhYP65UF0IrPP0QMOctNtfNMtMtg
 PsT9zLUM6r9NCGQR7uXg7VuqQLGdTZZKo9NSHos7UQgKCnsTkw04pXdOtLUhzN78LORp
 1JW13R3OvBjm0vV4B4R4+l+9mJR3TmE5bxkUaWHXZ6RC4CDfRquoRMZ3MX3/hGeLcAEd
 DKcA==
X-Gm-Message-State: ABuFfohXb4uzafTgaJ5pv5OoVFqYxA2cn6RriJ1DrD8H0O0v4y6sHtHB
 gqyhGwXbScZgX1PEizOoTv0bUu9rXkG83fkXz+8=
X-Google-Smtp-Source: ACcGV62PaTnruQZsal+60+njskNgOXLchqbSfBlVbYThVVjfFKpN9VJfPfbMU75dGkva7KfCQvpInc5sn8Fywso5RCc=
X-Received: by 2002:a1f:b547:: with SMTP id
 e68-v6mr10837096vkf.72.1539098049724; 
 Tue, 09 Oct 2018 08:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
 <0d489a2c917d6e8528fad099023eac3d5a516787.1539092111.git.christophe.leroy@c-s.fr>
 <1539097191.64374.44.camel@acm.org>
In-Reply-To: <1539097191.64374.44.camel@acm.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Oct 2018 17:13:57 +0200
Message-ID: <CAMuHMdVpS2wzUniDdXKSWyyTr3Cn9NsXAxOJEKe=D9BUrpdt=w@mail.gmail.com>
Subject: Re: [PATCH v3 03/24] drivers/block/z2ram: use ioremap_wt() instead of
 __ioremap(_PAGE_WRITETHRU)
To: Bart Van Assche <bvanassche@acm.org>
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
Cc: Jens Axboe <axboe@kernel.dk>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Geoff Levand <geoff@infradead.org>,
 DRI Development <dri-devel@lists.freedesktop.org>, linux-block@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>, Leo Li <leoyang.li@nxp.com>,
 Scott Wood <oss@buserror.net>, Debian m68k <debian-68k@lists.debian.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Bart,

CC debian-68k, linux-m68k

On Tue, Oct 9, 2018 at 5:00 PM Bart Van Assche <bvanassche@acm.org> wrote:
> On Tue, 2018-10-09 at 13:51 +0000, Christophe Leroy wrote:
> > _PAGE_WRITETHRU is a target specific flag. Prefer generic functions.
> >
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
> Hi Geert,
>
> All patches that have been applied to this driver since 2005 are API refactoring
> patches. I haven't found any patches in the history of this driver that seem to
> have been submitted by a user of this driver. Do you perhaps know whether anyone
> is using this driver?

The z2ram is a very simple driver, used to configure (slower) Zorro II RAM as
a swap device.  So I'm not so surprised no one submitted functional patches.

I believe it's still being used.
Probably it could be modified to use mtdram.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
