Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJknN2Y78zDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Oct 2017 11:58:48 +1100 (AEDT)
Message-ID: <1508547527.23934.4.camel@neuling.org>
Subject: Re: [PATCH 1/4] powerpc/tm: Add commandline option to disable
 hardware transactional memory
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, stewart@linux.vnet.ibm.com, cyrilbur@gmail.com
Date: Sat, 21 Oct 2017 11:58:47 +1100
In-Reply-To: <20171020114539.piyh4wmby5gz7qnb@gmail.com>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
 <20171020114539.piyh4wmby5gz7qnb@gmail.com>
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

On Fri, 2017-10-20 at 09:45 -0200, Breno Leitao wrote:
> Mikey, Cyril,
>=20
> On Thu, Oct 12, 2017 at 09:17:16PM +1100, Michael Ellerman wrote:
> > From: Cyril Bur <cyrilbur@gmail.com>
> >=20
> > Currently the kernel relies on firmware to inform it whether or not the
> > CPU supports HTM and as long as the kernel was built with
> > CONFIG_PPC_TRANSACTIONAL_MEM=3Dy then it will allow userspace to make
> > use of the facility.
> >=20
> > There may be situations where it would be advantageous for the kernel
> > to not allow userspace to use HTM, currently the only way to achieve
> > this is to recompile the kernel with CONFIG_PPC_TRANSACTIONAL_MEM=3Dn.
> >=20
> > This patch adds a simple commandline option so that HTM can be
> > disabled at boot time.
> >=20
> > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > [mpe: Simplify to a bool, move to prom.c, put doco in the right place.
> > =C2=A0Always disable, regardless of initial state, to avoid user confus=
ion.]
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> > =C2=A0Documentation/admin-guide/kernel-parameters.txt |=C2=A0=C2=A04 ++=
++
> > =C2=A0arch/powerpc/kernel/prom.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0| 31
> > +++++++++++++++++++++++++
> > =C2=A02 files changed, 35 insertions(+)
> >=20
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > b/Documentation/admin-guide/kernel-parameters.txt
> > index 05496622b4ef..ef03e6e16bdb 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3185,6 +3185,10 @@
> > =C2=A0			allowed (eg
> > kernel_enable_fpu()/kernel_disable_fpu()).
> > =C2=A0			There is some performance impact when enabling
> > this.
> > =C2=A0
> > +	ppc_tm=3D		[PPC]
> > +			Format: {"off"}
> > +			Disable Hardware Transactional Memory
> > +
> > =C2=A0	print-fatal-signals=3D
> > =C2=A0			[KNL] debug: print fatal signals
> > =C2=A0
> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> > index f83056297441..d9bd6555f980 100644
> > --- a/arch/powerpc/kernel/prom.c
> > +++ b/arch/powerpc/kernel/prom.c
> > @@ -658,6 +658,35 @@ static void __init early_reserve_mem(void)
> > =C2=A0#endif
> > =C2=A0}
> > =C2=A0
> > +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> > +static bool tm_disabled __initdata;
>=20
> I think the name 'tm_disabled' might cause more confusion on the TM
> code. Mainly because we already have tm_enable() and tm_enabled()
> functions which are related to the MSR register and TM bit, and, with
> your new variable, tm_enabled() and tm_disabled are not going to be
> exclusionary. Neither tm_enable() with be able to toggle the tm_disabled
> value.

Got a proposal for better names?

Mikey
