Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wT7gr2VcvzDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 21:07:36 +1000 (AEST)
Received: by mail-oi0-x241.google.com with SMTP id w10so6773509oif.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 04:07:36 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <87a86alo9q.fsf@concordia.ellerman.id.au>
References: <20170512042002.18524-1-chris.packham@alliedtelesis.co.nz>
 <20170512042002.18524-4-chris.packham@alliedtelesis.co.nz>
 <20170517181021.yfctrok7f25d5bu5@pd.tnic>
 <87a86alo9q.fsf@concordia.ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 18 May 2017 13:07:33 +0200
Message-ID: <CAK8P3a0xvL1jfY1+93mnkmBTu-ew+hybFaH57KuRC69RpZJqPg@mail.gmail.com>
Subject: Re: [PATCH 3/3] EDAC: mv64x60: replace in_le32/out_le32 with
 ioread32/iowrite32
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Borislav Petkov <bp@alien8.de>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 18, 2017 at 7:36 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Borislav Petkov <bp@alien8.de> writes:
>
>> Top-posting so that the PPC list can see the whole patch below.
>>
>> Since I don't know PPC, let me add PPC ML to CC for a confirmation this
>> change is correct.
>>
>> Which brings me to the tangential: this driver is from 2006-ish and
>> is for some "Marvell MV64x60 Memory Controller kernel module for PPC
>> platforms". If you're going to touch it, then you should test on the PPC
>> hardware too, so that you don't break the driver there.
>>
>> Unless that hardware is obsolete now and we don't care and, and ..?
>>
>> Maybe someone has some insights...
>
> Not really sorry.
>
> I don't have one of those boards, so I can't test. Maybe someone else on
> the list does?
>
> I'd err on the side of the PPC hardware being obsolete and no one really
> caring. If the driver is helpful on ARM then we may as well use it
> there, if we can also avoid breaking it on PPC then great.

I never had one myself, but tried to figure out what is still there to be
supported. In 2014, we removed one platform (PrPMC2800) that was
obsolete. There were eight boards that didn't make the cut from
arch/ppc32 to arch/powerpc. The C2K is the last one and it was
added in 2008 with this comment:

    Support for the C2K cPCI Single Board Computer from GEFanuc
    (PowerPC MPC7448 with a Marvell MV64460 chipset).
    All features of the board are not supported yet, but the board
    boots, flash works, all Ethernet ports are working and PCI
    devices are all found (USB and SATA on PCI1 do not work yet).

    Part 3 of 5: driver for the board.  At this time it is very generic
    and similar to its original, the driver for the prpmc2800.

The original submitter never followed up on it and neither the
board code not the DTS was ever updated to include additional
features, so I assume it only got worse from there.

According to https://www.abaco.com/products/c2ka-compactpci-sbc
the end-of-life date for the product was in 2015, presumably 10 years
after it got introduced.

This is definitely obsolete by now, and given the missing features
I would assume that nobody is running mainline kernels on it and
it can be removed.

For other related system controllers, there is a good overview on
https://www.linux-mips.org/wiki/Marvell_system_controllers
Apparently some of the older chips are still used in MIPS systems,
aside from the newer ARM SoC designs.

       Arnd
