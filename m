Message-ID: <38D67FA3.D00A5110@ccrl.mot.com>
Date: Mon, 20 Mar 2000 13:44:35 -0600
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question on QSPAN Driver
References: <38D64A54.D5A8E8BA@ccrl.mot.com> <38D66069.AA538C28@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

>
> > So here are my questions:
> > 1. Why doesn't qspan_init ever get called before the PCI bus is scanned?
>
> That is the job of something during the boot process before the Linux
> kernel is started.
>
> > 2. Should the pci_scanner function in arch/ppc/mbxboot/pci.c be called
> > in
> > place of the normal pci_scan_bus() function in drivers/pci/pci.c?
>
> No, those functions are very different.  The functions in 'mbxboot'
> are used to initialize and map the PCI bus.  The functions in the
> Linux kernel are discovery functions.

Ok, now this is making a whole lot more sense to me, so where would
be an appropriate place to call qspan_init and pci_scanner from?  I
understand it should happen before the kernel loads, is it something
that would make sense to put in embed_config.c? Is there a more
appropriate place to put it? I can't find where (or if) it happens for
the mbx board.

Thanks!
Steve

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
