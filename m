From: benh@kernel.crashing.org
To: <msokolov@ivan.Harhan.ORG>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
Date: Wed, 27 Mar 2002 19:46:38 +0100
Message-Id: <20020327184638.18731@mailhost.mipsys.com>
In-Reply-To: <0203271832.AA04627@ivan.Harhan.ORG>
References: <0203271832.AA04627@ivan.Harhan.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Yeah, that's right, I messed up.  So what should be done for the nested
>ones?
>> What is we use the BI_DEVICE as a quasi-BI_FIRST and then add a BI_LAST
>to each
>> nested one?  This is what it would look like:
>
>I think the whole idea of nested bi_recs is completely unnecessary
complexity.
>A simple BI_GT64260_ETH_CFG is better.

Well, I find it pretty simple, and it helps in lots of situations, especially
when you deal with devices on the PCI bus.

The main problem I have with putting a "structure" inside one bi_rec like
BI_GT64260_ETH_CFG is that it won't evolve. I mean, let's say today, you
define it contains an HW ethernet address. Then, you figure out you have
wired your PHY directly, it's not on the MII and you need your driver to
know about it, how do you add that info ? Or you figure out that your
driver would need some tunning (different LED wiring on the PHY), you
change the structure layout to pass new parameters ?
You create unnecessary compatibility hell.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
