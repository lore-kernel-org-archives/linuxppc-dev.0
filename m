Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnkDK4NbxzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 06:59:29 +1100 (AEDT)
Date: Tue, 21 Mar 2017 14:59:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 2/4] asm-generic/io.h: Remove unused generic
 __ioremap() definition
Message-ID: <20170321195923.GC5073@bhelgaas-glaptop.roam.corp.google.com>
References: <20170320182014.4858.22352.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170320184253.4858.12956.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAMuHMdXzCPwijpHsvgHGDYRawF5paBxi4RNYPjxA8fRKOHQb0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAMuHMdXzCPwijpHsvgHGDYRawF5paBxi4RNYPjxA8fRKOHQb0w@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 21, 2017 at 11:37:11AM +0100, Geert Uytterhoeven wrote:
> Hi Björn,
> 
> On Mon, Mar 20, 2017 at 7:42 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > Several arches use __ioremap() to help implement the generic ioremap(),
> > ioremap_nocache(), and ioremap_wc() interfaces, but this usage is all
> > inside the arch/ directory.
> >
> > The only __ioremap() uses outside arch/ are in the ZorroII RAM disk driver
> > and some framebuffer drivers that are only buildable on m68k and powerpc,
> > and they use the versions provided by those arches.
> >
> > There's no need for a generic version of __ioremap(), so remove it.
> 
> These all predate the ioremap_*() variants, and can be converted to
> either ioremap_nocache() or ioremap_wt().
> 
> However, PPC doesn't implement ioremap_wt() yet, so asm-generic will
> fall back to the less-efficient nocache variant.
> PPC does support __ioremap(..., _PAGE_WRITETHRU), so adding a wrapper
> is trivial.

Thanks, I'll try adding ioremap_wt() (at least for PPC32) and cleaning this
up.

> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Regardless,
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
