Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE0EEDDF30
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 09:41:07 +1100 (EST)
In-Reply-To: <000f01c74587$10bc5cf0$6405a8c0@absolut>
References: <mailman.1454.1170226011.9285.linuxppc-embedded@ozlabs.org>
	<000601c74531$62220820$6405a8c0@absolut>
	<0ACC0A3E-9DF3-4927-8F67-E525BA0E6C13@kernel.crashing.org>
	<000001c7454b$69a25ae0$6405a8c0@absolut>
	<0A655A39-4101-48B4-BE9C-50A30163679C@kernel.crashing.org>
	<000701c7457a$d180e300$6405a8c0@absolut>
	<183E66A5-E983-4D17-96E9-2EEAE6FDF7B6@kernel.crashing.org>
	<000f01c74587$10bc5cf0$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1546691E-0CCF-41C9-8B8A-7C6326CEEF7E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Audigy SE / ca0106 driver for PowerPC?
Date: Wed, 31 Jan 2007 16:40:04 -0600
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


On Jan 31, 2007, at 4:27 PM, Russell McGuire wrote:

> This makes sense...
>
> So if I have setup in U-boot the PCI IO space to be at 0xf0300000  
> and PCI
> MOM space at 0x80000000 then the inl() command should be accessing the
> 0xf0300000 space? And the frame buffer is accessing the 0x80000000.

That's correct, however both of these will go through ioremap to get  
virtual addresses in the kernel.  For the IO space its done in the  
PCI setup code for the platform, and for MEM space its done by the  
driver.

> The lock I experience, is when I compile the driver into the  
> kernel. During
> the PCI Probing, I have turned on ALL of the debug output, as well  
> as placed
> a ton of extra debug <printk> inside the ca0106 driver. I can see  
> clearly
> the kernel detects I have a sound card, as does it detect the video  
> card.
> Though I haven't gotten any PCI cards to function yet... The machine
> literally just halts the boot cycle inside the first inl() command,  
> and just
> sits here until the reset button is pressed. It feels much like an  
> illegal
> access to a non-existant memory space <maybe that should be my clue  
> = bus
> hang?>

Ah, this we can debug :)

In arch/powerpc/kernel/pci_32.c enable DEBUG in the file (change the  
#undef DEBUG to #define DEBUG).  At which you'll get some output of  
the form.

Also, you can stick a few printk's in pci_process_bridge_OF_ranges 
().  I'd suggest one before:

	hose->io_base_virt = ioremap(ranges[na+2], size);

> Perhaps then my problem lies in the OF_BLOB I am passing in to  
> Linux? Could
> this cause the problem? Is there a document someplace that  
> describes the
> <reg structure> passed into the kernel on the OF_BLOB for the PCI  
> setup? I
> made a good guess estimating this from other BLOB/dts files, but it is
> possible I have some incorrect values.

That would cause problems if not setup correctly.  Look at  
Documentation/powerpc/booting-without-of.txt, however a quick glance  
doesn't seem to cover PCI.

You've given the start addresses for PCI MEM & PCI IO, can you tell  
me the sizes and I can help tell you want the node should look like.

- k

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Wednesday, January 31, 2007 1:55 PM
> To: rmcguire@videopresence.com
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Audigy SE / ca0106 driver for PowerPC?
>
>
> On Jan 31, 2007, at 3:00 PM, Russell McGuire wrote:
>
>> I am using the Freescale MPC8360E, with U-boot 1.2.0.
>> When I compile the kernel <2.6.20-rc6> I select the MPC8360E-MDS
>> board.
>> ARCH = PowerPC.
>>
>> Well I might be all confused on the IO Remap, but if I look through
>> the
>> nvidafb driver and the ati frame buffer driver I can see the
>> resource_start() and pci_resource_len() function being called,
>> followed by
>> the ioremap() before any configuration is done with the PCI boards.
>
> The difference is the nvidafb driver isn't doing PCI IO but PCI mem
> accesses (note, I didn't see any inl/outl references in the nvida
> driver).
>
>> The ca0106 driver seems to miss this <ioremap> function, and it is
>> the only
>> one that 100% locks the system up during the PCI probing <that I have
>> tried>, and it happens after/during the very first inl() or outl()
>> command.
>
> This may be because IO space is setup properly.
>
> When you say locks the system, what exactly happens?
>
>> I read a thread someplace that says that pci_resource_start() is not
>> intended to return an actual address, but rather a token that is to
>> be used
>> by the ioremap() function? It just happens that on some systems
>> this value
>> is the same and so for some it will not fail with a missing ioremap
>> (), but
>> others it will not be. To be safe it must be passed through ioremap
>> ()? This
>> is the deprecated part, <right term? Perhaps just bad assumption is
>> a better
>> one> that this driver makes.
>>
>> After looking through more drivers, this ioremap seems 100% in
>> place on my
>> drivers. Maybe nobody has tested this with PowerPC in the past?
>
> ioremap() is intended for use with PCI MEM accesses not PCI IO.  If
> you think about the fact that PCI IO is based on the x86 port IO
> concept this makes sense.
>
>> See this thread as an example:
>> http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-09/1187.html
>>
>> Or see:
>> /drivers/video/nvidia/nvidia.c lines 1239->1243
>>
>> Verses
>>
>> /sound/pci/ca0106/ca0106_main.c
>> lines 1279 till the interrupt request
>> then lines 1069->1089 at which it locks on inl()
>>
>> I don't mean to argue, I am just confused at this point.
>
> Its ok.  I don't thinking you're arguing, just trying to figure out
> what's going on.
>
> - k
