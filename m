Subject: Re: PowerSpan PCI / sym2 SCSI
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Ppc Developers <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <NCBBIINEHIPFGJPLBEIFMEAJDLAA.acurtis@onz.com>
References: <NCBBIINEHIPFGJPLBEIFMEAJDLAA.acurtis@onz.com>
Content-Type: text/plain
Date: 23 Aug 2002 09:20:14 -0500
Message-Id: <1030112414.8559.20.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2002-08-21 at 22:47, Allen Curtis wrote:
>
> I retrieved 2.4.19 final from BitKeeper and have successfully gotten PCI
> working with the SYM53C8xx version 2 driver. (No modifications were made to
> the PCI setup)
>
> However it only works if you select the "normal I/O" option with the
> SYM53C8xx version 2 driver. SYM53C8xx version 1 does not work. Version 2
> does not work if the I/O option is not selected.

It might help if you described "does not work" in more detail... could
you paste error messages?

> It sounds like a byte-swap issue with the memory interface. Has anyone else
> run into this? I am using an 8260 not a Mac/PowerPC. Perhaps there is
> something there?

I've seen a problem on PReP where although the SCSI card is addressed at
0xc0000000, the BAR is 0x0 (because of the host bridge offset). From
memory, the sym2 driver checks the BAR and if it's 0 errors out.
Removing that check or enabling "normal IO" worked fine. Of course, this
might not be your problem, but without actual error messages...

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
