Message-ID: <001a01c394e0$2b08fba0$6401a8c0@sazabimobile>
From: "Shih-Ying Chou" <sschou@mtu.edu>
To: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <D73A25AA6E54D511AD74009027B1110F3C0AAE@ORION>
Subject: Re: Problem with EP405's PCI 
Date: Fri, 17 Oct 2003 14:55:01 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you for your advise, but I have check that, too.  It is normal.
the ppc405_map_irq uses the value from ep405_devtable[], but it is empty if
I did not use CONFIG_EP405PC
the original
static struct {
 u8 cpld_xirq_select;
 int pci_idsel;
 int irq;
} ep405_devtable[] = {
#ifdef CONFIG_EP405PC
 {0x07, 0x0E, 25},  /* EP405PC: USB */
#endif
};

So I changed it, so it can take make the PCI work.
static struct {
 u8 cpld_xirq_select;
 int pci_idsel;
 int irq;
} ep405_devtable[] = {
 {0x01, 0x0A, 25},
};
which I copy from the Timesys Linux version of the ep405.c
Now it pass 25 as the irq number, but it still does not work.
When I do a cat /proc/interrupts
         CPU0
  0:        263  IBM UIC Level     serial
  9:          0    IBM UIC Level     OCP EMAC Wakeup
 10:          0   IBM UIC Level     MAL SERR
 11:        915  IBM UIC Level     MAL TX EOB
 12:       1891  IBM UIC Level     MAL RX EOB
 13:          0  IBM UIC Level     MAL TX DE
 14:          0  IBM UIC Level     MAL RX DE
 15:          0  IBM UIC Level     OCP EMAC MAC
 25:          0  IBM UIC Level     usb-ohci, usb-ohci
BAD:          0

When I do a cat /proc/pci
PCI devices found:
  Bus  0, device  10, function  0:
    USB Controller: NEC Corporation USB (rev 65).
       IRQ 25
      Master Capable.  Latency=128.  Min Gnt=1.Max Lat=42.
      Non-prefetchable 32 bit memory at 0xbffff000 [0xbfffffff].
  Bus  0, device  10, function  1:
    USB Controller: NEC Corporation USB (#2) (rev 65).
      IRQ 25
      Master Capable.  Latency=128.  Min Gnt=1.Max Lat=42.
      Non-prefetchable 32 bit memory at 0xbfffe000 [0xbfffefff].
  Bus  0, device  10, function  2:
    USB Controller: NEC Corporation USB 2.0 (rev 2).
      IRQ 25
      Master Capable.  Latency=128.  Min Gnt=16.Max Lat=34.
      Non-prefetchable 32 bit memory at 0xbfffdf00 [0xbfffdfff].

When I plug in a device into the USB card, it will complain about can't
accept the address which indicate that the interrupt is not set correctly on
the PCI side.  Am I right about this?

Thank you

Shih-Ying Chou

----- Original Message -----
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "'Shih-Ying Chou'" <sschou@mtu.edu>
Sent: Friday, October 17, 2003 12:13 PM
Subject: RE: Problem with EP405's PCI


> check to see if the function ppc405_map_irq in ep405.c ever returns a -1.
> If that happens you may not have the correct value for the device ID in
the
> ep405_devtable.
>
> -----Original Message-----
> From: Shih-Ying Chou [mailto:sschou@mtu.edu]
> Sent: Friday, October 17, 2003 11:57 AM
> To: Jacky Lam
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Problem with EP405's PCI
>
>
>
> Thank you very much for your input.  I have read the previous post but it
is
> not very useful to me.
> Because I am not using u-boot as my bootloader, since u-boot does not
> support EP405 board.
> I am using the Planet Core from Embedded Planet which does not do any
> initialization on the PCI.
>
> Does anyone have any other idea?
>
> Thanks in advance
>
> Shih-Ying Chou
>
> ----- Original Message -----
> From: "Jacky Lam" <jackylam@astri.org>
> To: <linuxppc-embedded@lists.linuxppc.org>
> Sent: Friday, October 17, 2003 1:56 AM
> Subject: Re: Problem with EP405's PCI
>
>
> >
> >     Please see my previous post and the reply from xzuo@vinesystech.com
.
> > Hope it can help.
> >
> > Jacky
> > ----- Original Message -----
> > From: "Shih-Ying Chou" <sschou@mtu.edu>
> > To: <linuxppc-embedded@lists.linuxppc.org>
> > Sent: Friday, October 17, 2003 12:58 PM
> > Subject: Problem with EP405's PCI
> >
> >
> > >
> > > Hi All,
> > >     Have anyone successfully made the EP405's PCI (through PC/104
plus)
> > > work?  If anyone does, please help me, I have struggle with it for
over
> a
> > > month now.
> > >     Right now I am using the linuxppc_2_4_devel kernel, and I can get
> the
> > > EP405 to boot successfully.  But I can get the PCI interface to work
> > right.
> > > When booting up, the kernel can recognize the card weither USB or
Sound
> > > card, but it can seem to assign the right irq to the card.  Because
USB
> > card
> > > always complain about no IRQ assign and ask to check BIOS.
> > >     I have look at the ep405.c and ppc405_pci.c and ppc4xx_pic.c
files,
> > but
> > > I cannot find out what is wrong.  I know that I need to modify the
> > > ppc405_devtable [] in the ep405.c file. I also check the registers
such
> as
> > > DCRN_UIC_PR, DCRN_UIC_TR, and DCRN_UIC_SR and all the value seems to
be
> > > correct, except DCRN_UIC_PR.  In the ep405.c DCRN_UIC_PR is set to be
> > > 0xffffff80 which makes the PCI interrupt to be high, so as the User
> manual
> > > stated.  But isn't PCI's interrupt should be active low?
> > >
> > > Any pointer will be helpful, thank you in advance!
> > >
> > > Shih-Ying Chou
> > >
> > >
> >
> >
> >
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
