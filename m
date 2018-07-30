Return-Path: <srs0=lxf2=ko=kernel.org=robh+dt@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fM6248KzzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 00:15:06 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41fM6236Ncz8v8h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 00:15:06 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41fM620Tlyz9rxx
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2018 00:15:05 +1000 (AEST)
Received: from mail-qt0-f171.google.com (mail-qt0-f171.google.com
 [209.85.216.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E090020870
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2018 14:15:03 +0000 (UTC)
Received: by mail-qt0-f171.google.com with SMTP id y5-v6so12170447qti.12
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2018 07:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180730131516.18406-1-mpe@ellerman.id.au>
 <20180730131516.18406-2-mpe@ellerman.id.au>
In-Reply-To: <20180730131516.18406-2-mpe@ellerman.id.au>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 30 Jul 2018 08:14:51 -0600
Message-ID: <CAL_JsqLX+NFXRMQXOT352Er5vG_iVSg8dKoouJ5uR0KymW1EdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc: Use of_machine_compatible_match()
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2018 at 7:15 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Use of_machine_compatible_match() in platform code rather than open
> coding.

This is good because I want to get rid of of_root being used outside
of drivers/of/. Can you also convert this one:

drivers/clk/clk-qoriq.c:            of_device_is_compatible(of_root,
"fsl,ls1021a")) {

>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/platforms/40x/ppc40x_simple.c    | 2 +-
>  arch/powerpc/platforms/512x/mpc512x_generic.c | 2 +-
>  arch/powerpc/platforms/52xx/lite5200.c        | 2 +-
>  arch/powerpc/platforms/52xx/media5200.c       | 2 +-
>  arch/powerpc/platforms/52xx/mpc5200_simple.c  | 2 +-
>  arch/powerpc/platforms/83xx/mpc830x_rdb.c     | 2 +-
>  arch/powerpc/platforms/83xx/mpc831x_rdb.c     | 2 +-
>  arch/powerpc/platforms/83xx/mpc837x_rdb.c     | 2 +-
>  arch/powerpc/platforms/85xx/corenet_generic.c | 2 +-
>  arch/powerpc/platforms/85xx/tqm85xx.c         | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

Rob
