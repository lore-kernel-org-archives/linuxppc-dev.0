From: benh@kernel.crashing.org
To: <msokolov@ivan.Harhan.ORG>, <mgreer@mvista.com>
Cc: <linux-galileo@source.mvista.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
Date: Wed, 20 Mar 2002 14:19:24 +0100
Message-Id: <20020320131924.29210@mailhost.mipsys.com>
In-Reply-To: <0203200043.AA08228@ivan.Harhan.ORG>
References: <0203200043.AA08228@ivan.Harhan.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I disagree. I don't see how a generic BI_ETH_CFG is possible. See how I've
>implemented BI_GT64260_ETH_CFG in arch/ppc/kernel/setup.c:parse_bootinfo: it
>injects the information from this record directly into the gt64260_eth
driver,
>which is where this information is needed.

This is the wrong approach. What we should do instead is have the gt eth
driver
do some kind of find_bi_rec(BI_GT64260_ETH_CFG). setup.c doesn't have to be
changed each time a new birec is added, and your approach seem wrong if
that driver ever becomes a module.

What I have not yet decided regarding what to do of birec's in 2.5.
That is either providing some structure to them so they represent devices
with all the mapping & routing information needed (flexible enough to
accomodate
most embedded needs), that is some kind of lightweight device-tree, or if
we just
stay to what we have now (minus bd_t), that is everybody defines it's own
set of
bi_recs.

I've started writing a draft of what the first option could be last year, I'll
see if I can still find it and post it for you guys to fight over some
material ;)

The _important_ point however is that the common arch code and the common
CPU code mustn't have to care (or be modified) when a bi_rec is added and
then later used by whatever driver you want to pass it to.


Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
