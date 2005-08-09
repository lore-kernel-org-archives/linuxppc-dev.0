Return-Path: <jotken@softadvances.com>
Received: from smtpauth01.mail.atl.earthlink.net
	(smtpauth01.mail.atl.earthlink.net [209.86.89.61])
	by ozlabs.org (Postfix) with ESMTP id 1621B68019
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 02:58:52 +1000 (EST)
Message-ID: <42F8E0C9.2050505@softadvances.com>
Date: Tue, 09 Aug 2005 11:58:49 -0500
From: John Otken <jotken@softadvances.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42F89F49.4000205@softadvances.com>
	<A9E0A66D-CE6F-4A55-80FD-5D9E57BB6035@freescale.com>
In-Reply-To: <A9E0A66D-CE6F-4A55-80FD-5D9E57BB6035@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: thomas@schnuerer-online.de,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [linuxppc] 2.6.12-3 header <asm/usb.h> missing ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

My patch to add on-chip OHCI support to the 440EP adds
an asm/usb.h reference to 4xx/ibm440ep.c.  Thomas may
also require it for his MPC5200 mods.

I don't like small include files either.  Perhaps there
is an existing file where struct usb_hcd_platform_data
can live.  Any suggestions?

John


Kumar Gala wrote:
> Why are we bothering with asm-ppc/usb.h anyways?
> 
> The structure defn only appears to be used once.  If this is true,  why 
> not just define it in the .c file.
> 
> - kumar
> 
> On Aug 9, 2005, at 7:19 AM, John Otken wrote:
> 
>> Google found it for me.  It is in my "Support 440EP
>> On-Chip OHCI USB Host Controller" patch:
>>
>> http://patchwork.ozlabs.org/linuxppc/patch?id=1965
>>
>>
>> diff -uprN a/include/asm-ppc/usb.h b/include/asm-ppc/usb.h
>> --- a/include/asm-ppc/usb.h    1969-12-31 17:00:00.000000000 -0700
>> +++ b/include/asm-ppc/usb.h    2005-08-05 06:13:58.000000000 -0500
>> @@ -0,0 +1,13 @@
>> +/*
>> + * ppc/usb.h:
>> + *
>> + */
>> +#ifndef _PPC_USB_H
>> +#define _PPC_USB_H
>> +
>> +struct usb_hcd_platform_data {
>> +    int (*start) (struct platform_device *pdev);
>> +    void (*stop) (struct platform_device *pdev);
>> +};
>> +
>> +#endif /* !(_PPC_USB_H) */
>>
>>
>> Kumar Gala wrote:
>>
>>>
>>>
>>> Begin forwarded message:
>>>
>>>
>>>> From: "Thomas S." <thomas@schnuerer-online.de>
>>>> Date: August 8, 2005 4:48:03 PM CDT
>>>> To: <linux-kernel@vger.kernel.org>
>>>> Subject: [linuxppc] 2.6.12-3 header <asm/usb.h> missing ?
>>>>
>>>>
>>>> Hello,
>>>>
>>>> Im using Kernel PPC on a MPC5200 board and try to use the onChip   
>>>> USB. In
>>>> file /drivers/usb/host/ohci-ppc-soc.c a file <asm/usb.h> is included
>>>> which seems to be missing. I cant find it anywhere , any ideas ?
>>>>
>>>> Thomas
>>>>
>>>>
>>>>
>>>>
>>>> -
>>>> To unsubscribe from this list: send the line "unsubscribe linux-  
>>>> kernel"
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>>
>>>>
>>>
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>
>>
> 
> 
