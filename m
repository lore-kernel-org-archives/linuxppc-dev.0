Message-ID: <4022BAB8.2060707@lycos.nl>
Date: Thu, 05 Feb 2004 22:50:48 +0100
From: Mikolaj Krzewicki <mkrzewicki@lycos.nl>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Cc: benh@kernel.crashing.org
Subject: Re: benh performance problem
References: <401FE138.8080807@lycos.nl> <1075847083.17327.31.camel@gaston>
In-Reply-To: <1075847083.17327.31.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Wed, 2004-02-04 at 04:58, Mikolaj Krzewicki wrote:
>
>>> hi all,
>>> starting 2.6.0-test9-benh3 i noticed an increased system overhead on my
>>> ibook 500. Each process eats much more cpu time than in 2.4 or even
>>> vanilla 2.6.
>>> gkrellm takes 1% instead of 0.1, xmms 5% instead of ~1% and so on.
>>> I benchmarked the lot with octave and it indeed runs ~10% slower on the
>>> benh kernels.
>>> I would use vanilla 2.6.1 but it won't sleep/wake correctly (at all).
>>> All pre-2.6.0-test9-benh3 kernels worked fast but would't sleep/wake either.
>>> I tried to isolate the patch responsible but failed.
>>> Has anybody come across similar behaviour?
>>> greetings, M
>
>
> I switched to HZ=1000, the userland procps utilities (like ps and top)
> tend to not properly deal with that, at least earlier versions, afaik.
>
> I suspect it's just display crap.
>
> Alos, you can find a more recent kernel than that  My bk tree is
> currently at 2.6.2-rc3-ben1
>
> Ben.

i tested 2.6.1-benh1 now with HZ=100
the benchmark i used shows a speedup back to the values i'm used to.
The benchmark itself is an octave script the execution time of which i
tested with different kernels under similar circumstances, so here are
the details:

2.6.1-benh1, HZ=1000: timing=36.5s
2.6.1-benh1, HZ=100 : timing=32s

this is with X running and a lot more processes(not running).
the weird thing is it executes slightly faster (on average) with
pbbuttonsd off.
The machine is g3 500 ibook, the octave script is:

   tic;
     a = abs(randn(1500, 1500)/10);
     b = a';
     c= a*b;
     a = reshape(b, 750, 3000);
     b = a';
   timing=toc;

so lots of system calls and cache flushing is in order.

Mikolaj.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
