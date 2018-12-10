Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5750EC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 20:13:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998B32082F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 20:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vS6jJnWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998B32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DDmd3ympzDqV2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 07:13:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="vS6jJnWE";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::943; helo=mail-ua1-x943.google.com;
 envelope-from=rsalvaterra@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="vS6jJnWE"; 
 dkim-atps=neutral
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com
 [IPv6:2607:f8b0:4864:20::943])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DDYJ5y9HzDr2P
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 07:04:04 +1100 (AEDT)
Received: by mail-ua1-x943.google.com with SMTP id z24so4288763ual.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 12:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AkPN93qMOA0IRtRg7BfWRUTvc7TYJd7/F0i7q7hurpE=;
 b=vS6jJnWEsTQW7E9sylRBX9sMMhnlc/oVluy0mVZG2Vr7PcsqeY+ug3F/fc2aIji4/S
 CAgVeX9SJQm8bXdentZ7Ky0exmiaiBF6SKVcRb5jYxsiVOo1TvoBmHkZzSkC6ip0pOe9
 1BqM1QoTp7OEhkcRiVdkoz16B4e+Y/NWkDKqzW+ZUiw+62how8fpIEjH9CHsZi2/bkZR
 MpJ3hMJXywKaV+mDig7fUaZJ8+vaZ43CkkWzqBJNiJE6tNbCA0TKUOOA/N2UwqfysiD7
 DTxToPS7Wo3ScROLht/BacN//iQyHZbL0MGLDF2uD8ygbad3eIz9KaAeA0LUUsppTqId
 n1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AkPN93qMOA0IRtRg7BfWRUTvc7TYJd7/F0i7q7hurpE=;
 b=FnGtV9GO8ArQO/zGu5BYKOnzIOz/0NLW0X7N98Hva1QSTgU841znDWI/wrp8gxVgtW
 OUW/DBMVCeIqipckKk17ErSlquwIYvLfxGI2guWxtWbJLYcDp3zs5T2HyZQWkRlihMBj
 m0aeLFkCtBr7WASK3gMGTxn+qcCiqd0iHWPR9Wx7Ot6VdnwqY7Ahuby1WetmVPffaM7a
 FlmZgloPFnjkQrax4JpirhlW8YIgfqaCSv9VPdvdD2Izzjc5ffL4+vhPWOtCmJF9hKBF
 OLvHXgwRAQlP1pJAAJ40FE6OwlgGjp15gMOO18njuemvmLCSjHibAKo0ngxqqfLxOWxQ
 GriA==
X-Gm-Message-State: AA+aEWZ5OTJp2i4Md+kpbFb/0tfsBiE/iGBzuE+CZQVKUpgGOSHnOWCA
 eJM0ienl7vheV4ROh9HgzZqcENQbDF5kYrCh0w==
X-Google-Smtp-Source: AFSGD/U9u7glBZtMC6sfUxRd0OWKLxnWZoYUPocjb0Oj2yhmUNCHrOq4rhWzf8iKsy84Rhld/ohdKT6wvQURksAmxgI=
X-Received: by 2002:ab0:1058:: with SMTP id g24mr5931973uab.58.1544472241744; 
 Mon, 10 Dec 2018 12:04:01 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
 <20181130103222.GA23393@lst.de>
 <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
 <42b1408cafe77ebac1b1ad909db237fe34e4d177.camel@kernel.crashing.org>
 <20181208171746.GB15228@lst.de>
 <CALjTZvb4+Ox5Jdm-xwQuxMDz_ub=mHAgPLA4NgrVNZTmUZwhnQ@mail.gmail.com>
 <20181210193317.GA31514@lst.de>
In-Reply-To: <20181210193317.GA31514@lst.de>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Mon, 10 Dec 2018 20:03:49 +0000
Message-ID: <CALjTZvZNNj7L6MWg=xdA31xbfwW_8gej5iUPXqz4Xg55EQUYSA@mail.gmail.com>
Subject: Re: use generic DMA mapping code in powerpc V4
To: hch@lst.de
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 10 Dec 2018 at 19:33, Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Dec 10, 2018 at 05:04:46PM +0000, Rui Salvaterra wrote:
> > Hi, Christoph and Ben,
> >
> > It just came to my mind (and this is most likely a stupid question,
> > but still)=E2=80=A6 Is there any possibility of these changes having an
> > (positive) effect on the long-standing problem of Power Mac machines
> > with AGP graphics cards (which have to be limited to PCI transfers,
> > otherwise they'll hang, due to coherence issues)? If so, I have a G4
> > machine where I'd gladly test them.
>
> These patches themselves are not going to affect that directly.
> But IFF the problem really is that the AGP needs to be treated as not
> cache coherent (I have no idea if that is true) the generic direct
> mapping code has full support for a per-device coherent flag, so
> support for a non-coherent AGP slot could be implemented relatively
> simply.

Thanks for the insight, Christoph. Well, the problem[1] is real, and
it's been known for a long time, though I can't be sure if it's *only*
a coherence issue. If someone who knows the hardware manages to cook
up a patch (as hacky is it may be), I'll definitely fire up old my G4
laptop to test it! :)

[1] https://bugs.freedesktop.org/show_bug.cgi?id=3D95017
