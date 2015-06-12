Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id E92281A0456
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 17:14:55 +1000 (AEST)
Message-ID: <557A86EB.1070509@c-s.fr>
Date: Fri, 12 Jun 2015 09:14:51 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Rob Herring <robh@kernel.org>
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [BUG] mpc8323_rdb platform doesn't boot since kernel 3.16
References: <5572D773.1090008@c-s.fr>
 <CAL_JsqLRFfjOkzw24EttG4kZtafxki+SgRHXFYoLDfjDBwGmbg@mail.gmail.com>
 <557853D5.1040207@c-s.fr>
 <CAL_JsqKuEpBEf6noqjU-N1a38pL8L--Fv-3qfx-xA14oF_+6rg@mail.gmail.com>
In-Reply-To: <CAL_JsqKuEpBEf6noqjU-N1a38pL8L--Fv-3qfx-xA14oF_+6rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/06/2015 20:17, Rob Herring a écrit :
> On Wed, Jun 10, 2015 at 10:12 AM, leroy christophe
> <christophe.leroy@c-s.fr> wrote:
>> Le 06/06/2015 17:32, Rob Herring a écrit :
>>> On Sat, Jun 6, 2015 at 6:20 AM, christophe leroy
>>> <christophe.leroy@c-s.fr> wrote:
>>>> I've got a MPC8323 RDB evaluation platform from freescale
>>>> kernel 4.0 doesn't boot
>>>> kernel 3.16 doesn't boot
>>>> kernel 3.15 boots ok
>>>>
>>>> I disected the issue down to your commit "of/fdt: Convert FDT functions
>>>> to
>>>> use libfdt" (e6a6928c3ea1d0195ed75a091e345696b916c09b)
>>>>
>>>> Do you have an idea of what the issue could be ?
>>> Is your dtb older version of the dtb format (before 0x10)? libfdt
>>> doesn't work on the older versions.
>> Yes, dtb has version 0x11, which seems to be the issue (see below)
> In that your bootloader doesn't understand 0x11.
>
>>> If not, do you have logs with debug enabled in drivers/of/fdt.c?
>> I get "unflatten: error -11 processing FDT"
> Can I get the full debug prints.
Here it is:

  -> unflatten_device_tree()
Unflattening device tree:
magic: d00dfeed
size: 000020b5
version: 00000011
unflatten: error -11 processing FDT
unflatten: error -11 processing FDT
   size is 44dc, allocating...
   unflattening c3ff0b20...
fixed up name for  ->
fixed up name for aliases -> aliases
fixed up name for cpus -> cpus
fixed up name for PowerPC,8323@0 -> PowerPC,8323
fixed up name for memory -> memory
fixed up name for soc8323@e0000000 -> soc8323
fixed up name for wdt@200 -> wdt
fixed up name for power@b00 -> power
fixed up name for i2c@3000 -> i2c
fixed up name for serial@4500 -> serial
fixed up name for serial@4600 -> serial
fixed up name for dma@82a8 -> dma
fixed up name for dma-channel@0 -> dma-channel
fixed up name for dma-channel@80 -> dma-channel
fixed up name for dma-channel@100 -> dma-channel
fixed up name for dma-channel@180 -> dma-channel
fixed up name for crypto@30000 -> crypto
fixed up name for pic@700 -> pic
fixed up name for par_io@1400 -> par_io
fixed up name for gpio-controller@1448 -> gpio-controller
fixed up name for ucc_pin@02 -> ucc_pin
fixed up name for ucc_pin@03 -> ucc_pin
fixed up name for qe@e0100000 -> qe
fixed up name for muram@10000 -> muram
fixed up name for data-only@0 -> data-only
fixed up name for spi@4c0 -> spi
fixed up name for mmc-slot@0 -> mmc-slot
fixed up name for spi@500 -> spi
fixed up name for ucc@3000 -> ucc
fixed up name for ucc@2200 -> ucc
fixed up name for mdio@3120 -> mdio
fixed up name for ethernet-phy@00 -> ethernet-phy
fixed up name for ethernet-phy@04 -> ethernet-phy
fixed up name for interrupt-controller@80 -> interrupt-controller
fixed up name for pci@e0008500 -> pci
unflatten: error -11 processing FDT
unflatten: error -11 processing FDT
  <- unflatten_device_tree()

Christophe
