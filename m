Message-ID: <39D84FB8.CDDDA9AD@mvista.com>
Date: Mon, 02 Oct 2000 05:04:56 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: frowand@mvista.com,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <19340822040932.8760@mailhost.mipsys.com>
		<Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home>
		<14803.57550.118150.759977@argo.linuxcare.com.au>
		<39D41AA2.C586D738@mvista.com>
		<14804.7238.688771.238444@argo.linuxcare.com.au>
		<39D4E85F.926CFD5B@mvista.com>
		<14805.17492.766815.388301@argo.linuxcare.com.au>
		<39D66E4D.4364FC8B@mvista.com>
		<39D68EB8.4CAD5168@mvista.com>
		<14806.62164.27906.255635@argo.linuxcare.com.au>
		<39D7ACEC.D8E572DE@mvista.com> <14807.49063.358772.190447@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> Now, are those addresses physical or virtual?

Both.  They get mapped 1:1 in the mmu initialization, ioremap, and
work while the mmu is disabled.  Simple, easy, debuggers work, everyone
is happy.

> ... If you are saying "but we have device registers at
> physical address 0xff000000" my response is "so why is that a
> problem?".

Because you are taking something that works just fine and complicating
it for me without adding any value.  The whole PCI subsystem
implementation
needs lots of work, and adding a little VM mapping doesn't solve much
of the problem.  This is probably a bad time for me to comment on this
because I am trying to get a PPC750 cPCI board running with 2.4.  It
worked great in a 2.2 kernel, with all of its multiple bridges and Prep
memory map.  It does the same stupid thing as a PMac right now, claiming
everything is a mapping collision and you can't get there from here.
The interrupt routing is all screwed up as well.  There were a bunch of
PCI updates from Matt Porter in the 2.2 kernel for this, and I
don't know why they didn't make it into 2.4.  I suspect if they did
we could utilize it for PMacs too and just get on with life.

Yeah, I can add more code to head.S, have multiple mappings for the
same thing, and add more "fixup" functions for those places where it
has to be adjusted during the initialization.  The kernel is bigger,
executing more code, and making it more complicated for others to
understand....just so I can map my PCI like a PMac.....

I've had enough of PCI for today.  Maybe after I sleep on this for
a few hours I'll see the light :-).

Oh....and then there is his CONFIG_ALL_PPC thing.....


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
