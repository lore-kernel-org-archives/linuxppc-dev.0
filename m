Subject: RE: PowerSpan PCI / sym2 SCSI
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Ppc Developers <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <NCBBIINEHIPFGJPLBEIFGEBODLAA.acurtis@onz.com>
References: <NCBBIINEHIPFGJPLBEIFGEBODLAA.acurtis@onz.com>
Content-Type: text/plain
Date: 23 Aug 2002 09:51:58 -0500
Message-Id: <1030114318.8559.28.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2002-08-23 at 09:35, Allen Curtis wrote:
> > > However it only works if you select the "normal I/O" option with the
> > > SYM53C8xx version 2 driver. SYM53C8xx version 1 does not work. Version 2
> > > does not work if the I/O option is not selected.
> >
> > It might help if you described "does not work" in more detail... could
> > you paste error messages?
>
> http://lists.linuxppc.org/linuxppc-dev/200208/msg00032.html
> More information here than would need...

That's a lot more than I want to think about. :) Of course I'm assuming
you have your PCI config set up correctly - in that case the below is an
error I've seen.

> > I've seen a problem on PReP where although the SCSI card is addressed at
> > 0xc0000000, the BAR is 0x0 (because of the host bridge offset). From
> > memory, the sym2 driver checks the BAR and if it's 0 errors out.
> > Removing that check or enabling "normal IO" worked fine. Of course, this
> > might not be your problem, but without actual error messages...
>
> This sounds promising. Is this check in both versions of the driver? I don't
> remember a BAR check. I thought it just ioremapped() the region. Could you
> provide a reference? (line#)

I didn't notice you were still having problems with version 1 of the
driver; I thought you had resolved that. IME that almost always means
your PCI config is not correct.

The BAR check in sym2 is around line 2531 of sym53c8xx_2/sym_misc.c .

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
