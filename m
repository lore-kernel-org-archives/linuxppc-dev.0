Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A31A9DDFA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Feb 2007 02:28:52 +1100 (EST)
In-Reply-To: <000c01c746db$6451e7e0$6405a8c0@absolut>
References: <000c01c746db$6451e7e0$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <06A02CF1-7D0C-4D59-9628-A2EB0FF3CCF4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC8360 : PCI resource allocate error
Date: Fri, 2 Feb 2007 09:27:55 -0600
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


On Feb 2, 2007, at 9:04 AM, Russell McGuire wrote:

> While trying out various of my PCI slots, I ran into this =20
> interesting error.
>
>
>
> If I try to put a sounc card, Audigy SE, into SLOT 1 and 2 this =20
> error doesn=92t occur.
>
> But when I place it in the 3rd. I get this:  <Note the 02:0b is =20
> SLOT 3>
>
>
>
> <Linux 2.6.20-rc6 compiled for PowerPC / MPC83xx>
>
>
>
> --------------------------------------
>
> PCI: Probing PCI hardware
>
> Try to map irq for 0000:00:19.0...
>
> pci_busdev_to_OF_node(0,0xc8)
>
>  parent is /soc8360@f0000000/pci@8500
>
>  result is <NULL>
>
> Try to map irq for 0000:00:19.1...
>
> pci_busdev_to_OF_node(0,0xc9)
>
>  parent is /soc8360@f0000000/pci@8500
>
>  result is <NULL>
>
> Try to map irq for 0000:02:0b.0...
>
> pci_busdev_to_OF_node(2,0x58)
>
> pci_busdev_to_OF_node(0,0xc9)
>
>  parent is /soc8360@f0000000/pci@8500
>
>  result is <NULL>
>
>  -> got one, spec 2 cells (0x00000017...) on /soc8360@f0000000/pic@700
>
> PCI: bridge rsrc 0..ffffffff (100), parent c038d184
>
> PCI: bridge rsrc 80000000..8fffffff (1200), parent c038d168
>
> PCI: bridge rsrc 90000000..9fffffff (200), parent c038d168
>
> PCI: bridge rsrc f0302000..f0302fff (101), parent c03da03c
>
> PCI:0000:02:0b.0: Resource 0: 0000000000302000-000000000030201f =20
> (f=3D101)
>
> PCI: Cannot allocate resource region 0 of device 0000:02:0b.0
>
> PCI: Error while updating region 0000:02:0b.0/0 (f0302001 !=3D =
00302001)
>
> ------------------------------
>
>
>
> What can cause this to not work?

The problem is with the IO resource, for some reason the code things =20
your PCI IO space is at f03... instead of 000...

Is Slot 3 behind the P2P bridge or directly connected to the 83xx?

Also, what's your .dts look like now.

- k=
