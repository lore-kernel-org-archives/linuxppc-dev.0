From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <msokolov@ivan.Harhan.ORG>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
Date: Thu, 11 Apr 2002 00:42:59 +0100
Message-Id: <20020410234259.7501@smtp.adsl.oleane.com>
In-Reply-To: <0204110308.AA27139@ivan.Harhan.ORG>
References: <0204110308.AA27139@ivan.Harhan.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Paul Mackerras <paulus@samba.org> wrote:
>
>> A laudable goal.  I like the idea of having each platform selected
>> with a bool rather than just having a single choice of platform.
>
>So how about pushing it into 2_4_devel?

Let's do it first in 2.5, we can backport it once we are satisfied

>> I also agree about the CONFIG_ALL_PPC name but no-one has ever been
>> able to come up with a better name for the PReP/PMac/CHRP combination.
>
>Rather than rename it, eliminate it altogether and replace it with my
>solution!

Wich is +/- what I'm doing in 2.5 though with some tweaks.

>> However, there are some aspects of the way you have done your
>> CONFIG_GENERIC_PPC32 that I don't like.
>
>So can you promise that if I change those to the way you said you'll
accept my
>patch into 2_4_devel? Without that there is no incentive for me to do
any more
>work.

Don't be in so much hurry ;) And things can be discussed, even with paulus
who is far from beeing a dictator :)

Leave me some time, I hope next week-end, I'll have everything done in
bk 2.5 for pmac/chrp/prep. Then we can see what to do, keep, change,
merge, whatever.

>> In particular I don't like
>> the list of ifdefs in setup.c.  Whenever that sort of thing appears it
>> is a sign that we need to rethink how we do things.  The old
>> drivers/net/Space.c was a classic example, and it was a mistake and it
>> basically became unmaintainable.  Fortunately we have better ways to
>> handle that sort of thing these days.  In particular we can use ELF
>> sections in creative ways to make lists of things without having to
>> have strings of ifdefs.
>
>I guess I could try to do that with ELF sections, but see above about
>incentive.

I'll do ELF sections in 2.5

>> The other thing I don't like is the bi_rec changes.  While I like the
>> idea of passing in device information in bi_recs, I really don't like
>> the use of binary tags for the various specific pieces of information
>> that we want to specify for the different devices.  This is ultimately
>> once again a maintainability concern.  Using an enumeration like that
>> basically forces us into having a central repository for assigning the
>> numbers and that is going to get us into problems down the track.
>>
>> Instead I think that both the names of the pieces of information, and
>> the values of things like the device type, should be represented as
>> strings.  Using strings just gives us orders of magnitude more
>> flexibility and extensibility, and is much more suitable for the sort
>> of decentralized and distributed development that we do.
>
>But this is not how bi_recs work. Do you want to break compatibility with the
>existing bi_recs, to add a whole new boot info mechanism independent of
>bi_recs, or what? And if I am to implement it, I need to be given some
kind of
>spec as to what to implement.

I'll keep bi_rec tags as longs, but I'll add "new" more friendly definitions
using 4 byte ASCII, keeping backward compatibility with older ones is easy.
We can still change that if we really want.

>> About the early_serial_init changes - using early_serial_init is nice
>> when the serial driver is built in, but the problem is that when the
>> serial driver is a module, we don't get given the opportunity to do
>> the early_serial_init calls between when the module is loaded and when
>> it runs rs_init.  Otherwise I would have decreed the use of
>> early_serial_init some time ago. :)
>
>On all machines I've supported so far one of the system serial ports that are
>supported in this manner is the system console and the serial driver
therefore
>has to be compiled in anyway. I don't see a problem with making a requirement
>that the serial driver be compiled in for CONFIG_GENERIC_PPC32. After all, we
>are not dealing with a PeeCee where the serial ports are an auxiliary
feature,
>we are dealing with real computers where the system serial ports are central
>system resources like on a VAX.

Well.. you forget pmac here ;)

The problem is that pmac has it's own serial HW with a different driver,
but still may need serial.o for PCI serial cards or pcmcia modems.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
