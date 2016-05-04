Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0GMd12KBzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 21:41:17 +1000 (AEST)
Message-ID: <1462362076.4115.89.camel@neuling.org>
Subject: Re: [PATCH 3/3] powerpc: Load Monitor Register Tests
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Jack Miller <jack@codezen.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: anton@samba.org
Date: Wed, 04 May 2016 21:41:16 +1000
In-Reply-To: <1462361464.1846.3.camel@ellerman.id.au>
References: <201604190414.NkLxbSQl%fengguang.wu@intel.com>
 <1461013724-12784-1-git-send-email-jack@codezen.org>
 <1461013724-12784-4-git-send-email-jack@codezen.org>
 <1462358630.4115.76.camel@neuling.org>
 <1462361464.1846.3.camel@ellerman.id.au>
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

On Wed, 2016-05-04 at 21:31 +1000, Michael Ellerman wrote:
> On Wed, 2016-05-04 at 20:43 +1000, Michael Neuling wrote:
> >=20
> > On Mon, 2016-04-18 at 16:08 -0500, Jack Miller wrote:
> >=20
> > >=20
> > > +int ebb_lmr(void)
> > > +{
> > > +	int i;
> > > +
> > > +	SKIP_IF(!ebb_is_supported());
> > We skip this test currently as EBB is not enabled on POWER9.
> >=20
> > On POWER8 we enable EBB in the PMU code. Should we do this elsewhere fo=
r
> > POWER9 since EBB doesn't directly require the PMU?
> Probably. But we will need to check that if the PMU code is *not* enabled=
 we
> still do the context switching of EBB regs correctly. We probably do, but=
 I
> don't now for sure.

I think we're fine. =C2=A0The code to switch BESCR, EBBHR & EBBRR is in
save/restore_sprs() and just depends on cpu_has_feature(CPU_FTR_ARCH_207S).

Actually, do we really need be using PPC_FEATURE2_EBB for this test? Should
we really be using PPC_FEATURE2_ARCH_3_00?

Should the existing=C2=A0PPC_FEATURE2_EBB really signify=C2=A0PPC_FEATURE2_=
EBB_PMU?

Mikey
