Return-Path: <ulrich.weigand@de.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2B541A0010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 23:54:37 +1100 (AEDT)
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8A2DB140077
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2015 23:54:36 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ulrich.weigand@de.ibm.com>;
 Wed, 18 Mar 2015 12:54:33 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4186417D8019
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2015 12:54:55 +0000 (GMT)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2ICsU5Q8126884
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2015 12:54:30 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2ICsQQW015431
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2015 06:54:29 -0600
In-Reply-To: <1424667110.16027.6.camel@neuling.org>
References: <20141203052204.9DA8F1400DD@ozlabs.org>		
 <547EB253.5050307@linux.vnet.ibm.com>
 <548578A8.5020901@linux.vnet.ibm.com> <54947C64.4030206@linux.vnet.ibm.com>
 <54A50094.5070902@linux.vnet.ibm.com>	 <1421883597.30744.3.camel@neuling.org>
 <OFC6CFC348.C619B89D-ONC1257DD5.0056279B-C1257DD5.00577002@de.ibm.com>
 <1421963049.30744.23.camel@neuling.org>	
 <1422419289.9646.20.camel@neuling.org>
 <OFE5516C3F.3C4884DE-ONC1257DE4.004E7852-C1257DE4.00514232@de.ibm.com>
 <1424667110.16027.6.camel@neuling.org>
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
To: Michael Neuling <mikey@neuling.org>
Message-ID: <OF5DE08D4B.0B79C501-ONC1257E0C.0044F80B-C1257E0C.0046DC8F@de.ibm.com>
From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Date: Wed, 18 Mar 2015 13:53:59 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
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

Michael Neuling <mikey@neuling.org> wrote on 23.02.2015 05:51:50:

> Sorry for the slow response.

Same here :-(

> Should this inferior function be run in the current mode of the
> processor?  ie if the process is currently transactional and the
> transaction aborts, should we be able to see any global state change
> because of an inferior function being run in GDB?

Inferior functions IMO should *not* run in transactional mode.
A typical inferior call is to malloc to get some memory to be used
by GDB to store data in the inferior ... you wouldn't want to call
malloc inside a transaction.

Now, whether inferior functions can run in *suspended* mode
(i.e. causing the transaction to abort after the inferior call
has returned) or have to run in nontransactional mode (aborting
the transaction befer the inferior call), I'm not sure.  Unless
there are some unexpected side effect, it seems cleaner to run
in suspended mode, since this way we can restore the state we
were in before the inferior call after the call (which is what
user would tend to expect).

On the other hand, inferior function calls do not necessarily
return.  In fact, they could throw or longjmp to some routine
higher up on the stack, in which case GDB will never get control
back.  The rest of program execution would then be done in suspended
mode (and not nontransactional mode), at least until code attempts
to start the next transaction.  Not sure if this is an issue.

> Also, if you modify the stack in suspend mode, that'll be persistent.
> So it's possible that you could corrupt your stack if you abort.  For
> example, if your tbegin is inside a function (one or more deep) that
> returns (one or more times while transactional), you need make sure you
> don't touch the stack non-transactionally if you want to be able to
> abort and not corrupt your stack.

I see.

> I think what you're proposing with running the inferior function in
> suspend mode may end up corrupting the stack in this way.  You'd need to
> be really careful to make sure the inferior function is run on the stack
> pointer of the checkpointed registers.

On the other hand, if code called a subroutine after the tbegin, if we
were using the checkpointed r1, this might corrupt the stack of the
transactional code.  (This code will never actually *run* again since
the transaction is doomed, but we can still *inspect* it in GDB after
the inferior call has returned, so the stack should remain unchanged.
Well .. if the transaction is suspended, the code might in fact still
run, so it should remain unchanged either way.)

I guess we could use the minimum of transactional and checkpointed r1
in that case, to be safe either way.

> > (A) In suspended state, I guess GDB could modify the "normal" register
> > set and ask the kernel to continue.  The kernel would then transfer
> > control to the inferior function entry point while still in suspended
> > state, and the inferior function would execute in suspended state until
> > it hits the GDB-placed breakpoint at the end.  At this point, GDB would
> > reload the original values to the "normal" register set, and ask the
> > kernel to continue.  The kernel would then transfer control to the
> > originally-interrupted piece of code in suspended state, which would
> > continue to execute until the tresume, at which point the transaction
> > would abort (due to TDOOMED).  Right?
>
> I think so.

Good.

> > (B) In transactional state, GDB could modify the "checkpointed"
register
> > set and ask the kernel to continue.  The kernel would transfer control
> > to the originally-interrupted code in transactional state.  At this
> > point, the transaction would immediately abort, and control would
> > transfer to the state specified in the checkpointed register set,
> > and the inferior function would now execute in non-transactional
> > state, until it hits the breakpoint.  At this point, GDB would now
> > have to restore the original values of the *checkpointed* register
> > set into the *normal* register set (a bit weird from a GDB internals
> > perspective), and ask the kernel to continue.  Execution would now
> > resume at the abort handler of the originally interrupted transaction.
> > (Hmm.  Maybe GDB would also have to set cr0 or something?)
>
> OK, but do we want the inferior function to be run non-transactionally?
> Should it changes be seen after the transaction aborts?

Yes, see above.

> > Is it possible for GDB to change the state (transactional vs.
> > suspended) where the kernel ought to let the application continue in?
> > I guess via modifying the appropriate MSR bits via ptrace?
>
> Yes, you can change the MSR to change the TM mode.

OK, that's good.

> > If so, there would be other options to handle this:
> >
> > (A') In the transactional state, GDB could set the MSR to suspended,
> > and modify the "normal" register set.  The inferior function would
> > execute in the suspended state as in (A) above.  Upon return, GDB
> > would restore the normal register set (including restoring the MSR
> > to transactional state).  Once the kernel resumes the application,
> > the transaction would abort at this point.
>
> This seems ok, although again, the inferior function would have side
> effects even if the transaction aborts.  Is that what we want?  Can we
> say to users that the inferior function is actually be run after the
> transaction aborts?
>
> Also, we need to be careful with the stack.

See above.

> > (B') In the suspended state, GDB could set the MSR to transactional,
> > and modify the "checkpointed" register set.  Once the kernel resumes
> > the application, the transaction immediately aborts and control
> > transfers to the inferior function, executing in nontransactional
> > state as in (B).  Upon return, GDB would again need to restore the
> > original checkpointed register set into the normal register set,
> > set cr0 to indicate transactional abort, and continue.
>
> OK.
>
> > Using the combination of (A)+(A') would be easiest to implement
> > in GDB without modifying a lot of common code, and would have the
> > advantage that the inferior function always executes in the same
> > state (suspended), while leaving information about the interrupted
> > transaction visible.
> >
> > Using the combination of (B)+(B') would be a bit more difficult
> > to implement (but certainly feasible), and would have the advantage
> > that the inferior function always executes in nontransactional state
> > (which is what it would most likely expect, anyway).  However, the
> > disadvantage is that after the inferior call returns, GDB is unable
> > to fully restore the visible inferior state as it was before (since
> > we're now in nontransactional state, and there is probably no way
> > to force us back into transactional/suspended state ...).
>
> Yep.

So right now I'd tend to prefer (A)+(A'), but the important thing is
that the kernel seems to provide all features required for GDB to
implement any of the above, so we can still make that decision later.

> Getting back to the kernel interface, are you happy with what Anshuman
> has proposed in the current series?

Given the discussion above, this seems fine to me now.

Bye,
Ulrich
