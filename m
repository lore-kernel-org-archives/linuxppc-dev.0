Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WwBj2XKqzDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 12:41:49 +1000 (AEST)
Message-ID: <dd4a5526966b9b24b7eb52efadf3b9bcd4a94bd1.camel@neuling.org>
Subject: Re: [RESEND][PATCH] powerpc/powernv : Save/Restore SPRG3 on
 entry/exit from stop.
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, ego@linux.vnet.ibm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Vaidyanathan
 Srinivasan <svaidy@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,  Florian Weimer <fweimer@redhat.com>, Oleg
 Nesterov <oleg@redhat.com>
Date: Fri, 20 Jul 2018 12:41:48 +1000
In-Reply-To: <87tvoubpro.fsf@concordia.ellerman.id.au>
References: <1531826849-31838-1-git-send-email-ego@linux.vnet.ibm.com>
 <1531843216-22209-1-git-send-email-ego@linux.vnet.ibm.com>
 <80bbdf47081e3e302ab5f28b5ddc9e2faabba842.camel@neuling.org>
 <20180718081249.GA17700@in.ibm.com>
 <1205bfc10c62986b4345fa258cf37e820c08226b.camel@neuling.org>
 <87tvoubpro.fsf@concordia.ellerman.id.au>
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

On Fri, 2018-07-20 at 12:32 +1000, Michael Ellerman wrote:
> Michael Neuling <mikey@neuling.org> writes:
> > On Wed, 2018-07-18 at 13:42 +0530, Gautham R Shenoy wrote:
> > > On Wed, Jul 18, 2018 at 09:24:19AM +1000, Michael Neuling wrote:
> > > >=20
> > > > >  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
> > > > > diff --git a/arch/powerpc/kernel/idle_book3s.S
> > > > > b/arch/powerpc/kernel/idle_book3s.S
> > > > > index d85d551..5069d42 100644
> > > > > --- a/arch/powerpc/kernel/idle_book3s.S
> > > > > +++ b/arch/powerpc/kernel/idle_book3s.S
> > > > > @@ -120,6 +120,9 @@ power9_save_additional_sprs:
> > > > >  	mfspr	r4, SPRN_MMCR2
> > > > >  	std	r3, STOP_MMCR1(r13)
> > > > >  	std	r4, STOP_MMCR2(r13)
> > > > > +
> > > > > +	mfspr	r3, SPRN_SPRG3
> > > > > +	std	r3, STOP_SPRG3(r13)
> > > >=20
> > > > We don't need to save it.  Just restore it from paca->sprg_vdso whi=
ch
> > > > should
> > > > never change.
> > >=20
> > > Ok. I will respin a patch to restore SPRG3 from paca->sprg_vdso.
> > >=20
> > > >=20
> > > > How can we do better at catching these missing SPRGs?
> > >=20
> > > We can go through the list of SPRs from the POWER9 User Manual and
> > > document explicitly why we don't have to save/restore certain SPRs
> > > during the execution of the stop instruction. Does this sound ok ?
> > >=20
> > > (Ref: Table 4-8, Section 4.7.3.4 from the POWER9 User Manual
> > > accessible from
> > > https://openpowerfoundation.org/?resource_lib=3Dpower9-processor-user=
s-manua
> > > l)
> >=20
> > I was thinking of a boot time test case built into linux. linux has som=
e
> > boot
> > time test cases which you can enable via CONFIG options.
> >=20
> > Firstly you could see if an SPR exists using the same trick xmon does i=
n
> > dump_one_spr(). Then once you have a list of usable SPRs, you could wri=
te
> > all
> > the known ones (I assume you'd have to leave out some, like the PSSCR),=
 then
> > set
>=20
> Write what value?
>=20
> Ideally you want to write a random bit pattern to reduce the chance
> that only some bits are being restored.

The xmon dump_one_spr() trick tries to work around that by writing one rand=
om
value and then a different one to see if it really is a nop.

> But you can't do that because writing a value to an SPRs has an effect.

Sure that's a concern but xmon seems to get away with it.

> Some of them might even need to be zero, in which case you can't really
> distinguish that from a non-restored zero.

It doesn't need to be perfect. It just needs to catch more than we have now=
.

> > the appropriate stop level, make sure you got into that stop level, and=
 then
> > see
> > if that register was changed. Then you'd have an automated list of regi=
sters
> > you
> > need to make sure you save/restore at each stop level.
> >=20
> > Could something like that work?
>=20
> Maybe.
>=20
> Ignoring the problem of whether you can write a meaningful value to some
> of the SPRs, I'm not entirely convinced it's going to work. But maybe
> I'm wrong.

Yeah, I'm not convinced it'll work either but it would be a nice piece of t=
est
infrastructure to have if it does work.

We'd still need to marry up the SPR numbers we get from the test to what's
actually being restored in Linux.

> But there's a much simpler solution, we should 1) have a selftest for
> getcpu() and 2) we should be running the glibc (I think?) test suite
> that found this in the first place. It's frankly embarrassing that we
> didn't find this.

Yeah, we should do that also, but how do we catch the next SPR we are missi=
ng.
I'd like some systematic way of doing that rather than wack-a-mole.

Mikey
