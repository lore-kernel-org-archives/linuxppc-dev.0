Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B4E62C02CF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 02:22:49 +1000 (EST)
Received: from mail97-tx2 (localhost [127.0.0.1])	by mail97-tx2-R.bigfish.com
 (Postfix) with ESMTP id C52B2320071	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 18 Jun 2013 16:22:44 +0000 (UTC)
Received: from TX2EHSMHS034.bigfish.com (unknown [10.9.14.230])	by
 mail97-tx2.bigfish.com (Postfix) with ESMTP id 84AA140048	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 16:22:31 +0000 (UTC)
Date: Tue, 18 Jun 2013 11:22:25 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5/5] powerpc/fsl_msi: add 'msiregs' kernel parameter
To: Lian Minghuan-b31939 <B31939@freescale.com>
References: <1371514692.9073.12@snotra> <51BFCF99.1010608@freescale.com>
In-Reply-To: <51BFCF99.1010608@freescale.com> (from B31939@freescale.com on
 Mon Jun 17 22:10:17 2013)
Message-ID: <1371572545.9073.21@snotra>
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

On 06/17/2013 10:10:17 PM, Lian Minghuan-b31939 wrote:
> Hi Scott,
>=20
> please see my comments inline.
>=20
> On 06/18/2013 08:18 AM, Scott Wood wrote:
>> On 06/17/2013 12:36:50 AM, Lian Minghuan-b31939 wrote:
>>> Hi Scott,
>>>=20
>>> please see my comments inline.
>>>=20
>>> On 06/15/2013 06:13 AM, Scott Wood wrote:
>>>> On 06/14/2013 02:15:59 AM, Minghuan Lian wrote:
>>>>> 1. Only MSIIR1 can index 16 MSI registers, but when using MSIIR1
>>>>> the IRQs of a register are not continuous. for example, the first
>>>>> register irq values are 0x0, 0x10, 0x20, 0x30 ... 0x1f0. So it
>>>>> is hard to use 'msi-available-ranges' property to indicate the
>>>>> available ranges and 'msi-available-ranges' property has been
>>>>> removed from dts node, so this patch removes the related code.
>>>>>=20
>>>>> 2. Add 'msiregs' kernel parameter instead of =20
>>>>> 'msi-available-ranges'
>>>>> functionality.
>>>>=20
>>>> The reason we used a device tree property was because this is for =20
>>>> virtualization and AMP scenarios where this instance of Linux does =20
>>>> not own all of the MSI registers.
>>>>=20
>>>> I don't see any reasonable way to partition an MPIC v4.3 MSI group =20
>>>> -- but there are more groups, so it's not that bad. What's the use =20
>>>> case for this patch?
>>>>=20
>>> [Minghuan] I do not known any case about this patch. I add =20
>>> 'msiregs' just for achieving "msi-available-ranges" functionality. =20
>>> I do not want to remove partition functionality when updating to =20
>>> mpic4.3, although I do not see virtualization and AMP cases on =20
>>> T4(KVM does not need this functionality).
>>=20
>> Such functionality does not work on mpic v4.3.  There are =20
>> conflicting requirements of contiguous MSIs (because PCI devices can =20
>> use them that way) and the inability to partition a single register =20
>> (because they all go to the same MPIC interrupt).
>>=20
>> Keep msi-available-ranges as is for older hardware, and just ignore =20
>> it (with a warning printed) if it's present on MPIC v4.3.
>>=20
> [Minghuan] Thanks for your guidance.
> But 'msireg' should be remained or removed?

Removed.

-Scott=
