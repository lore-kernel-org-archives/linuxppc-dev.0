Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2A95D6877F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 06:41:21 +1100 (EST)
Message-ID: <437A39DA.5030307@varma-el.com>
Date: Tue, 15 Nov 2005 22:41:14 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Vitaly Bordug <vbordug@ru.mvista.com>
References: <437A1208.2060804@ru.mvista.com> <20051115165532.GB12968@kroah.com>
	<437A21EA.5020507@ru.mvista.com>
In-Reply-To: <437A21EA.5020507@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <greg@kroah.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Platform device model drawback
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> Greg KH wrote:
> 
>> On Tue, Nov 15, 2005 at 07:51:20PM +0300, Vitaly Bordug wrote:
>>
>>> Hi, Greg!
>>>
>>> While doing "platformization" for one of the Freescale SoC's, I have
>>> discovered a serious drawback of the model - it prevents registering
>>> driver with the same name.
>>
>>
>> That's not a "drawback" :)
>>
>>> For instance, cpm2 on either ppc82xx or ppc85xx is very flexible, and
>>> its device fsl-cpm-scc could (and actually are) utilized in the
>>> different drivers.
>>>
>>> Those devices will have different bus_id, but pdev->name fields are
>>> the same for all the fsl-cpm-scc, only id is different there. Hence
>>> the fsl-cpm-scc could be driver_register'ed only once, while it is
>>> required several times.
>>
>>
>> A driver is registered only once, but can be bound to multiple devices
>> just fine, right?
> 
> Please let me know, how?
> 
> I have for instance struct device_driver with name="fsl-cpm-scc" in both
> fs_enet and cpm_uart(one using SCC1, the other - SCC4, the same device
> with different id's).
> 
> Once it has been registered in fs_enet, I could not register it in
> cpm_uart, due to kobject_register fo require unique names in
> kobject->name. Am I missing something?

May be better to convert fsl-cpm-scc to BUS driver which will be
derived from platform_driver? In this case you'll get flexible
SCCx enumerator as bonus.

--
Regards
Andrey Volkov
