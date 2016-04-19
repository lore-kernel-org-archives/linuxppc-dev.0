Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ig0-x241.google.com (mail-ig0-x241.google.com
 [IPv6:2607:f8b0:4001:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpwnJ1dbhzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 16:57:40 +1000 (AEST)
Received: by mail-ig0-x241.google.com with SMTP id g8so1288763igr.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 23:57:40 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1461048813-28712-1-git-send-email-geert@linux-m68k.org>
References: <1461048813-28712-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 19 Apr 2016 08:57:37 +0200
Message-ID: <CAMuHMdUqJ0dj25oXhC4MgqSk0SaOHvT262ew+sBs7eV2SCwyUA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.6-rc4
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 19, 2016 at 8:53 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.6-rc4[1] compared to v4.5[2].
>
> Summarized:
>   - build errors: +11/-7
>   - build warnings: +16376/-165

Sorry for the delay, initially I didn't realize why my first report didn't make
it to the list. It was too big, due to 16211 warnings in parisc-allmodconfig
about "-ffunction-sections disabled; it makes profiling impossible [enabled by
default]".

> JFYI, when comparing v4.6-rc4[1] to v4.6-rc3[3], the summaries are:
>   - build errors: +9/-9

  + /home/kisskb/slave/src/arch/powerpc/kernel/pci_dn.c: error:
'struct pci_dn' has no member named 'edev':  => 272:8
  + /home/kisskb/slave/src/arch/powerpc/kernel/pci_dn.c: error:
dereferencing pointer to incomplete type:  => 215:7
  + /home/kisskb/slave/src/arch/powerpc/kernel/pci_dn.c: error:
implicit declaration of function 'eeh_dev_init'
[-Werror=implicit-function-declaration]:  => 212:3

powerpc-randconfig

  + /home/kisskb/slave/src/drivers/thermal/mtk_thermal.c: error:
implicit declaration of function 'device_reset'
[-Werror=implicit-function-declaration]:  => 560:2

x86_64-randconfig (patch available)

> [1] http://kisskb.ellerman.id.au/kisskb/head/10194/ (all 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/10162/ (all 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
