From: Pantelis Antoniou <panto133@otenet.gr>
Reply-To: panto133@otenet.gr
To: Dan Malek <dan@embeddededge.com>,
	Pantelis Antoniou <panto@intracom.gr>
Subject: Re: [2.5] Hang on 8xx in head_8xx.S
Date: Fri, 14 Feb 2003 23:30:59 +0200
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>,
	Tom Rini <trini@kernel.crashing.org>
References: <3E4B9D4E.7080808@intracom.gr> <3E4CF810.8040803@intracom.gr> <3E4D5209.30802@embeddededge.com>
In-Reply-To: <3E4D5209.30802@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Message-Id: <200302142330.59987.panto133@otenet.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Friday 14 February 2003 22:31, Dan Malek wrote:
> Pantelis Antoniou wrote:
> > 1. I think it is time to look into the
> > artificial (IMO) division between 8xx_io/8260_io.
> >
> > The CPM is basically the same, but there are two kind
> > of drivers for every peripheral that is common.
>
> The CPM isn't the same, especially when you look at some
> of the details.  There are reserved areas for special
> functions that are very different between the two, along
> with CPM memory configuration options (cache coherency
> options and local memory) on the 8260.
>
> If we can't make all of the drivers common, I'd prefer
> not to make any of them common.  From a far away distance,
> yes, everything looks similar, but I believe the details
> are going to make for confusing #defines/#ifdefs that you
> want to remove in some of the other drivers.
>
> Another issue I have is that when I'm working on an 8260
> driver, I don't want to worry about the impact on 8xx processors.
> If someone is working on a common driver, I also want them to
> ensure they have tested it on the other platform, and I don't
> think there are very many people able (because they don't
> have the hardware) or willing to do that.  Unfortunately,
> I have both, and I don't want to be responsible for that
> additional work prior to checking in the changes.
>

Fair enough. IMHO it is doable.
I'm currently hacking away at a 850 board, but I will shortly
have access to a 8270 based board.

As you see I'm acting out of pure self interest :-).


> > 2. The profusion of platform specific #defines in the
> > drivers. Typically something like the configuration of
> > the port I/O for the ethernet/uart whatever.
>
> That's always a trade off.  Some people like all of the
> configuration stuff together so they can easily see
> differences or be aware of configurations they can leverage
> when doing new ports/designs.  I'm not a big fan of changing
> something for the sake of personal preference.  If there is
> some development or feature advantage, that's great, but
> just because you like it one way and someone else likes it
> another without any functional improvement isn't a reason
> for change.  Since one of the goals of 2.5 is to have spilt
> out these details, it's reasonable to try that.  I find it
> interesting that other architectures are currently trying
> to go the other way, more use of common code and fewer
> platform specific directories........
>

I agree, you should not mess with something that works.
However we should strive for clarity when it is within reach.

> > How about having a platform specific source file
> > that will export functions for the platform specific
> > part of the configuration?
>
> That's a reasonable thing to do, unless you end up with
> less than 10 lines of code in a file.  Please, don't put
> such code in an include file, though.
>

Agreed.

> > How about taking a look at the patches I have sent
> > you earlier about the dpalloc/hostalloc problem?
>
> I got 'em.  There may be other things that are issues
> that may appear.
>
> Thanks.
>
>
> 	-- Dan
>

Thanks.

I forgot to mention one more thing.

The drivers are assuming that you use only one
peripheral of each kind. That is yoy have a
UART in SCC1, ethernet in SCC3 and so on.

There are some configurations that require
more than one of each kind, for example two
ethernets.

How do you think we can tackle this issue?

Regards

Pantelis

P.S. This is sent from my home account; that explains the
different email adress.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
