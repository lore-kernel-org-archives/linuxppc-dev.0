Date: Mon, 30 Sep 2002 14:01:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20020930040143.GF10265@zax>
References: <OF8DC4E66D.5C36B7D3-ON87256C41.00434ACB@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF8DC4E66D.5C36B7D3-ON87256C41.00434ACB@boulder.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Sep 27, 2002 at 08:27:35AM -0400, Ralph Blach wrote:
>
> Yesterday I discovered a minor 405GP vs 405GPr PCI difference.
> IN the 405GP the ptm1ms bit 31, the enable bit for the region is set to 1
> by the hardware and cannot be written.
> On the 405GPr the bit is writable and this makes necessitates  a change in
> walnut.c
>
> In walnut.c there is the line
>
> out_le32((void *) &(pcip->ptm1ms), 0x00000000);
>
> On the walnut, this would work fine because bit 31 cannot be written to a
> 0,
> On the GPr, this disables the regions and PCI no longer functions.
> The line should be changed to
>
> out_le32((void*)&(pcip->ptm1ms),0x000000001);
>
> This will fix the 405GPr and make no difference to the 405GP since the bit
> is permanently to 1.

I would put it more strongly than that:  this is a bug, which we just
happen to get away with because of the behaviour of the 405GP.

The arrangement of the code in walnut.c suggests some confusion
between the PLB->PCI and PCI->PLB windows, which is probably the
origin of the bug (the fact that the 405GP numbers the former from 0
and the latter from 1 probably didn't help).

The fix you've suggested should be correct for Walnut, and probably
the other places that that code has been copied.  I tend to think,
though, that this configuration of the 4xx PCI bridge should be moved
out of the board code and into ppc4xx_pci.c.  If we do that, though we
should fully configure the PTMs, to wit:
	out_le32((void *) &(pcip->ptm1ms), 0x00000000);
	out_le32((void *) &(pcip->ptm1la), 0x00000000);
	out_le32((void *) &(pcip->ptm1ms), 0x80000001);
	out_le32((void *) &(pcip->ptm2ms), 0x00000000);

Which should configure the PCI bridge to match the comments in
walnut.c (i.e. map PCI addresses 0x00000000-0x7fffffff to
corresponding PLB addresses).

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
