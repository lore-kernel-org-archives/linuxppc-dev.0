Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x232.google.com (mail-ob0-x232.google.com
 [IPv6:2607:f8b0:4003:c01::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEF5F1A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 07:53:32 +1100 (AEDT)
Received: by obcxo2 with SMTP id xo2so132849805obc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 13:53:30 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1427138173-18838-1-git-send-email-geert@linux-m68k.org>
References: <1427138173-18838-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 23 Mar 2015 21:53:30 +0100
Message-ID: <CAMuHMdWCyMN4QXU5d=wiy+2hZxxrL2eA12WfWvLqqkLRqhNf3A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.0-rc5
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 23, 2015 at 8:16 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.0-rc5[1] to v4.0-rc4[3], the summaries are:
>   - build errors: +19/-7

  + /home/kisskb/slave/src/drivers/gpu/drm/bridge/ptn3460.c: error:
implicit declaration of function 'devm_gpiod_get'
[-Werror=implicit-function-declaration]:  => 333:2
  + /home/kisskb/slave/src/drivers/gpu/drm/bridge/ptn3460.c: error:
implicit declaration of function 'gpiod_direction_output'
[-Werror=implicit-function-declaration]:  => 340:2
  + /home/kisskb/slave/src/drivers/gpu/drm/bridge/ptn3460.c: error:
implicit declaration of function 'gpiod_set_value'
[-Werror=implicit-function-declaration]:  => 135:2
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error:
'PAGES_PER_SECTION' undeclared (first use in this function):  =>
1836:46, 1178:18, 1943:46
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error:
'PAGE_SECTION_MASK' undeclared (first use in this function):  =>
1177:20
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error:
'PFN_SECTION_SHIFT' undeclared (first use in this function):  =>
1405:31
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
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error: implicit
declaration of function 'section_nr_to_pfn'
[-Werror=implicit-function-declaration]:  => 1873:3
  + error: book3s_64_vio_hv.c: undefined reference to
`power7_wakeup_loss':  => .text+0x408)

powerpc-randconfig

  + error: kvm_main.c: undefined reference to `__stack_chk_guard':  =>
.text+0x5be8)

x86_64-randconfig

  + error: misc.c: undefined reference to `__stack_chk_fail':  => .text+0x9f0)
  + error: misc.c: undefined reference to `__stack_chk_guard':  =>
.text+0x50c), .text+0x310)

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/8610/ (255 out of 257 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/8579/ (255 out of 257 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
