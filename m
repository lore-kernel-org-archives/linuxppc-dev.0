Message-ID: <39D3D33F.6AA82A1D@mvista.com>
Date: Thu, 28 Sep 2000 16:24:47 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Paul Mackerras <paulus@linuxcare.com.au>, Dan Malek <dan@mvista.com>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <Pine.LNX.4.10.10009231430200.413-100000@cassiopeia.home> <19340822040932.8760@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >Life would be much simpler if PCI I/O space used a similar opaque IO base
> >cookie with a corresponding ioportremap(cookie) function (looks a lot like
> >Dan's tell_me_where() function, which I didn't realize until now :-), before
> >feeding everything to inb() and friends. On ia32, ioportremap() would
> evaluate
> >to the identity.
> >
> >No way we can convince The Others to use this approach? It does sound logical
> >:-)
>
> I'm not sure it would help. It would probably allow a kind of "mapping on
> demand" of the IO region on memory mapped IOs platforms, but unless we
> add another parameter to ioportremap telling it the pci_dev (or at least
> the bus number), we can't "guess" on which IO bus the device is and which
> physical base we must use.
>
> Ben.
>

Yes, we should add pci_dev to ioportremap(), which can then extract the
bus number from pci_dev->pci_bus.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
