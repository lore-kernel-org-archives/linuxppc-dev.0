Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8AF181A0157
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 15:28:09 +1100 (AEDT)
Message-ID: <1422419289.9646.20.camel@neuling.org>
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
From: Michael Neuling <mikey@neuling.org>
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Date: Wed, 28 Jan 2015 15:28:09 +1100
In-Reply-To: <1421963049.30744.23.camel@neuling.org>
References: <20141203052204.9DA8F1400DD@ozlabs.org>
 <547EB253.5050307@linux.vnet.ibm.com> <548578A8.5020901@linux.vnet.ibm.com>
 <54947C64.4030206@linux.vnet.ibm.com> <54A50094.5070902@linux.vnet.ibm.com>
 <1421883597.30744.3.camel@neuling.org>
 <OFC6CFC348.C619B89D-ONC1257DD5.0056279B-C1257DD5.00577002@de.ibm.com>
 <1421963049.30744.23.camel@neuling.org>
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

On Fri, 2015-01-23 at 08:44 +1100, Michael Neuling wrote:
> > > > Inside transaction both running and check pointed values can be
> > > > probed independently.
> > >
> > > Yep, that's the idea, although setting the running values won't chang=
e
> > > anything since the the translation is already doomed and will abort o=
nce
> > > the cpu starts executing it.
> >=20
> > So this looks to me like the overall effect on debugging transactional
> > code should be the same on Power and z, even if some internal details
> > are different (on z, the exception will automatically abort the
> > transaction; on p, the exception itself will not abort, but *restarting=
*
> > user space execution will).
>=20
> Yep
>=20
> > From a GDB perspective, it would therefore be preferable if the ptrace
> > interface were to behave in a similar fashion on p as on z: that is,
> > if an exception interrupting a transaction results in a ptrace intercep=
t,
> > at this point:
>=20
> Agreed.
>=20
> > - the "normal" ptrace register set commands should access the
> >   *checkpointed* registers (allowing both read and write access)
>=20
> OK, this is a change from what we've been proposing with Anshuman's
> patch set but I'm happy to change it to make it consistent with other
> architectures.  It's relatively arbitrary which goes where, so I'm happy
> to change.
>=20
> >   -- GDB will use this to display current position (already reflecting
> >   the fact that the transaction will abort), and use it when changing
> >   register values e.g. to effect an inferior function call
>=20
> "Current position" depends on your perspective.  Is it the last executed
> instruction or the next executed instruction?  If it's the last executed
> instruction, then it's the running values.  If it's the next, then it's
> the check pointed. =20
>=20
> Anyway, I'm happy to make it the check pointed values for the sake of
> ptrace/gdb.

Uli,

Sorry, I'm rethinking this as we didn't consider user suspended
transactions.

It makes sense for normal transactions but for user suspended
transactions the running values are the ones you want to modify since
that is where you'll end up restarting from.  The hardware will only
abort/rollback once a tresume is encountered.
      *=20
So we could do what you're talking about for normal transactions and
then switch them for suspended transactions.  But this just seems to be
making the kernel interface overly complicated. =20

So I'm keen on just keeping it the way Anshuman has now and GDB has to
understand the program flow better to know which ones it wants to
modify.  The kernel always provides the "normal" set as running and the
new set as check pointed.  GDB then has to check the MSR to work out
what it wants to modify.

> > - a new ptrace register set should allow access (read-only) to the
> >   *running* register values
>=20
> This is because changing them won't ever result in a side effect? =20

For the same reason as above, we need to be able to modify the running
values when it's a user suspended transaction.  So I don't agree with
this any more in the case of user suspended transaction.  We need to be
able to modify both sets of registers.

Mikey
