Subject: Re: benh performance problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikolaj Krzewicki <mkrzewicki@lycos.nl>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <40221664.70208@lycos.nl>
References: <401FE138.8080807@lycos.nl> <1075847083.17327.31.camel@gaston>
	 <40221664.70208@lycos.nl>
Content-Type: text/plain
Message-Id: <1076044476.885.9.camel@gaston>
Mime-Version: 1.0
Date: Fri, 06 Feb 2004 16:14:36 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-02-05 at 21:09, Mikolaj Krzewicki wrote:

> the benchmark i used shows a speedup back to the values i'm used to.
> The benchmark itself is an octave script the execution time of which i
> tested with different kernels under similar circumstances, so here are
> the details:
>
> 2.6.1-benh1, HZ=1000: timing=36.5s
> 2.6.1-benh1, HZ=100 : timing=32s
>
> this is with X running and a lot more processes(not running).
> the weird thing is it executes slightly faster (on average) with
> pbbuttonsd off.
> The machine is g3 500 ibook, the octave script is:
>
>    tic;
>      a = abs(randn(1500, 1500)/10);
>      b = a';
>      c= a*b;
>      a = reshape(b, 750, 3000);
>      b = a';
>    timing=toc;
>
> so lots of system calls and cache flushing is in order.
>
> Mikolaj.

Well, I don't knwo what the above means, I don't talk that language
anyway :)

The fact that pbbuttons makes a difference makes me think the
interrupt handling is taking way too much time on your setup,
and pbbuttons is loading the machine with PMU interrupts...

Not sure if I can fix any of this at this point without doing a
major rewrite of the exception handling code, I suspect those
CPUs don't like running in real mode and our exception handling
happens mostly in that mode in ppc32...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
