Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pb0-x231.google.com (mail-pb0-x231.google.com
 [IPv6:2607:f8b0:400e:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DFC5C2C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 20:06:48 +1100 (EST)
Received: by mail-pb0-f49.google.com with SMTP id up15so16400134pbc.22
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 01:06:44 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1392714172-2712-1-git-send-email-geert@linux-m68k.org>
References: <1392714172-2712-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 18 Feb 2014 10:06:43 +0100
Message-ID: <CAMuHMdXqSJRyxHaCthxntjwur8uJ6zyps40A0QxFwMqFmMPKzw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.14-rc3
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 18, 2014 at 10:02 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.14-rc3[1]  to v3.14-rc2[3], the summaries are:
>   - build errors: +17/-6

  + /scratch/kisskb/src/arch/powerpc/include/asm/floppy.h: error:
'isa_bridge_pcidev' undeclared (first use in this function):  =>
142:20
  + /scratch/kisskb/src/drivers/pcmcia/m8xx_pcmcia.c: error: #error
m8xx_pcmcia: Bad configuration!:  => 127:2
  + /scratch/kisskb/src/drivers/pcmcia/m8xx_pcmcia.c: error:
'PCMCIA_IO_WIN_NO' undeclared here (not in a function):  => 220:30
  + /scratch/kisskb/src/drivers/pcmcia/m8xx_pcmcia.c: error:
'PCMCIA_MEM_WIN_NO' undeclared here (not in a function):  => 219:32
  + /scratch/kisskb/src/drivers/pcmcia/m8xx_pcmcia.c: error:
'PCMCIA_SOCKETS_NO' undeclared here (not in a function):  => 225:34
  + /scratch/kisskb/src/drivers/pcmcia/m8xx_pcmcia.c: error: 'irq_map'
undeclared (first use in this function):  => 1027:10
  + /scratch/kisskb/src/drivers/pcmcia/m8xx_pcmcia.c: error: 's'
undeclared (first use in this function):  => 982:2
  + /scratch/kisskb/src/drivers/pcmcia/m8xx_pcmcia.c: error: expected
')' before 'PCMCIA_BOARD_MSG':  => 1036:2
  + /scratch/kisskb/src/drivers/pcmcia/m8xx_pcmcia.c: error: implicit
declaration of function 'hardware_disable'
[-Werror=implicit-function-declaration]:  => 1137:3
  + /scratch/kisskb/src/drivers/pcmcia/m8xx_pcmcia.c: error: implicit
declaration of function 'hardware_enable'
[-Werror=implicit-function-declaration]:  => 1080:2
  + /scratch/kisskb/src/drivers/pcmcia/m8xx_pcmcia.c: error: implicit
declaration of function 'mk_int_int_mask'
[-Werror=implicit-function-declaration]:  => 748:6
  + /scratch/kisskb/src/drivers/pcmcia/m8xx_pcmcia.c: error: implicit
declaration of function 'socket_get'
[-Werror=implicit-function-declaration]:  => 657:2
  + /scratch/kisskb/src/drivers/pcmcia/m8xx_pcmcia.c: error: implicit
declaration of function 'voltage_set'
[-Werror=implicit-function-declaration]:  => 686:2

powerpc-randconfig

  + /scratch/kisskb/src/drivers/gpio/gpio-xtensa.c: Error: unknown
opcode or format name 'read_impwire':  => 87
  + /scratch/kisskb/src/drivers/gpio/gpio-xtensa.c: Error: unknown
opcode or format name 'rur.expstate':  => 110
  + /scratch/kisskb/src/drivers/gpio/gpio-xtensa.c: Error: unknown
opcode or format name 'wrmsk_expstate':  => 124

xtensa-allmodconfig

  + error: kvm_main.c: undefined reference to `__stack_chk_guard':  =>
.text+0x6895)

i386-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7190/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7167/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
