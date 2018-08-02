Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vk0-f65.google.com (mail-vk0-f65.google.com
 [209.85.213.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41h3vt2W2KzF1pj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 18:57:14 +1000 (AEST)
Received: by mail-vk0-f65.google.com with SMTP id 125-v6so655371vke.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 01:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-7-acolin@isi.edu>
 <20180801095404.GA17585@infradead.org>
 <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
In-Reply-To: <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Aug 2018 10:57:00 +0200
Message-ID: <CAMuHMdVDra1MKcuuD0SqEYXSggr0iVFcbcjL33z7JuiE1_y8yw@mail.gmail.com>
Subject: Re: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
To: alex.bou9@gmail.com
Cc: Christoph Hellwig <hch@infradead.org>, acolin@isi.edu,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "the arch/x86 maintainers" <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jwalters@isi.edu,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alex,

On Wed, Aug 1, 2018 at 3:16 PM Alex Bounine <alex.bou9@gmail.com> wrote:
> On 2018-08-01 05:54 AM, Christoph Hellwig wrote:
> > On Tue, Jul 31, 2018 at 10:29:54AM -0400, Alexei Colin wrote:
> >> Platforms with a PCI bus will be offered the RapidIO menu since they may
> >> be want support for a RapidIO PCI device. Platforms without a PCI bus
> >> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> >> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> >>
> >> Tested that kernel builds for arm64 with RapidIO subsystem and
> >> switch drivers enabled, also that the modules load successfully
> >> on a custom Aarch64 Qemu model.
> >
> > As said before, please include it from drivers/Kconfig so that _all_
> > architectures supporting PCI (or other Rapidio attachements) get it
> > and not some arbitrary selection of architectures.

+1

> As it was replied earlier this is not a random selection of
> architectures but only ones that implement support for RapidIO as system
> bus. If other architectures choose to adopt RapidIO we will include them
> as well.
>
> On some platforms RapidIO can be the only system bus available replacing
> PCI/PCIe or RapidIO can coexist with PCIe.
>
> As it is done now, RapidIO is configured in "Bus Options" (x86/PPC) or
> "Bus Support" (ARMs) sub-menu and from system configuration option it
> should be kept this way.
>
> Current location of RAPIDIO configuration option is familiar to users of
> PowerPC and x86 platforms, and is similarly available in some ARM
> manufacturers kernel code trees.
>
> drivers/Kconfig will be used for configuring drivers for peripheral
> RapidIO devices if/when such device drivers will be published.

Everything in drivers/rapidio/Kconfig depends on RAPIDIO (probably it should
use a big if RAPIDIO/endif instead), so it can just be included from
drivers/Kconfig now.

The sooner you do that, the less treewide changes are needed (currently
limited to mips, powerpc, and x86; your patch adds arm64).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
