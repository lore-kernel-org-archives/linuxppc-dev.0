Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9063E2C029D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 10:28:16 +1000 (EST)
Received: from mail124-co9 (localhost [127.0.0.1])	by
 mail124-co9-R.bigfish.com (Postfix) with ESMTP id C5FC3A40268	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 00:28:11 +0000 (UTC)
Received: from CO9EHSMHS031.bigfish.com (unknown [10.236.132.241])	by
 mail124-co9.bigfish.com (Postfix) with ESMTP id DF5F282004C	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 00:28:09 +0000 (UTC)
Date: Mon, 17 Jun 2013 19:28:07 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/5] powerpc/dts: update MSI bindings doc for MPIC v4.3
To: Lian Minghuan-b31939 <B31939@freescale.com>
In-Reply-To: <51BE999D.2080207@freescale.com> (from B31939@freescale.com on
 Mon Jun 17 00:07:41 2013)
Message-ID: <1371515287.9073.15@snotra>
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

On 06/17/2013 12:07:41 AM, Lian Minghuan-b31939 wrote:
> Hi Soctt,
>=20
> please see my comments.
>=20
> On 06/15/2013 06:06 AM, Scott Wood wrote:
>> On 06/14/2013 02:15:57 AM, Minghuan Lian wrote:
>>> Add compatible "fsl,mpic-msi-v4.3" for MPIC v4.3. MPIC v4.3 contains
>>> MSIIR and MSIIR1. MSIIR supports 8 MSI registers and MSIIR1 supports
>>> 16 MSI registers, but uses different IBS and SRS shift. When using
>>> MSIR1, the interrupt number is not consecutive. It is hard to use
>>> 'msi-available-ranges' to describe the ranges of the available
>>> interrupt and the ranges are related to the application, rather than
>>> the description of the hardware. this patch also removes
>>> 'msi-available-ranges' property.
>>>=20
>>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>>> ---
>>>  .../devicetree/bindings/powerpc/fsl/msi-pic.txt    | 49 =20
>>> ++++++++++------------
>>>  1 file changed, 22 insertions(+), 27 deletions(-)
>>>=20
>>> diff --git =20
>>> a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt =20
>>> b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
>>> index 5693877..e851e93 100644
>>> --- a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
>>> +++ b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
>>> @@ -1,26 +1,23 @@
>>>  * Freescale MSI interrupt controller
>>>=20
>>>  Required properties:
>>> -- compatible : compatible list, contains 2 entries,
>>> +- compatible : compatible list, may contains one or two entries,
>>>    first is "fsl,CHIP-msi", where CHIP is the processor(mpc8610, =20
>>> mpc8572,
>>> -  etc.) and the second is "fsl,mpic-msi" or "fsl,ipic-msi" =20
>>> depending on
>>> -  the parent type.
>>> +  etc.) and the second is "fsl,mpic-msi" or "fsl,ipic-msi" or
>>> +  "fsl,mpic-msi-v4.3" depending on the parent type and version. If =20
>>> mpic
>>> +  version is 4.3, the number of MSI registers is increased to 16, =20
>>> MSIIR1 is
>>> +  provided to access these 16 registers, compatible =20
>>> "fsl,mpic-msi-v4.3"
>>> +  should be used.
>>=20
>> Why "one or two"?  What does it look like in the case where there's =20
>> just one?
>>=20
> [Minghuan] The original doc said 'contains 2 entries', but I notcie =20
> pq3-mpic.dtsi and qoriq-mpic.dtsi have only one entry "fsl,mpic-msi", =20
> do not have "fsl,CHIP-msi".
> for example:
> mpc8610_hpcd.dts: compatible =3D "fsl,mpc8610-msi", "fsl,mpic-msi";
> fsl/qoriq-mpic.dtsi:  compatible =3D "fsl,mpic-msi"
>=20
> Maybe I should say " For some platforms, "fsl,CHIP-msi' is optional."

Well, this is more a matter of some device trees not complying with the =20
binding, rather than an update for MPIC v4.3.

In any case, if the plan is to update the binding to match what we've =20
been doing in the actual trees, at least word it so that it's clear =20
which one of the two is optional.

>> Why are you removing msi-available-ranges?  It's not valid for MPIC =20
>> v4.3, but it's still valid for older MPICs.  It should move to the =20
>> optional section, though.
> [Minghuan] Because I would like to add kernel parameter 'msiregs' =20
> instead of "msi-available-ranges", for all the MPICs, we will have a =20
> uniform way to configure

I've responded elsewhere to this, but I'd also like to add that we =20
don't break compatibility with older device tree bindings just for "a =20
uniform way".

>>>  Example:
>>>      msi@41600 {
>>> -        compatible =3D "fsl,mpc8610-msi", "fsl,mpic-msi";
>>> -        reg =3D <0x41600 0x80>;
>>> -        msi-available-ranges =3D <0 0x100>;
>>> -        interrupts =3D <
>>> -            0xe0 0
>>> -            0xe1 0
>>> -            0xe2 0
>>> -            0xe3 0
>>> -            0xe4 0
>>> -            0xe5 0
>>> -            0xe6 0
>>> -            0xe7 0>;
>>> -        interrupt-parent =3D <&mpic>;
>>> -    };
>>> +    compatible =3D "fsl,mpic-msi";
>>> +    reg =3D <0x41600 0x200 0x44140 4>;
>>=20
>> Why 0x200?
>>=20
> [Minghuan] The offsets of the MSIA registers are from 0x41600 to =20
> 0x417ff, and the size is 0x200.
> offset 0x41600-0x4170 are MSIIRA1-7.
> 0x41720 is MSISRA,
> 0x41750 is MSIIR.
> The others are reserved.

There is no MSIIRA on fsl,mpic-msi.

If you want to show an fsl,mpic-msi-v4.3 example, update the compatible =20
and add the extra 8 interrupts.  We should probably show an example of =20
each.

BTW, why are you changing/breaking the whitespace in the example?

-Scott=
