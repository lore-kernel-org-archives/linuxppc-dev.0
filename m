Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F01312C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 04:43:22 +1100 (EST)
Received: by mail-pa0-f43.google.com with SMTP id bj1so9139613pad.30
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Mar 2014 10:43:18 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1394528182-32013-1-git-send-email-geert@linux-m68k.org>
References: <1394528182-32013-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 11 Mar 2014 18:43:18 +0100
Message-ID: <CAMuHMdWvQ3aux_901uoiw4k_YJ37Wbvdaroz3z-3GVxBPzoMWQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.14-rc6
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: the arch/x86 maintainers <x86@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 11, 2014 at 9:56 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.14-rc6[1]  to v3.14-rc5[3], the summaries are:
>   - build errors: +10/-4

Only fuzz from the randconfig police:

  + /scratch/kisskb/src/drivers/gpu/drm/drm_gem_cma_helper.c: error:
implicit declaration of function 'dma_alloc_writecombine'
[-Werror=implicit-function-declaration]:  => 91:2
  + /scratch/kisskb/src/drivers/gpu/drm/drm_gem_cma_helper.c: error:
implicit declaration of function 'dma_free_writecombine'
[-Werror=implicit-function-declaration]:  => 176:3

sh-randconfig

  + /scratch/kisskb/src/kernel/bounds.c: error: -mcall-aixdesc must be
big endian:  => 1:0
  + /scratch/kisskb/src/scripts/mod/devicetable-offsets.c: error:
-mcall-aixdesc must be big endian:  => 1:0
  + /scratch/kisskb/src/scripts/mod/empty.c: error: -mcall-aixdesc
must be big endian:  => 1:0
  + <stdin>: error: -mcall-aixdesc must be big endian:  => 1:0

powerpc-randconfig

  + error: No rule to make target /etc/sound/pndsperm.bin:  => N/A
  + error: No rule to make target /etc/sound/pndspini.bin:  => N/A
  + error: No rule to make target /etc/sound/trxpro.hex:  => N/A

i386-randconfig

  + error: initramfs.c: undefined reference to `__stack_chk_guard':
=> .init.text+0x1aef)

x86_64-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7258/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7236/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
