Date: Thu, 20 Apr 2000 23:35:17 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Steve Rossi <srossi@ccrl.mot.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: QSPAN PCI wierdness
In-Reply-To: <38FF7CF5.C915436B@ccrl.mot.com>
Message-ID: <Pine.HPX.4.10.10004202325400.19933-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 20 Apr 2000, Steve Rossi wrote:

>
> Hi All,
>
> I'm working on gettting QSPAN PCI to work using the monta vista 2.2.13
> kernel. (I finally have hardware to work with.) In head.S, after
> serial_init
> I've added a call to qspan_init() and to
> pci_scanner(). I'm printing out the Device ID/Vendor ID fields as they
> are read. The problem is that they are all 0. In fact, the config
> transactions
> are not taking place on the PCI bus. I've verified that PCI_CSR_ADDR is
> correct and my chip selects are set up correctly. I've got an analyzer
> on
> the PCI bus, and when I manually (i.e. using my debugger) create a
> configuration cycle by writing the QSPAN's config address register
> and reading the config data register I get valid data back for the
> devices
> that are on the PCI bus, and I see the transaction occur with the PCI
> analyzer. But when pci_scanner runs, I don't even see the configuration
> transactions on the PCI bus. I've stepped through the code and verified
> that the config address register write instruction and config data
> register
> read instructions occur correctly to the right addresses and all that,
> but
> the data that is returned is always zero. I've also verified that the
> data cache
> isn't turned on. I'm waiting for access to a logic analyzer so I can see
> what
> is happening on the PPC bus. But in the mean time, anyone have any ideas

- is the MMU on or off (we know the dache is off) ?

- are accesses separated with at least an eieio instruction ?

 Try with a sync just in case: I had problems while debugging on a 603e
recently with dcache off and mmu off (tracking a problem in code which was
designed to run with both cache and MMU on), an eieio was not enough but a
sync worked just fine.

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
