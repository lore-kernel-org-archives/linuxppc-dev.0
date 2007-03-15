Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B01D5DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 16:41:06 +1100 (EST)
In-Reply-To: <989B956029373F45A0B8AF02970818902DB10B@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF02970818902DB10B@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <656DBF73-C99B-4C86-9C86-763744FB4C5C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][POWERPC] QE: Make QUICC Engine support a
	configurableoption
Date: Thu, 15 Mar 2007 00:40:13 -0500
To: "Li Yang-r58472" <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 15, 2007, at 12:39 AM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Thursday, March 15, 2007 11:49 AM
>> To: Li Yang-r58472
>> Cc: Tabi Timur-B04825; Phillips Kim-R1AAHA; linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH][POWERPC] QE: Make QUICC Engine support a
> configurableoption
>>
>>
>> On Mar 14, 2007, at 10:02 PM, Li Yang-r58472 wrote:
>>
>>>> -----Original Message-----
>>>> From: linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org
>>>> [mailto:linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org] On
>>>> Behalf
>>> Of Timur
>>>> Tabi
>>>> Sent: Thursday, March 15, 2007 3:36 AM
>>>> To: Phillips Kim-R1AAHA
>>>> Cc: linuxppc-dev@ozlabs.org
>>>> Subject: Re: [PATCH][POWERPC] QE: Make QUICC Engine support a
>>> configurableoption
>>>>
>>>> Kim Phillips wrote:
>>>>> On Wed, 14 Mar 2007 13:15:05 -0500 (CDT)
>>>>> Kumar Gala <galak@kernel.crashing.org> wrote:
>>>>>
>>>>>>  arch/powerpc/Kconfig                |    8 --------
>>>>>>  arch/powerpc/platforms/83xx/Kconfig |   12 ++++++++++--
>>>>>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>>>>
>>>>> What about 85xx QE support?
>>>>
>>>> Kumar and I talked about it.  85xx support will be added when QE
>>>> works
>>> on 85xx.
>>>> However,
>>>> the patch still needs changes.  To allow each CPU family to have
> its
>>> own QE option,
>>>> we'll
>>>> need to define something like QUICC_ENGINE_83xx and
>>>> QUICC_ENGINE_85xx,
>>> and then
>>>> have
>>>> something like this:
>>>>
>>>> config QUICC_ENGINE
>>>> 	bool
>>>> 	default y if QUICC_ENGINE_83xx || QUICC_ENGINE_85xx
>>>
>>> I don't think we need these new options.  If there are differences
>>> between the two SOC versions, presumably not too many, we can
> address
>>> them in device tree.  It's better to leave the QUICC_ENGINE option
> at
>>> arch/powerpc/Kconfig level, IMHO.
>>
>>
>> The issue isn't dealing with differences between 83xx/85xx.  Its
>> allowing the choice for only those two subarchs.
>
> If you want to make it configurable, I suggest we put it under the
> "Processor Support" menu in arch/powerpc/Kconfig like Altivec and SPE.
> It is a chip feature rather than board.  And we won't need the two
> redundant options then.

Both of those are features of the Core processor, not the platform.

I'd prefer this be a platform option.  (I'm not a fan of the  
duplication, but its minor)

- k
