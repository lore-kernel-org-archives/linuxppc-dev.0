Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-oi0-x229.google.com (mail-oi0-x229.google.com
 [IPv6:2607:f8b0:4003:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B47661A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 17:14:44 +1000 (AEST)
Received: by oiab3 with SMTP id b3so129619775oia.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 00:14:42 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20150712220211.7166.42035.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150712215559.7166.33068.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150712220211.7166.42035.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Mon, 13 Jul 2015 09:14:42 +0200
Message-ID: <CAMuHMdWW3uHLm=rwQ8cmhxGff8vwFDx7_-eSmiy3dndpDKk35Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] IRQ: Print "unexpected IRQ" messages consistently
 across architectures
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-c6x-dev@linux-c6x.org, Parisc List <linux-parisc@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 alpha <linux-alpha@vger.kernel.org>,
 "the arch/x86 maintainers" <x86@kernel.org>,
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

On Mon, Jul 13, 2015 at 12:02 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Many architectures use a variant of "unexpected IRQ trap at vector %x" to
> log unexpected IRQs.  This is confusing because (a) it prints the Linux IRQ
> number, but "vector" more often refers to a CPU vector number, and (b) it
> prints the IRQ number in hex with no base indication, while Linux IRQ
> numbers are usually printed in decimal.
>
> Print the same text ("unexpected IRQ %d") across all architectures.
>
> No functional change other than the output text.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Thanks!

>  arch/m68k/include/asm/hardirq.h    |    2 +-

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

And it looks like m68k can switch to the asm-generic version afterwards...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
