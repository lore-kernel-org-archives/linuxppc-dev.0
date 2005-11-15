Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id EF6D66877A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 04:59:08 +1100 (EST)
Message-ID: <437A21EA.5020507@ru.mvista.com>
Date: Tue, 15 Nov 2005 20:59:06 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
References: <437A1208.2060804@ru.mvista.com> <20051115165532.GB12968@kroah.com>
In-Reply-To: <20051115165532.GB12968@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
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

Greg KH wrote:
> On Tue, Nov 15, 2005 at 07:51:20PM +0300, Vitaly Bordug wrote:
>> Hi, Greg!
>>
>> While doing "platformization" for one of the Freescale SoC's, I have 
>> discovered a serious drawback of the model - it prevents registering 
>> driver with the same name.
> 
> That's not a "drawback" :)
> 
>> For instance, cpm2 on either ppc82xx or ppc85xx is very flexible, and 
>> its device fsl-cpm-scc could (and actually are) utilized in the 
>> different drivers.
>>
>> Those devices will have different bus_id, but pdev->name fields are the 
>> same for all the fsl-cpm-scc, only id is different there. Hence the 
>> fsl-cpm-scc could be driver_register'ed only once, while it is required 
>> several times.
> 
> A driver is registered only once, but can be bound to multiple devices
> just fine, right?
Please let me know, how?

I have for instance struct device_driver with name="fsl-cpm-scc" in both fs_enet and 
cpm_uart(one using SCC1, the other - SCC4, the same device with different id's).

Once it has been registered in fs_enet, I could not register it in cpm_uart, due to 
kobject_register fo require unique names in kobject->name. Am I missing something?

Not registering it in CPM_UART, how the pdev could be obtained?

Maybe this is clear, but platform stuff is cumbersome some times...
> 
>> Could you please suggest possible solutions for this situation? This is 
>> relatively common case among freescale chips, so I guess inventing a 
>> workaround is odd, and writing an additional shim to handle CPM device 
>> multiplexing  is odd either.
> 
> I don't see the problem here.  Are you looking at the new stuff in
> 2.6.15-rc1?
> 
Yes, sort of. I am going to add 8xx IRDA and make cpm_uart platform device model compatible.
> thanks,
> 
> greg k-h
> 
> 


-- 
Sincerely,
Vitaly
