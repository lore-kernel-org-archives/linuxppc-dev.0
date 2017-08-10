Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSmHx40L2zDqs4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 21:34:21 +1000 (AEST)
Message-ID: <1502364831.2563.63.camel@kernel.crashing.org>
Subject: Re: [PATCH 02/10] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Date: Thu, 10 Aug 2017 21:33:51 +1000
In-Reply-To: <2306956d-c447-24af-a20c-5f2eec011164@kaod.org>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-3-git-send-email-clg@kaod.org>
 <20170809035306.GC13670@umbus.fritz.box>
 <f82c1111-3dd3-f378-0ff6-222bffc07a35@kaod.org>
 <20170810042849.GU13670@umbus.fritz.box>
 <1502340360.2563.53.camel@kernel.crashing.org>
 <2306956d-c447-24af-a20c-5f2eec011164@kaod.org>
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

On Thu, 2017-08-10 at 08:45 +0200, Cédric Le Goater wrote:
> > The problem with doorbells on POWER9 guests is that they may have
> > to trap and be emulated by the hypervisor, since the guest threads
> > on P9 don't have to match the HW threads of the core.
> 
> Well, the pseries cause_ipi() handler does :
> 
>         if (doorbell_try_core_ipi(cpu))
>                 return;
> 
> to limit the doorbells to the same core. So we should be fine ?

No. It's theorically possible to create a guest that think it has 4
threads on P9 but those threads run on different cores of the host.

The doorbells are useful if KVM uses a "P8 style" whole-core dispatch
model or with PowerVM. We should probably invent some kind of DT
property to tell the guest I suppoes.

>  If not
> I suppose we should check CPU_FTR_ARCH_300 and use IPIs only for XIVE.
> 
> > Thus it's quite possible that using XIVE for IPIs is actually faster
> > than doorbells in that case.
> 
> How can we measure that ? ebizzy may be.

Or a simple socket ping pong with processes pinned to different
threads.

However the current KVM for P9 doesn't do threads yet afaik.

Cheers,
Ben.
