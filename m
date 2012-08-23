Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E8DEF2C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 06:50:25 +1000 (EST)
Received: by vbbfn1 with SMTP id fn1so1242278vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 13:50:22 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1345754768-4634-1-git-send-email-geert@linux-m68k.org>
References: <1345754768-4634-1-git-send-email-geert@linux-m68k.org>
Date: Thu, 23 Aug 2012 22:50:22 +0200
Message-ID: <CAMuHMdWFY_iOXTfLO7zCm_RTdkEjj7BpT5o9pJ6cu3LdT8JsYQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.6-rc3
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: linux-xtensa@linux-xtensa.org, the arch/x86 maintainers <x86@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 23, 2012 at 10:46 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.6-rc3 to v3.6-rc2[3], the summaries are:
>   - build errors: +13/-9

  + arch/x86/include/asm/uaccess_32.h: error: call to
'copy_from_user_overflow' declared with attribute error:
copy_from_user() buffer size is not provably correct:  => 211:26

i386_defconfig, i386-randconfig, x86_64_defconfig

  + drivers/extcon/extcon_gpio.c: error: implicit declaration of
function 'devm_gpio_request_one'
[-Werror=implicit-function-declaration]:  => 110:2

xtensa-allmodconfig

  + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  => N/A

i386-randconfig

  + error: eni.c: relocation truncated to fit: R_PPC64_REL24 against
symbol `._raw_read_lock' defined in .spinlock.text section in
kernel/built-in.o:  => (.text+0x1ff91bc)
  + error: eni.c: relocation truncated to fit: R_PPC64_REL24 against
symbol `.sprintf' defined in .text section in lib/lib.a(vsprintf.o):
=> (.text+0x1ff940c)
  + error: eni.c: relocation truncated to fit: R_PPC64_REL24 against
symbol `_restgpr0_16' defined in .text.save.restore section in
arch/powerpc/lib/built-in.o:  => (.text+0x1ffa6e8)
  + error: eni.c: relocation truncated to fit: R_PPC64_REL24 against
symbol `_savegpr0_27' defined in .text.save.restore section in
arch/powerpc/lib/built-in.o:  => (.text+0x1ff9854)
  + error: eni.c: relocation truncated to fit: R_PPC64_REL24 against
symbol `_savegpr0_30' defined in .text.save.restore section in
arch/powerpc/lib/built-in.o:  => (.text+0x1ff8eb4), (.text+0x1ff8e80)
  + error: fore200e.c: relocation truncated to fit: R_PPC64_REL24
against symbol `._raw_spin_unlock_irqrestore' defined in
.spinlock.text section in kernel/built-in.o:  => (.text+0x1ff82cc),
(.text+0x1ff8278)
  + error: fore200e.c: relocation truncated to fit: R_PPC64_REL24
against symbol `.mutex_unlock' defined in .sched.text section in
kernel/built-in.o:  => (.text+0x1ff83fc), (.text+0x1ff83a8)

powerpc-allyesconfig

  + error: via-pmu-event.c: undefined reference to
`.input_allocate_device':  => .init.text+0xdfbc)
  + error: via-pmu-event.c: undefined reference to
`.input_free_device':  => .init.text+0xe084)
  + error: via-pmu-event.c: undefined reference to
`.input_register_device':  => .init.text+0xe06c)

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/5359/ (all 116 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/5338/ (all 116 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
