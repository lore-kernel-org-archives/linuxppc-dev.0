Message-ID: <3A8A65CC.87648220@mpifr-bonn.mpg.de>
Date: Wed, 14 Feb 2001 12:02:36 +0100
From: Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: "Michael K. Fleming" <mikef@praxis.etla.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCMCIA on a Pismo with pcmcia-cs-3.1.24
References: <Pine.LNX.4.21.0102130946440.32475-100000@praxis.etla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Michael!

> > "Michael K. Fleming" wrote:
> > > I'm trying to get PCMCIA working on my Mac Powerbook Pismo, with kernel
> > > 2.2.18pre4-ben1 and pcmcia-cs-3.1.24 (no patches applied--as far as I can
> > > tell, none should be necessary...).  I'm primarily trying to get a
> >
> > This should be your problem... If you have a Pismo, you can not boot with BootX,
> > and in this case you have to patch your kernel. Did not check 2.2.18 yet (yeah,
> > my web page is outdated...), but I guess it is still necessary...
>
> I'm not booting with BootX--I'm booting with yaboot.

If you boot with BootX (which you *can* *not* use with the Pismo), OpenFirmware
takes care that the CardBus Bridge is initialised properly (but the kernel still
get a wrong number of pci busses on the Wallstreet/Lombard...). If you boot with
yaboot, some registers in the bridge contain bad values. I tried the stock
LinuxPPC 2.2.18 sources a few days ago, and they *still* need the patch. I did
not try the kernel-pmac rpm though, but if your box does not detect the IRQ,
there is no other solution than building a new kernel.

> What patches do I have to apply to my kernel?  Or do you mean patches to
> pcmcia-cs?

You just have to patch your kernel sources, as decsribed on my web page (see
http://www.mpifr-bonn.mpg.de/div/iri/Archiv/LinuxPPC/PCMCIA.html, just follow
the instructions in the section "Kernel Setup").

It *might* be possible for you to use the kernel-pcmcia-cs-2.2.18-4h.ppc.rpm
package. If it does not work, you should build your own pcmcia stuff. As pointed
out in the "PCMCIA/CardBus" section of the web page mentioned above, on the
Pismo you should use the stock package from sourceforge *without* any additional
patches. You *must* change the pcmcia config files afterwards, though.

Hth,

	Albrecht.

--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
