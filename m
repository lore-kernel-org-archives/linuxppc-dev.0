Message-ID: <3AB89DCA.4530834A@vienna.at>
Date: Wed, 21 Mar 2001 13:25:46 +0100
From: Roman Weissgaerber <weissg@vienna.at>
Reply-To: weissg@vienna.at
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: More USB questions (for the MPC8xx)
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Christian,

if you use the virtual root hub (Patch 2) the root hub will
be controlled by the built in hub driver of the USB subsystem.
And this driver disables the port if it gets to much errors.
And a disable switches off the SOF.
D+ then goes up because a high speed device is connected to the bus.
D+/D-:
 0/0 if ther is no device or reset.
 1/0 full speed device
 0/1 low speed device
BTW. the HCD should use these signals to recognize a device
on the bus (unpached m8xxhci polls with control messages, patch 2 use
the bus signals)

As there should be no errors I guess you also need a hardware patch.

I would suggest you to use patch 1 only as long there are so much
errors/timeouts.

- Roman

>
> [Date Prev][Date Next] [Chronological] [Thread] [Top]
>
> Re: More USB questions (for the MPC8xx)
>
>
>
>       To: Kári Davíðsson <karid@flaga.is>
>       Subject: Re: More USB questions (for the MPC8xx)
>       From: Christian Schroeder <christian.schroeder@imms.de>
>       Date: Wed, 21 Mar 2001 10:15:23 +0100 (MET)
>       Cc: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
>       In-Reply-To: <EADB10BAC266A14A85ECBF8686A73E3108AFEA@kolkrabbi.flaga.is>
>       References: <EADB10BAC266A14A85ECBF8686A73E3108AFEA@kolkrabbi.flaga.is>
>       User-Agent: IMP/PHP IMAP webmail program 2.2.2
>
>
>
> Quoting Kári Davíðsson <karid@flaga.is>:
>
> >
> > Hi,
> >
> > I managed to get the m8xxhci with the TIMER1 patch to sort of work with
> > my board.
> > I.e. the SOF seem to be genrated normally and there seem to be some
> > traffic on
> > the usb bus when I plug in keyspan_pda USB device. Althoug the
> > initialization of
> > the keyspan_pda fails.
> > I have also tried a MS USBMouse but then the m8xxhci is totally silent
> > and there
> > is no traffic on the USB.
> >
> > What kind of USB devices have you used to plug to a MPC8xx in HIC mode?
> >
>
> Hi,
>
>
> I have similar experiences. I use a TQM823L board and applied Roman Weiss-
> gaerbers patches. The microcode patch seems to work, because I can see the
> SOF packets every 1 ms between D+ and GND. If I disconnect /DREQ1, the
> SOFs disappear. So far so good. Now I tried to connect USB devices.
>
> First I connected an USB mouse and got:
>
> rh::int:0 2 1 301 1
> m8xxhci_alloc_dev(usb_dev=c0fcca00)
> hub.c: USB new device connect on bus1/1, assigned device number 2
> usb_control/bulk_msg: timeout
> unlink_urb(urb=c04b5f50,qtype=2) status -115
> unlink_urb(urb=c04b5f50) done
> usb.c: USB device not accepting new address=2 (error=-110)
> m8xxhci_free_dev(usb_dev=c0fcca00)
> m8xxhci_free_dev(dev=c0fcca00) done
> m8xxhci_alloc_dev(usb_dev=c0fcca00)
> hub.c: USB new device connect on bus1/1, assigned device number 3
> usb_control/bulk_msg: timeout
> unlink_urb(urb=c04b5f50,qtype=2) status -115
> unlink_urb(urb=c04b5f50) done
> usb.c: USB device not accepting new address=3 (error=-110)
> m8xxhci_free_dev(usb_dev=c0fcca00)
> m8xxhci_free_dev(dev=c0fcca00) done
>
> The SOFs disappear completely and I cannot see any traffic
> between D+ and GND. The D+ Line goes up (about 3 V).
>
> If I connct a Thunderbird 4-port USB hub, I get:
>
> rh::int:0 2 2 101 1
> m8xxhci_alloc_dev(usb_dev=c0fcca00)
> hub.c: USB new device connect on bus1/1, assigned device number 2
> rx err sc (status 0x1c54)
> complete urb c04b5f50, actual_length 0, status -1
> unlink_urb(urb=c04b5f50,qtype=2) status -110
> unlink_urb(urb=c04b5f50) done
> complete urb c04b5f50, actual_length 0, status -1
> unlink_urb(urb=c04b5f50,qtype=2) status -110
> unlink_urb(urb=c04b5f50) done
> complete urb c04b5f50, actual_length 0, status -1
> unlink_urb(urb=c04b5f50,qtype=2) status -110
> unlink_urb(urb=c04b5f50) done
> complete urb c04b5f50, actual_length 0, status -1
> unlink_urb(urb=c04b5f50,qtype=2) status -110
> unlink_urb(urb=c04b5f50) done
> complete urb c04b5f50, actual_length 0, status -1
> unlink_urb(urb=c04b5f50,qtype=2) status -110
> unlink_urb(urb=c04b5f50) done
> usb.c: USB device not responding, giving up (error=-110)
> m8xxhci_free_dev(usb_dev=c0fcca00)
> m8xxhci_free_dev(dev=c0fcca00) done
> m8xxhci_alloc_dev(usb_dev=c0fcca00)
> hub.c: USB new device connect on bus1/1, assigned device number 3
> complete urb c04b5f50, actual_length 8, status -1
> unlink_urb(urb=c04b5f50,qtype=2) status -110
> unlink_urb(urb=c04b5f50) done
> complete urb c04b5f50, actual_length 8, status -1
> unlink_urb(urb=c04b5f50,qtype=2) status -110
> unlink_urb(urb=c04b5f50) done
> complete urb c04b5f50, actual_length 8, status -1
> unlink_urb(urb=c04b5f50,qtype=2) status -110
> unlink_urb(urb=c04b5f50) done
> complete urb c04b5f50, actual_length 8, status -1
> unlink_urb(urb=c04b5f50,qtype=2) status -110
> unlink_urb(urb=c04b5f50) done
> rx err sc (status 0x1c44)
> complete urb c04b5f50, actual_length 0, status -1
> unlink_urb(urb=c04b5f50,qtype=2) status -110
> unlink_urb(urb=c04b5f50) done
> usb.c: USB device not responding, giving up (error=-110)
> m8xxhci_free_dev(usb_dev=c0fcca00)
> m8xxhci_free_dev(dev=c0fcca00) done
>
> The SOFs disappear too!
>
> In some rare cases (when I connect a HUB), the SOFs don't
> disappear. In this cases the 4-port HUB is recognized
> partially.
>
>
> Christian Schroeder
>
> Dr.-Ing. Christian Schroeder
> Institut fuer Mikroelektronik- und Mechatronik-Systeme
> Langewiesener Strasse 22
> 98693 Ilmenau
> Telefon: +49 3677 678315
> Telefax: +49 3677 678337
> Mobil:   +49 173 5789172
> e-mail:  christian.schroeder@imms.de
> www:     http://www.imms.de/~christi/cs.html
> pgp:     finger christi@finger.imms.de
>
>
>
>
>       References:
>             More USB questions (for the MPC8xx)
>                   From: Kári Davíðsson <karid@flaga.is>
>             More USB questions (for the MPC8xx)
>                   From: Kári Davíðsson <karid@flaga.is>
>
>       Prev by Date: Re: es1371.o sound module on a IBM 405 walnut platform
>       Next by Date: RE: More USB questions (for the MPC8xx)
>       Index(es):
>             Chronological
>             Thread

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
