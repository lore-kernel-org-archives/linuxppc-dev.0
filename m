Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3S6v6HVfzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 14:12:23 +1000 (AEST)
Message-ID: <1492056725.7236.95.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powernv:idle: Set LPCR_UPRT on wakeup from deep-stop
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Gautham R.
 Shenoy" <ego@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>, "Shreyas B. Prabhu"
 <shreyasbp@gmail.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Anton Blanchard
 <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 13 Apr 2017 14:12:05 +1000
In-Reply-To: <8737ddq7py.fsf@skywalker.in.ibm.com>
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
 <9be8410e0abe5ae1afa16a6f987c53046ef51757.1491996797.git.ego@linux.vnet.ibm.com>
 <8737ddq7py.fsf@skywalker.in.ibm.com>
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

On Thu, 2017-04-13 at 09:28 +0530, Aneesh Kumar K.V wrote:
> >   #endif
> >        mtctr   r12
> >        bctrl
> > +/*
> > + * cur_cpu_spec->cpu_restore would restore LPCR to a
> > + * sane value that is set at early boot time,
> > + * thereby clearing LPCR_UPRT.
> > + * LPCR_UPRT is required if we are running in Radix mode.
> > + * Set it here if that be the case.
> > + */
> > +BEGIN_MMU_FTR_SECTION
> > +     mfspr   r3, SPRN_LPCR
> > +     LOAD_REG_IMMEDIATE(r4, LPCR_UPRT)
> > +     or      r3, r3, r4
> > +     mtspr   SPRN_LPCR, r3
> > +END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)

We are probably better off saving the value somewhere during boot
and just "blasting" it whole back.

Cheers
Ben.
