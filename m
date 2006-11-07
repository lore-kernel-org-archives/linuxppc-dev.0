Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <454FC539.2050900@246tNt.com>
References: <200611061035.kA6AZtGZ018329@post.webmailer.de>
	<9580D2CE-BD68-440F-A1FD-09E882D93231@kernel.crashing.org>
	<454FC539.2050900@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <754FECA8-A7B4-44FE-A08D-89019F9005A8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_platform support for OHCI/Bigendian HC
Date: Tue, 7 Nov 2006 10:46:38 -0600
To: Sylvain Munaut <tnt@246tNt.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 6, 2006, at 5:28 PM, Sylvain Munaut wrote:

> Kumar Gala wrote:
>> On Nov 6, 2006, at 4:35 AM, Nicolas DET wrote:
>>
>>
>>> This patch use of_platform device to probe and install OHCI big
>>> endian HC.
>>>
>>> PS: I did not success to properly inline the file using  
>>> thrunderbird.
>>>
>>
>> You really copy the USB maintainers on this.  Also, why bother with
>> the Kconfig for USB_OHCI_HCD_PPC_OF_BE/USB_OHCI_HCD_PPC_OF_LE?
>>
> I think it's a good idea to use those :
>  - Just including both when PPC_OF is used is overkill because it  
> makes
> all USB
> perform useless tests if you never intend to use the LE version for  
> example.
>  - Using the already defined symbol USB_OHCI_BIG_ENDIAN would force
> other ohci user to select BE/LE and they may not want to expose this.

Maybe I'm missing something, but it looks like the _OF_LE & _OF_BE  
are just configuring what matches may occur.  This seems like a one  
time event.

> However in this bus glue test :
>
> +      || defined (CONFIG_USB_OHCI_HCD_PPC_OF_LE) \
> +      || defined (CONFIG_USB_OHCI_HCD_PPC_OF_BE) \
>
> I would just test for CONFIG_USB_OHCI_HCD_PPC_OF to keep things the  
> same
> betwenn all the bus glues. (Sure it would be stupid to select  
> PPC_OF and neither
> LE nor BE ...)
>
> But that's just me and if the usb maintainer is ok with it, it's  
> his call.
>
>
> So otherwise, looks good to me. Haven't tested in hw yet ... I'll  
> report asap.
>
>
> Sylvain
