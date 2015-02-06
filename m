Return-Path: <ulrich.weigand@de.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75B021A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Feb 2015 01:48:39 +1100 (AEDT)
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5E4A814016A
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2015 01:48:38 +1100 (AEDT)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ulrich.weigand@de.ibm.com>;
 Fri, 6 Feb 2015 14:48:34 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id B03DA1B08070
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2015 14:48:40 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t16EmWO74391268
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Feb 2015 14:48:32 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t16EmUSL000894
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Feb 2015 07:48:32 -0700
In-Reply-To: <1422419289.9646.20.camel@neuling.org>
References: <20141203052204.9DA8F1400DD@ozlabs.org>	
 <547EB253.5050307@linux.vnet.ibm.com> <548578A8.5020901@linux.vnet.ibm.com>
 <54947C64.4030206@linux.vnet.ibm.com> <54A50094.5070902@linux.vnet.ibm.com>
 <1421883597.30744.3.camel@neuling.org>	
 <OFC6CFC348.C619B89D-ONC1257DD5.0056279B-C1257DD5.00577002@de.ibm.com>
 <1421963049.30744.23.camel@neuling.org> <1422419289.9646.20.camel@neuling.org>
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
To: Michael Neuling <mikey@neuling.org>
Message-ID: <OFE5516C3F.3C4884DE-ONC1257DE4.004E7852-C1257DE4.00514232@de.ibm.com>
From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Date: Fri, 6 Feb 2015 15:47:33 +0100
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

Michael Neuling <mikey@neuling.org> wrote on 28.01.2015 05:28:09:

> Sorry, I'm rethinking this as we didn't consider user suspended
> transactions.
>
> It makes sense for normal transactions but for user suspended
> transactions the running values are the ones you want to modify since
> that is where you'll end up restarting from.  The hardware will only
> abort/rollback once a tresume is encountered.

OK, I see.  I hadn't really looked into suspended transactions before ...

> So we could do what you're talking about for normal transactions and
> then switch them for suspended transactions.  But this just seems to be
> making the kernel interface overly complicated.

Agreed.  Given that there seems to be an inevitable difference in how
transactions are seen by the debugger between Power and z (there are
no suspended transactions on z), I guess it makes more sense to have
the interface naturally model the hardware register sets on Power,
and have GDB cope with the differences.

> So I'm keen on just keeping it the way Anshuman has now and GDB has to
> understand the program flow better to know which ones it wants to
> modify.  The kernel always provides the "normal" set as running and the
> new set as check pointed.  GDB then has to check the MSR to work out
> what it wants to modify.

So I'm thinking how this all would work out for the case of GDB wanting
to call an inferior function while the process is stopped within a
transaction (in either transactional or suspended state).

(A) In suspended state, I guess GDB could modify the "normal" register
set and ask the kernel to continue.  The kernel would then transfer
control to the inferior function entry point while still in suspended
state, and the inferior function would execute in suspended state until
it hits the GDB-placed breakpoint at the end.  At this point, GDB would
reload the original values to the "normal" register set, and ask the
kernel to continue.  The kernel would then transfer control to the
originally-interrupted piece of code in suspended state, which would
continue to execute until the tresume, at which point the transaction
would abort (due to TDOOMED).  Right?

(B) In transactional state, GDB could modify the "checkpointed" register
set and ask the kernel to continue.  The kernel would transfer control
to the originally-interrupted code in transactional state.  At this
point, the transaction would immediately abort, and control would
transfer to the state specified in the checkpointed register set,
and the inferior function would now execute in non-transactional
state, until it hits the breakpoint.  At this point, GDB would now
have to restore the original values of the *checkpointed* register
set into the *normal* register set (a bit weird from a GDB internals
perspective), and ask the kernel to continue.  Execution would now
resume at the abort handler of the originally interrupted transaction.
(Hmm.  Maybe GDB would also have to set cr0 or something?)

Is it possible for GDB to change the state (transactional vs.
suspended) where the kernel ought to let the application continue in?
I guess via modifying the appropriate MSR bits via ptrace?

If so, there would be other options to handle this:

(A') In the transactional state, GDB could set the MSR to suspended,
and modify the "normal" register set.  The inferior function would
execute in the suspended state as in (A) above.  Upon return, GDB
would restore the normal register set (including restoring the MSR
to transactional state).  Once the kernel resumes the application,
the transaction would abort at this point.

(B') In the suspended state, GDB could set the MSR to transactional,
and modify the "checkpointed" register set.  Once the kernel resumes
the application, the transaction immediately aborts and control
transfers to the inferior function, executing in nontransactional
state as in (B).  Upon return, GDB would again need to restore the
original checkpointed register set into the normal register set,
set cr0 to indicate transactional abort, and continue.


Using the combination of (A)+(A') would be easiest to implement
in GDB without modifying a lot of common code, and would have the
advantage that the inferior function always executes in the same
state (suspended), while leaving information about the interrupted
transaction visible.

Using the combination of (B)+(B') would be a bit more difficult
to implement (but certainly feasible), and would have the advantage
that the inferior function always executes in nontransactional state
(which is what it would most likely expect, anyway).  However, the
disadvantage is that after the inferior call returns, GDB is unable
to fully restore the visible inferior state as it was before (since
we're now in nontransactional state, and there is probably no way
to force us back into transactional/suspended state ...).

Am I missing something here?  Any additional thoughts?


> > > - a new ptrace register set should allow access (read-only) to the
> > >   *running* register values
> >
> > This is because changing them won't ever result in a side effect?
>
> For the same reason as above, we need to be able to modify the running
> values when it's a user suspended transaction.  So I don't agree with
> this any more in the case of user suspended transaction.  We need to be
> able to modify both sets of registers.

So I guess the kernel, on resuming the application, first loads the
checkpointed register set into normal registers, issues the trechkpt
instruction to move them to the checkpointed register, and then loads
the normal register set, before returning to user space?  Then it does
indeed appear that both sets *are* modifyable, and thus the kernel
interface should export them as such.

Bye,
Ulrich
