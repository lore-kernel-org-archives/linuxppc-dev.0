Return-Path: <linus.walleij@linaro.org>
Received: from mail-oa0-f41.google.com (mail-oa0-f41.google.com
 [209.85.219.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F9232C0094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 20:32:51 +1100 (EST)
Received: by mail-oa0-f41.google.com with SMTP id j17so10165638oag.14
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 01:32:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1385107960-373-1-git-send-email-Gang.Liu@freescale.com>
References: <1385107960-373-1-git-send-email-Gang.Liu@freescale.com>
Date: Fri, 29 Nov 2013 10:32:47 +0100
Message-ID: <CACRpkdaHtWze_L-WQ1JadN7isN6HLtv=p3ich8DvT+gjWbGdfg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/gpio: Fix the wrong GPIO input data on
 MPC8572/MPC8536
From: Linus Walleij <linus.walleij@linaro.org>
To: Liu Gang <Gang.Liu@freescale.com>, Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 r61911@freescale.com, b07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 22, 2013 at 9:12 AM, Liu Gang <Gang.Liu@freescale.com> wrote:

> For MPC8572/MPC8536, the status of GPIOs defined as output
> cannot be determined by reading GPDAT register, so the code
> use shadow data register instead. But the code may give the
> wrong status of GPIOs defined as input under some scenarios:
>
> 1. If some pins were configured as inputs and were asserted
> high before booting the kernel, the shadow data has been
> initialized with those pin values.
> 2. Some pins have been configured as output first and have
> been set to the high value, then reconfigured as input.
>
> The above cases will make the shadow data for those input
> pins to be set to high. Then reading the pin status will
> always return high even if the actual pin status is low.
>
> The code should eliminate the effects of the shadow data to
> the input pins, and the status of those pins should be
> read directly from GPDAT.
>
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
> changes in v2:
>  - Added more description of the problem.
>  - Reduced one in_be32() call.
>  - Do not modify the shadow data.

I'm waiting for the maintainers to ACK this before
applying.

Anatolij?

Yours,
Linus Walleij
