Message-ID: <3CA8A96D.9040309@embeddededge.com>
Date: Mon, 01 Apr 2002 13:39:41 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <0203210213.AA15856@ivan.Harhan.ORG>	<3C99801A.8070002@embeddededge.com> <15526.51621.991410.781713@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> I don't particularly like the way we define what is on a given
> embedded board with what boils down to a shell script.

Why single out embedded boards?

> What I would like to see is a readable, compact, clear description of
> the hardware (for a given embedded board) in one place,

One of my peeves is all I have ever done with Linux is embedded boards,
for many years, no one seemed to care what I thought would make it
easier, and recently people that have little experience with them
now seem to want to solve all of the problems in one weekend :-).

I'm all for making it better, but I have yet to see anything that
really does.  Everyone has an opinion, few people will ever agree
on the single solution, and all we seem to be doing is swapping
one equally successful (or poor) solution for another.  It's different,
but not better.

> 1. Derive a set of config option values (or recommendations for those
>    values, at least) for including the necessary kernel drivers to
>    support the devices on the board.

The interdependencies among the resources on an intergrated processor
often require cooperation among drivers.  Oh you could probably remove
a few #ifdefs and replace it with addtional overhead of some generic
function calls.  Now, you have moved a few ifdefs into a "common" place,
but along with that you also moved the mental context of the code.
Rather than describing and implementing in the place where I can
understand it (the driver itself), I have to look someplace else and
remember why I am looking there.

> 2. Make a list of devices and the information that their drivers will
>    need about them, such as register base addresses, interrupt
>    assignments, etc., for inclusion in the kernel.

For PowerPC (well, 8xx anyway, I don't know what 4xx looks like these days)
all of this stuff is already defined in a board description configuration
file or in the generic processor files.  IMHO, it isn't going to get
any better than this (and it seems sufficient for other processors).

> 3. Make such a list for inclusion in a bootloader so that it can
>    supply it to the kernel, for people who aren't so worried about the
>    size of their kernels and who want to be able to use the same
>    kernel binary on several different boards.

Bleh.....You have to compile the kernel anyway, why bother complicating
everything by passing information through the bootloader?  We have gone
around and around with this "common binary" before.  How come once we
decide to go one direction (no common binaries), we now have to expend
energy going the other direction again?  Not long ago even you argued
for separate binaries, what happened? (change of business pressure? :-)


> The idea of 2 (and 3) is to make it easy for drivers to find out how
> many instances of their device exist,

For embedded boards you know this at compile/config time, especially
in a production environment.  It only takes a few seconds to rebuild a
kernel these days, so just do it.  Lots of this flexibility was nicer
a half dozen years ago when it took an hour to build a kernel.

> For the situations where every byte is precious,....

Surprisingly, there are still many systems that care about this, and
I'm still trying to understand how a dynamic and complex boot/driver
interface is going to be better than something well defined at compile
time with a trivial boot interface.

> For the situations where every byte is precious, we could get a little
> cleverer and have preprocessing code....

Why have all of this complexity?  For people that understand these
processors and are actively using them, a few #ifdefs and configuration
scripts work just fine.  If you don't understand how the peripherals
interact, share processor resources, and the driver implementations operate,
I don't believe you can guide any configuration tool to the proper
results.

Rather rewrite drivers for the sake of removing some #ifdefs, let's write
a smart configuration tool that understands how to select the proper #ifdefs
and build the kernel.  I thought we were headed this way with CML-2?

I would like to make it better, but making sweeping statements about
a "hardware description" that is going to make my life better doesn't cut it.
The devil is in the details, and unless you live those everyday to see
how people are developing software for real products I don't understand
how you can appreciate these suggestions.

I work on lots of processor and projects other than PowerPC, so I get
to see alternatives to what is done here.  It's interesting how some of
those better ideas are met with such resistance here, in particular if
I have to modify something related to a workstation platform :-).  IMHO,
there are many more important technical challenges to solve than worrying
about replacing some #ifdefs with a complex configuration process.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
