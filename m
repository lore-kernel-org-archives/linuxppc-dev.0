To: Tom Rini <trini@kernel.crashing.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 19 Mar 2002 16:16:28 MST."
             <20020319231628.GQ3762@opus.bloom.county>
Date: Wed, 20 Mar 2002 00:46:57 +0100
Message-Id: <20020319234702.CA8AA109F3@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20020319231628.GQ3762@opus.bloom.county> you wrote:
>
> I sort-of remember this too.  For 2.4 I'm not sure if it's better to
> have a massive ammount of compile time options or not.  Either way we'd

What sort of compile time options? I don't want to have MAC addresses
built into the kernel images!

> need to change the driver to handle multiple enets, yes?

Only some, like the 8xx. Other  configurations  run  just  fine  with
several ethernet interfaces.

> > BTW: the structure should probably be extended by one entry  for  the
> > interface (eth0, eth1, etc...).
>
> Forcing ethX is a bad idea I think, but we do need a way of saying all
> of this applies to *this* enet device.

Right, probably an index is all we need.

> Yes, but we're speaking in terms of GT-64260, which has ns1655x and it's
> own, but I'm not as clear about having 'em both on.  But, does 8xx not
> allow for reading of what things are currently set at now or must it be
> specified?

But isn't this the whole idea behind the new  interface  -  to  allow
certain  things to be done just ONCE, in ONE place, and not again and
again and again in several instances of  the  same  code,  with  good
chances that at least one instance is buggy?

Of course I can retrieve this information in some CPU and  eventually
board  dependend  way  somehow - but why should I bother to implement
this code when the information is already available?

With the same argiment we could drop the MEMSIZE record - the  kernel
can  detect the memory size as well. Not that I think that would be a
good idea...

And BTW: I'm not talking about 8xx systems only.

> > You are wrong. We'll switch faster than you seem to think.
>
> I know you'll switch when it's all set and working.

Then, or before :-)

> There's a time and place for everything, and it's called the development
> line.  Big rewrites/changes are supposed to be done there and maybe
> backported.

Ummm... someone called 2.5 "fs-eating-non-compiling-crap,  so  ignore
that for a few months". Guess who?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"I say we take off; nuke the site from orbit. It's the only way to be
sure."                                  - Corporal Hicks, in "Aliens"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
