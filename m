Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
 [209.85.213.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 80AA22C0098
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2012 05:22:37 +1000 (EST)
Received: by yenl12 with SMTP id l12so5203024yen.15
 for <linuxppc-dev@ozlabs.org>; Tue, 03 Jul 2012 12:22:34 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1341342768-22221-1-git-send-email-geert@linux-m68k.org>
References: <1341342768-22221-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 3 Jul 2012 21:22:31 +0200
Message-ID: <CAMuHMdUcOrCwtj9iUQCu543zJhZTV_TscGfKPxfWG6w-aAoBGA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.5-rc5
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 3, 2012 at 9:12 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.5-rc5 to v3.5-rc4[3], the summaries are:
>   - build errors: +20/-11

20 regressions:
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error:
'FSL_DIU_PORT_DVI' undeclared (first use in this function):  => 189:9
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: 'enum
fsl_diu_monitor_port' declared inside parameter list [-Werror]:  =>
70:9, 84:9, 88:36
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: 'return' with
a value, in function returning void [-Werror]:  => 189:2
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: function
declaration isn't a prototype [-Werror=strict-prototypes]:  => 69:5,
88:6, 83:6, 187:1
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: its scope is
only this definition or declaration, which is probably not what you
want [-Werror]:  => 70:9
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: parameter 1
('port') has incomplete type:  => 187:54, 83:56, 88:57, 69:56
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: return type
is an incomplete type:  => 187:1
  + drivers/net/ethernet/3com/3c515.c: error: implicit declaration of
function 'isa_bus_to_virt' [-Werror=implicit-function-declaration]:
=> 1374:12
  + drivers/net/ethernet/3com/3c515.c: error: implicit declaration of
function 'isa_virt_to_bus' [-Werror=implicit-function-declaration]:
=> 824:9
  + drivers/net/ethernet/amd/ni65.c: error: implicit declaration of
function 'isa_bus_to_virt' [-Werror=implicit-function-declaration]:
=> 756:4
  + drivers/net/ethernet/amd/ni65.c: error: implicit declaration of
function 'isa_virt_to_bus' [-Werror=implicit-function-declaration]:
=> 586:2

powerpc-randconfig

  + error: idt77252.c: relocation truncated to fit: R_PPC64_REL24
against symbol `.__raw_spin_lock_init' defined in .text section in
lib/built-in.o:  => (.text+0x1ff8c5c)
  + error: idt77252.c: relocation truncated to fit: R_PPC64_REL24
against symbol `.del_timer' defined in .text section in
kernel/built-in.o:  => (.text+0x1ff806c)
  + error: idt77252.c: relocation truncated to fit: R_PPC64_REL24
against symbol `.mutex_unlock' defined in .sched.text section in
kernel/built-in.o:  => (.text+0x1ff8eec), (.text+0x1ff8c14),
(.text+0x1ff8e80), (.text+0x1ff8e08), (.text+0x1ff8f30)
  + error: solos-pci.c: relocation truncated to fit: R_PPC64_REL24
against symbol `._raw_spin_lock_irqsave' defined in .spinlock.text
section in kernel/built-in.o:  => (.text+0x1ff954c)
  + error: solos-pci.c: relocation truncated to fit: R_PPC64_REL24
against symbol `._raw_spin_unlock' defined in .spinlock.text section
in kernel/built-in.o:  => (.text+0x1ff970c)
  + error: solos-pci.c: relocation truncated to fit: R_PPC64_REL24
against symbol `.iowrite32' defined in .text section in
lib/built-in.o:  => (.text+0x1ff98e4)

powerpc-allyesconfig

  + error: vsprintf.c: relocation truncated to fit: R_AVR32_9UW_PCREL
against `.text'+b28:  => (.text+0x92a)

avr32-allnoconfig

  + include/linux/sh_pfc.h: error: field 'chip' has incomplete type:  => 121:19

se7721_defconfig

  + kernel/sys.c: error: 'mmap_min_addr' undeclared (first use in this
function): 1864:34 => 1864:37, 1864:34

sh-randconfig, sh-allyesconfig, sh-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/5202/ (all 116 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
