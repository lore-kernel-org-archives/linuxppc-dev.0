Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B6Vt672tzF2K5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 23:23:50 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id j3so2271737qtn.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 05:23:50 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180328120440.GB1838@infradead.org>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180324174458.26423-2-shea@shealevy.com>
 <20180328120440.GB1838@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Mar 2018 14:23:47 +0200
Message-ID: <CAMuHMdXwEL-gLxiVJwuxwRtkyhR=vEm3GP4dzJMpc1nS8AKxKQ@mail.gmail.com>
Subject: Re: [PATCH 01/16] initrd: Add generic code path for common initrd
 unloading logic.
To: Christoph Hellwig <hch@infradead.org>
Cc: Shea Levy <shea@shealevy.com>, alpha <linux-alpha@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>, linux-c6x-dev@linux-c6x.org,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, nios2-dev@lists.rocketboards.org,
 Openrisc <openrisc@lists.librecores.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Linux-sh list <linux-sh@vger.kernel.org>,
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 28, 2018 at 2:04 PM, Christoph Hellwig <hch@infradead.org> wrote:
>> +#ifdef CONFIG_INITRAMFS_GENERIC_UNLOAD
>> +void free_initrd_mem(unsigned long start, unsigned long end)
>> +{
>> +       free_reserved_area((void *)start, (void *)end, -1, "initrd");
>> +}
>> +#endif
>
> Given how trivial this is and how many architectures can use it I'd
> reverse the polarity and add a CONFIG_HAVE_ARCH_FREE_INITRD_MEM
> instead.

And while adding "special" functionality to the generic version, more and more
users of CONFIG_HAVE_ARCH_FREE_INITRD_MEM will be removed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
