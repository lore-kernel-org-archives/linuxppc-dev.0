To: space19@earthlink.net
Cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Asante 10/100 Rev. b now working!
References: <37DE273B.97EB1DBC@earthlink.net>
From: Chris Baker <bakerc@pacbell.net>
Date: 14 Sep 1999 19:44:17 -0700
In-Reply-To: Shawn Anderson's message of "Tue, 14 Sep 1999 04:45:15 -0600"
Message-ID: <87ogf4ki66.fsf@perisphere.worldsfair>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Shawn Anderson <space19@earthlink.net> writes:

> Forwarded from the linux-tulip mailing list:

[...]

> That's the problem.
> The pre-0.91j Tulip drivers work on the PowerPC, but used the descriptor
> byte-swapping feature of the Tulip so that the driver wouldn't need to
> byte
> swap on the PPC.  (It still must in the setup, but not during
> operation.)
> 
> But the most of the Tulip clones, including the PNIC, didn't both to
> implement the byte-swap feature. 
> 
> I used to advise just buying a real Tulip board.  But I decided that I
> had
> spent way too much answering "bug" reports, and it was only going to get
> worse with the increasing number of clone chips.  So the v0.91j and
> later
> drivers have explicit byte swapping.
> 
> Get the new driver from
>   http://cesdis.gsfc.nasa.gov/linux/drivers/kern-2.3/index.html
>   ftp://cesdis.gsfc.nasa.gov/pub/linux/drivers/kern-2.3/
> 
> You *must* get the new support files (k_compat.h pci-netif.[ch]) as
> well!

This is great!  This should also help all the Pacbell DSL customers
that got free KNE110's.  Shawn, thanks for tracking this down.

Anyway, now the bad news: I'm running R4 on the machine in question.
When I try to compile pci-netif.c I get the following output:

pci-netif.c: In function `pci_find_capability':
pci-netif.c:342: `PCI_STATUS_CAP_LIST' undeclared (first use this function)
pci-netif.c:342: (Each undeclared identifier is reported only once
pci-netif.c:342: for each function it appears in.)
pci-netif.c:344: `PCI_CAPABILITY_LIST' undeclared (first use this function)
pci-netif.c: In function `acpi_wake':
pci-netif.c:364: `PCI_CAP_ID_PM' undeclared (first use this function)
pci-netif.c: In function `acpi_set_pwr_state':
pci-netif.c:396: `PCI_CAP_ID_PM' undeclared (first use this function)

The rest of the package seems to be designed to work with older
kernels (I'm using 2.1.130), so I suspect that this is a ppc specific
problem.  Does anyone have any ideas?

TIA,

cbb


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
