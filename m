Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD6DB2C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2012 21:32:41 +1100 (EST)
Received: by mail-vb0-f51.google.com with SMTP id fn1so6916016vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2012 02:32:38 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au>
References: <ADE657CA350FB648AAC2C43247A983F00206B25884B1@AUSP01VMBX24.collaborationhost.net>
 <CAErSpo6WG2R_8sa=rOmAOci-3iFpDs2NFzNkZYxDnD2oTiMQJg@mail.gmail.com>
 <20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au>
Date: Tue, 13 Nov 2012 11:32:37 +0100
Message-ID: <CAMuHMdXu2VJhB+1uFApeBrYS3t2cfpPMaTz12F=A_FNJB1Q60w@mail.gmail.com>
Subject: Re: [PATCH] Centralise CONFIG_ARCH_NO_VIRT_TO_BUS
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Cc: linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
 Paul Mackerras <paulus@samba.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 H Hartley Sweeten <hartleys@visionengravers.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 12, 2012 at 10:26 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 366ec06..9bc00e7 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -271,6 +271,13 @@ config ARCH_WANT_OLD_COMPAT_IPC
>         select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>         bool
>
> +config ARCH_NO_VIRT_TO_BUS
> +       bool
> +       help
> +         An architecture should select this if it cannot (or will not)
> +         implement virt_to_bus().  All new architectures should probably
> +         select this.

Don't we typically put the burden of selecting Kconfig flags for deprecated
features on the existing architectures that provide the deprecated features?

I.e. shouldn't it be ARCH_HAS_VIRT_TO_BUS, selected by the architectures
that need it, instead?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
