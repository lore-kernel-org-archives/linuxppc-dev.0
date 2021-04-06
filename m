Return-Path: <SRS0=CtgL=JD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B7FC433ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 21:52:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C8D61262
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 21:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C8D61262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFLqR0pJsz3bqS
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 07:52:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.161.54; helo=mail-oo1-f54.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com
 [209.85.161.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFLq44wndz2yyF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Apr 2021 07:52:30 +1000 (AEST)
Received: by mail-oo1-f54.google.com with SMTP id
 i25-20020a4aa1190000b02901bbd9429832so4072898ool.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Apr 2021 14:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SZYgSptA3ZzQ3t6TtpWVpGXzldK/l7dPJJEKGwpB+bk=;
 b=b2lAeIC767gfaNhunCW2lbaJ6CjOhEQyYyA7ubOdafHOSN9yUeLShJpY3lv222DkZQ
 vYXP1E6icIIX4Agu3Qp7ar+mQ/b60H1iK7ZJTPTwSQ/OsSDTPKz7bPHniBLZEX1OfkXX
 7/GygIP7l8uVzDft9+05+OxWcnbka0Q4KwhaDuVkNZoDyMuDwsdzSVZwF+2aTE0dCE4I
 n7oxu1laxKrc30PqKcis1cZhxdYF82gP726G2f712igY0iNzwbS4zdMvKhxB5Cn87g6u
 nesiKGavXO++LT6YwYa+jm737FRu6nUH6GoNzsDHp98iUTA8BPb0mNk7FnaqCL86bxtC
 BExA==
X-Gm-Message-State: AOAM533GVyqRgNoVQtQYUsNuCphgteJqyp2c4PlZFiVrVaqAysoMaKmO
 rUDRfx8LfO89tfUsGAOOv8OlxyPaslQ=
X-Google-Smtp-Source: ABdhPJygR9ummQ5t/s7aRtjIjDmI4+r3mvfOZnHaCz8VMU/a/kGxoOUUYPsifJIs8A61FDH2fVb1hA==
X-Received: by 2002:a4a:244d:: with SMTP id v13mr293339oov.66.1617745947907;
 Tue, 06 Apr 2021 14:52:27 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com.
 [209.85.167.171])
 by smtp.gmail.com with ESMTPSA id l190sm3947226oig.39.2021.04.06.14.52.26
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Apr 2021 14:52:27 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id d12so16681514oiw.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Apr 2021 14:52:26 -0700 (PDT)
X-Received: by 2002:aca:53cb:: with SMTP id h194mr4992128oib.175.1617745946741; 
 Tue, 06 Apr 2021 14:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615053848.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615053848.git.christophe.leroy@csgroup.eu>
From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 6 Apr 2021 16:52:14 -0500
X-Gmail-Original-Message-ID: <CADRPPNSx=sbWu9FGujp7=EV7d=dTn+ukvKAgpEHQ5u0vNwR+QQ@mail.gmail.com>
Message-ID: <CADRPPNSx=sbWu9FGujp7=EV7d=dTn+ukvKAgpEHQ5u0vNwR+QQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Remove qe_io{read,write}* IO accessors
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
Cc: Timur Tabi <timur@kernel.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Qiang Zhao <qiang.zhao@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Mar 6, 2021 at 12:11 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Commit 6ac9b61786cc ("soc: fsl: qe: introduce qe_io{read,write}*
> wrappers") added specific I/O accessors for qe because at that
> time ioread/iowrite functions were sub-optimal on powerpc/32
> compared to the architecture specific in_/out_ IO accessors.
>
> But as ioread/iowrite accessors are now equivalent since
> commit 894fa235eb4c ("powerpc: inline iomap accessors"),
> use them in order to allow removal of the qe specific ones.
>
> Christophe Leroy (3):
>   soc: fsl: qe: replace qe_io{read,write}* wrappers by generic
>     io{read,write}*
>   tty: serial: ucc_uart: replace qe_io{read,write}* wrappers by generic
>     io{read,write}*
>   Revert "soc: fsl: qe: introduce qe_io{read,write}* wrappers"

Series applied.  Thanks.

>
>  drivers/soc/fsl/qe/gpio.c     |  20 +++---
>  drivers/soc/fsl/qe/qe.c       |  24 +++----
>  drivers/soc/fsl/qe/qe_ic.c    |   4 +-
>  drivers/soc/fsl/qe/qe_io.c    |  36 +++++-----
>  drivers/soc/fsl/qe/ucc_fast.c |  68 +++++++++----------
>  drivers/soc/fsl/qe/ucc_slow.c |  42 ++++++------
>  drivers/tty/serial/ucc_uart.c | 124 +++++++++++++++++-----------------
>  include/soc/fsl/qe/qe.h       |  34 +++-------
>  8 files changed, 168 insertions(+), 184 deletions(-)
>
> --
> 2.25.0
>
