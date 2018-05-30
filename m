Return-Path: <diana.craciun@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0046.outbound.protection.outlook.com [104.47.1.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wvCR4hN1zDr6Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 01:09:54 +1000 (AEST)
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Scott Wood <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: "mpe@ellerman.id.au" <mpe@ellerman.id.au>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [RFC PATCH] powerpc/fsl: Add barrier_nospec implementation for
 NXP PowerPC Book E
Date: Wed, 30 May 2018 15:09:48 +0000
Message-ID: <VI1PR0401MB24632A29ADC51D30D2247BB7FF6C0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <1526973031-9543-1-git-send-email-diana.craciun@nxp.com>
 <1527020969.30674.13.camel@buserror.net>
 <VI1PR0401MB246345AD11EC8666B7187F8DFF6D0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
 <1527621245.30674.30.camel@buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/29/2018 10:16 PM, Scott Wood wrote:=0A=
> On Tue, 2018-05-29 at 15:22 +0000, Diana Madalina Craciun wrote:=0A=
>> Hi Scott,=0A=
>>=0A=
>> Thanks for the review.=0A=
>>=0A=
>> On 05/22/2018 11:31 PM, Scott Wood wrote:=0A=
>>> On Tue, 2018-05-22 at 10:10 +0300, Diana Craciun wrote:=0A=
>>>> Implement the barrier_nospec as a isync;sync instruction sequence.=0A=
>>>> The implementation uses the infrastructure built for BOOK3S 64=0A=
>>>> with the difference that for NXP platforms there is no firmware involv=
ed=0A=
>>>> and the need for a speculation barrier is read from the device tree.=
=0A=
>>>> I have used the same name for the property:=0A=
>>>> fsl,needs-spec-barrier-for-bounds-check=0A=
>>> Using the device tree this way means that anyone without an updated dev=
ice=0A=
>>> tree won't get the protection.  I also don't see any device tree update=
s=0A=
>>> --=0A=
>>> which chips are affected?=0A=
>> I was planning to have the device tree changes in a different patch-set.=
=0A=
>> The affected cores are e500, e500mc, e5500, e6500.=0A=
> So, all supported FSL/NXP book E chips.  Why not just enable the workarou=
nd=0A=
> unconditionally (and revisit if NXP ever produces a book E chip that does=
n't=0A=
> need it and/or e200 is ever supported if that's simple enough to be immun=
e)?=0A=
=0A=
I think it makes sense having in mind that all the NXP book E chips are=0A=
vulnerable. e200 is not vulnerable, but it is not properly supported in=0A=
the kernel anyway. So I guess I can enable the workaround=0A=
unconditionally. I am wondering if it does make sense patching the=0A=
instructions at all (instead just use the barrier as an isync; sync=0A=
sequence always), but in this case we will loose the possibility of=0A=
controlling it via debugfs at runtime.=0A=
=0A=
>=0A=
>>> Why patch nops in if not enabled?  Aren't those locations already=0A=
>>> nops?  For=0A=
>>> that matter, how can this function even be called on FSL_BOOK3E with=0A=
>>> enable !=3D=0A=
>>> true?=0A=
>> There is some code in arch/powerpc/kernel/security.c which allows=0A=
>> control of barrier_nospec via debugfs.=0A=
> OK.=0A=
>=0A=
>>> Should there be a way for the user to choose not to enable this (editin=
g=0A=
>>> the=0A=
>>> device tree doesn't count), for a use case that is not sufficiently=0A=
>>> security=0A=
>>> sensitive to justify the performance loss?  What is the performance imp=
act=0A=
>>> of=0A=
>>> this patch?=0A=
>> My reason was that on the other architectures Spectre variant 1=0A=
>> mitigations are not disabled either. But I think that it might be a good=
=0A=
>> idea to add a bootarg parameter to disable the barrier.=0A=
> Is there a specific policy reason why they allow spectre v2 to be disable=
d but=0A=
> not v1, or just a matter of not having a mechanism to disable it, or the =
parts=0A=
> which could practically be disabled not impacting performance much?=0A=
=0A=
I do not know for sure but I can speculate. The other architectures read=0A=
some flags set by the firmware, so I might think that they might use=0A=
different versions of firmware if they do not want the mitigations. On=0A=
the other hand the other architectures defined special barriers just for=0A=
the purpose of preventing speculations which might be more lightweight=0A=
and maybe they are not impacting the performance much. But having in=0A=
mind that the NXP parts are used in embedded scenarios that might run in=0A=
isolation (so no vulnerability) and that the barrier we are using is not=0A=
that lightweight I think that we should have a way to disable it.=0A=
=0A=
Diana=0A=
=0A=
