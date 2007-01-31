Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E5E1DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 10:50:29 +1100 (EST)
In-Reply-To: <000401c74591$8a3a4ec0$6405a8c0@absolut>
References: <mailman.1454.1170226011.9285.linuxppc-embedded@ozlabs.org>
	<000601c74531$62220820$6405a8c0@absolut>
	<0ACC0A3E-9DF3-4927-8F67-E525BA0E6C13@kernel.crashing.org>
	<000001c7454b$69a25ae0$6405a8c0@absolut>
	<0A655A39-4101-48B4-BE9C-50A30163679C@kernel.crashing.org>
	<000701c7457a$d180e300$6405a8c0@absolut>
	<183E66A5-E983-4D17-96E9-2EEAE6FDF7B6@kernel.crashing.org>
	<000f01c74587$10bc5cf0$6405a8c0@absolut>
	<1546691E-0CCF-41C9-8B8A-7C6326CEEF7E@kernel.crashing.org>
	<000301c7458b$b9eb1330$6405a8c0@absolut>
	<829261C6-F534-4B85-A04D-8D280E46B2CF@kernel.crashing.org>
	<000401c74591$8a3a4ec0$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BC5846DA-A217-43B7-8060-6EA05CC62913@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Audigy SE / ca0106 driver for PowerPC?
Date: Wed, 31 Jan 2007 17:49:27 -0600
To: <rmcguire@videopresence.com>
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


On Jan 31, 2007, at 5:42 PM, Russell McGuire wrote:

>
>
> /* Configure PCI Local Access Windows  */
> pci_law[0].bar = CFG_PCI_MEM_PHYS & LAWBAR_BAR;
> pci_law[0].ar = LAWAR_EN | LAWAR_SIZE_512M;
>
> pci_law[1].bar = CFG_PCI_IO_PHYS & LAWBAR_BAR;
> pci_law[1].ar = LAWAR_EN | LAWAR_SIZE_1M;

Well, you're making life difficult, not sure what's wrong :)

At this point I'd suggest adding a printk before the ioremap as I  
mentioned before, as well turning on the DEBUG and report the output.

It seems like the HW is setup properly, lets see if the address  
you're trying to access is valid or not.

The other place to put a printk is before the first inl().

Do something like printk("about to do inl for port:%x base:%p\n",  
(port based to inl), _IO_BASE);

- k

-----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Wednesday, January 31, 2007 3:19 PM
> To: rmcguire@videopresence.com
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Audigy SE / ca0106 driver for PowerPC?
>
>
> On Jan 31, 2007, at 5:01 PM, Russell McGuire wrote:
>
>>
>> What I really don't know is what the first column in the ranges
>> field does.
>> I.e. the <42000000>, <02000000>, and <01000000>.
>
> They are encoding of type of "space" is being described, the first
> byte's what's important:
>
> [42]	- prefetchable memory
> [02]	- 32-bit memory space
> [01]	- IO space
>
> [00]	- CFG space
> [03]	- 64-bit memory space
>
>> Here is part of current blob I am using:
>>
>> pci@8500 {
>> 	linux,phandle = <8500>;
>> 	interrupt-map-mask = <f800 0 0 7>;
>> 	interrupt-map= <
>>  		/* IDSEL 0x19 AD25*/
>> 		 c800 0 0 1 700 14 8
>> 		 c800 0 0 2 700 15 8
>> 		 c800 0 0 3 700 16 8
>> 		 c800 0 0 4 700 17 8>; > //and a lot more like this
>> 	bus-range = <0 0>; //U-boot modifies this to be <0 2> I think
>> 	ranges = <42000000 0 80000000 80000000 0 10000000
>> 		  02000000 0 90000000 90000000 0 10000000
>> 		  01000000 0 00000000 f0300000 0 00100000>;
>> 	clock-frequency = <3f940aa>;
>> 	#interrupt-cells = <1>;
>> 	#size-cells = <2>;
>> 	#address-cells = <3>;
>> 	reg = <8500 100>;
>> 	compatible = "83xx";
>> 	device_type = "pci";
>> }
>>
>> Here are the U-boot #defines I am using at the moment.
>>
>> #define CFG_PCI_MEM_BASE	0x80000000
>> #define CFG_PCI_MEM_PHYS	CFG_PCI_MEM_BASE
>> #define CFG_PCI_MEM_SIZE	0x10000000 /* 256M */
>> #define CFG_PCI_MMIO_BASE	0x90000000
>> #define CFG_PCI_MMIO_PHYS	CFG_PCI_MMIO_BASE
>> #define CFG_PCI_MMIO_SIZE	0x10000000 /* 256M */
>> #define CFG_PCI_IO_BASE		0x00000000
>> #define CFG_PCI_IO_PHYS		0xF0300000
>> #define CFG_PCI_IO_SIZE		0x00100000 /* 1M */
>> Might need to change PCI_IO_BASE to match PCI_IO_PHYS as well?
>
> This all looks correct, how are you setting PCILAWBAR0/1, PCILAWAR0/1?
>
> - k
>
