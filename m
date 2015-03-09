Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x234.google.com (mail-ob0-x234.google.com
 [IPv6:2607:f8b0:4003:c01::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23CC71A020A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 21:56:26 +1100 (AEDT)
Received: by obbgq1 with SMTP id gq1so32631711obb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2015 03:56:23 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1425898222-19721-1-git-send-email-geert@linux-m68k.org>
References: <1425898222-19721-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 9 Mar 2015 11:56:22 +0100
Message-ID: <CAMuHMdVNWVKA0iuTMABQPzJJtjCAD_Ey7w1gx2ojYzG4TscyKA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.0-rc3
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 9, 2015 at 11:50 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.0-rc3[1] to v4.0-rc2[3], the summaries are:
>   - build errors: +18/-7

  + /home/kisskb/slave/src/arch/arm/mach-pxa/idp.c: error:
'SMC91X_NOWAIT' undeclared here (not in a function):  => 85:47
  + /home/kisskb/slave/src/arch/arm/mach-pxa/idp.c: error:
'SMC91X_USE_32BIT' undeclared here (not in a function):  => 85:11
  + /home/kisskb/slave/src/arch/arm/mach-pxa/idp.c: error:
'SMC91X_USE_DMA' undeclared here (not in a function):  => 85:30
  + /home/kisskb/slave/src/arch/arm/mach-pxa/idp.c: error: unknown
field 'flags' specified in initializer:  => 85:2
  + /home/kisskb/slave/src/arch/arm/mach-pxa/idp.c: error: variable
'smc91x_platdata' has initializer but incomplete type:  => 84:15

pxa255-idp_defconfig

  + /home/kisskb/slave/src/arch/arm/mach-pxa/lpd270.c: error: expected
'}' before ';' token:  => 198:43

lpd270_defconfig

  + /home/kisskb/slave/src/arch/arm/mach-sa1100/neponset.c: error:
'smc91c_platdata' undeclared (first use in this function):  => 271:12

neponset_defconfig

  + /home/kisskb/slave/src/arch/arm/mach-sa1100/pleb.c: error:
'smc91c_platdata' undeclared here (not in a function):  => 57:22

pleb_defconfig

  + /home/kisskb/slave/src/drivers/net/ethernet/smsc/smc91x.c: error:
implicit declaration of function 'machine_has_neponset'
[-Werror=implicit-function-declaration]:  => 2363:2

neponset_defconfig

smc91x fallout. The lpd270_defconfig failure looks like not covered by
"ARM: fix typos in smc91x platform data" yet?

  + /home/kisskb/slave/src/arch/powerpc/platforms/pseries/hotplug-memory.c:
error: 'SECTION_SIZE_BITS' undeclared (first use in this function):
=> 27:31
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error:
'PAGES_PER_SECTION' undeclared (first use in this function):  =>
1836:46, 1178:18
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error:
'PAGE_SECTION_MASK' undeclared (first use in this function):  =>
1177:20
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error: implicit
declaration of function '__nr_to_section'
[-Werror=implicit-function-declaration]:  => 1841:3
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error: implicit
declaration of function 'find_memory_block_hinted'
[-Werror=implicit-function-declaration]:  => 1848:3
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error: implicit
declaration of function 'pfn_to_section_nr'
[-Werror=implicit-function-declaration]:  => 1837:3
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error: implicit
declaration of function 'present_section_nr'
[-Werror=implicit-function-declaration]:  => 1838:3

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/8557/ (255 out of 257 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/8529/ (256 out of 257 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
