Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E3641A0BC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 15:51:51 +1100 (AEDT)
Message-ID: <1424667110.16027.6.camel@neuling.org>
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
From: Michael Neuling <mikey@neuling.org>
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Date: Mon, 23 Feb 2015 15:51:50 +1100
In-Reply-To: <OFE5516C3F.3C4884DE-ONC1257DE4.004E7852-C1257DE4.00514232@de.ibm.com>
References: <20141203052204.9DA8F1400DD@ozlabs.org>
 <547EB253.5050307@linux.vnet.ibm.com>
 <548578A8.5020901@linux.vnet.ibm.com> <54947C64.4030206@linux.vnet.ibm.com>
 <54A50094.5070902@linux.vnet.ibm.com>
 <1421883597.30744.3.camel@neuling.org>
 <OFC6CFC348.C619B89D-ONC1257DD5.0056279B-C1257DD5.00577002@de.ibm.com>
 <1421963049.30744.23.camel@neuling.org>
 <1422419289.9646.20.camel@neuling.org>
 <OFE5516C3F.3C4884DE-ONC1257DE4.004E7852-C1257DE4.00514232@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: shuahkh@osg.samsung.com, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, dhowells@redhat.com, linuxppc-dev@ozlabs.org,
 kirjanov@gmail.com, tglx@linutronix.de, oleg@redhat.com,
 sukadev@linux.vnet.ibm.com, davej@redhat.com, akpm@linux-foundation.org,
 palves@redhat.com, Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
 sam.bobroff@au1.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Uli,

Sorry for the slow response.

> Michael Neuling <mikey@neuling.org> wrote on 28.01.2015 05:28:09:
>=20
> > Sorry, I'm rethinking this as we didn't consider user suspended
> > transactions.
> >
> > It makes sense for normal transactions but for user suspended
> > transactions the running values are the ones you want to modify since
> > that is where you'll end up restarting from.  The hardware will only
> > abort/rollback once a tresume is encountered.
>=20
> OK, I see.  I hadn't really looked into suspended transactions before ...
>
> > So we could do what you're talking about for normal transactions and
> > then switch them for suspended transactions.  But this just seems to be
> > making the kernel interface overly complicated.
>=20
> Agreed.  Given that there seems to be an inevitable difference in how
> transactions are seen by the debugger between Power and z (there are
> no suspended transactions on z), I guess it makes more sense to have
> the interface naturally model the hardware register sets on Power,
> and have GDB cope with the differences.
>
> > So I'm keen on just keeping it the way Anshuman has now and GDB has to
> > understand the program flow better to know which ones it wants to
> > modify.  The kernel always provides the "normal" set as running and the
> > new set as check pointed.  GDB then has to check the MSR to work out
> > what it wants to modify.
>=20
> So I'm thinking how this all would work out for the case of GDB wanting
> to call an inferior function while the process is stopped within a
> transaction (in either transactional or suspended state).

Should this inferior function be run in the current mode of the
processor?  ie if the process is currently transactional and the
transaction aborts, should we be able to see any global state change
because of an inferior function being run in GDB? =20

Also, if you modify the stack in suspend mode, that'll be persistent.
So it's possible that you could corrupt your stack if you abort.  For
example, if your tbegin is inside a function (one or more deep) that
returns (one or more times while transactional), you need make sure you
don't touch the stack non-transactionally if you want to be able to
abort and not corrupt your stack.

I think what you're proposing with running the inferior function in
suspend mode may end up corrupting the stack in this way.  You'd need to
be really careful to make sure the inferior function is run on the stack
pointer of the checkpointed registers. =20

We do something like this in the kernel when laying out a signal frame
on the user stack when the user is transactional.  We lay it out on the
checkpointed stack pointer/r1.  (The best way for users to avoid this
problem is to use sigaltstack() but we can't rely on that).

> (A) In suspended state, I guess GDB could modify the "normal" register
> set and ask the kernel to continue.  The kernel would then transfer
> control to the inferior function entry point while still in suspended
> state, and the inferior function would execute in suspended state until
> it hits the GDB-placed breakpoint at the end.  At this point, GDB would
> reload the original values to the "normal" register set, and ask the
> kernel to continue.  The kernel would then transfer control to the
> originally-interrupted piece of code in suspended state, which would
> continue to execute until the tresume, at which point the transaction
> would abort (due to TDOOMED).  Right?

I think so.

> (B) In transactional state, GDB could modify the "checkpointed" register
> set and ask the kernel to continue.  The kernel would transfer control
> to the originally-interrupted code in transactional state.  At this
> point, the transaction would immediately abort, and control would
> transfer to the state specified in the checkpointed register set,
> and the inferior function would now execute in non-transactional
> state, until it hits the breakpoint.  At this point, GDB would now
> have to restore the original values of the *checkpointed* register
> set into the *normal* register set (a bit weird from a GDB internals
> perspective), and ask the kernel to continue.  Execution would now
> resume at the abort handler of the originally interrupted transaction.
> (Hmm.  Maybe GDB would also have to set cr0 or something?)

OK, but do we want the inferior function to be run non-transactionally?
Should it changes be seen after the transaction aborts? =20

> Is it possible for GDB to change the state (transactional vs.
> suspended) where the kernel ought to let the application continue in?
> I guess via modifying the appropriate MSR bits via ptrace?

Yes, you can change the MSR to change the TM mode.

> If so, there would be other options to handle this:
>=20
> (A') In the transactional state, GDB could set the MSR to suspended,
> and modify the "normal" register set.  The inferior function would
> execute in the suspended state as in (A) above.  Upon return, GDB
> would restore the normal register set (including restoring the MSR
> to transactional state).  Once the kernel resumes the application,
> the transaction would abort at this point.

This seems ok, although again, the inferior function would have side
effects even if the transaction aborts.  Is that what we want?  Can we
say to users that the inferior function is actually be run after the
transaction aborts?

Also, we need to be careful with the stack. =20

> (B') In the suspended state, GDB could set the MSR to transactional,
> and modify the "checkpointed" register set.  Once the kernel resumes
> the application, the transaction immediately aborts and control
> transfers to the inferior function, executing in nontransactional
> state as in (B).  Upon return, GDB would again need to restore the
> original checkpointed register set into the normal register set,
> set cr0 to indicate transactional abort, and continue.

OK.

> Using the combination of (A)+(A') would be easiest to implement
> in GDB without modifying a lot of common code, and would have the
> advantage that the inferior function always executes in the same
> state (suspended), while leaving information about the interrupted
> transaction visible.
>=20
> Using the combination of (B)+(B') would be a bit more difficult
> to implement (but certainly feasible), and would have the advantage
> that the inferior function always executes in nontransactional state
> (which is what it would most likely expect, anyway).  However, the
> disadvantage is that after the inferior call returns, GDB is unable
> to fully restore the visible inferior state as it was before (since
> we're now in nontransactional state, and there is probably no way
> to force us back into transactional/suspended state ...).

Yep.

> Am I missing something here?  Any additional thoughts?
>
> > > > - a new ptrace register set should allow access (read-only) to the
> > > >   *running* register values
> > >
> > > This is because changing them won't ever result in a side effect?
> >
> > For the same reason as above, we need to be able to modify the running
> > values when it's a user suspended transaction.  So I don't agree with
> > this any more in the case of user suspended transaction.  We need to be
> > able to modify both sets of registers.
>=20
> So I guess the kernel, on resuming the application, first loads the
> checkpointed register set into normal registers, issues the trechkpt
> instruction to move them to the checkpointed register, and then loads
> the normal register set, before returning to user space? =20

Correct.

> Then it does
> indeed appear that both sets *are* modifyable, and thus the kernel
> interface should export them as such.

Correct.

Getting back to the kernel interface, are you happy with what Anshuman
has proposed in the current series?

Regards,
Mikey
