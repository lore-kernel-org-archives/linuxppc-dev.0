From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: Ani Joshi <ajoshi@shell.unixbox.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Driver Hell: was Re: GeForce on PPC == _no work_
Date: Sun, 28 Oct 2001 16:35:00 +0100
Message-Id: <20011028153500.18947@smtp.wanadoo.fr>
In-Reply-To: <20011028151111.JZNC28233.tomts15-srv.bellnexxia.net@there>
References: <20011028151111.JZNC28233.tomts15-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>How does Darwin even boot on some machines without this support.  Do they
>instead install some binary only driver set?

Yes, they provide binary only driver for download or on their CD.

>Also why all the secrecy about drivers in general.

Go figure... some vendors beleive it will help competitors to
see their driver because it can make you learn about the HW,
some are just paranoid about open source, or don't like it for
political reasons, ...

>Right now I seem to be in driver hell:
>
>- firewire does not work

Sorta works ;) Depends on the machine and the devices, it's beeing
actively worked on.

>- radeon fp does not work

Ani have made some progress. The radeonfb in my current rsync
might work with the proper panel_yres:xxx argument. I think we
can use i2c to really probe the panel type, it's just a matter
for Ani to find the time to implement & test it.

>- new driver for adaptec scsi drivers does not work (old ones do)

It works again for me with 2.4.13 "final". I fixed a possible interrupt
probleme where a level interrupt that is kept asserted upon exist of
the handler could fail to be re-issued. Can you try this ? (It's
in my rsync tree).
It _might_ explain problems with non-openpic machines.

>- the new tulip ethernet driver does not really support Lite-On PNIC2
>  negotiation (seems to have been hardwired to 100mb?).    Again, at
>  least the old becker driver did work at 10baseT-HD.

Isn't this old becker vs new becker ? In all case, you should ask the
maintainer.

>Being an old EE who used to write his own drivers, all we really need is
>the damn interface description and some sample code but I could not find
>anything publicly on either the Radeon, the Lite-ON PNIC2 (very similar to
>a D21143).

For the radeon, I'm pretty sure if you are an XFree devel, you can get
them. You might also ask ATI.

>Where does one get the equivalent of the old "Data-Books" for these little
>gems?  I can remember each little device (DMA chips, processor, memory
>controller, etc each came with enough info and examples to get them
>working (after playing around long enough).  Why today do they make it so
>hard for people to find information on them? Or am I just looking in the
>wrong place?

#pragma political ON

That's the beauty of the market ;) The more things are kept secret and
hidden, the more companies are happy. In their ideal view of the world,
you shouldn't be able to know a bit about what you are using, that might
prevent them from selling you crap.

#pragma political OFF

>What is the technical or business rationale for making your "product" hard
>to use?  Is there some kickback from designer to chip maker that has come
>into existance that I am missing here?  Since they basically give away
>binary drivers (and not selling them) keeping info locked up just makes no
>business sense to me?

They just don't care about linux or whatever is not Windows anyway...

>Anyone with insights here they would like to share?

Well, my experience is that some vendors (like ATI), do send you docs
if asked. Sometimes with an NDA. In some cases, reverse engineering is
the only solution.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
