Message-ID: <38FF7CF5.C915436B@ccrl.mot.com>
Date: Thu, 20 Apr 2000 16:56:05 -0500
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: QSPAN PCI wierdness
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I'm working on gettting QSPAN PCI to work using the monta vista 2.2.13
kernel. (I finally have hardware to work with.) In head.S, after
serial_init
I've added a call to qspan_init() and to
pci_scanner(). I'm printing out the Device ID/Vendor ID fields as they
are read. The problem is that they are all 0. In fact, the config
transactions
are not taking place on the PCI bus. I've verified that PCI_CSR_ADDR is
correct and my chip selects are set up correctly. I've got an analyzer
on
the PCI bus, and when I manually (i.e. using my debugger) create a
configuration cycle by writing the QSPAN's config address register
and reading the config data register I get valid data back for the
devices
that are on the PCI bus, and I see the transaction occur with the PCI
analyzer. But when pci_scanner runs, I don't even see the configuration
transactions on the PCI bus. I've stepped through the code and verified
that the config address register write instruction and config data
register
read instructions occur correctly to the right addresses and all that,
but
the data that is returned is always zero. I've also verified that the
data cache
isn't turned on. I'm waiting for access to a logic analyzer so I can see
what
is happening on the PPC bus. But in the mean time, anyone have any ideas

as to why I always get 0.

Thanks,
Steve


--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
