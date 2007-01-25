Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2B0DDDF32
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 02:11:51 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E85D6EF@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816B9C@zch01exm20.fsl.freescale.net>
	<2C8EB4AF-97B2-40F5-8112-0CEE6E3D4D42@kernel.crashing.org>
	<32F3CC26D4DAC44E8ECD07155727A46E85D6E4@zch01exm20.fsl.freescale.net>
	<A85281E5-1E9C-4938-8940-CF696C3C5174@kernel.crashing.org>
	<32F3CC26D4DAC44E8ECD07155727A46E85D6EF@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=GB2312; delsp=yes; format=flowed
Message-Id: <F8DCDEDE-C060-458D-8E04-EA4C1EE2B2EE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Thu, 25 Jan 2007 09:10:48 -0600
To: Zhu Ebony-r57400 <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 25, 2007, at 2:53 AM, Zhu Ebony-r57400 wrote:

>
>
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: 2007=C4=EA1=D4=C225=C8=D5 16:29
>> To: Zhu Ebony-r57400
>> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
>> Subject: Re: [patch][0/5] powerpc: Add support to fully
>> comply with IEEE-754 standard
>>
>>
>> On Jan 25, 2007, at 2:25 AM, Zhu Ebony-r57400 wrote:
>>
>>>
>>>> No, I think the round handler should try to do the
>> rounding by hand.
>>>> Since you have the non rounded information provided by HW,
>> its much
>>>> simpler to just do the rounding step.
>>>
>>> Hi Kumar,
>>>
>>> I have some new thoughts about rounding handler.
>>> Suppose we set SPEFSCR[FRMC]=3D0b10 (rounding towards +Inf)
>> and a normal
>>> "efsmul" may generate rounding interrupt. At this time,
>> according to
>>> manual, unrounded (truncated) result is placed in the
>> target register.
>>> Please note the target register contains a hexadecimal
>> representation
>>> of a floating point number. Since it represents a floating point
>>> number exactly so we can not round it anymore.
>>
>> I don't follow what you mean by not being able to round it anymore.
>
> I try to make myself clear:
>> =46rom my understanding, rounding is from a floating point number to =20=

>> another
> which can be represented by IEEE-754 complied hexadecimal, but not
> from a hexadecimal to another. For example:
>
> Assume the result we got from efsmul is 3.29305125103e-44
> It will be stored in target register as 0x00000017. However, =20
> 0x00000017
> Represents 3.2229864679470793e-44 accurately. Can we round  =20
> 3.2229864679470793e-44?
> I'm afraid not. I mean, we must round the result before it being =20
> stored in
> target register as hexadecimal, not after.

I still don't follow what you are getting at.  The HW stores the non-=20
rounded result.  You seem to imply there is some format change or =20
something that is going on between the computed result and what's =20
stored in the register.  If the result is such that it doesn't need =20
rounding than you don't round (I forget if you can an exception or =20
not if G|X are not set).

>>> Maybe we still need to emulate the whole "efsmul" instruction by
>>> software.
>>
>> You can't always do that.  Think about the following instruction:
>>
>> 	efsmul	r3, r3, r3
>>
>> You'll have lost the original value of r3 when the exception occurs.
>
> If this operation causes FP data interrupt, just let data interrupt =20=

> handler to
> do the simulation. I think there's no chance that we get data and =20
> round interrupts
> simultaneously.

Agreed, and I think FP data will take precedence, however the example =20=

I use can still cause a round exception and no data exception given =20
the right input values.

- k
