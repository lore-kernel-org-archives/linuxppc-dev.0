Date: Wed, 2 Oct 2002 11:42:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021002014219.GF1848@zax>
References: <OF8DC4E66D.5C36B7D3-ON87256C41.00434ACB@boulder.ibm.com> <20020930040143.GF10265@zax> <20021001052121.GV10265@zax> <3D995EC0.2000500@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D995EC0.2000500@elsoft.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Oct 01, 2002 at 10:37:20AM +0200, "David M?ller (ELSOFT AG)" wrote:
>
> Hello
>
> David Gibson wrote:
> >On Mon, Sep 30, 2002 at 02:01:43PM +1000, David Gibson wrote:
> >
> >>On Fri, Sep 27, 2002 at 08:27:35AM -0400, Ralph Blach wrote:
> >>
> >>>Yesterday I discovered a minor 405GP vs 405GPr PCI difference.
> >>>IN the 405GP the ptm1ms bit 31, the enable bit for the region is set to 1
> >>>by the hardware and cannot be written.
> >>>On the 405GPr the bit is writable and this makes necessitates  a change
> >>>in
> >>>walnut.c
> >>>
>
> [stuff deleted]
>
> >So, here is a patch to do that.  If there are no objections, I will
> >commit this to linuxppc-2.5 BK.
>
>
> In your proposed patch, i'm missing a way to install a board specify
> mapping either by using special constants, callback functions to board
> specific code, .... AFAICS all boards are forced to use the same mapping.

That's right.  Is there a reason for boards to have different
mappings?  I can well believe that there is, but the current tree
doesn't show it - all the boards (in the tree) that have PCI appear to
do the same initialisation of the windows.  It doesn't seem worthwhile
to create board specific PCI initialisation hooks until we have a
board that needs it.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
