Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ua0-f195.google.com (mail-ua0-f195.google.com
 [209.85.217.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418Ql304ZgzF0XQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 19:28:46 +1000 (AEST)
Received: by mail-ua0-f195.google.com with SMTP id s13-v6so10243688uad.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 02:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180618091729.11091-1-geert@linux-m68k.org>
In-Reply-To: <20180618091729.11091-1-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 Jun 2018 11:28:32 +0200
Message-ID: <CAMuHMdULmiArTvYsEqnyg5SB6PqjZnNANLAyYcqqYeYmHKJ5Dw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.18-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 sparclinux <sparclinux@vger.kernel.org>, linux-ia64@vger.kernel.org,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2018 at 11:18 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.18-rc1[1] compared to v4.17[2].
>
> Summarized:
>   - build errors: +11/-1

> [1] http://kisskb.ellerman.id.au/kisskb/head/ce397d215ccd07b8ae3f71db689a=
edb85d56ab40/ (233 out of 244 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/29dcea88779c856c7dc92040a0c0=
1233263101d4/ (all 244 configs)

> 11 error regressions:
>   + /kisskb/src/drivers/ata/pata_ali.c: error: implicit declaration of fu=
nction 'pci_domain_nr' [-Werror=3Dimplicit-function-declaration]:  =3D> 469=
:38

sparc64/sparc-allmodconfig

>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_allo=
c_try_nid':  =3D> 1413:15
>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_allo=
c_try_nid_nopanic':  =3D> 1377:15
>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_allo=
c_try_nid_raw':  =3D> 1340:15

ia64/ia64-defconfig
mips/bigsur_defconfig
mips/cavium_octeon_defconfig
mips/ip22_defconfig
mips/ip27_defconfig
mips/ip32_defconfig
mips/malta_defconfig
mips/mips-allmodconfig
mips/mips-allnoconfig
mips/mips-defconfig
mipsel/mips-allmodconfig
mipsel/mips-allnoconfig
mipsel/mips-defconfig

>   + error: ".radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefine=
d!:  =3D> N/A
>   + error: ".radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] und=
efined!:  =3D> N/A
>   + error: ".radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-hv.=
ko] undefined!:  =3D> N/A
>   + error: "radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefined=
!:  =3D> N/A
>   + error: "radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] unde=
fined!:  =3D> N/A
>   + error: "radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-hv.k=
o] undefined!:  =3D> N/A

powerpc/ppc64_defconfig+NO_RADIX
ppc64le/powernv_defconfig+NO_RADIX (what's in a name ;-)

>   + {standard input}: Error: offset to unaligned destination:  =3D> 2268,=
 2316, 1691, 1362, 1455, 1598, 2502, 1645, 1988, 1927, 1409, 2615, 1548, 24=
09, 1268, 2363, 1314, 1208, 1785, 2034, 2222, 2661, 1880, 2552, 1161, 2082,=
 1833, 2455, 2176, 2129, 1501, 1738

sh4/sh-randconfig (doesn't seem to be a new issue, seen before on v4.12-rc3=
)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
