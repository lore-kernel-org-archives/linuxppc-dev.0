From: benh@kernel.crashing.org
To: <linuxppc-dev@lists.linuxppc.org>,
	Werner Almesberger <wa@almesberger.net>
Subject: Re: performance monitor exceptions
Date: Tue, 12 Feb 2002 13:55:01 +0100
Message-Id: <20020212125502.32396@mailhost.mipsys.com>
In-Reply-To: <20020211233730.E5079@almesberger.net>
References: <20020211233730.E5079@almesberger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>It seems to work (I had a handler there that does something a little
>more useful), but when I start kernel builds, I get a dead system
>(rebooted by hardware watchdog) within a few minutes.
>
>Instead of SIAR, I also tried SPRG0 and SPRG1, but got exactly the
>same behaviour. Time to crash varies from one to ten minutes. The
>time increases proportionally if I use TLB[19] (~200 Hz) instead.
>
>Any ideas of what I could be trampling over (or be trampled over
>by) ? This code seems rather bullet-proof to me, and I don't think
>anything else is using SIAR, or could change it while I'm using it.

A first quick look doesn't seem to show any problem with your code
I have two clues at hand:

 - I don't know how the perf. mon stuff works, but couldn't you
enter a condition were the CPU is continuously sending your the
pef monitor exception until you clear something else ?

 - I encountered a problem with the TAU stuff and the 7400 where
the CPU could actually get mixed up when getting both a normal
interrupt and a TAU exception and scew up itself (by taking both
exceptions and screwing up SRR0/1)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
