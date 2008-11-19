Return-Path: <m.fortini@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0C58DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Nov 2008 02:29:38 +1100 (EST)
Message-ID: <492430D5.5090806@selcomgroup.com>
Date: Wed, 19 Nov 2008 16:29:25 +0100
From: Matteo Fortini <m.fortini@selcomgroup.com>
MIME-Version: 1.0
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: Device tree and IRQ for chip on PCI
References: <492189ED.6050700@selcomgroup.com>
	<200811180649.28792.matthias.fuchs@esd-electronics.com>
In-Reply-To: <200811180649.28792.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The lspci output gives me the same IRQ for both the PCI bus and the 
peripheral attached to it. I don't know why the pci_get_config_byte call 
was returning me 0x00, I'll check into it.

Regarding the DT, it should be ok, at least the IDSEL is 0x15, but if 
you have any specific documentation I can take a look at, I will recheck it.

Thanks,
Matteo

Matthias Fuchs ha scritto:
> Hi Matteo,
>
>   
>> I have a chip connected on the PCI bus on an MPC512x, but if I get the
>> IRQ property from the PCI chip, it is not set up by Linux.
>>     
> It's not clear to me what you mean by this. 
> Do you see an interrupt assigned to your pci device's PCI_INTERRUPT_LINE 
> register? Check lspci output.
>
>   
>> The IRQ line goes directly from the chip to the MPC512x uc, so I don't
>> know if I should create a separate node just to get the interrupt, or I
>>     
> No. The pci node in  the DT should be ok.
> Because you posted to an embedded list, I need to ask this: are you using a 
> custom hardware? Does the DT fit to your board's interrupt / IDSEL routing?
>
> Matthias
>
>   
>> should expect the pci functions to assign it an interrupt based on the
>> PCI bus.
>>
>> The description for the PCI bus is like this:
>>         pci: pci@80008500 {
>>                 interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
>>                 interrupt-map = <
>>                                 // IDSEL 0x15 - Slot PCI
>>                                  0xa800 0x0 0x0 0x1 &ipic 0x0 0x8
>>                                  0xa800 0x0 0x0 0x2 &ipic 0x1 0x8
>>                                  0xa800 0x0 0x0 0x3 &ipic 0x2 0x8
>>                                  0xa800 0x0 0x0 0x4 &ipic 0x3 0x8
>>
>>                                 >;
>>
>>                 interrupt-parent = < &ipic >;
>>                 interrupts = <17 0x8>;
>>                 bus-range = <0 0>;
>>                 ranges = <0x42000000 0x0 0xa0000000 0xa0000000 0x0
>> 0x10000000
>>                           0x02000000 0x0 0xb0000000 0xb0000000 0x0
>> 0x10000000
>>                           0x01000000 0x0 0x00000000 0x84000000 0x0
>> 0x01000000>;
>>                 clock-frequency = <66000000>;
>>                 #interrupt-cells = <1>;
>>                 #size-cells = <2>;
>>                 #address-cells = <3>;
>>                 reg = <0x80008500 0x100>;
>>                 compatible = "fsl,mpc5121-pci";
>>                 device_type = "pci";
>>         };
>>     
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   

-- 
Ing. Matteo Fortini, PhD
Digitek spa
Embedded Linux specialist
V. Romagnoli, 24
41033 Concordia (MO)
Italy

Tel  : (+39) 0535-56942
Fax  : (+39) 0535-54550
Skype: callto://matteofortini
eMail: m.fortini@selcomgroup.com
