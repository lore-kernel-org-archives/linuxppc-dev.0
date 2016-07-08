Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm1fw6FcMzDr0H
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 14:27:20 +1000 (AEST)
Message-ID: <1467952040.13193.0.camel@neuling.org>
Subject: Re: [PATCH v7 07/11] powerpc/powernv: Add platform support for stop
 instruction
From: Michael Neuling <mikey@neuling.org>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, ego@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com
Date: Fri, 08 Jul 2016 14:27:20 +1000
In-Reply-To: <577F29EF.9090405@linux.vnet.ibm.com>
References: <1467924432-29003-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1467924432-29003-8-git-send-email-shreyas@linux.vnet.ibm.com>
 <1467944442.27479.155.camel@neuling.org>
 <577F29EF.9090405@linux.vnet.ibm.com>
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


> > >=20
> > > @@ -439,7 +540,18 @@ timebase_resync:
> > > =C2=A0	=C2=A0*/
> > > =C2=A0	bne	cr4,clear_lock
> > > =C2=A0
> > > -	/* Restore per core state */
> > > +	/*
> > > +	=C2=A0* First thread in the core to wake up and its waking up
> > > with
> > > +	=C2=A0* complete hypervisor state loss. Restore per core
> > > hypervisor
> > > +	=C2=A0* state.
> > > +	=C2=A0*/
> > > +BEGIN_FTR_SECTION
> > > +	ld	r4,_PTCR(r1)
> > > +	mtspr	SPRN_PTCR,r4
> > > +	ld	r4,_RPR(r1)
> > > +	mtspr	SPRN_RPR,r4
> > RPR looks wrong here.=C2=A0=C2=A0This should be on POWER8 too.
> >=20
> > This has changed since v6 and not noted in the v7 comments.=C2=A0=C2=A0=
Why are
> > you
> > changing this now?
> >=20
> RPR is a per-core resource in P9. So with this patch, RPR will continue
> to be restored per-subcore in P8 and will restored once per core in P9.

Ok, thanks for the explanation.

Mikey
