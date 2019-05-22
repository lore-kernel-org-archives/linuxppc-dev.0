Return-Path: <SRS0=UVon=TW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3460AC282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 May 2019 21:21:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504B221773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 May 2019 21:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504B221773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 458QYX026dzDqS2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 May 2019 07:21:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.196; helo=mail-qt1-f196.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 458QX5554mzDqQl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2019 07:20:19 +1000 (AEST)
Received: by mail-qt1-f196.google.com with SMTP id y22so4235345qtn.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2019 14:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PLY+CCzT6G7iJEFJBPIdwtB7E513yqHwhuA32U3ib3M=;
 b=hdTaoM7nDbtiEnJ0E1dZmPm8pcq731sy5bEoBfMlZH7oMTYt0t6ryxPS9Fiyz9mflP
 boJGf81dVj1IxB5XtWD0h2g+ZiHj1cs50T6tUIc09RilxcblTHcXcSwdYwZtTwJgjva/
 1OxAg2GFb3jki/VfjKqv1hkte2e36DYNQWR0plnTwxxLs7j1UJOOQai1lhj5x1kpX6qP
 WdJeV1P/sGT6D77BQj2hPgz048j9eS2CgaZX44XxaOZefbj/kjq9PQkVxM+HzSs1uhtj
 k3fXe13C4rKye2WBxIpHN9qZ+yKWFXf2o0MY+YPHnWwaKixiaPuJ2KnIUpNYRBiAYs02
 kc/Q==
X-Gm-Message-State: APjAAAVddUo4VJflxjaiT+U+Mjc7oYQUEsXyOgJmVSQhQ3u8/q/9wYPu
 1lF4aSqJTlNoWlFW4EPr4MDrofOAZWlnNDRMbY4=
X-Google-Smtp-Source: APXvYqwXie6/tZhn3C4BpBgyl8D93Wtqfnb2Q1JvEErclhEBWpspsuISvDK5zx3thIBKKQda8003GrBIAoQ7tjRZi2o=
X-Received: by 2002:ac8:2a05:: with SMTP id k5mr59259074qtk.304.1558560017048; 
 Wed, 22 May 2019 14:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190520141047eucas1p2c6006d1ecfc3eb287b6b33d131f66180@eucas1p2.samsung.com>
 <1ab818ae-4d9f-d17a-f11f-7caaa5bf98bc@samsung.com>
In-Reply-To: <1ab818ae-4d9f-d17a-f11f-7caaa5bf98bc@samsung.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 22 May 2019 23:20:00 +0200
Message-ID: <CAK8P3a0wky-Km=PQO9=jN2kC0Zyy75LfD-1Kn5YHiEEV8ymZHQ@mail.gmail.com>
Subject: Re: [PATCH] misc: remove redundant 'default n' from Kconfig-s
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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
Cc: Eric Piel <eric.piel@tremplin-utc.net>,
 Andrew Donnellan <ajd@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frank Haverkamp <haver@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, May 20, 2019 at 4:10 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
>
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
>
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>
>         config FOO
>                 bool
>
>         config FOO
>                 bool
>                 default n
>
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
