Message-ID: <39BA8A45.1AC4A341@rochcivictheatre.org>
Date: Sat, 09 Sep 2000 14:06:45 -0500
From: Tom Gall <gall@rochcivictheatre.org>
MIME-Version: 1.0
To: Chas Williams <chas@cmf.nrl.navy.mil>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 64-bit pci bus on a powermac g4
References: <200009091757.NAA35435@borg.cmf.nrl.navy.mil>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Chas Williams wrote:
>
> i am writing a driver for an atm adapter and i am seeing some strange
> problems.  the card is 32/64 bit.  it works fine in my 32-bit pci bus
> on my umax s900, but in the g4 it oops' with a trap 300 during operation.
> i understand this to be 'data access exception' or 'data storage exception'.

Hi Chas,

  We're working towards much the same goal. I'm trying to get multiple
PCI buses working on IBM hardware... and they just happen to be 64 bit
PCI. The card I am working with is an 64 bit LVD SCSI card.

> a couple questions:
>
> . is the 64bit pci bus capability functional in the g4?  (i gather it
>   must be since my 64bit ati rage pro for the second monitor is working fine)

  That's a good sign. For me, any device on the buses other than the
first were not even there...  I've got past that hurdle now tho.

> . anyone else written a driver for a 64bit pci card in the g4's?

  I'm not on a G4, but on a Model 270, which is a Power3 processor...
but I'm sure we're not too far off.

> . do i need to align my dma regions to 64bits?  shouldnt the card be
>   able transfer non-dma until it gets to a dma region?  i suppose this
>   depends on the bridge/card controller.  the driver documentation
>   is a bit lacking on this detail.  it claims that tx buffers dont
>   require special alignment but if you dont use dma, of course it doesnt.

  For the LVD SCSI (it's an SYMBIOS 896 chip) I literally haven't had to
do anything to the existing driver. Right now the driver (as well as my
test code) can talk to the card, get the config space, IRQ #s etc.  Are
you able to do this at a minimum?

  The current problem I do have is that IRQs are not setup right at the
moment. Anything on the first bus still works fine but the 2nd buses etc
don't. The driver will send commands to the card, expect and IRQ back
and things will time out. I suspect some mixture of
arch/ppc/kernel/prom.c  chrp_setup.c and chrp_pci.c probably to blame.

  Hopefully the work that I'm doing with merge with the efforts that Ben
is doing and all will be well.

--
Regards,

Tom

-----------------------------------------------------------
Linux Guy          "My heart is human, my blood is boiling,
tgall@uswest.net    my brain IBM" -- Mr Roboto, Styxx

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
