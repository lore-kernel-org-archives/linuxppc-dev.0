Message-ID: <20010308155428.6682.qmail@dag.newtech.fi>
To: linuxppc-dev@lists.linuxppc.org
Subject: PCI confusion
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 08 Mar 2001 17:54:28 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

just spent some hours going through all
postings in the mailing list about PCI-setup,
but now i am even more confused....

The setup is:

Nonsupported (sofar) VME board with
a PreP address map and MPC107.

I have the board booting but the PCI-drivers
are all working through the I/O space and cannot see
the memoryspace of the PCI devices.

The questions I have are:

1. The I/O BAT:s are setup as follows:
BAT 0: 0x10000000@0x80000000 to virtual 0x80000000
BAT 1: 0x10000000@0xc0000000 to virtual 0xe0000000
ioremap_base = 0xe0000000
Are these OK ?

2. What is the right value for hose->pci_mem_offset ?
    The physical 0xc0000000 or the address the processor sees
    0xe0000000.

3. the driver I am using for testing (for the Tundra Universe) uses
  the following construction:
  baseaddr = ioremap(pci_resource_start(uni_pci_dev,0),
		pci_resource_len (uni_pci_dev, 0));
  Then request_mem_region() for the same resources.
   Then pci_enable_device()
   Then pci_set_master()
   After this a access: temp = readl(baseaddr) will generate
   an Oops with illegal access....
  What am I doing wrong ?

My kernel is a stock 2.4.2 from ftp.kernel.org.

Many thanks for reading this
BRGDS





--
Dag Nygren                               email: dag@newtech.fi
Oy NewTech Ab                            phone: +358 9 8024910
Trasktorpet 3                              fax: +358 9 8024916
02360 ESBO                                 GSM: 0400-426312
FINLAND


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
