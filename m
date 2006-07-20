Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D73AA67B87
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 22:58:56 +1000 (EST)
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D07064D@zch01exm20.fsl.freescale.net>
References: <4879B0C6C249214CBE7AB04453F84E4D07064D@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <93F26879-ECEB-4513-AA77-EE7285DF7961@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [linux-usb-devel] [PATCH] Fix Freescale high-speed USB
	hostdependency
Date: Thu, 20 Jul 2006 07:59:08 -0500
To: "Li Yang-r58472" <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 20, 2006, at 6:42 AM, Li Yang-r58472 wrote:

> Another one in header file.
>
> ---
> diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> index 679c1cd..8da2774 100644
> --- a/drivers/usb/host/ehci.h
> +++ b/drivers/usb/host/ehci.h
> @@ -642,7 +642,7 @@ #endif
>
>
> / 
> *--------------------------------------------------------------------- 
> -
> ---*/
>
> -#ifdef CONFIG_PPC_83xx
> +#ifdef CONFIG_MPC834x
>  /* Some Freescale processors have an erratum in which the TT
>   * port number in the queue head was 0..N-1 instead of 1..N.
>   */

Do we really want to make this change.  What harm is there in having  
the ehci support for MPC834x build on all 83xx processors?  I can't  
imagine we are going to config in support for ehci on anything that  
is MPC834x at this point and if you do, your device tree isn't going  
to have nodes in it so the drivers not going to bind against anything.

Finally, I got to believe Freescale's going to build some MPC83xx in  
the future with the high speed USB IP.

- kumar

>
>> -----Original Message-----
>> From: linux-usb-devel-bounces@lists.sourceforge.net
>> [mailto:linux-usb-devel-bounces@lists.sourceforge.net] On Behalf Of
> Kumar Gala
>> Sent: Friday, July 14, 2006 9:52 PM
>> To: Li Yang-r58472
>> Cc: linuxppc-dev@ozlabs.org; gregkh@suse.de;
>> linux-usb-devel@lists.sourceforge.net
>> Subject: Re: [linux-usb-devel] [PATCH] Fix Freescale high-speed USB
> hostdependency
>>
>> Acked-by: Kumar Gala <galak@kernel.crashing.org>
>>
>> On Jul 14, 2006, at 6:58 AM, Li Yang wrote:
>>
>>> The high-speed USB SOC only exists on MPC834x family not MPC83xx
>>> family.
>>>
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>
>>> ---
>>>
>>>  drivers/usb/host/ehci-hcd.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-
>>> hcd.c index 79f2d8b..3af1844 100644
>>> --- a/drivers/usb/host/ehci-hcd.c
>>> +++ b/drivers/usb/host/ehci-hcd.c
>>> @@ -892,7 +892,7 @@ #include "ehci-pci.c"
>>>  #define	EHCI_BUS_GLUED
>>>  #endif
>>>
>>> -#ifdef CONFIG_PPC_83xx
>>> +#ifdef CONFIG_MPC834x
>>>  #include "ehci-fsl.c"
>>>  #define	EHCI_BUS_GLUED
>>>  #endif
>
