Message-ID: <3C0668DF.9000100@embeddededge.com>
Date: Thu, 29 Nov 2001 11:57:03 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: Adrian Cox <adrian@humboldt.co.uk>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_init_hwif_ports
References: <15365.51839.327359.844495@gargle.gargle.HOWL>	<3C05F807.9090806@humboldt.co.uk> <15366.8953.429603.173303@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:


> Ah, OK.  Is this the 82c105?  Are the two channels separate PCI
> functions in the device, or are they the same function?

It's part of the 83c553 bridge.  IIRC, the interrupts from the IDE
can be routed in a couple of different ways, including directly into
the EPIC.  You can kind of pretend it is a PCI-IDE controller, but there
isn't any PCI config register to read that will tell you the interrupt
number, so we need a way to tell the generic IDE code what to use (and
of course this number is suitably "faked" so it generates the proper
EPIC interrupt).  The reason you want to use this configuration mode
on the Sandpoint is because it eliminates some other interrupt
multiplexing problems and board resource conflicts.

Custom boards that don't have a regular appearance in the source tree
have copied a similar design.  I would like to vote for leaving this
interrupt mapping function in place as well.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
