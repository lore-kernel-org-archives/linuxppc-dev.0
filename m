Message-ID: <38D2A182.DA3DA70E@email.sps.mot.com>
Date: Fri, 17 Mar 2000 15:20:02 -0600
From: "Richard Hendricks" <ra6353@email.sps.mot.com>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: Alan Mimms <alanm@unforgettable.com>,
        Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: What is the catch with IDMA on MPC860?
References: <38D27077.C11A3B28@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ah, but there's an assumption you're making Dan, and that's the IDMA
was added for the 860.  It was really added for camera customers using
the MPC821/MPC823.  That's why single buffer burst flyby was added,
and that's why it supports interlacing.  In the MPC823 manual, we even
describe how to setup IDMA to interface to a CCD camera with multiple
fields.

Anyways, IDMA performance is horse that has been beaten enough here
in Motorola.  The hardware DMA controller in the original 360 took
too much space, and so using the CPM to do IDMA was born.  For most
situations, it is a perfect compromise.

Actually, I was remiss in my earlier statement.  The biggest complaint
about IDMA is that you can't use it with Ethernet.  On the latest
version of the MPC823 this is fixed.  The problem comes about because
the CAM capability of the Ethernet can't be turned off.  CAM was removed
from the feature list of the MPC823, but wasn't removed from the die
itself until Rev. A (I think).  It caused us many a headaches as
we couldn't understand why a collegue's audio codec using
DMA would always go haywire whenever he received an Ethernet packet.

Dan Malek wrote:
>
> Alan Mimms wrote:
> >
> > Regarding the "where does the manual say that the performance stinks"
>
> That's an irrelevant question, as no one literally said "the performance
> stinks", and no one should.
>
> If you take a look at the timing diagrams and the CPM performance
> worksheets, you will find the IDMA is not terribly efficient.  This
> is a system design choice.  You can move data significantly faster
> using PPC core programmed I/O operations.  The other system design
> considerations surround the use of the CPM.  If you choose to use
> the IDMA, it affects other CPM operations.
>
> The IDMA could very well statisfy a particular system design.  If
> the feature wasn't there, people would be complaining for that
> reason.
>
> The 860 is a killer communication processor.  When you start using
> some of these other features, it significantly impacts this capability.
> In the case if IDMA, control signals used for some communication
> capabilities are lost, and you have to choose configuration options
> that further erode the communication processing performance.  Just
> be aware of this.
>
>         -- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
