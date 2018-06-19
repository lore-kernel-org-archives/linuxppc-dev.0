Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418yrF2SSqzF0Tn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 16:35:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Build regressions/improvements in v4.18-rc1
In-Reply-To: <CAMuHMdULmiArTvYsEqnyg5SB6PqjZnNANLAyYcqqYeYmHKJ5Dw@mail.gmail.com>
References: <20180618091729.11091-1-geert@linux-m68k.org>
 <CAMuHMdULmiArTvYsEqnyg5SB6PqjZnNANLAyYcqqYeYmHKJ5Dw@mail.gmail.com>
Date: Tue, 19 Jun 2018 16:35:07 +1000
Message-ID: <87vaafxp0k.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> On Mon, Jun 18, 2018 at 11:18 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Below is the list of build error/warning regressions/improvements in
>> v4.18-rc1[1] compared to v4.17[2].
>>
>> Summarized:
>>   - build errors: +11/-1
>
>> [1] http://kisskb.ellerman.id.au/kisskb/head/ce397d215ccd07b8ae3f71db689aedb85d56ab40/ (233 out of 244 configs)
>> [2] http://kisskb.ellerman.id.au/kisskb/head/29dcea88779c856c7dc92040a0c01233263101d4/ (all 244 configs)
>
>> 11 error regressions:
>>   + /kisskb/src/drivers/ata/pata_ali.c: error: implicit declaration of function 'pci_domain_nr' [-Werror=implicit-function-declaration]:  => 469:38
>
> sparc64/sparc-allmodconfig
>
>>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid':  => 1413:15
>>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid_nopanic':  => 1377:15
>>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid_raw':  => 1340:15
>
> ia64/ia64-defconfig
> mips/bigsur_defconfig
> mips/cavium_octeon_defconfig
> mips/ip22_defconfig
> mips/ip27_defconfig
> mips/ip32_defconfig
> mips/malta_defconfig
> mips/mips-allmodconfig
> mips/mips-allnoconfig
> mips/mips-defconfig
> mipsel/mips-allmodconfig
> mipsel/mips-allnoconfig
> mipsel/mips-defconfig

These are now fixed in Linus' tree by:

  6cc22dc08a24 ("revert "mm/memblock: add missing include <linux/bootmem.h>"")


>>   + error: ".radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>>   + error: ".radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>>   + error: ".radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>>   + error: "radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>>   + error: "radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>>   + error: "radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>
> powerpc/ppc64_defconfig+NO_RADIX
> ppc64le/powernv_defconfig+NO_RADIX (what's in a name ;-)

Can you tell we don't test that combination very often :/


>>   + {standard input}: Error: offset to unaligned destination:  => 2268, 2316, 1691, 1362, 1455, 1598, 2502, 1645, 1988, 1927, 1409, 2615, 1548, 2409, 1268, 2363, 1314, 1208, 1785, 2034, 2222, 2661, 1880, 2552, 1161, 2082, 1833, 2455, 2176, 2129, 1501, 1738
>
> sh4/sh-randconfig (doesn't seem to be a new issue, seen before on v4.12-rc3)

I think I'll disable that one, it's been broken more often that not and
I doubt anyone is that motivated to fix sh4 randconfig breakages?

  http://kisskb.ellerman.id.au/kisskb/target/1826/


Relatedly I might move all the randconfig targets from Linus' tree into
a separate "linus-rand" tree, so that they don't pollute the results, as
I've done for linux-next.

cheers
