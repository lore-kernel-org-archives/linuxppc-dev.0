From: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Date: Mon, 1 Feb 1999 18:32:25 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: matroxfb, anybody? (More details...)
CC: linuxppc-dev@lists.linuxppc.org
Message-ID: <1F394C253DD@vcnet.vc.cvut.cz>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  1 Feb 99 at 18:15, Geert Uytterhoeven wrote:
> > So, attached patch adds back that matrox_init is called unless you
> > specify `video=matrox:off' on command line. In this case, matrox can
> > be still initialized through offb. If you specify `video=matrox:disabled',
> > driver will be unavailable for offb too.
> Which does not help if you have 2 Matrox boards, due to the single static
> `initialized' variable.
No problem because of driver initializes ALL matroxes once matrox_init is
called, regardless of device_node contents (behavior is determined by
video=matrox:dev:X parameter).
> > Also, driver still does not use device_node passed to driver by offb
> > because of no-one told me what I can expect in that variable... Driver
> You can find the PCI base addresses in there (look at atyfb_of_init() for an
> example).
Unless `register_pci_region' is here, I think that I stay with current
behavior. I'm too lazy to add skipping of already registered devices
into matrox_init().
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
