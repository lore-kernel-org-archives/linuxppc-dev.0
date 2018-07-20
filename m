Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41X23N2YzMzDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 17:05:52 +1000 (AEST)
Message-ID: <6ac334813cdc7729d1a3529b183880c2be7acddf.camel@neuling.org>
Subject: Re: [RESEND][PATCH] powerpc/powernv : Save/Restore SPRG3 on
 entry/exit from stop.
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, ego@linux.vnet.ibm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Vaidyanathan
 Srinivasan <svaidy@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,  Florian Weimer <fweimer@redhat.com>, Oleg
 Nesterov <oleg@redhat.com>
Date: Fri, 20 Jul 2018 17:05:51 +1000
In-Reply-To: <871sbya08w.fsf@concordia.ellerman.id.au>
References: <1531826849-31838-1-git-send-email-ego@linux.vnet.ibm.com>
 <1531843216-22209-1-git-send-email-ego@linux.vnet.ibm.com>
 <80bbdf47081e3e302ab5f28b5ddc9e2faabba842.camel@neuling.org>
 <20180718081249.GA17700@in.ibm.com>
 <1205bfc10c62986b4345fa258cf37e820c08226b.camel@neuling.org>
 <87tvoubpro.fsf@concordia.ellerman.id.au>
 <dd4a5526966b9b24b7eb52efadf3b9bcd4a94bd1.camel@neuling.org>
 <871sbya08w.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-07-20 at 16:29 +1000, Michael Ellerman wrote:
> Michael Neuling <mikey@neuling.org> writes:
> > On Fri, 2018-07-20 at 12:32 +1000, Michael Ellerman wrote:
> > > Michael Neuling <mikey@neuling.org> writes:
> > > > On Wed, 2018-07-18 at 13:42 +0530, Gautham R Shenoy wrote:
> > > > > On Wed, Jul 18, 2018 at 09:24:19AM +1000, Michael Neuling wrote:
> > > > > >=20
> > > > > > >  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
> > > > > > > diff --git a/arch/powerpc/kernel/idle_book3s.S
> > > > > > > b/arch/powerpc/kernel/idle_book3s.S
> > > > > > > index d85d551..5069d42 100644
> > > > > > > --- a/arch/powerpc/kernel/idle_book3s.S
> > > > > > > +++ b/arch/powerpc/kernel/idle_book3s.S
> > > > > > > @@ -120,6 +120,9 @@ power9_save_additional_sprs:
> > > > > > >  	mfspr	r4, SPRN_MMCR2
> > > > > > >  	std	r3, STOP_MMCR1(r13)
> > > > > > >  	std	r4, STOP_MMCR2(r13)
> > > > > > > +
> > > > > > > +	mfspr	r3, SPRN_SPRG3
> > > > > > > +	std	r3, STOP_SPRG3(r13)
> > > > > >=20
> > > > > > We don't need to save it.  Just restore it from paca->sprg_vdso
> > > > > > which
> > > > > > should
> > > > > > never change.
> > > > >=20
> > > > > Ok. I will respin a patch to restore SPRG3 from paca->sprg_vdso.
> > > > >=20
> > > > > >=20
> > > > > > How can we do better at catching these missing SPRGs?
> > > > >=20
> > > > > We can go through the list of SPRs from the POWER9 User Manual an=
d
> > > > > document explicitly why we don't have to save/restore certain SPR=
s
> > > > > during the execution of the stop instruction. Does this sound ok =
?
> > > > >=20
> > > > > (Ref: Table 4-8, Section 4.7.3.4 from the POWER9 User Manual
> > > > > accessible from
> > > > > https://openpowerfoundation.org/?resource_lib=3Dpower9-processor-=
users-m
> > > > > anua
> > > > > l)
> > > >=20
> > > > I was thinking of a boot time test case built into linux. linux has=
 some
> > > > boot
> > > > time test cases which you can enable via CONFIG options.
> > > >=20
> > > > Firstly you could see if an SPR exists using the same trick xmon do=
es in
> > > > dump_one_spr(). Then once you have a list of usable SPRs, you could
> > > > write
> > > > all
> > > > the known ones (I assume you'd have to leave out some, like the PSS=
CR),
> > > > then
> > > > set
> > >=20
> > > Write what value?
> > >=20
> > > Ideally you want to write a random bit pattern to reduce the chance
> > > that only some bits are being restored.
> >=20
> > The xmon dump_one_spr() trick tries to work around that by writing one
> > random
> > value and then a different one to see if it really is a nop.
> >=20
> > > But you can't do that because writing a value to an SPRs has an effec=
t.
> >=20
> > Sure that's a concern but xmon seems to get away with it.
>=20
> I don't think it writes, but maybe I'm reading the code wrong.

You're right, sorry. It's the write the GPR that becomes a NOP when the SPR=
 is
not there. I misremembered how it worked.=20

Maybe that won't work stop since we'd need to be able change the SPR value =
to
ensure we don't hit the reset value after a stop state.=20

We'd be able to detect SPRs that that change from it's reset value but not =
those
that are already at their reset value.

> Writing a random value to the MSR could be fun :)

Fortunately the MSR is not an SPR :-P

> >=20
> > Yeah, I'm not convinced it'll work either but it would be a nice piece =
of
> > test
> > infrastructure to have if it does work.
>=20
> Yeah I guess I'd rather we worked on 1) and 2) below first :)

ok

> > We'd still need to marry up the SPR numbers we get from the test to wha=
t's
> > actually being restored in Linux.
> >=20
> > > But there's a much simpler solution, we should 1) have a selftest for
> > > getcpu() and 2) we should be running the glibc (I think?) test suite
> > > that found this in the first place. It's frankly embarrassing that we
> > > didn't find this.
> >=20
> > Yeah, we should do that also, but how do we catch the next SPR we are
> > missing.
> > I'd like some systematic way of doing that rather than wack-a-mole.
>=20
> Whack-a-mole =F0=9F=98=82=F0=9F=98=82=F0=9F=98=82=F0=9F=98=82

I preferred waking them :-)

> We could also improve things by documenting how each SPR is handled, eg.
> is it saved/restored across idle, syscall, KVM etc. And possibly that
> could even become code that defines how SPRs are handled, rather than it
> all being done ad-hoc.

Yeah.  It's complicated by linux calling opal_slw_set_reg() to change what'=
s
saved. This was part of the reason I'd hoped doing a linux test case would =
help
as we could do it after those calls.

Mikey
