Return-Path: <tnt@246tNt.com>
Received: from outmx003.isp.belgacom.be (outmx003.isp.belgacom.be
	[195.238.4.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 013A0DE052
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Jan 2007 04:14:16 +1100 (EST)
Received: from outmx003.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx003.isp.belgacom.be (8.13.4/8.12.11/Skynet-OUT-2.22) with ESMTP
	id l0THE70a031325
	for <linuxppc-embedded@ozlabs.org>; Mon, 29 Jan 2007 18:14:07 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45BE2B48.9070708@246tNt.com>
Date: Mon, 29 Jan 2007 18:13:44 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Eric Nuckols <jrocnuck@hotmail.com>
Subject: Re: mem=XXXM ioremap DMA
References: <BAY117-F356D4E37F804FF68E26CB2C8A70@phx.gbl>
In-Reply-To: <BAY117-F356D4E37F804FF68E26CB2C8A70@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eric Nuckols wrote:
>   
>> Eric Nuckols wrote:
>>     
>>> in my driver, I'm calling
>>> my_virt_address =   ioremap( 0x1F800000, 0x800000  );
>>> my_bus_address = virt_to_bus( my_virt_address );
>>>
>>>       
>> You can't use virt_to_bus on address returned by ioremap AFAIK.
>>
>> I think you could do
>> my_bus_address = virt_to_bus(phys_to_virt(0x1f800000));
>>
>> Altough it slightly misuse the functions ... but that should work.
>>
>>
>>         Sylvain
>>
>>     
>
> If I use this approach in a driver, won't I still need to use the ioremap 
> function to make sure the kernel does not reassign the virtual addresses to 
> some other physical memory locations?
mmh, I wasn't clear :
You must do :

my_virt_address =   ioremap( 0x1F800000, 0x800000  );
my_bus_address = virt_to_bus(phys_to_virt(0x1f800000));

The virtual address returned by phys_to_virt won't be really valid ... but it
will be good enough for virt_to_bus. In the end, it will just do
PCI_DRAM_OFFSET + 0x1f800000;


Sylvain
