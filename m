Message-ID: <38FF8C7C.86F2DDCA@embeddededge.com>
Date: Thu, 20 Apr 2000 19:02:20 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@ccrl.mot.com>
CC: Gabriel Paubert <paubert@iram.es>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: QSPAN PCI wierdness
References: <Pine.HPX.4.10.10004202325400.19933-100000@gra-ux1.iram.es> <38FF95C5.DEBB683A@ccrl.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Rossi wrote:

> Its when pci_scanner() calls qs_pci_read_config_dword()
> that it reads 0. Can someone verified that pci_scanner() and
> the qs_pci_* functions in mbxboot/pci.c and
> mbxboot/qspan_pci.c work?

I know I have posted this before.......

The PCI functions in this directory are just for reference.  I checked
them in because I didn't want to lose them.  They are not complete
for one simple reason: the QSPAN generates bus time outs when you
access the config registers for devices that don't exist.  We need to
place some kind of a bus fault exception hander in the code that
exists here for proper operation.

These are examples of functions I normally put into custom 8xx boot
roms.  Someone once asked for them, I checked them into here as it
was the easiest at the time.

These functions work.  If the QSPAN is properly mapped at the time
these functions are called, currently one of three things will happen:

	1.  If no bus timeout and no PCI device, the bus will hang.
	2.  If bus timeout and no PCI device, machine check exception
	3.  If PCI device, proper config cycle will occur.

I believe they should also work for a QSPAN-II, although the
initialization function should have more "stuff" in it.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
