Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ua0-f177.google.com (mail-ua0-f177.google.com
 [209.85.217.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kZ082DcjzF3HJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2018 20:39:35 +1000 (AEST)
Received: by mail-ua0-f177.google.com with SMTP id r15-v6so3042738uao.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Aug 2018 03:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <1523884165-17044-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1523884165-17044-1-git-send-email-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Aug 2018 12:39:21 +0200
Message-ID: <CAMuHMdXxV1nWGWAAXSkBWm-9VWHVc57nhFLfQ4BijbKGh-vaUQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.17-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CC Dan, Michael, AKPM, powerpc

On Mon, Apr 16, 2018 at 3:10 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.17-rc1[1] compared to v4.16[2].

I'd like to point your attention to:

>   + warning: vmlinux.o(.text+0x376518): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
>   + warning: vmlinux.o(.text+0x376d64): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
>   + warning: vmlinux.o(.text+0x37dfd8): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
>   + warning: vmlinux.o(.text+0x37e824): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
>   + warning: vmlinux.o(.text+0x3944): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
>   + warning: vmlinux.o(.text+0x3978): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
>   + warning: vmlinux.o(.text+0x3a66c): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3():  => N/A
>   + warning: vmlinux.o(.text+0x3e9908): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
>   + warning: vmlinux.o(.text+0x3ea154): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
>   + warning: vmlinux.o(.text+0x498dbc): Section mismatch in reference from the function hmm_devmem_release() to the function .meminit.text:arch_remove_memory():  => N/A
>   + warning: vmlinux.o(.text+0x499130): Section mismatch in reference from the function hmm_devmem_pages_create() to the function .meminit.text:arch_add_memory():  => N/A
>   + warning: vmlinux.o(.text+0x4a59ec): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
>   + warning: vmlinux.o(.text+0x4a5d08): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A
>   + warning: vmlinux.o(.text+0x4ad8ac): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
>   + warning: vmlinux.o(.text+0x4adbc8): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A
>   + warning: vmlinux.o(.text+0x4ca7238): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label():  => N/A
>   + warning: vmlinux.o(.text+0x51ffec): Section mismatch in reference from the function .hmm_devmem_release() to the function .meminit.text:.arch_remove_memory():  => N/A
>   + warning: vmlinux.o(.text+0x520308): Section mismatch in reference from the function .hmm_devmem_pages_create() to the function .meminit.text:.arch_add_memory():  => N/A

These are still seen on v4.18-rc8 on various powerpc all{mod,yes}config builds.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
