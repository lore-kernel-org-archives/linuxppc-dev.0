Date: Thu, 24 Feb 2000 17:17:16 +0100
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
To: "Maxim S. Shatskih" <maxim@storagecraft.com>
Cc: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>,
        FireWire devel <linux1394-devel@eclipt.uni-klu.ac.at>,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: FireWire + Apple PB G3: some success
Message-ID: <20000224171715.B2137@storm.local>
References: <38B3B564.CBA71EC0@mpifr-bonn.mpg.de> <20000224005839.A2784@storm.local> <002801bf7e71$24c2e5a0$0100000a@sauron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002801bf7e71$24c2e5a0$0100000a@sauron>; from maxim@storagecraft.com on Thu, Feb 24, 2000 at 05:44:53AM +0300
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 24, 2000 at 05:44:53AM +0300, Maxim S. Shatskih wrote:
> > It's not seen because the driver is stuck in bus reset.  The most
> > probable reason is that DMA is not working.  I can't think of a reason
> > right now (since it does work on another PPC).
>
> I've had this problem on NT4. Are you sure that the DMA enable bit in PCI
> config space is set?

To quote Albert's patch:

 +       pci_read_config_word (dev, PCI_COMMAND, &w);
 +       pci_write_config_word (dev, PCI_COMMAND, w | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY | PCI_COMMAND_IO);

He sets the PCI master flag (which should be the only thing disabling /
enabling DMA in general).  In the standard sources pci_set_master() is
used, which does the same.

Setting PCI_COMMAND_IO on the other hand is unneccessary since the
PCILynx only uses memory mapped I/O (if I understand PCI config
correctly).  I don't know if this flag is harmful if there are no I/O
ports.

--
          Andreas E. Bombe <andreas.bombe@munich.netsurf.de>
http://home.pages.de/~andreas.bombe/                DSA key 0x04880A44

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
