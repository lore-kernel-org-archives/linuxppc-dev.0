Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTk085KP9zDqbF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 19:53:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-edac@vger.kernel.org
Subject: Re: [PATCH 3/3] EDAC: mv64x60: replace in_le32/out_le32 with
 ioread32/iowrite32
In-Reply-To: <CAK8P3a0xvL1jfY1+93mnkmBTu-ew+hybFaH57KuRC69RpZJqPg@mail.gmail.com>
References: <20170512042002.18524-1-chris.packham@alliedtelesis.co.nz>
 <20170512042002.18524-4-chris.packham@alliedtelesis.co.nz>
 <20170517181021.yfctrok7f25d5bu5@pd.tnic>
 <87a86alo9q.fsf@concordia.ellerman.id.au>
 <CAK8P3a0xvL1jfY1+93mnkmBTu-ew+hybFaH57KuRC69RpZJqPg@mail.gmail.com>
Date: Fri, 19 May 2017 19:53:43 +1000
Message-ID: <8737c16ul4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> writes:

> On Thu, May 18, 2017 at 7:36 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Borislav Petkov <bp@alien8.de> writes:
>>
>>> Top-posting so that the PPC list can see the whole patch below.
>>>
>>> Since I don't know PPC, let me add PPC ML to CC for a confirmation this
>>> change is correct.
>>>
>>> Which brings me to the tangential: this driver is from 2006-ish and
>>> is for some "Marvell MV64x60 Memory Controller kernel module for PPC
>>> platforms". If you're going to touch it, then you should test on the PPC
>>> hardware too, so that you don't break the driver there.
>>>
>>> Unless that hardware is obsolete now and we don't care and, and ..?
>>>
>>> Maybe someone has some insights...
>>
>> Not really sorry.
>>
>> I don't have one of those boards, so I can't test. Maybe someone else on
>> the list does?
>>
>> I'd err on the side of the PPC hardware being obsolete and no one really
>> caring. If the driver is helpful on ARM then we may as well use it
>> there, if we can also avoid breaking it on PPC then great.
>
> I never had one myself, but tried to figure out what is still there to be
> supported. In 2014, we removed one platform (PrPMC2800) that was
> obsolete. There were eight boards that didn't make the cut from
> arch/ppc32 to arch/powerpc. The C2K is the last one and it was
> added in 2008 with this comment:
>
>     Support for the C2K cPCI Single Board Computer from GEFanuc
>     (PowerPC MPC7448 with a Marvell MV64460 chipset).
>     All features of the board are not supported yet, but the board
>     boots, flash works, all Ethernet ports are working and PCI
>     devices are all found (USB and SATA on PCI1 do not work yet).
>
>     Part 3 of 5: driver for the board.  At this time it is very generic
>     and similar to its original, the driver for the prpmc2800.
>
> The original submitter never followed up on it and neither the
> board code not the DTS was ever updated to include additional
> features, so I assume it only got worse from there.
>
> According to https://www.abaco.com/products/c2ka-compactpci-sbc
> the end-of-life date for the product was in 2015, presumably 10 years
> after it got introduced.
>
> This is definitely obsolete by now, and given the missing features
> I would assume that nobody is running mainline kernels on it and
> it can be removed.

Great, thanks for doing all that digging.

I'll cook up a patch to remove c2k next week.

Then we can drop CONFIG_MV64X60 from PPC and see where that leaves
things, depending on what's useful on ARM.

cheers
