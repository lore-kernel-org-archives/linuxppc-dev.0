Message-ID: <008801c29a25$cf02f460$0300a8c0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Pantelis Antoniou" <panto@intracom.gr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLEEHBFIAA.joakim.tjernlund@lumentis.se> <3DEB7A88.1030205@intracom.gr>
Subject: Re: QMC driver for 860?
Date: Mon, 2 Dec 2002 18:11:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Joakim Tjernlund wrote:
>
> >>OK
> >>
> >>You asked for it ;).
> >>
> >>The file netvia_tsa.c is the actual QMC + stuff driver.
> >>The file netvia_bri.c is an example driver.
> >>The header files are the QMC definitions.
> >>
> >>Linux kernel version is 2.4.20.
> >>
> >>Don't hesitate to ask for any explanations.
> >>
> >>Pantelis
> >>
> >>
> >
> >Thanks a lot!
> >
> >I have just browsed the driver and I noticed that there is room for performance
> >improvements in netvia_tsa.c w.r.t memcpy(). You can avoid the memcpy() call
> >for received packets by using invalidate_dcache_range(). I did this for
> >the 8xx_io/enet.c driver a few weeks ago(it's not in BK yet).
> >
> >See http://lists.linuxppc.org/linuxppc-embedded/200210/msg00317.html
> >and
> >http://lists.linuxppc.org/linuxppc-embedded/200210/msg00272.html
> >
> >   Jocke
> >
> Yes, I know the trick. I'm looking forward to see your changes
> make it in. As it stands I'm not tracking the BK PPC tree, but
> the Linus tree. Being behind the company firewall, BK is not
> very useful.

The patch should apply to linus tree as well. There is just a small bug
in my second version(the invalidate_dcache_range() call must be moved).

>
> In this driver case since I'm reading the packet in a non-cachable
> area, and not directly in a skb, I'm not convinced that
> the invalidate_dcache_range will be a great win.

It should be a win since the patch removes the need for non-cachable memory and a
memcpy()(only add a invalidate_dcache_range call for non cache coherent CPUs like the 8xx).

 Jocke

>
> If you do any performance testing I'm very interested in
> your results.
>
> Pantelis
>
> P.S. Is there anyone in the list interested in this?
> Should I clean it up, and submit it?

Is QMC supported on other families than 8xx? If so I think it would be a good idea.
The 862 even has the QMC built in so there must be a need for this.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
