Message-ID: <F14842317963D111817100805F0DFE4D4FFF9A@server1.controlnet.com>
From: Mark Knecht <mknecht@controlnet.com>
To: Andreas Bombe <andreas.bombe@munich.netsurf.de>,
        "Maxim S. Shatskih"
	 <maxim@storagecraft.com>
Cc: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>,
        FireWire devel <linux1394-devel@eclipt.uni-klu.ac.at>,
        LinuxPPC-Dev Liste
	 <linuxppc-dev@lists.linuxppc.org>
Subject: RE: [Linux1394-devel] Re: FireWire + Apple PB G3: some success
Date: Thu, 24 Feb 2000 08:58:51 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


According to the LV23 spec the IO_ENB bit is read only, so one would presume
that writing the a 1 to the IO_ENB ( I presume that this is what is actually
happening with PCI_COMMAND_IO) would not cause any problems.

As for some of the performance issues, is the Memory Write and Invalidate
bit in the same PCI register turned off or is it getting turned on? The
default state is OFF. If not, then DMA writes from the OHCI controller could
potentially be causing cache flushes and slowing the system down. I am
presuming here that all or some of the memory addressed by OHCI is marked as
cacheable which may or may not be the case...)

This may not be visible to something like 'top' because the cache flush it
is a hardware process in the processor and it is possible that the front
side bus gets bogged down with cache flush traffic.

-----Original Message-----
From: Andreas Bombe [mailto:andreas.bombe@munich.netsurf.de]
Sent: Thursday, February 24, 2000 8:17 AM
To: Maxim S. Shatskih
Cc: Albrecht Dreﬂ; FireWire devel; LinuxPPC-Dev Liste
Subject: [Linux1394-devel] Re: FireWire + Apple PB G3: some success


On Thu, Feb 24, 2000 at 05:44:53AM +0300, Maxim S. Shatskih wrote:
> > It's not seen because the driver is stuck in bus reset.  The most
> > probable reason is that DMA is not working.  I can't think of a reason
> > right now (since it does work on another PPC).
>
> I've had this problem on NT4. Are you sure that the DMA enable bit in PCI
> config space is set?

To quote Albert's patch:

 +       pci_read_config_word (dev, PCI_COMMAND, &w);
 +       pci_write_config_word (dev, PCI_COMMAND, w | PCI_COMMAND_MASTER |
PCI_COMMAND_MEMORY | PCI_COMMAND_IO);

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


_______________________________________________
Linux1394-devel maillist  -  Linux1394-devel@eclipt.uni-klu.ac.at
http://eclipt.uni-klu.ac.at/mailman/listinfo/linux1394-devel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
