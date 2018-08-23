Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x3Xd5QzrzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 22:25:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Breno Leitao
 <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/xive: Initialize symbol before usage
In-Reply-To: <3b8841ac-ebbb-523e-0d65-ebe27a702d3c@kaod.org>
References: <1534877212-22678-1-git-send-email-leitao@debian.org>
 <87lg8xlq9a.fsf@concordia.ellerman.id.au>
 <3b8841ac-ebbb-523e-0d65-ebe27a702d3c@kaod.org>
Date: Thu, 23 Aug 2018 22:25:36 +1000
Message-ID: <87y3cxjmm7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

C=C3=A9dric Le Goater <clg@kaod.org> writes:
> On 08/23/2018 05:24 AM, Michael Ellerman wrote:
>> Breno Leitao <leitao@debian.org> writes:
>>> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xi=
ve/native.c
>>> index 311185b9960a..fc56673a3c0f 100644
>>> --- a/arch/powerpc/sysdev/xive/native.c
>>> +++ b/arch/powerpc/sysdev/xive/native.c
>>> @@ -239,7 +239,7 @@ static bool xive_native_match(struct device_node *n=
ode)
>>>  static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
>>>  {
>>>  	struct device_node *np;
>>> -	unsigned int chip_id;
>>> +	unsigned int chip_id =3D 0;
>>>  	s64 irq;
>>>=20=20
>>>  	/* Find the chip ID */
>>=20
>> The current code is:
>>=20
>> 	/* Find the chip ID */
>> 	np =3D of_get_cpu_node(cpu, NULL);
>> 	if (np) {
>> 		if (of_property_read_u32(np, "ibm,chip-id", &chip_id) < 0)
>> 			chip_id =3D 0;
>> 	}
>>=20
>> Where if np is NULL then we don't initialise chip_id.
>>=20
>> Which could be:
>>=20
>> 	np =3D of_get_cpu_node(cpu, NULL);
>>         if (of_property_read_u32(np, "ibm,chip-id", &chip_id) < 0)
>>                 chip_id =3D 0;
>>=20
>> Because of_property_read_u32() will just return an error if np is NULL.
>>=20
>> It's also missing an of_node_put() of np, you should do a separate patch
>> to fix that. You can just do it unconditionally after the
>> of_property_read_u32().
>
> I think we can simply get rid of the OF code under xive_native_get_ipi()
> and use xc->chip_id instead. It should be safe to use as xive_prepare_cpu=
()=20
> should have initialized ->chip_id by the time xive_native_get_ipi() is=20
> called.=20

Even better!

cheers
