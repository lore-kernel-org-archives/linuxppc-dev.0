Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com
 [209.85.223.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2B21214013F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 22:15:57 +1000 (EST)
Received: by mail-ie0-f182.google.com with SMTP id tp5so9653376ieb.41
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 May 2014 05:15:54 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1399377878-29995-1-git-send-email-geert@linux-m68k.org>
References: <1399377878-29995-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 6 May 2014 14:15:54 +0200
Message-ID: <CAMuHMdUxTDCLFWEDxYT2CT8__xyZcp83dXLYqeJfoG+u8BDVBg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.15-rc4
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: the arch/x86 maintainers <x86@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 6, 2014 at 2:04 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.15-rc4[1]  to v3.15-rc3[3], the summaries are:
>   - build errors: +7/-1

  + /scratch/kisskb/src/arch/powerpc/include/asm/fixmap.h: error:
overflow in enumeration values  CC      drivers/hwmon/smsc47m192.o:
=> 51:2
  + /scratch/kisskb/src/arch/powerpc/include/asm/fixmap.h: error:
overflow in enumeration values  CC [M]  drivers/usb/gadget/f_rndis.o:
=> 51:2
  + /scratch/kisskb/src/arch/powerpc/include/asm/fixmap.h: error:
overflow in enumeration values:  => 51:2

powerpc-randconfig (looks scary, is CONFIG_HIGHMEM=y broken on ppc?)

  + /scratch/kisskb/src/arch/powerpc/kernel/head_44x.S: Error: invalid
operands (*ABS* and *UND* sections) for `|':  => 686, 603
  + /scratch/kisskb/src/arch/powerpc/mm/tlb_nohash_low.S: Error:
unsupported relocation against PPC47x_TLBE_SIZE:  => 113

powerpc-randconfig

  + /scratch/kisskb/src/arch/powerpc/platforms/powernv/setup.c: error:
implicit declaration of function 'get_hard_smp_processor_id'
[-Werror=implicit-function-declaration]:  => 179:4

ppc64_defconfig+UP

Lemme guess: If CONFIG_SMP=n, <linux/smp.h> does not include <asm/smp.h>,
so it needs an explicit #include <asm/smp.h>?

  + error: initramfs.c: undefined reference to `__stack_chk_guard':
=> .init.text+0x19dc)

x86_64-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7449/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7427/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
