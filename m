Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EFFA62C008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 04:10:38 +1000 (EST)
Received: from mail170-co1 (localhost [127.0.0.1])	by
 mail170-co1-R.bigfish.com (Postfix) with ESMTP id 052866C02FA	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:10:34 +0000 (UTC)
Received: from CO1EHSMHS006.bigfish.com (unknown [10.243.78.233])	by
 mail170-co1.bigfish.com (Postfix) with ESMTP id D3C6A860195	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:09:53 +0000 (UTC)
Date: Tue, 18 Jun 2013 13:08:58 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/5] powerpc/fsl_msi: add MSIIR1 support for MPIC v4.3
To: Lian Minghuan-b31939 <B31939@freescale.com>
In-Reply-To: <51BFC749.3080502@freescale.com> (from B31939@freescale.com on
 Mon Jun 17 21:34:49 2013)
Message-ID: <1371578938.9073.30@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2013 09:34:49 PM, Lian Minghuan-b31939 wrote:
> Hi Soctt,
>=20
> please see my comments inline.
>=20
> On 06/18/2013 08:15 AM, Scott Wood wrote:
>> On 06/16/2013 10:00:01 PM, Lian Minghuan-b31939 wrote:
>>> Hi Scott,
>>>=20
>>> please see my comments inline.
>>>=20
>>> On 06/15/2013 06:09 AM, Scott Wood wrote:
>>>> On 06/14/2013 02:15:56 AM, Minghuan Lian wrote:
>>>>> diff --git a/arch/powerpc/sysdev/fsl_msi.h =20
>>>>> b/arch/powerpc/sysdev/fsl_msi.h
>>>>> index 8225f86..43a9d99 100644
>>>>> --- a/arch/powerpc/sysdev/fsl_msi.h
>>>>> +++ b/arch/powerpc/sysdev/fsl_msi.h
>>>>> @@ -16,7 +16,7 @@
>>>>>  #include <linux/of.h>
>>>>>  #include <asm/msi_bitmap.h>
>>>>>=20
>>>>> -#define NR_MSI_REG        8
>>>>> +#define NR_MSI_REG        16
>>>>>  #define IRQS_PER_MSI_REG    32
>>>>>  #define NR_MSI_IRQS    (NR_MSI_REG * IRQS_PER_MSI_REG)
>>>>=20
>>>> I don't see where you update all_avail in fsl_of_msi_probe.
>>>>=20
>>>> We should also be bounds-checking the contents of =20
>>>> msi-available-ranges.
>>>> Currently it looks like we just silently overrun the bitmap if we =20
>>>> get bad
>>>> input from the device tree.
>>>>=20
>>> [Minghuan] all_avail definition: static const u32 all_avail[] =3D { =20
>>> 0, NR_MSI_IRQS };
>>> When changing NR_MSI_REG to 16, NR_MSI_IRQS has been changed to =20
>>> 16*32, and all_avail also is updated.
>>=20
>> That's my point.  It shouldn't change for older hardware.
> [Minghaun] the older hardware has 8 registers, mipcv4.3 has 16 =20
> registers. If we do not use 16*32 bitmap to indicate 8*32 irqs.(this =20
> way just only wastes some memory and has no other harm)

Using the larger bitmap unconditionally is fine.  What is not fine is, =20
on older hardware, acting as if all 16 irqs are present.

In other words, I'm talking about the contents of the bitmap, not its =20
size.

> we have two choice I think.
> 1. Use a variable assigned value 8 or 16 based on compatible, then =20
> dynamically create bitmap

If we have the mpic4.3 compatible, then we don't even support =20
msi-available-ranges, so we'd skip this code and free everything in the =20
bitmap.

> 2. Add a new file for mpic v4.3.

No. :-)

-Scott=
