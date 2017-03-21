Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnTlb4BPzzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 21:37:15 +1100 (AEDT)
Received: by mail-io0-x244.google.com with SMTP id 68so6839997ioh.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 03:37:15 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20170320184253.4858.12956.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170320182014.4858.22352.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170320184253.4858.12956.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Mar 2017 11:37:11 +0100
Message-ID: <CAMuHMdXzCPwijpHsvgHGDYRawF5paBxi4RNYPjxA8fRKOHQb0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] asm-generic/io.h: Remove unused generic
 __ioremap() definition
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bj=C3=B6rn,

On Mon, Mar 20, 2017 at 7:42 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Several arches use __ioremap() to help implement the generic ioremap(),
> ioremap_nocache(), and ioremap_wc() interfaces, but this usage is all
> inside the arch/ directory.
>
> The only __ioremap() uses outside arch/ are in the ZorroII RAM disk drive=
r
> and some framebuffer drivers that are only buildable on m68k and powerpc,
> and they use the versions provided by those arches.
>
> There's no need for a generic version of __ioremap(), so remove it.

These all predate the ioremap_*() variants, and can be converted to
either ioremap_nocache() or ioremap_wt().

However, PPC doesn't implement ioremap_wt() yet, so asm-generic will
fall back to the less-efficient nocache variant.
PPC does support __ioremap(..., _PAGE_WRITETHRU), so adding a wrapper
is trivial.

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Regardless,
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
