Message-ID: <3B01BFDD.8E326595@mutoh.co.jp>
Date: Wed, 16 May 2001 08:46:37 +0900
From: Hideo Noda <Hideo_Noda@mutoh.co.jp>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC405GPWalnutPciBusMaster
References: <fc.106ccf27106ccf2715ebed273b9aca00.25700d@mutoh.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are running pci cards very well.

The boot loader we used was openbios, which was already
installed in the flash.
We ported a part of ppcboot to linux kernel to complete
the pci configuration. Now pci is running well on our Walnut.

What we did was:

add the function
"void pci_init(void)" in <cpu/ppc4xx/405gp_pci.c> in ppcboot
directory

into
"void __init pcibios_init(void)" in <linux/arch/ppc/kernel/pci.c>

Some minor changes were needed such as functions/macros
renaming.


The conclusion is that ppcboot configures pci well.

Above is one of solutions.
Swapping openbios with ppcboot will be good.
Downloading and running ppcboot, then downloading linux by
ppcboot seems well.

hideo



"dony.he@huawei.com" wrote:

> Now I have the same problem as you meet before.
> Have you find a good solutions?
> Thank you very mcuh.
>
> machael
>
> >
> > Hi,
> >
> > I am trying to install Intel eepro100 onto WalnutPPC405GP.
> > Basic PCI settings seem good but no frame is transmitted.
> > The environment is WalnutPPC305GP with HardHatLinux 2.4.2 from
> > MonraVista.
> >
> > I can read or write eepro configuration registers and other control
> > registers via PCI memory space.
> > But Bus Master operations do not seem functional. I am confirmed that
> > MASTER operation bit in eepro100 is enabled.
> > I think some more settings are needed for PPC405GP built-in PCI control
> > registers and/or Walnut board jumpers/dipswitches.
> >
> > Has anyone tried PCI cards with BUS MASTER operations for Walnut
> > PPC405GP?
> >
> > Thanks in advance,
> >
> > Hideo
> >
> >
> >


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
