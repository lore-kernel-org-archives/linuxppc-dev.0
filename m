To: Tom Rini <trini@kernel.crashing.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 20 Mar 2002 08:01:19 MST."
             <20020320150119.GB3762@opus.bloom.county>
Date: Wed, 20 Mar 2002 16:43:18 +0100
Message-Id: <20020320154323.55F28109F3@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20020320150119.GB3762@opus.bloom.county> you wrote:
>
> > Has been shot down? When? Where? Why? Am I missing something?
>
> You were CC'ed.   One problem with a generic record is that what happens
> when you have multiple drivers (8260 + gt-64260, for example).  Also Dan
> Malek pointed out that most of the information (not all) should be up to
> the driver (or userland) to handle.

We talked about problems, yes. But  that  doesn't  usually  mean  the
whole idea gets dropped, or does it?

I really like to be able to configure the network interface(s)  of  a
memory-restricted  embedded  system  using  the IP-autoconfig feature
just by passing it a "ip=..." command line agument.  This  saves  (1)
the  memory  for tools like ifconfig etc in the application image and
(2) the need to  modify  the  application  when  the  network  config
changes.

> > We need to deal with boards with more than  one  ethernet  interface,
> > which  are already active in the firmware (net-booting from redundand
> > interfaces, using separate MAC addresses).
>
> Well, you had a patch awhile ago which allowed for this to be
> configured, yes?

I am not aware of something that looks like an acceptable solution to
me.

> > We added an index field to BI_ETH_CFG, didn't we?  The  driver  would
> > then "know" how to map this...
>
> How would it "know" which ones it can grab?  Ben said the driver should
> do something like find_bi_rec(BI_XXX_ETH_CFG), which would presumbly
> return NULL or >= 1 set of bi_recs of BI_XXX_ETH_CFG.  Then you get the
> 1st and 2nd GT64260 enet devices, and say the 1st and 2nd 8260 enet
> devices, and whichever drivers registers first gets eth0+eth1 and the
> other eth2+eth3.

...which may be perfectly fine in many situations. If you need a more
selective assignment, there was the proposal to add some  index  (me)
or  "some bytes for driver specific info (e.g., on gt64260, is_rmii)"
(Mark A. Greer) which could be easily used to mark a bi_rec as  [not]
acceptable by a certain ethernet driver.


> > We _do_ care, a little for 8xx, very much for 8260, also for 824x and
>
> We also need to fix the drivers for these at the same time.  Do we
> actually make use of special 824x enet right now?  I think one of the

So far all 824x systems we (DENX) have seen  looked  like  "standard"
PCI devices, using standard device drivers under Linux.

> other problems we'll run into is some of the rough edges of 8xx and 8260
> support...

Right. Some work will be necessary.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In an infinite universe all things are possible, including the possi-
bility that the universe does not exist.
                        - Terry Pratchett, _The Dark Side of the Sun_

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
