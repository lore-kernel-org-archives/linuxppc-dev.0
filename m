Date: Thu, 27 May 1999 01:19:21 -0400 (EDT)
From: "Jason Y. Sproul" <jsproul@mail.wesleyan.edu>
Reply-To: jsproul@mail.wesleyan.edu
To: Scott Sams <sbsams@eos.ncsu.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: AWACS Bug
In-Reply-To: <374CCD26.AB2C6ADC@eos.ncsu.edu>
Message-ID: <Pine.GSO.4.05.9905270049360.18099-100000@mail.wesleyan.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 27 May 1999, Scott Sams wrote:

> Thank you for the helpful information. However, neither of the tricks
> you suggested helped me.

Wow... That sounds rather hard-core.

> Is it possible to damage the AWACS chip on the motherboard (maybe by an
> electrical surge?) and still have the machine run?

I suppose so, although it would almost certainly have to come from a source
other than the motherboard that could create a voltage across just the
AWACS without also toasting other components. Highly improbable. A simple
statistical failure of the chip itself is more likely than that, though a
short in the connections to the various outputs is possible too.

1. You mentioned checking the ports. There should be fuses on all of them,
in theory, as well as the speaker lines. Fuses burn out.

2. Instrument the AWACS driver heavily with printk()s and see if the
various settings of the control registers are actually working, or if the
chip is a total zombie.

3. If you've got a voltmeter (or, in a perfect world, an oscilloscope) try
watching the various output lines as you play sounds. Single frequencies
are best if you've got an oscilloscope that'll trigger on them. If there's
a signal there, you can probably trace the failure to another component
that might be replaceable with a bit of surgery. (Amplifier, pull-up
resistor, capacitor, wiring, something like that.) Work backwards from the
output port contacts towards the AWACS using the port specs in your user's
guide technical appendix. I assume that the AWACS clocks from the bus, but
you might want to make sure there's not an associated clock that's gone
dead. Try not to short out your entire motherboard in the process.

If the above all fail, you're probably SOL.

> I guess I will have to install a new card. Do you know of any other PCI
> sound cards that work under linuxppc on a powermac?

Not offhand. I've been meaning to explore this, but I've already got too
much going on just now. :^)

........................................................................
Jason Y. Sproul                    http://www.con.wesleyan.edu/~jsproul/
jsproul@wesleyan.edu        jsproul@iced.com        http://www.iced.com/
     Eagles may soar, but weasels don't get sucked into jet engines.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
