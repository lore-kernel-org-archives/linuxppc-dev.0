Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lb0-x230.google.com (mail-lb0-x230.google.com
 [IPv6:2a00:1450:4010:c04::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D0651A018A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Dec 2014 07:22:45 +1100 (AEDT)
Received: by mail-lb0-f176.google.com with SMTP id p9so11283494lbv.21
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Dec 2014 12:22:41 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1419883144-13523-1-git-send-email-geert@linux-m68k.org>
References: <1419883144-13523-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 29 Dec 2014 21:22:41 +0100
Message-ID: <CAMuHMdXccHA6Zzv-avucH3e5CpguUT-nAAHQ=E+V-rdVLiEV7g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.19-rc2
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

On Mon, Dec 29, 2014 at 8:59 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.19-rc2[1]  to v3.19-rc1[3], the summaries are:
>   - build errors: +8/-5

Surprise! No new R_PPC64_REL24 relocation truncations, hence not much new
generic code was added. Bloat-o-meter on atari_defconfig agrees: +36 bytes.

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

  + error: initramfs.c: undefined reference to `__stack_chk_guard':
=> .init.text+0x3132)

i386-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/8257/ (all 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/8241/ (all 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
