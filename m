Message-ID: <3817A76D.6C22F219@jlc.net>
Date: Wed, 27 Oct 1999 21:31:25 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RevD iMac USB errors (was Problems compiling ppc kernels)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just an update......

My iMac has the Lucent USS-302 OHCI host controller.  I discovered
that in ohci_host_init(), just before the "clear interrupt routing
and reset", it is in the suspended state.

If I change the control register to operational at this point, then
go through the reset and initialization that follows, all of my
timeout messages disappear.

After the first device attachment message, I get several "Ran out of
hub queuing slots" messages.  I later get the "....protocol 1.16" message
that I have patched out, and finally detect the hub on port 0.  I
don't get any messages about devices connected to the hub.

This same kernel boots just find on my "old" iMac, so I want to assume
the trouble is with the host controller.  Swapping keyboards (which is
weird because of different colors :-), results in the old "old" iMac
still working, while the "new" old iMac still failing.....further
pointing to the host controller.

That's all from me tonight....time to go and watch South Park :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
