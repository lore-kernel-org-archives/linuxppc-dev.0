Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3W6v54QrzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 16:27:35 +1000 (AEST)
Message-ID: <1492064854.4624.48.camel@neuling.org>
Subject: Re: [PATCH 3/3] powernv:idle: Set LPCR_UPRT on wakeup from deep-stop
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, "Gautham R. Shenoy"
 <ego@linux.vnet.ibm.com>,  Michael Ellerman <mpe@ellerman.id.au>, "Shreyas
 B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Balbir
 Singh <bsingharora@gmail.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>,  Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 13 Apr 2017 16:27:34 +1000
In-Reply-To: <1492056725.7236.95.camel@kernel.crashing.org>
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
 <9be8410e0abe5ae1afa16a6f987c53046ef51757.1491996797.git.ego@linux.vnet.ibm.com>
 <8737ddq7py.fsf@skywalker.in.ibm.com>
 <1492056725.7236.95.camel@kernel.crashing.org>
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

On Thu, 2017-04-13 at 14:12 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2017-04-13 at 09:28 +0530, Aneesh Kumar K.V wrote:
> > > =C2=A0 #endif
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtctr=C2=A0=C2=A0=C2=A0r12
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bctrl
> > > +/*
> > > + * cur_cpu_spec->cpu_restore would restore LPCR to a
> > > + * sane value that is set at early boot time,
> > > + * thereby clearing LPCR_UPRT.
> > > + * LPCR_UPRT is required if we are running in Radix mode.
> > > + * Set it here if that be the case.
> > > + */
> > > +BEGIN_MMU_FTR_SECTION
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mfspr=C2=A0=C2=A0=C2=A0r3, SPRN_LPCR
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LOAD_REG_IMMEDIATE(r4, LPCR_UPRT)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0or=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
r3, r3, r4
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtspr=C2=A0=C2=A0=C2=A0SPRN_LPCR, r3
> > > +END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
>=20
> We are probably better off saving the value somewhere during boot
> and just "blasting" it whole back.

We seem to touch LPCR in a bunch of places these days.  Not sure when "some=
times
 during boot" should actually be.

Mikey
