Date: Wed, 20 Mar 2002 01:03:02 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	<linux-galileo@source.mvista.com>, <wd@denx.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
In-Reply-To: <20020319224420.GO3762@opus.bloom.county>
Message-ID: <Pine.LNX.4.33.0203200100150.15761-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 19 Mar 2002, Tom Rini wrote:

>
> On Tue, Mar 19, 2002 at 02:56:14PM -0500, Mark A. Greer wrote:
>
> > I like what Michael has done but want to add more and change the
> > BI_GT64260_ETH_CFG to a more generic BI_ETH_CFG.
>
> I don't know about this.  Why?  From what I can tell, this is something
> that will be useful for 8xx/8260, but would require changing the driver
> to know about this, and it's currently over bd_t, and I'd rather leave
> it for now.
>
> > New (and [pretty much] generic):
> > --------------------------------
> >   BI_MEMSTART -- mem start
>
> GT-64260 doesn't use this, does it?  We'll need this for Nubus and other
> discontig memory situations, but not right now (except for APUS).
>
> >   BI_INTFREQ -- internal CPU frequency??
> >   BI_BUSFREQ -- CPU bus freqency?
> >   BI_ETH_CFG -> struct with following:
> >    -- mac addr
> >    -- hdx/fdx; 10/100/1000/...; OR autonegotiate
> >    -- phy addr
> >    -- some bytes for driver specific info (e.g., on gt64260, is_rmii)
>
> Looks fine, see above of course...

Don't forget timebase/decrementer frequency, it is not always easy to
measure and very important for timekeeping.

Still fighting lack of reproducible timebase frequency measurements at
boot on some boards. Not very actively since I've got more urgent
problems and NTP ends up hiding most of it.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
