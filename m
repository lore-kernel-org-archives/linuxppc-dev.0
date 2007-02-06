Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 044A7DDE34
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 15:02:31 +1100 (EST)
In-Reply-To: <989B956029373F45A0B8AF02970818900D41CE@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF02970818900D41CE@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C51879CA-3989-4E6C-9C5A-9839B3E93EB6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Mon, 5 Feb 2007 22:01:32 -0600
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 5, 2007, at 9:46 PM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Tuesday, February 06, 2007 11:31 AM
>> To: Li Yang-r58472
>> Cc: Paul; linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
>>
>>
>> On Feb 5, 2007, at 9:15 PM, Li Yang-r58472 wrote:
>>
>>>> -----Original Message-----
>>>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>>>> Sent: Monday, February 05, 2007 11:04 PM
>>>> To: Li Yang-r58472
>>>> Cc: Paul; linuxppc-dev@ozlabs.org
>>>> Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
>>>>
>>>>
>>>> On Feb 5, 2007, at 3:09 AM, Li Yang wrote:
>>>>
>>>> You have no description about what this patch does and why its
>>>> needed.
>>>
>>> Add cpu and board specific initialization code for USB to work in
> both
>>> MPH and DR mode for MPC8349EMDS PB board.
>>>>
>>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>>> ---
>>>>> arch/powerpc/platforms/83xx/Kconfig       |    4 ++
>>>>> arch/powerpc/platforms/83xx/mpc834x_sys.c |   77
> +++++++++++++++++++
>>>>> ++++++++++
>>>>> arch/powerpc/platforms/83xx/mpc834x_sys.h |   23 +++++++++
>>>>> 3 files changed, 104 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/
>>>>> platforms/83xx/Kconfig
>>>>> index edcd5b8..5371645 100644
>>>>> --- a/arch/powerpc/platforms/83xx/Kconfig
>>>>> +++ b/arch/powerpc/platforms/83xx/Kconfig
>>>>> @@ -59,4 +59,8 @@ config PPC_MPC836x
>>>>> 	select PPC_INDIRECT_PCI
>>>>> 	default y if MPC8360E_PB
>>>>> +config 834x_USB_SUPPORT
>>>>> +	bool
>>>>> +	default y if MPC834x_SYS && (USB || USB_GADGET)
>>>>> +
>>>>
>>>> Do we really need to introduce a new config option?
>>>
>>> It will be neater to make use of the Kconfig feature than judging
> all
>>> the macros and module variations.  It will be a very long #if
> defined
>>> the other way.
>>
>> Huh, it would look like:
>>
>> #if defined(CONFIG_USB) || defined(CONFIG_USB_GADGET).
>
> Are you sure we don't need CONFIG_USB_MODULE and
> CONFIG_USB_GADGET_MODULE any more?  At least in some early kernel
> version, they are needed explicitly.

I'm not seeing any references to either CONFIG option.

Also, I'm not seeing any code to support OTG for ehci/83xx... (in the  
kernel tree).  Are there patches for this?

- k
