Date: Sat, 7 Feb 2004 09:17:48 +0000
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mikolaj Krzewicki <mkrzewicki@lycos.nl>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: benh performance problem
Message-ID: <20040207091748.A6427@mrt-lx3.iram.es>
References: <401FE138.8080807@lycos.nl> <1075847083.17327.31.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1075847083.17327.31.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 04, 2004 at 09:24:44AM +1100, Benjamin Herrenschmidt wrote:
>
> On Wed, 2004-02-04 at 04:58, Mikolaj Krzewicki wrote:
> > hi all,
> > starting 2.6.0-test9-benh3 i noticed an increased system overhead on my
> > ibook 500. Each process eats much more cpu time than in 2.4 or even
> > vanilla 2.6.
> > gkrellm takes 1% instead of 0.1, xmms 5% instead of ~1% and so on.
> > I benchmarked the lot with octave and it indeed runs ~10% slower on the
> > benh kernels.
> > I would use vanilla 2.6.1 but it won't sleep/wake correctly (at all).
> > All pre-2.6.0-test9-benh3 kernels worked fast but would't sleep/wake either.
> > I tried to isolate the patch responsible but failed.
> > Has anybody come across similar behaviour?
> > greetings, M
>
> I switched to HZ=1000, the userland procps utilities (like ps and top)
> tend to not properly deal with that, at least earlier versions, afaik.
>
> I suspect it's just display crap.

The other problem is that measuring CPU time just by sampling which
process is running at timer interrupt is a crappy method bound to be
inaccurate, espcially on very bursty workloads, or one which depend
on other frequencies which beat with the timer.

Didn't somebody implemented CPU process accounting based on the
timebase? Or was it for another architecture (maybe s390)?


	Regards,
	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
