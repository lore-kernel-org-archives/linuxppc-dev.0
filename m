Message-ID: <3CEC6019.8060700@embeddededge.com>
Date: Wed, 22 May 2002 23:20:57 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Nate Pletcher <pletch@po.cwru.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: using cpm interrupts on 8xx
References: <1022079528.1226.15.camel@soundgarden>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Nate Pletcher wrote:


> ...  Do I need to register a handler for the SIU
> interrupt for the CPM and then another handler for the individual IDMA
> interrupt from the CPM?

All you need to do is use cpm_install_handler() for the IDMA interrupt.

> The interrupt hardware on the 8xx is multilevel (CPM interrupts
> multiplexed into SIU) so it seems that both functions would be
> necessary.

The cpm initialization installs the SIU interrupt handler, so don't
worry about that one.

> ....  What do I need to do myself and what is
> provided by the request_/free_irq interface?

For your IDMA device all you need to do is cpm_install_handler()/cpm_free_handler().


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
