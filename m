From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15894.4788.289339.561234@argo.ozlabs.ibm.com>
Date: Sat, 4 Jan 2003 09:46:12 +1100
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel patch: 8xx FEC extensions
In-Reply-To: <3E10EF1C.5040505@embeddededge.com>
References: <20021230162621.1741CC6139@atlas.denx.de>
	<3E10EF1C.5040505@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> It needs to be volatile as a means of synchronization between the interrupt
> handler that will set the flags and a normal thread of execution that will
> test them.  The normal thread would cache a value in a register and never
> look at any updates that occurred as part of an interrupt.

If we have a variable which is being updated both by the mainline and
an interrupt handler, then we should be using some explicit
synchronization (e.g. disabling interrupts around the region where we
do the update) or else we should be using atomic operations.  Just
declaring it volatile is *not* enough, because, clearly, something
like "a &= ~1;" in the mainline will do a load and a store and that
will create a window where an update done by an interrupt handler will
get ignored.

In general we should have a spinlock and do spin_lock_irqsave /
spin_unlock_irqrestore around the update.  If the code will never be
used on an SMP system then we can reduce that to save_flags/cli and
restore_flags.

Note that __cli et al. include a gcc memory barrier precisely because
they are often used to protect accesses to variables that are accessed
both by mainline and interrupt-level code.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
