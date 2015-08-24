Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-oi0-x230.google.com (mail-oi0-x230.google.com
 [IPv6:2607:f8b0:4003:c06::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7250B1A1D6F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2015 18:36:06 +1000 (AEST)
Received: by oieu205 with SMTP id u205so5496711oie.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2015 01:36:04 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1440405251-9184-1-git-send-email-geert@linux-m68k.org>
References: <1440405251-9184-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 24 Aug 2015 10:36:04 +0200
Message-ID: <CAMuHMdVomabvJOLLJ-tJs6KjL05YpH3zLkyrPbyEghe=WvOVkA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.2-rc8
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 24, 2015 at 10:34 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.2-rc8[1] to v4.2-rc7[3], the summaries are:
>   - build errors: +4/-7

4 regressions:
  + /home/kisskb/slave/src/include/linux/kvm_host.h: error: array
subscript is above array bounds [-Werror=array-bounds]:  => 430:19
    (arch/powerpc/kvm/book3s_64_mmu.c: In function 'kvmppc_mmu
_book3s_64_tlbie':)

powerpc-randconfig (seen before in a v3.15-rc1 build?)

  + error: initramfs.c: undefined reference to `__stack_chk_guard':
=> .init.text+0x1cb0)
    (init/built-in.o: In function `parse_header':)

x86_64-randconfig

  + error: pci.c: undefined reference to `pci_ioremap_io':  => .init.text+0x3c4)
    (arch/arm/mach-versatile/built-in.o: In function `pci_versatile_setup')

arm-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/9289/ (253 out of 254 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9260/ (253 out of 254 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
