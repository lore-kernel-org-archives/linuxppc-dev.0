From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development
 <linuxppc-dev@lists.linuxppc.org>,
        Paul Mackerras <paulus@linuxcare.com.au>, Dan Malek <dan@mvista.com>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
Date: Wed, 27 Sep 2000 12:37:48 +0200
Message-Id: <19340822040932.8760@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.10.10009231430200.413-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10009231430200.413-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Life would be much simpler if PCI I/O space used a similar opaque IO base
>cookie with a corresponding ioportremap(cookie) function (looks a lot like
>Dan's tell_me_where() function, which I didn't realize until now :-), before
>feeding everything to inb() and friends. On ia32, ioportremap() would
evaluate
>to the identity.
>
>No way we can convince The Others to use this approach? It does sound logical
>:-)

I'm not sure it would help. It would probably allow a kind of "mapping on
demand" of the IO region on memory mapped IOs platforms, but unless we
add another parameter to ioportremap telling it the pci_dev (or at least
the bus number), we can't "guess" on which IO bus the device is and which
physical base we must use.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
