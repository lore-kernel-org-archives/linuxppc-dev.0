Message-ID: <3A634565.ED2F77C6@mvista.com>
Date: Mon, 15 Jan 2001 13:45:57 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Timothy Ritchey <tritchey@vacuumgenesis.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kswapd Oops
References: <3A625423.E0F6C9AC@vacuumgenesis.com> <3A628C9B.489E401A@mvista.com> <3A633075.5952B4C0@vacuumgenesis.com> <3A6331BF.FB53A3FF@mvista.com> <3A6342EA.DEA7FA9B@vacuumgenesis.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Timothy Ritchey wrote:

> That is what I figured, although I had to make some changes to get the
> FEC driver to compile

Hmmm...you may have grabbed something a little old.  I would suggest
starting with the Embedded Planet "CLLF" LSP.

> > Are you including the software work arounds for the CPU6 silicon
> > errata?
>
> yes

Although it shouldn't be causing the trouble, there is/was a bug
in the code with this option enabled.  Check the file
arch/ppc/kernel/head.S and make sure the 'cpu6_bug' buffer is
declared '.space 16' instead of '.space 4'.

> ARRRGGGGHHH. You can't imagine how much this pains me. Well.... perhaps
> you can :)

Yes, I can.  You are not the first to see this and won't be the
last.  I have been very fortunate to work with some awesome hardware
engineers in the past, where the the first round of hardware had
high speed logic connectors to the processor bus.  The MPC8xx
memory controller can do some pretty weird things, all legitimate
and logical, and not something you will comprehend from reading
the manual.  You have to see it in action, especially when running Linux.

> .... I am going to disable everything I can WRT caches, etc. and
> see if it clears up.

Another thing to test is setting burst inhibit in the ORx for the DRAM.
This will prevent the CPM DMA from generating burst cycles as well.
Most people can get the single cycle memory operations working because
the timing isn't as critical and there is lots of overhead so a few
wasted clock cycles are seldom noticed.  Burst mode has to be perfect.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
