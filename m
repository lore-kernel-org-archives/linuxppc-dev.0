Message-ID: <3AF8348F.FEBF22DE@routefree.com>
Date: Tue, 08 May 2001 11:01:51 -0700
From: David Blythe <blythe@routefree.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <Pine.HPX.4.10.10105072359470.22253-100000@gra-ux1.iram.es> <3AF72CA8.52163E55@mvista.com> <03a001c0d74e$60022c70$4b00000a@foolio1> <3AF73161.26986237@mvista.com> <040a01c0d754$1bf6d5c0$4b00000a@foolio1> <3AF740C0.F65FBCB8@mvista.com> <047301c0d75c$2da00a00$4b00000a@foolio1> <3AF747C4.9C2D74A5@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:


> There may be something else wrong with the Ethernet driver itself.
> When I updated it to the 2.4_devel baseline, there were some weird
> cache management calls that didn't make sense.  My updates were to
> use the standard non-coherent cache management functions, and I
> changed the logic to make sense (to me :-).  From this quick update,
> I noticed it would be nice to make the transmit more efficient
> and higher performance by handling multiple frames, but it should
> function properly.

There are a large number of bugs in the 405 ethernet driver.  We (I)
were waiting until we had resolved this reference count problem, and had
a some workable solution to the starvation under packet floods problem
discussed a few weeks ago with other embedded processors before posting
a patch (i.e., have the driver stand up to reasonable stress tests).
Among the bugs are:

leaks of all the receive buffers, plus other memory on every device
close,
not checking for failed allocations in skb allocations,
poor choice of cache operations when manipulating buffers,
race conditions in data structure access between the rxde and rxeob
interrupt handlers

In either event we had proven to ourselves that this "reference count"
bug happened with other nic cards when used with the 405GP processor, so
we are reasonably certain that it is not specific to the 405 ethernet
driver.  As Eli mentioned ping flooding demonstrates the problem too so
we still believe that it is a generic atomic op problem.  However, we
can only make it happen on our 405GP walnut board(s) and not our
prototype 405GP board(s) (they both have rev D processors).

Just to refresh everyone's memory, the other reference count problems we
were seeing were "Freeing alive device" messages indicating the dev
reference count had gone to zero, and another one in the skb code when
ping flooding with large packet sizes (causing lots of fragments to be
generated).

	david

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
