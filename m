To: Tom Rini <trini@kernel.crashing.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 20 Mar 2002 08:55:51 MST."
             <20020320155551.GD3762@opus.bloom.county>
Date: Wed, 20 Mar 2002 17:18:35 +0100
Message-Id: <20020320161840.C5A84109F3@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20020320155551.GD3762@opus.bloom.county> you wrote:
>
> Well, I do think the idea of a generic BI_ETH_DEVICE was killed.  Unless
> you can work out how to deal with the multiple driver issue above.

I'm getting a bit tired about this discussion. We  start  with  siome
nice  ideas,  then  some open issues pop up, and instead of trying to
find a solution we drop everything again. I think I rather lean  back
and  wait for the next round of this discussin in about 2 or 3 months
from now.

We are just wasting time. it seems.

> Well if this works now, why wouldn't it work later?

It works now because we usually have only a single network interface,
and there is a single MAC address entry in bd_info. There are  a  few
systems which have more interfaces (with a strong tendency that their
number  is  growing) and they use a private (non-standard) version of
bd_info which is incompatible with anything else. Or  they  use  some
hard-wired mechanism to compute the additional MAC addresses from the
first one which is usually not acceptable.

> > I am not aware of something that looks like an acceptable solution to
> > me.
>
> So you don't like the patch you made or you don't recall the patch I'm
> talking about?

I'm not really sure which patch you are referring to; I think I  know
which one you mean, and that one was ugly ;-)

> I don't see how an index helps (enet drivers are in a 'random' order,
> normally) and some bytes for specific info just means there's some bytes
> there.  Are you saying the first set of bytes we toss in say this is
> driver X ?

For instance. Hey, but we are talking about a very, very special case
here - when you have set of non-standard controllers which don't know
their own addresses _and_ need to get a specific assignment _and_ you
don't know the initialization sequence _and_ ...

For 98% of all practical purposes it will be sufficient to  pass  the
list of MAC addresses, and for 1.95% it will be sufficient to combine
the  MAC  address  with  information about the driver type (GT, 82xx,
...).

> > So far all 824x systems we (DENX) have seen  looked  like  "standard"
> > PCI devices, using standard device drivers under Linux.
>
> Er, you lost me there.  Either you're saying it's using "standard" chips
> (tulip, eepro, et al), or (and I don't recall if 824x has it's own
> special enet like 8260) the enet device shows up normally on the PCI bus
> and you've got drivers for it..

They are using hardware that looks like standard chips to the system.

> But either way it's sounding like it's not a problem now..

Right.

The biggest problem to me is a couple of 8260 systems with  dedicated
assigment of MAC addresses to several ethernet interfaces.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Quote from the Boss after overriding the decision of a task force  he
created  to  find  a  solution:  "I'm  sorry  if  I ever gave you the
impression your input would have any effect on my  decision  for  the
outcome of this project!"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
