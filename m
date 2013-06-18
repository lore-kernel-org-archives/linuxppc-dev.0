Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1DC292C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 10:15:19 +1000 (EST)
Received: from mail175-co9 (localhost [127.0.0.1])	by
 mail175-co9-R.bigfish.com (Postfix) with ESMTP id 37230CC0458	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 00:15:16 +0000 (UTC)
Received: from CO9EHSMHS024.bigfish.com (unknown [10.236.132.244])	by
 mail175-co9.bigfish.com (Postfix) with ESMTP id 4676784004A	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 00:15:14 +0000 (UTC)
Date: Mon, 17 Jun 2013 19:15:12 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/5] powerpc/fsl_msi: add MSIIR1 support for MPIC v4.3
To: Lian Minghuan-b31939 <B31939@freescale.com>
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
 <1371194159-17332-2-git-send-email-Minghuan.Lian@freescale.com>
 <1371247751.2996.16@snotra> <51BE7BB1.1070309@freescale.com>
In-Reply-To: <51BE7BB1.1070309@freescale.com> (from B31939@freescale.com on
 Sun Jun 16 22:00:01 2013)
Message-ID: <1371514512.9073.11@snotra>
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

On 06/16/2013 10:00:01 PM, Lian Minghuan-b31939 wrote:
> Hi Scott,
>=20
> please see my comments inline.
>=20
> On 06/15/2013 06:09 AM, Scott Wood wrote:
>> On 06/14/2013 02:15:56 AM, Minghuan Lian wrote:
>>> diff --git a/arch/powerpc/sysdev/fsl_msi.h =20
>>> b/arch/powerpc/sysdev/fsl_msi.h
>>> index 8225f86..43a9d99 100644
>>> --- a/arch/powerpc/sysdev/fsl_msi.h
>>> +++ b/arch/powerpc/sysdev/fsl_msi.h
>>> @@ -16,7 +16,7 @@
>>>  #include <linux/of.h>
>>>  #include <asm/msi_bitmap.h>
>>>=20
>>> -#define NR_MSI_REG        8
>>> +#define NR_MSI_REG        16
>>>  #define IRQS_PER_MSI_REG    32
>>>  #define NR_MSI_IRQS    (NR_MSI_REG * IRQS_PER_MSI_REG)
>>=20
>> I don't see where you update all_avail in fsl_of_msi_probe.
>>=20
>> We should also be bounds-checking the contents of =20
>> msi-available-ranges.
>> Currently it looks like we just silently overrun the bitmap if we =20
>> get bad
>> input from the device tree.
>>=20
> [Minghuan] all_avail definition: static const u32 all_avail[] =3D { 0, =20
> NR_MSI_IRQS };
> When changing NR_MSI_REG to 16, NR_MSI_IRQS has been changed to =20
> 16*32, and all_avail also is updated.

That's my point.  It shouldn't change for older hardware.

> Before calling fsl_msi_setup_hwirq(), the code has checked =20
> 'msi-available-ranges',  only the interrupts lied in =20
> 'msi-available-ranges' will be initialized by call =20
> fsl_msi_setup_hwirq() , and the corresponding bitmap will be freed. I =20
> moved msi_bitmap_free_hwirqs() to fsl_msi_setup_hwirq(), because the =20
> code would generate different bitmap when using MSIIR or MSIIR1.

And what happens if msi-available-ranges is bad, and refers to =20
non-existent MSIs past the end of the bitmap?

-Scott=
