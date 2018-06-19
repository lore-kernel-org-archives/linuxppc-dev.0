Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ua0-f193.google.com (mail-ua0-f193.google.com
 [209.85.217.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418z9C2jmVzF0Tn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 16:49:51 +1000 (AEST)
Received: by mail-ua0-f193.google.com with SMTP id 74-v6so12372144uav.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 23:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180618091729.11091-1-geert@linux-m68k.org>
 <CAMuHMdULmiArTvYsEqnyg5SB6PqjZnNANLAyYcqqYeYmHKJ5Dw@mail.gmail.com>
 <87vaafxp0k.fsf@concordia.ellerman.id.au>
In-Reply-To: <87vaafxp0k.fsf@concordia.ellerman.id.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Jun 2018 08:49:36 +0200
Message-ID: <CAMuHMdUfHJS-ykNr-vPPUDfGLsGr62c4R=EThw33-DFNj9ZQNg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.18-rc1
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-ia64@vger.kernel.org,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Tue, Jun 19, 2018 at 8:35 AM Michael Ellerman <mpe@ellerman.id.au> wrote=
:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Mon, Jun 18, 2018 at 11:18 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> >> Below is the list of build error/warning regressions/improvements in
> >> v4.18-rc1[1] compared to v4.17[2].

> >>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_a=
lloc_try_nid':  =3D> 1413:15
> >>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_a=
lloc_try_nid_nopanic':  =3D> 1377:15
> >>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_a=
lloc_try_nid_raw':  =3D> 1340:15
> >
> > ia64/ia64-defconfig
> > mips/bigsur_defconfig
> > mips/cavium_octeon_defconfig
> > mips/ip22_defconfig
> > mips/ip27_defconfig
> > mips/ip32_defconfig
> > mips/malta_defconfig
> > mips/mips-allmodconfig
> > mips/mips-allnoconfig
> > mips/mips-defconfig
> > mipsel/mips-allmodconfig
> > mipsel/mips-allnoconfig
> > mipsel/mips-defconfig
>
> These are now fixed in Linus' tree by:
>
>   6cc22dc08a24 ("revert "mm/memblock: add missing include <linux/bootmem.=
h>"")

Good.

> >>   + error: ".radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undef=
ined!:  =3D> N/A
> >>   + error: ".radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] =
undefined!:  =3D> N/A
> >>   + error: ".radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-=
hv.ko] undefined!:  =3D> N/A
> >>   + error: "radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefi=
ned!:  =3D> N/A
> >>   + error: "radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] u=
ndefined!:  =3D> N/A
> >>   + error: "radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-h=
v.ko] undefined!:  =3D> N/A
> >
> > powerpc/ppc64_defconfig+NO_RADIX
> > ppc64le/powernv_defconfig+NO_RADIX (what's in a name ;-)
>
> Can you tell we don't test that combination very often :/

That's why you have a special config for it? ;-)

> >>   + {standard input}: Error: offset to unaligned destination:  =3D> 22=
68, 2316, 1691, 1362, 1455, 1598, 2502, 1645, 1988, 1927, 1409, 2615, 1548,=
 2409, 1268, 2363, 1314, 1208, 1785, 2034, 2222, 2661, 1880, 2552, 1161, 20=
82, 1833, 2455, 2176, 2129, 1501, 1738
> >
> > sh4/sh-randconfig (doesn't seem to be a new issue, seen before on v4.12=
-rc3)
>
> I think I'll disable that one, it's been broken more often that not and
> I doubt anyone is that motivated to fix sh4 randconfig breakages?

Probably not. Usually I ignore the commonly seen issues.
This one was more uncommon, so I kept it.

> Relatedly I might move all the randconfig targets from Linus' tree into
> a separate "linus-rand" tree, so that they don't pollute the results, as
> I've done for linux-next.

Sounds look a good thing.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
