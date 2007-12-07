Return-Path: <FENKES@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 18A8BDDDFB
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 03:25:31 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id lB7GPRpQ177268
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 16:25:27 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lB7GPRZW2805920
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 17:25:27 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lB7GPQlf024584
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 17:25:27 +0100
In-Reply-To: <ada7ijrd6gy.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH] IB/ehca: Serialize HCA-related hCalls on POWER5
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF85E31FAA.DADA6039-ONC12573AA.005439C8-C12573AA.005A137A@de.ibm.com>
Date: Fri, 7 Dec 2007 17:25:23 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: Arnd Bergmann <arnd@arndb.de>, OF-EWG <ewg@lists.openfabrics.org>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland Dreier <rdreier@cisco.com> wrote on 06.12.2007 19:27:09:

>  > > +               ehca_lock_hcalls = 
!(cur_cpu_spec->cpu_user_features
>  > > +                                    & PPC_FEATURE_ARCH_2_05);
> 
>  > We already talked about this yesterday, but I still feel that 
checking the
>  > instruction set of the CPU should not be used to determine whether a
>  > specific device driver implementation is used int hypervisor.
> 
> I had the same reaction... is testing cpu_user_features really the
> best way to detect this issue?

I concur it's not nice, but it was the only feasible method we could find 
without adding a "bug fixed" feature flag to the partition<->firmware 
interface. The firmware version reported in the OFDT is not a reliable 
enough source, and even if it were, it would require a lot of string 
parsing and matching against tables.

We're taking this to the firmware architects at the moment, but they're 
not very fond of the idea of reporting the absence of bugs through 
capability flags, as this could quickly lead to the exhaustion of flag 
bits. We'll let the discussion stew for a bit, but if we don't get this 
flag, we'll have to resort to the CPU features.
 
> I'll hold off applying this for a few days so you guys can decide the
> best thing to do.  We'll definitely get some fix into 2.6.24 but we
> have time to make a good decision.

Right.
 
>  > Regarding the performance problem, have you checked whether 
converting all
>  > your spin_lock_irqsave to spin_lock/spin_lock_irq improves your 
performance
>  > on the older machines? Maybe it's already fast enough that way.
> 
> It does seem that the only places that the hcall_lock is taken also
> use msleep, so they must always be in process context.  So you can
> safely just use spin_lock(), right?

As Arnd said, there are hCalls that will never return H_LONG_BUSY_*, such 
as H_QUERY_PORT and chums, so they will never sleep. The surrounding 
functions, though, are not prepared to be called from interrupt context 
(GFP_KERNEL comes to mind), so I agree that a simple spin_lock() will 
suffice. Thanks, Arnd, for pointing this out.

We'll keep you guys posted on the feature flag discussion. Until then, 
have a nice weekend!

Joachim
