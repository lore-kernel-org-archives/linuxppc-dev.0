Subject: Re: benh performance problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Mikolaj Krzewicki <mkrzewicki@lycos.nl>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <A3B443AA-58B8-11D8-884B-000A95A0560C@us.ibm.com>
References: <401FE138.8080807@lycos.nl> <1075847083.17327.31.camel@gaston>
	 <40221664.70208@lycos.nl> <1076044476.885.9.camel@gaston>
	 <A3B443AA-58B8-11D8-884B-000A95A0560C@us.ibm.com>
Content-Type: text/plain
Message-Id: <1076188588.27930.57.camel@gaston>
Mime-Version: 1.0
Date: Sun, 08 Feb 2004 08:16:43 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> pbbuttons is loading the machine? What about all those extra
> decrementer ticks? I assume benchmarks showed no performance
> degradation on some class of ppc32; what was the slowest system tested?
> For that matter, couldn't this hurt 4xx, 8xx(x), as well?

Heh, well, I did see any obvious degradation on my powerbook but
I didn't benchmark much actually. Maybe I should, or make kernel HZ
a config option.

> Perhaps HZ should be user-configurable? Although that doesn't help
> distributions who'd like one kernel to work everywhere... How does
> Linux handle increased HZ on old i386 anyways?

I don't know :)

> > Not sure if I can fix any of this at this point without doing a
> > major rewrite of the exception handling code, I suspect those
> > CPUs don't like running in real mode and our exception handling
> > happens mostly in that mode in ppc32...
>
> I didn't realize CPUs go slower in real mode..?

It is the case with 970's and I think with IBM G3s, I'm not sure
about Motorola G4s and other CPUs. In real mode, all memory is
treated like it has the G bit set, preventing speculation (among
others, I suppose prefetch gets killed too).

I's very visible on lmbench with a G5: The null syscall overhead
of the ppc64 kernel is lower than the one of the ppc32 kernel
despite actually running more code and saving more & bigger registers.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
