Message-Id: <5.1.0.14.2.20030924133835.021bf780@falcon.si.com>
Date: Wed, 24 Sep 2003 13:43:34 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: 64-bit Data Flash Access Problem [MPC8245]
In-Reply-To: <0000C657.C22236@eudoramail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


32 bit reads should be easy: reading 32 bits should cause a 64 (full width)
read since you only have one chip select and the processor will ignore the
32 bits it doesn't want.  I'm confused when you say you have only one chip
select but then say only 4 chips respond when you do a 32 bit read.  How do
the other 4 chips know _not_ to respond?

Writing is much more complicated.  If you have what you say you have, 64
bit wide flash with no provisions for selecting upper/lower, you will need
to do 64 bit write operations.  This requires a "trick": using a floating
point store operation, which is a 64 bit write.  As an alternative, you can
enable cache, do your write, and then flush the cache (also a 64 bit
write), but that is much more complex because you have the cache as an
intermediary between you and your flash and it will do things you didn't
expect it to do :-(.

gvb

At 12:04 PM 9/24/2003 -0400, nebuphilips@eudoramail.com wrote:
>
>I have a set of 8 1GB data flash chips (Samsung) on an MPC8245 Ref.
>Board. These are on a 64-bit bus-mode.
>
>-------DBUS_SIZ[0-1]:DBUS_SIZ[2] = 110b -------
>
>All 8 chips are selected by a single chip select (RCS1). Trying a
>32-bit read from the Data Address Location after giving the Command
>to Access the flash IDs, only 4 flashes on a common byte lane seem to
>be responding. 32-bit writes appear only on the DH[0-31] and not on
>DL[0-31].
>
>I am not very clear as to:
>
>(a) How do we perform writes to send out data out on
>     all 64-bits of the bus..?
>(b) How would we ideally access 64-bit data through 32-bit reads..?
>(c) Or must we *have* 64- bit read/write
>     instructions..?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
