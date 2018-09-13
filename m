Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429fq83PLQzF3MW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 10:36:52 +1000 (AEST)
Message-ID: <29d3467a9314f5b80f93d241ae2566c48b546bfe.camel@neuling.org>
Subject: Re: [PATCH v2] powerpc: Avoid code patching freed init sections
From: Michael Neuling <mikey@neuling.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 paulus@ozlabs.org, Haren Myneni <haren@linux.vnet.ibm.com>, Michal
 =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Date: Thu, 13 Sep 2018 10:36:50 +1000
In-Reply-To: <0922624b-6c6f-1afd-a9e2-cde5a9a8a1e4@c-s.fr>
References: <20180912052058.10062-1-mikey@neuling.org>
 <0922624b-6c6f-1afd-a9e2-cde5a9a8a1e4@c-s.fr>
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


> > --- a/arch/powerpc/lib/code-patching.c
> > +++ b/arch/powerpc/lib/code-patching.c
> > @@ -23,11 +23,33 @@
> >   #include <asm/code-patching.h>
> >   #include <asm/setup.h>
> >  =20
> > +
>=20
> This blank line is not needed

Ack

>=20
> > +static inline bool in_init_section(unsigned int *patch_addr)
> > +{
> > +	if (patch_addr < (unsigned int *)__init_begin)
> > +		return false;
> > +	if (patch_addr >=3D (unsigned int *)__init_end)
> > +		return false;
> > +	return true;
> > +}
>=20
> Can we use the existing function init_section_contains() instead of this=
=20
> new function ?

Nice, I was looking for something like that...=20

> > +
> > +static inline bool init_freed(void)
> > +{
> > +	return (system_state >=3D SYSTEM_RUNNING);
> > +}
> > +
>=20
> I would call this function differently, for instance init_is_finished(),=
=20
> because as you mentionned it doesn't exactly mean that init memory is fre=
ed.

Talking to Nick and mpe offline I think we are going to have to add a flag =
when
we free init mem rather than doing what we have now since what we have now =
has a
potential race. That change will eliminate the function entirely.

> >   static int __patch_instruction(unsigned int *exec_addr, unsigned int
> > instr,
> >   			       unsigned int *patch_addr)
> >   {
> >   	int err;
> >  =20
> > +	/* Make sure we aren't patching a freed init section */
> > +	if (in_init_section(patch_addr) && init_freed()) {
>=20
> The test must be done on exec_addr, not on patch_addr, as patch_addr is=
=20
> the address where the instruction as been remapped RW for allowing its=
=20
> modification.

Thanks for the catch

> Also I think it should be tested the other way round, because the=20
> init_freed() is a simpler test which will be false most of the time once=
=20
> the system is running so it should be checked first.

ok, I'll change.

> > +		printk(KERN_DEBUG "Skipping init section patching addr:
> > 0x%lx\n",
>=20
> Maybe use pr_debug() instead.

Sure.

>=20
> > +			(unsigned long)patch_addr);
>=20
> Please align second line as per Codying style.

Sorry I can't see what's wrong. You're (or Cody :-P) going to have to spell=
 it
this out for me...

>=20
> > +		return 0;
> > +	}
> > +
> >   	__put_user_size(instr, patch_addr, 4, err);
> >   	if (err)
> >   		return err;
> >=20
>=20
> I think it would be better to put this verification in=20
> patch_instruction() instead, to avoid RW mapping/unmapping the=20
> instruction to patch when we are not going to do the patching.

If we do it there then we miss the raw_patch_intruction case.

IMHO I don't think we need to optimise this rare and non-critical path.=20

Mikey
