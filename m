Message-ID: <39C77719.311C0F52@cetia.fr>
Date: Tue, 19 Sep 2000 16:24:25 +0200
From: Rigis Odeyi <rod@cetia.fr>
Reply-To: rod@cetia.fr
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Linux SMP and G3
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everybody,

I'm going to get involved into a linux project to port a linux SMP on a
dual-PPC750 box.

So before starting to do this job, I'm trying to analyse some particular
points which are quite important for G3 in SMP configuration:

First, I know that the G3 is not broadcasting the tlbie instruction
(Invalidate Entries of Translation Lookaside Buffers) on the CPU bus.
And I was happy to find a message passing mecanism emulating this
broadcast using IPI interruption (see arch/ppc/kernel/smp.c on a 2.2.15
source tree).

But it seems (perhaps I'm wrong) that the CPU initiating the broadcast
is not waiting for the full completion of the tlbie on the other CPU(s)
which may be delayed. But perhaps it is not really necessary...

Any experiences, ideas, suggestions ?

Then, the G3 is not broadcasting the icbi instruction either (Invalidate
L1 I-cache Entries). So, I was expecting the same kind of mecanism like
tlbie. But the sequences like:
	flush_cache_page() (some icbi)
	set_pte( **mark dirty** )
	flush_tlb_page() (tlbie is broadcasted)
may be enough to be sure I-caches are coherent.

Can anybody help me to become a "doubtless" guy ?

Merci,
ROD.

PS: Sorry about my poor english...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
