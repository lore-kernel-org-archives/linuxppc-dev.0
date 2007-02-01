Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7FEFCDDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 05:12:03 +1100 (EST)
In-Reply-To: <001101c74629$28797380$6405a8c0@absolut>
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
	<BC5846DA-A217-43B7-8060-6EA05CC62913@kernel.crashing.org>
	<000801c7460d$211e46e0$6405a8c0@absolut>
	<974C77BD-19A0-4843-8E7B-3B430DB4ADE9@kernel.crashing.org>
	<001101c74629$28797380$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AF782BFC-5262-462B-A522-8F685DC59158@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 8360E - PCI / DTC Blob Setup
Date: Thu, 1 Feb 2007 12:11:02 -0600
To: rmcguire@videopresence.com
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


On Feb 1, 2007, at 11:48 AM, Russell McGuire wrote:

> This might be the wrong forum to discuss HW routing, but I am not  
> sure of
> many HW guys that would understand blob setups. I know I still don't.
>
> I read through the booting-without-of-tree.txt and it doesn't  
> explain this
> other than the interrupt routing needs to be present. Perhaps some  
> of the
> maintainers of the 83xx platforms can explain how this blob is  
> developed?
> I assume their board work with the submitted mp38360emds.dts files,  
> as an
> example.
>
> Let me see if I can simplify this, I had this schematic reviewed by  
> Pericom
> <a PCI bridge MFG> and they recommended these IDSEL lines. And I  
> know the
> card detection works great, in U-boot.
>
> My external PCI bridge is the only thing routed directly to the  
> 8360 Host
> bridge. The PCI Host bridge in my system is connected on IDSEL- 
> >AD25,0x19
> Perhaps I shouldn't use any interrupt routing for this, as there is  
> no true
> /INTA line tied directly to the bridge?
>
> My Three PCI slots are routed as follows:
>
> Bus 0, Bridge Chip, IDSEL = AD25

Huh, this is only describes one slot/connection.  If you have 3  
slots, they'd have 3 unique IDSELs

> Other side of the Host bridge, all are routed to INTA directly to the
> CPU.
> Bus 1, Slot 1, IDSEL = AD20 <card would be ID'd as 1.04 (Bus.Dev)>
> Bus 1, Slot 2, IDSEL = AD24 <card would be ID'd as 1.08 (Bus.Dev)>
> Bus 2, Slot 1, IDSEL = AD20 <card would be ID'd as 2.04 (Bus.Dev)>
>
> That being said:
> /* IDSEL 0x19 AD25*/
>  c800 0 0 1 700 14 8

so the way you read this:

<PCI DEV specifier> <INT A-D> <HOST IRQ specifier>

Do break it down further:

<PCI DEV specifier>:

[(bus << 16) | (idsel << 11)] 0 0

<INT A-D>:
INTA - 1
INTB - 2
INTC - 3
INTD - 4

<HOST IRQ specifier> (on 83xx):

[linux,phandle for interrupt controller] [IRQ #] [sense]

> I see in the c800 directly corresponds to the 83xx manual for PCI  
> CONFIG
> address mapping for AD25.
>
> I think the '1' is mapped to /INTA, which is the only PCI INT  
> available in
> the 8360E.

INTA..INTD is more about the device, not host.

> I understand the 700 in this case is the address of the PIC@700.
>
> That leaves 5 fields/questions.
> 1) What do the first two '0's after c800 mean?

There always 0 0, since the int masks them away (they normally  
describe the address the device is at)

> 2) What does the '14' map to?

0x14 is the external IRQ # its wired to.

> 3) What does the '8' map to?

Sense of IRQ, should always be level for PCI.

> 4) Why would some boards map multiple interrupts to a single IDSEL,  
> like the
> mpc8360emds.dts file? Is this to handle extra bridges that might be  
> plugged
> in at a later time?

This is to handle the fact that a PCI add on card put into a slot  
might use multiple interrupts (INTA, INTB), so it lists multiple  
entries to cover the 4 PCI defined interrupts.

> If I understand the mapping correctly then I think I can hard code  
> in the
> interrupts for the PCI slots.
>
> So I don't drive everybody nuts, is there actual documentation on  
> this. I
> would be happy to stop spamming this list... :-)

There is, but its scattered in places.

Its good to ask these questions so the answers will get archived and  
other people can figure it out as well.

- k
