Date: Tue, 23 Dec 2003 14:20:15 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Karoliya, Abhishek" <Abhishek.Karoliya@fci.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PPC PCI Enumeration::Switch off
Message-ID: <20031223142015.B23655@home.com>
References: <903E17B6FF22A24C96B4E28C2C0214D7012BB3D8@sr-bng-exc01.int.tsbu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <903E17B6FF22A24C96B4E28C2C0214D7012BB3D8@sr-bng-exc01.int.tsbu.net>; from Abhishek.Karoliya@fci.com on Wed, Dec 24, 2003 at 12:08:58AM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 24, 2003 at 12:08:58AM +0530, Karoliya, Abhishek wrote:
>
> Hi ,
>
>   While porting Linux {we use both flavours MontaVista based on 2.4.18 &
> Kernel.org's 2.4.20} on MPC7447(Dual CPU) + MV64360 based Processor PMC
> boards , we have a scenario where multiple PMC card will reside on the same
> PCI bus . Out of all the boards only one {identified through hardware
> signal} will enumerate the rest and other PCI devices on the board. {Monarch
> mode}.
>
>   Hence we need to turn off PCI enumeration for other {Non-monarch boards }.
> I tried this by  not calling the
> pciauto_bus_scan(){arch/ppc/kernel/pci_auto.c} while setting up the host
> bridge . But the boards still goes forward and does the enumeration.
> Do I have take care of any other section of the code .

Don't call pcibios_alloc_controller() and the PCI subsystem will not
attempt to probe the bus (and enumerate via the fixup hooks).  Just
configure your inbound window(s) on the non-monarch boards and you
are done.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
