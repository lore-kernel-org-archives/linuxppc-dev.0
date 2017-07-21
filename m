Return-Path: <santosh@fossix.org>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDJ4751m2zDqsr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 14:40:55 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id d18so3924709pfe.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 21:40:54 -0700 (PDT)
Date: Fri, 21 Jul 2017 10:10:48 +0530
From: Santosh Sivaraj <santosh@fossix.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
Message-ID: <20170721044048.3dbqldqh6m7wj5kc@santosiv.in.ibm.com>
References: <20170720095834.15153-1-santosh@fossix.org>
 <87bmofgsbh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87bmofgsbh.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> wrote (on 2017-07-20 23:18:26 +1000=
):

> Santosh Sivaraj <santosh@fossix.org> writes:
>=20
> > Current vDSO64 implementation does not have support for coarse
> > clocks (CLOCK_MONOTONIC_COARSE, CLOCK_REALTIME_COARSE), for which it fa=
lls
> > back to system call. Below is a benchmark of the difference in execution
> > time with and without vDSO support.
>=20
> Hi Santosh,
>=20
> Great patch! Always good to see asm replaced with C.
>=20
> > diff --git a/arch/powerpc/kernel/vdso64/gettime.c b/arch/powerpc/kernel=
/vdso64/gettime.c
> > new file mode 100644
> > index 0000000..01f411f
> > --- /dev/null
> > +++ b/arch/powerpc/kernel/vdso64/gettime.c
> > @@ -0,0 +1,162 @@
> ...
> > +static notrace int gettime_syscall_fallback(clockid_t clk_id,
> > +					     struct timespec *tp)
> > +{
> > +	register clockid_t id asm("r3") =3D clk_id;
> > +	register struct timespec *t asm("r4") =3D tp;
> > +	register int nr asm("r0") =3D __NR_clock_gettime;
> > +	register int ret asm("r3");
>=20
> I guess this works. I've always been a bit nervous about register
> variables TBH.
Yes, this works. It falls back to syscall in the case of CLOCK_BOOTTIME.

>=20
> > +	asm volatile("sc"
> > +		     : "=3Dr" (ret)
> > +		     : "r"(nr), "r"(id), "r"(t)
> > +		     : "memory");
>=20
> Not sure we need the memory clobber?
>=20
> It can clobber more registers than that though.
>=20
> See: Documentation/powerpc/syscall64-abi.txt
>=20
> > diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/k=
ernel/vdso64/gettimeofday.S
> > index 3820213..1258009 100644
> > --- a/arch/powerpc/kernel/vdso64/gettimeofday.S
> > +++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
> > @@ -51,85 +53,21 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
> ...
> > +	stwu	r1,-112(r1)
> > +  .cfi_register lr,r6
> > +	std	r6,24(r1)
> > +	bl	V_LOCAL_FUNC(kernel_clock_gettime)
> >  	crclr	cr0*4+so
>=20
> Clearing CR0[SO] says that the syscall always succeeded.
>=20
> What happens if you call this with a completely bogus clock id?
>

In case of a bogus clock id, the default case sets 'ret' to -1, which force=
s it
to fallback to the syscall.
> I think the solution is probably to do the syscall fallback in asm, and
> everything else in C.

Ok. That's what Sergey also sugested. I will send a v2.

Thanks,
Santosh
>=20
> cheers

--=20
