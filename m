Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 962F0DDE34
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 15:10:17 +1100 (EST)
In-Reply-To: <989B956029373F45A0B8AF02970818900D4289@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF02970818900D4289@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8E80A9C2-2A46-4FF0-9AF4-79B8301858CF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Tue, 6 Feb 2007 22:09:16 -0600
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


On Feb 6, 2007, at 8:27 PM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Wednesday, February 07, 2007 12:31 AM
>> To: Kumar Gala
>> Cc: Li Yang-r58472; linuxppc-dev@ozlabs.org; Paul
>> Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
>>
>>
>> On Feb 6, 2007, at 8:37 AM, Kumar Gala wrote:
>>
>>>
>>> On Feb 6, 2007, at 3:05 AM, Li Yang wrote:
>>>
>>>> Add board specific initialization code for USB
>>>> to work in both MPH and DR mode for MPC8349EMDS
>>>> PB board.
>>>>
>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>> ---
>>>>
>>>> arch/powerpc/platforms/83xx/Kconfig       |    4 ++
>>>> arch/powerpc/platforms/83xx/mpc834x_sys.c |   79
> +++++++++++++++++++
>>>> ++++++++++
>>>> arch/powerpc/platforms/83xx/mpc834x_sys.h |    2 +
>>>> arch/powerpc/platforms/83xx/mpc83xx.h     |   18 +++++++
>>>> 4 files changed, 103 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/
>>>> platforms/83xx/Kconfig
>>>> index edcd5b8..5371645 100644
>>>> --- a/arch/powerpc/platforms/83xx/Kconfig
>>>> +++ b/arch/powerpc/platforms/83xx/Kconfig
>>>> @@ -59,4 +59,8 @@ config PPC_MPC836x
>>>> 	select PPC_INDIRECT_PCI
>>>> 	default y if MPC8360E_PB
>>>> +config 834x_USB_SUPPORT
>>>> +	bool
>>>> +	default y if MPC834x_SYS && (USB || USB_GADGET)
>>>> +
>>>
>>> I'm still not convinced we need a new config option for this.
>>
>> Ok, I see what this now accomplishes, but why don't we just build the
>> support in always, lets just remove the config option altogether?
>
> To save some space and time for embedded product which doesn't really
> need usb?

Its not worth the savings.  We are talking about a reference board  
here, if someone doesn't want this init code in their board port they  
are free to remove it.

- k
