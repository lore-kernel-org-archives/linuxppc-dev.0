In-Reply-To: <1076044476.885.9.camel@gaston>
References: <401FE138.8080807@lycos.nl> <1075847083.17327.31.camel@gaston> <40221664.70208@lycos.nl> <1076044476.885.9.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A3B443AA-58B8-11D8-884B-000A95A0560C@us.ibm.com>
Cc: Mikolaj Krzewicki <mkrzewicki@lycos.nl>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: benh performance problem
Date: Fri, 6 Feb 2004 09:25:05 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Feb 5, 2004, at 11:14 PM, Benjamin Herrenschmidt wrote:
>
> On Thu, 2004-02-05 at 21:09, Mikolaj Krzewicki wrote:
>>
>> 2.6.1-benh1, HZ=1000: timing=36.5s
>> 2.6.1-benh1, HZ=100 : timing=32s
> The fact that pbbuttons makes a difference makes me think the
> interrupt handling is taking way too much time on your setup,
> and pbbuttons is loading the machine with PMU interrupts...

pbbuttons is loading the machine? What about all those extra
decrementer ticks? I assume benchmarks showed no performance
degradation on some class of ppc32; what was the slowest system tested?
For that matter, couldn't this hurt 4xx, 8xx(x), as well?

Perhaps HZ should be user-configurable? Although that doesn't help
distributions who'd like one kernel to work everywhere... How does
Linux handle increased HZ on old i386 anyways?

> Not sure if I can fix any of this at this point without doing a
> major rewrite of the exception handling code, I suspect those
> CPUs don't like running in real mode and our exception handling
> happens mostly in that mode in ppc32...

I didn't realize CPUs go slower in real mode..?

--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
