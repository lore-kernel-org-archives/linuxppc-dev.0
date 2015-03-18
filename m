Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7FAC1A0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 09:45:03 +1100 (AEDT)
Message-ID: <1426718702.4866.2.camel@neuling.org>
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
From: Michael Neuling <mikey@neuling.org>
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Date: Thu, 19 Mar 2015 09:45:02 +1100
In-Reply-To: <OF5DE08D4B.0B79C501-ONC1257E0C.0044F80B-C1257E0C.0046DC8F@de.ibm.com>
References: <20141203052204.9DA8F1400DD@ozlabs.org>
 <547EB253.5050307@linux.vnet.ibm.com>
 <548578A8.5020901@linux.vnet.ibm.com> <54947C64.4030206@linux.vnet.ibm.com>
 <54A50094.5070902@linux.vnet.ibm.com>
 <1421883597.30744.3.camel@neuling.org>
 <OFC6CFC348.C619B89D-ONC1257DD5.0056279B-C1257DD5.00577002@de.ibm.com>
 <1421963049.30744.23.camel@neuling.org>
 <1422419289.9646.20.camel@neuling.org>
 <OFE5516C3F.3C4884DE-ONC1257DE4.004E7852-C1257DE4.00514232@de.ibm.com>
 <1424667110.16027.6.camel@neuling.org>
 <OF5DE08D4B.0B79C501-ONC1257E0C.0044F80B-C1257E0C.0046DC8F@de.ibm.com>
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

On Wed, 2015-03-18 at 13:53 +0100, Ulrich Weigand wrote:
> Michael Neuling <mikey@neuling.org> wrote on 23.02.2015 05:51:50:
>=20
> > Sorry for the slow response.
>=20
> Same here :-(

I'm going to break the cycle and respond in a few hours :-)


> > I think what you're proposing with running the inferior function in
> > suspend mode may end up corrupting the stack in this way.  You'd need t=
o
> > be really careful to make sure the inferior function is run on the stac=
k
> > pointer of the checkpointed registers.
>=20
> On the other hand, if code called a subroutine after the tbegin, if we
> were using the checkpointed r1, this might corrupt the stack of the
> transactional code.  (This code will never actually *run* again since
> the transaction is doomed, but we can still *inspect* it in GDB after
> the inferior call has returned, so the stack should remain unchanged.
> Well .. if the transaction is suspended, the code might in fact still
> run, so it should remain unchanged either way.)
>=20
> I guess we could use the minimum of transactional and checkpointed r1
> in that case, to be safe either way.

Sounds good.

<snip>

> > > Using the combination of (A)+(A') would be easiest to implement
> > > in GDB without modifying a lot of common code, and would have the
> > > advantage that the inferior function always executes in the same
> > > state (suspended), while leaving information about the interrupted
> > > transaction visible.
> > >
> > > Using the combination of (B)+(B') would be a bit more difficult
> > > to implement (but certainly feasible), and would have the advantage
> > > that the inferior function always executes in nontransactional state
> > > (which is what it would most likely expect, anyway).  However, the
> > > disadvantage is that after the inferior call returns, GDB is unable
> > > to fully restore the visible inferior state as it was before (since
> > > we're now in nontransactional state, and there is probably no way
> > > to force us back into transactional/suspended state ...).
> >
> > Yep.
>=20
> So right now I'd tend to prefer (A)+(A'), but the important thing is
> that the kernel seems to provide all features required for GDB to
> implement any of the above, so we can still make that decision later.
>=20
> > Getting back to the kernel interface, are you happy with what Anshuman
> > has proposed in the current series?
>=20
> Given the discussion above, this seems fine to me now.

Great, we'll push through with this in mind.

Thanks!
Mikey
