Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D1462C02BF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 02:21:58 +1000 (EST)
Received: from mail40-co1 (localhost [127.0.0.1])	by mail40-co1-R.bigfish.com
 (Postfix) with ESMTP id C6DFDDC0243	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 18 Jun 2013 16:21:53 +0000 (UTC)
Received: from CO1EHSMHS012.bigfish.com (unknown [10.243.78.229])	by
 mail40-co1.bigfish.com (Postfix) with ESMTP id 93F8172007A	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 16:21:52 +0000 (UTC)
Date: Tue, 18 Jun 2013 11:21:48 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/5] powerpc/dts: update MSI bindings doc for MPIC v4.3
To: Lian Minghuan-b31939 <B31939@freescale.com>
References: <1371516126.9073.16@snotra> <51BFCAAF.1070400@freescale.com>
In-Reply-To: <51BFCAAF.1070400@freescale.com> (from B31939@freescale.com on
 Mon Jun 17 21:49:19 2013)
Message-ID: <1371572508.9073.20@snotra>
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

On 06/17/2013 09:49:19 PM, Lian Minghuan-b31939 wrote:
> On 06/18/2013 08:42 AM, Scott Wood wrote:
>> On 06/17/2013 07:28:07 PM, Scott Wood wrote:
>>> On 06/17/2013 12:07:41 AM, Lian Minghuan-b31939 wrote:
>>>>>> +    compatible =3D "fsl,mpic-msi";
>>>>>> +    reg =3D <0x41600 0x200 0x44140 4>;
>>>>>=20
>>>>> Why 0x200?
>>>>>=20
>>>> [Minghuan] The offsets of the MSIA registers are from 0x41600 to =20
>>>> 0x417ff, and the size is 0x200.
>>>> offset 0x41600-0x4170 are MSIIRA1-7.
>>>> 0x41720 is MSISRA,
>>>> 0x41750 is MSIIR.
>>>> The others are reserved.
>>>=20
>>> There is no MSIIRA on fsl,mpic-msi.
>>=20
>> Sigh, I was thinking of MSIIR1A -- which of course is distinct from =20
>> both MSIIRA1 and MSIIRA. :-P
>>=20
>> So it's just a bug that pq3-mpic.dtsi has a length of 0x80?
> [Minghuan] I am sorry, there is a typo.
> offset 0x41600-0x4170 should be MSIRA0-7.
> The MSI bank size is 0x200.
> The MSIR 0-7 size is 0x80.
> So the first region of 'reg' should indicate bank size or MSIR size?
> I think it should be a bank size. So MSI driver can access MSISR and =20
> MSIIR, and provide some new features in feature.

It should be the bank size.  There's already inconsistency between =20
pq3-mpic.dtsi and qoriq-mpic.dtsi (the latter has 0x200).  I think =20
pq3-mpic.dtsi is just wrong and should be fixed.

-Scott=
