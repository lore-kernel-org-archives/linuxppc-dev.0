Date: Wed, 10 Apr 02 20:08:09 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204110308.AA27139@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras <paulus@samba.org> wrote:

> A laudable goal.  I like the idea of having each platform selected
> with a bool rather than just having a single choice of platform.

So how about pushing it into 2_4_devel?

> I also agree about the CONFIG_ALL_PPC name but no-one has ever been
> able to come up with a better name for the PReP/PMac/CHRP combination.

Rather than rename it, eliminate it altogether and replace it with my solution!

> However, there are some aspects of the way you have done your
> CONFIG_GENERIC_PPC32 that I don't like.

So can you promise that if I change those to the way you said you'll accept my
patch into 2_4_devel? Without that there is no incentive for me to do any more
work.

> In particular I don't like
> the list of ifdefs in setup.c.  Whenever that sort of thing appears it
> is a sign that we need to rethink how we do things.  The old
> drivers/net/Space.c was a classic example, and it was a mistake and it
> basically became unmaintainable.  Fortunately we have better ways to
> handle that sort of thing these days.  In particular we can use ELF
> sections in creative ways to make lists of things without having to
> have strings of ifdefs.

I guess I could try to do that with ELF sections, but see above about
incentive.

> The other thing I don't like is the bi_rec changes.  While I like the
> idea of passing in device information in bi_recs, I really don't like
> the use of binary tags for the various specific pieces of information
> that we want to specify for the different devices.  This is ultimately
> once again a maintainability concern.  Using an enumeration like that
> basically forces us into having a central repository for assigning the
> numbers and that is going to get us into problems down the track.
>
> Instead I think that both the names of the pieces of information, and
> the values of things like the device type, should be represented as
> strings.  Using strings just gives us orders of magnitude more
> flexibility and extensibility, and is much more suitable for the sort
> of decentralized and distributed development that we do.

But this is not how bi_recs work. Do you want to break compatibility with the
existing bi_recs, to add a whole new boot info mechanism independent of
bi_recs, or what? And if I am to implement it, I need to be given some kind of
spec as to what to implement.

> About the early_serial_init changes - using early_serial_init is nice
> when the serial driver is built in, but the problem is that when the
> serial driver is a module, we don't get given the opportunity to do
> the early_serial_init calls between when the module is loaded and when
> it runs rs_init.  Otherwise I would have decreed the use of
> early_serial_init some time ago. :)

On all machines I've supported so far one of the system serial ports that are
supported in this manner is the system console and the serial driver therefore
has to be compiled in anyway. I don't see a problem with making a requirement
that the serial driver be compiled in for CONFIG_GENERIC_PPC32. After all, we
are not dealing with a PeeCee where the serial ports are an auxiliary feature,
we are dealing with real computers where the system serial ports are central
system resources like on a VAX.

For other hardware with similar problems but where it's unreasonable to require
compiling the driver in there are other solutions. Look for example what I did
for GT-64260 Ethernet in 2_4_alt. It's much like serial in that there is a
generic driver, the device is fairly peripheral and should be supported as a
module (even though it currently isn't, but never mind), but the driver needs
certain info that has to be provided by the board ports. There I have a table
like rs_table called gt64260_eth_config which itself lives not in the
gt64260_eth driver, but in arch/ppc/kernel/gt64260_data.c. This table is
therefore always present whether the gt64260_eth driver is present or not, and
it is always filled in by <board>_setup_arch. Then when/if the gt64260_eth
driver initializes, whether compiled-in or as a module, it uses the info in
that table that must be in the kernel.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
