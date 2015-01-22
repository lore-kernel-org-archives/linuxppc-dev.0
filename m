Return-Path: <ulrich.weigand@de.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 729651A0E81
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 02:55:36 +1100 (AEDT)
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 58222140182
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2015 02:55:35 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ulrich.weigand@de.ibm.com>;
 Thu, 22 Jan 2015 15:55:31 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id CC4E817D8056
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2015 15:55:32 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0MFtUCS53411854
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2015 15:55:30 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0MFtSGx004436
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2015 08:55:30 -0700
In-Reply-To: <1421883597.30744.3.camel@neuling.org>
References: <20141203052204.9DA8F1400DD@ozlabs.org>	
 <547EB253.5050307@linux.vnet.ibm.com> <548578A8.5020901@linux.vnet.ibm.com>
 <54947C64.4030206@linux.vnet.ibm.com> <54A50094.5070902@linux.vnet.ibm.com>
 <1421883597.30744.3.camel@neuling.org>
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
To: Michael Neuling <mikey@neuling.org>
Message-ID: <OFC6CFC348.C619B89D-ONC1257DD5.0056279B-C1257DD5.00577002@de.ibm.com>
From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Date: Thu, 22 Jan 2015 16:55:03 +0100
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

Michael Neuling <mikey@neuling.org> wrote on 22.01.2015 00:39:57:
> On Thu, 2015-01-01 at 13:38 +0530, Anshuman Khandual wrote:
> > On 12/20/2014 12:58 AM, Edjunior Barbosa Machado wrote:
> > > The patchset seems to change the "original" ptrace requests (i.e.
> > > PTRACE_GETREGS/GETFPREGS/GETVRREGS...) to return the
> > > "transactional" state, and adds new register sets to return
> > > the "checkpointed" state.  Considering that whenever you get
> > > a debugger interception inside a transactional block, the
> > > transaction will abort, we're wondering if it wouldn't make
> > > more sense to display the 'checkpointed' state as the normal
> > > registers since this is where the execution will continue from.
> >
> > Debugger interception (trace interrupt) in between any transaction
> > block will abort it ? I doubt that.
>
> The trace interrupt will not abort the transaction explicitly...
>
> > The tracee process will just stop, it's context gets saved in the
> > kernel so that it can again start executing from the exact same
> > point onward when it resumes.
>
> ... unfortunately, this save *will* doom the transaction.  To save, a
> treclaim instruction is run which will always explicitly doom the
> transaction.
>
> > If this happens when inside any transaction block, the transaction's
running
> > context and check pointed context will get saved. The execution
> > will again start from the running context values instead of check
> > pointed when the process resumes. Check pointed values will be loaded
> > back into the context when the transaction finishes.
>
> Although since the transaction has been explicitly doomed, the hardware
> will *always* abort at this point and start execution from the
> checkpointed values.
>
> > Inside transaction both running and check pointed values can be
> > probed independently.
>
> Yep, that's the idea, although setting the running values won't change
> anything since the the translation is already doomed and will abort once
> the cpu starts executing it.

So this looks to me like the overall effect on debugging transactional
code should be the same on Power and z, even if some internal details
are different (on z, the exception will automatically abort the
transaction; on p, the exception itself will not abort, but *restarting*
user space execution will).

>From a GDB perspective, it would therefore be preferable if the ptrace
interface were to behave in a similar fashion on p as on z: that is,
if an exception interrupting a transaction results in a ptrace intercept,
at this point:

- the "normal" ptrace register set commands should access the
  *checkpointed* registers (allowing both read and write access)

  -- GDB will use this to display current position (already reflecting
  the fact that the transaction will abort), and use it when changing
  register values e.g. to effect an inferior function call

- a new ptrace register set should allow access (read-only) to the
  *running* register values

  -- GDB can use this to display the position inside the transaction
  at the point it aborted, using new transaction-specific commands


Bye,
Ulrich
