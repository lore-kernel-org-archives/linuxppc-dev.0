Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lb0-x22b.google.com (mail-lb0-x22b.google.com
 [IPv6:2a00:1450:4010:c04::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 191A91A003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 06:57:33 +1000 (EST)
Received: by mail-lb0-f171.google.com with SMTP id l4so4739868lbv.30
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 13:57:29 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAJhHMCDE8e019oLvO7QEcAB-=yqkmgF4OS2VwRrJNV+vvXOe5Q@mail.gmail.com>
References: <1408388465-26577-1-git-send-email-bobby.prani@gmail.com>
 <CAMuHMdXutLPeyDYHdRJ6Heb4vhtg=zMTpwOpKq1h4Yyk8exUSQ@mail.gmail.com>
 <CAJhHMCDE8e019oLvO7QEcAB-=yqkmgF4OS2VwRrJNV+vvXOe5Q@mail.gmail.com>
Date: Mon, 18 Aug 2014 22:57:29 +0200
Message-ID: <CAMuHMdXxpnXPqoo6cT2tmXxHmFc1syMxWnrc-khGxytVi81s0g@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix build failure for PPC_32
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pranith Kumar <bobby.prani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Rob Herring <robh@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Gerhard Sittig <gsi@denx.de>,
 open list <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Pranith,

On Mon, Aug 18, 2014 at 10:52 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> On Mon, Aug 18, 2014 at 3:28 PM, Geert Uytterhoeven <geert@linux-m68k.org>
> wrote:
>> On Mon, Aug 18, 2014 at 9:01 PM, Pranith Kumar <bobby.prani@gmail.com>
>> wrote:
>> > Fix ppc 32 build failure as reported here:
>> >
>> > http://kisskb.ellerman.id.au/kisskb/buildresult/11663513/
>>
>> | arch/powerpc/include/asm/floppy.h:142:20: error: 'isa_bridge_pcidev'
>> undeclared (first use in this function)
>> | make[3]: *** [drivers/block/floppy.o] Error 1
>>
>> The definition of isa_bridge_pcidev is only available if CONFIG_PCI=y...
>>
>> > The error is that pci_32.o was not being built for PPC_32. Fix error by
>> > adding
>> > it in the Makefile. Tested using the ppc cross compiler.
>>
>> ... so how can adding this make the floppy.h error go away?
>
> So the definition which you are talking about within CONFIG_PCI=y is an
> extern definition
>
> arch/powerpc/include/asm/ppc-pci.h:28:extern struct pci_dev
> *isa_bridge_pcidev;
>
> If you build pci_32.o unconditionally, there is an
>
> EXPORT_SYMBOL(isa_bridge_pcidev);
>
> which supplies the required symbol.

Yes, but the error in floppy.h is from the compiler, not from the linker.
Supplying the symbol for the linker doesn't help the compiler when
building floppy.c.

> But yes, you are right in that we should not unconditionally compile
> pci_32.o. Making floppy depend on PCI is the right thing to do. However,
>>
>> Note that arch/powerpc/kernel/Makefile does add
>> pci_$(CONFIG_WORD_SIZE).o, but only if CONFIG_PCI=y.
>>
>> So, thanks for your patch, but I don't think your fix is the right
>> solution.
>>
>> However, drivers/block/floppy.o is enabled by BLK_DEV_FD, which
>> depends on ARCH_MAY_HAVE_PC_FDC.
>>
>> arch/powerpc/Kconfig has:
>>
>> config ARCH_MAY_HAVE_PC_FDC
>>         bool
>>         default !PPC_PSERIES || PCI
>>
>> PCI is not set, and PPC_PSERIES is also not set, so this
>> defaults to y, which is obviously not correct, as floppy.h needs PCI.
>>
>> As this symbol doesn't enable floppy support in-se, probably it should
>> just
>> be:
>>
>> config ARCH_MAY_HAVE_PC_FDC
>>         bool
>>         depends on PCI
>
> the right thing I guess here is to depend on !PPC_PSERIES && PCI since I
> guess pSeries does not support floppy.h (hence the original condition
> check?).

Note that PowerPC supports multi-platform kernels.
A kernel with PPC_PSERIES and something else with PCI may still want to
have floppy support.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
