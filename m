Date: Tue, 8 Jul 2003 20:53:09 -0700
Subject: Re: OT: wanting to write PCI daemon
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-dev@lists.linuxppc.org
To: Stefan Jeglinski <jeglin@4pi.com>
From: Tim Seufert <tas@mindspring.com>
In-Reply-To: <p06001800bb30f2ae6091@[192.168.0.254]>
Message-Id: <DAD09CD5-B1C0-11D7-8101-003065F22EAA@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday, July 8, 2003, at 03:46  PM, Stefan Jeglinski wrote:

> We have been moving along in this project slowly, and you could say
> we're now caught with our pants down a bit, given that part of our
> customer base will soon be buying G5s with PCI-X only (except the one
> model).
>
> As an interim solution until our next-gen hardware becomes real, we
> want to use up our stock of existing PCI cards, and have mostly
> settled on the idea that we can build a small box with a commercial
> motherboard including 1 PCI slot.

You may be aware of this already, but it seems like an obvious question
to ask, so: Are your cards 5V, or are they Universal (compatible with
both 5V and 3.3V)?  If they're Universal, they will work as-is.  The
conflict isn't about PCI protocol vs PCI-X protocol (PCI-X is backwards
compatible), it's about signal levels.  All PCI slots faster than 33
MHz must (according to the standard) use 3.3V signaling, PCI-X slots
included.  3.3V slots don't accept 5V cards, 5V slots don't accept 3.3V
cards, and Universal cards work in either kind of slot.  Up until now,
Apple has used 5V slots almost exclusively (the lone exceptions prior
to the G5 were the B&W G3, which had one 32-bit 66 MHz 3.3V slot, and
the XServe, where I believe all slots are 3.3V and 66 MHz).  Recent
cards are usually Universal, but there must be enough 5V only cards
still in common use that Apple felt it necessary to make at least one
model compatible with them.

>  But to further our next-gen design,
> we'd like to go ahead and run a linux kernel on it. That means it
> will likely be Intel, so already I'm getting seriously close to
> getting booted here, but this we know how to do.

Aw, c'mon, use one of those cute little TeronCX boards or something
like that.  :)

> We then just need a)
> to talk TCP/IP out the one end, and b) PCI on the other.
>
> We had the naive idea that we could take an existing [open-source]
> daemon that listens via TCP/IP on an ethernet interface, and modify
> it for our purposes. We would then wed the kernel (and daemon) with
> source code from PLX, the maker of our PCI controller chip (they
> apparently provide Linux source as part of a $99 devel kit).
>
> Now the questions: does this seem at all reasonable?

Yes.  Presumably what PLX provides is a driver skeleton that knows how
to do DMA, use the chip's mailbox registers and other features, and
communicate with userspace.  You would flesh this skeleton out with
whatever device specific stuff you need to do, extending the userland
interface as appropriate.  Then you would hack the daemon to serve data
retrieved through the userland knobs of the device driver.

(Though I'm not sure whether it would be a good idea to use an existing
daemon as anything beyond sample code to see how real live TCP/IP
communications work.  You might have a hard time finding one that is
ideal for direct adaptation, and it can be a big mistake to try to bend
existing programs too far.  Hopefully somebody else who knows better
about what kind of server code is out there can provide you with some
advice on this.)

>  Are there
> obvious gotchas or better approaches? Is the idea of adapting an
> existing daemon a stupid one? If not, which existing daemon might be
> best adapted? Are there existing TCP/IP daemons that already are
> adapted for use in a PCI environment? Is there already a free OOTB
> solution for us? <grin>
>
> Any other thoughts or suggestions? Is my terminology even in the
> right place? Searching on sourceforge for "PCI" brings quite a few
> hits, but our resources to investigate even the reasonable
> possibilities are limited.

My only comment here is that the phrase "PCI daemon" probably isn't the
way you should think of it.  The canonical layering would be for the
device driver to present an abstract bus independent interface to the
card's functionality; the daemon shouldn't have to know anything about
what kind of bus the device happens to be on.

(But don't take that as gospel.  Sometimes it is good to push chunks of
driver functionality out into userland, especially if performance isn't
critical.  It can make debugging a great deal easier, for example.  And
to provide the proper disclaimer, I am not a driver expert, I just play
one on TV.)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
