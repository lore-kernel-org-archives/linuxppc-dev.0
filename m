Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7BB41DE4EB
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 20:16:01 +1000 (EST)
Message-ID: <4889A7D6.1070701@linux.net.cn>
Date: Fri, 25 Jul 2008 18:15:50 +0800
From: Wang Jian <lark@linux.net.cn>
MIME-Version: 1.0
To: richw@netcomuk.co.uk
Subject: Re: DTS configuration of external interrupts on 8347
References: <4887471E.6070306@btconnect.com>	<20080723131335.00eadc6a@lappy.seanm.ca>
	<48889A5B.5030200@btconnect.com>
In-Reply-To: <48889A5B.5030200@btconnect.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Richard Whitlock wrote:
> Sean MacLennan wrote:
>> On Wed, 23 Jul 2008 15:58:38 +0100
>> "Richard Whitlock" <richard.whitlo@btconnect.com> wrote:
>>
>>  
>>> I have a small problem with a port of linux 2.6.26 to a custom board.
>>> Our board is almost identical to the Analogue & Micro asp 8347 board,
>>> so I'm using Kumar Gala's excellent fsl tree (thank you Kumar) as it 
>>> already has a defconfig for the asp.
>>> Thanks also to Bryan O'Donoghue for pointing us in the direction of
>>> the asp port in the first place.
>>>
>>> The problem we have is I am unable to request an external interrupt.
>>> We have an FPGA which has an interrupt line - HW IRQ_0, so thats
>>> linux IRQ 48. I have added the following to the dts file:
>>>
>>> fpgaKFAF@0xF8000000 {
>>>                 interrupts = <48 8>;
>>>                 interrupt-parent = <&ipic>;
>>> }
>>>
>>> but whenever I call request_irq() it returns -ENOSYS.
>>>
>>> The driver loads fine, and the open function does very little - a
>>> call to ioremap() - which works, and a call to request_irq() which
>>> does not. Is there anything else I have to do to configure this
>>> interrupt?
>>>     
>>
>> I don't think you have enough information in the dts. We do the same
>> thing on the warp (you can look at the warp.dts):
>>
>> fpga@2,0 {
>>     compatible = "pika,fpga";
>>     reg = <0x00000002 0x00000000 0x00001000>;
>>     interrupts = <0x18 0x8>;
>>     interrupt-parent = <&UIC0>;
>> };
>>
>> You need the compatible, maybe "kfaf,fpga", and I believe the reg entry
>> although you could try without it.
>>
>> You then can use:
>>
>>     of_find_compatible_node
>>     irq_of_parse_and_map
>>     request_irq
>>
>> platforms/44x/warp.c shows an example using the ad7414. Just change the
>> ad7414 string to your compatible string.
>>
>> Cheers,
>>    Sean
>>
>>
>>
>>   
> Sean,
> 
> Thanks for that - our original code had no call to irq_of_parse_and_map().
> We've put that in, as well as a call to of_find_compatible_node(), and 
> now everything works fine. We have also modified our dts file along the 
> lines you suggested.
> Cheers,
> 

The docs on OF/DTS are very poor in this specific area. For starters, 
it's naturally assumed that after linking the drivers in and adding 
device nodes to device tree source file, all is done. But that is NOT 
enough, espeicially for non-bus device drivers. Sometime, you must add 
init code to search device tree nodes you are interested, add device 
objects for them.

I see a bunch of patches on dts documentation are pending for 2.6.27. 
Wish this area will be improved.
