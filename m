Date: Tue, 30 Jan 2001 16:57:10 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010130165710.B22219@allspice.cs.swarthmore.edu>
References: <20010130163538.A22219@allspice.cs.swarthmore.edu> <Pine.LNX.4.10.10101302239070.27612-100000@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10101302239070.27612-100000@zirkon.biophys.uni-duesseldorf.de>; from schmitz@zirkon.biophys.uni-duesseldorf.de on Tue, Jan 30, 2001 at 10:46:06PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 30, 2001 at 10:46:06PM +0100, Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de> wrote:
> > > The big question: why does this particular command time out in the first
> > > place? Does the target expect more data to be sent? Does the target just
> > > crash and fails to release the bus? It seems to work on other host
> > > adapters, doesn't it?
> >
> > There's a report of excatly the same failure mode on mac53c94 with a
> > different brand (Sony, as opposed to Yamaha on my MESH) of DVD drive.
>
> Please send a detailed description on how to reproduce this bug by PM.
> I'll try to look into that on my Lombard, and in case I can get the
> required binaries for m68k I'd also test on an old Quadra with 53c9x
> SCSI.

Basically, any time I have used cdrdao to write a disc, or cdrecord with
the -dao flag, the SCSI bus has locked up, under kernels from 2.2.15pre3
or so to a recent 2.4 from the bk tree.  I'm tempted to see whether I
can write a short program using the sg stuff to just send the
"send_cue_sheet" command to the CD-RW and see if it locks up, but I
haven't had a chance to look into it yet.

> Does the bug happen only with DVD writers, or regular CD writers?

Aargh, sorry, when I said "DVD" above it was a complete thinko.  I have
a Yamaha CD-RW drive (the model number is something wit 8424 in it, I
can get exact details when I get home.)  The report with the mac53c94
driver was a Sony CD-R or CD-RW drive -- I've exchanged email with the
guy who reported it and can ask for the details if you'd like.  I have
no idea if it would fail with a DVD writer, but all the cases I've seen
have been CD writers.  (This is why it's not a good idea to wait until
late afternoon to have coffee, and why if I do so, I should refrain from
writing email until after I have found some.)  :-)

> > So the only points in common seem to be that the DVD drives are running
> > on mac hardware and that the drivers are written by Paul Mackerras.  :-)
> > I don't at all mean to impugn Paul's coding ability, which is obviously
> > excellent, but the fact that he wrote both the drivers may mean that
> > they share lots of code and possibly share the same bug.
>
> If so, the bug should have propagated to the m68k 53c9x driver. Wouldn't
> be the 53c9x first weirdness - I never got it to accept a DAT drive (old
> DDS-1, possibly Apple) without blowing up.

It would be great if you could check this out.

> It might be something PPC specific as well and have nothing to do with
> Paul's drivers.

This is why I asked in a previous email whether anyone had ever burned
a disk in DAO mode successfully on a pmac or in fact on any powerpc
machine, but I've received no responses.  Hmm, maybe I should try to
conduct a quick survey of this on linuxppc-user and/or debian-powerpc.

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
