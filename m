Date: Thu, 24 Feb 2000 00:58:39 +0100
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
Cc: FireWire devel <linux1394-devel@eclipt.uni-klu.ac.at>,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: FireWire + Apple PB G3: some success
Message-ID: <20000224005839.A2784@storm.local>
References: <38B3B564.CBA71EC0@mpifr-bonn.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <38B3B564.CBA71EC0@mpifr-bonn.mpg.de>; from ad@mpifr-bonn.mpg.de on Wed, Feb 23, 2000 at 11:24:36AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 23, 2000 at 11:24:36AM +0100, Albrecht Dreﬂ wrote:
> I had some success with Newer Tech's FireWire2Go CardBus device on an Apple
> PowerBook G3/333 (aka "Lombard") with LinuxPPC 2.2.14pre9.  This is what I did:
>
> * added Ryuichi Oikawa patch to the kernel which enables the pci scan to "see"
> CardBus devices without the PCMCIA package (there is a japanese description at
> http://www.rr.iij4u.or.jp/~roikawa/others.html [which I can't read], but the
> patch seems to work really fine)

Nice.  So CardBus devices do act like normal PCI devices (except for
scanning, apparantly).

>          lynx->id = num_of_cards-1;
>          lynx->dev = dev;
>
> -        pci_set_master(dev);
> +       pci_read_config_word (dev, PCI_COMMAND, &w);
> +       pci_write_config_word (dev, PCI_COMMAND, w | PCI_COMMAND_MASTER |
> PCI_COMMAND_MEMORY | PCI_COMMAND_IO);
>
>          if (!request_irq(dev->irq, lynx_irq_handler, SA_SHIRQ,
>                           PCILYNX_DRIVER_NAME, lynx)) {

I see.  That's the missing pci_enable_device() biting us.  But at least
in 2.2 there is no such function anyway, so it has to be done by hand.

> * `modprobe pcilynx' gives the following kernel messages:
>
[...]
> kernel: pcilynx0: resetting bus on request
> kernel: ieee1394: detected 1 pcilynx adapter

The messages for bus reset completion are missing, so it only works
partly.

> * remaining questions:
>
> I have a FW disk attached to the bus, but when I run testlibraw, it is not seen:

It's not seen because the driver is stuck in bus reset.  The most
probable reason is that DMA is not working.  I can't think of a reason
right now (since it does work on another PPC).

--
          Andreas E. Bombe <andreas.bombe@munich.netsurf.de>
http://home.pages.de/~andreas.bombe/                DSA key 0x04880A44

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
