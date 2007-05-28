Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1489ADDF47
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 19:24:22 +1000 (EST)
Subject: RE: fsl booke MM vs. SMP questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Liu Dave-r63238 <DaveLiu@freescale.com>
In-Reply-To: <995B09A8299C2C44B59866F6391D263595EF5F@zch01exm21.fsl.freescale.net>
References: <1179731215.32247.659.camel@localhost.localdomain>
	<1179741447.3660.7.camel@localhost.localdomain>
	<1179742083.32247.689.camel@localhost.localdomain>
	<1179747448.3660.22.camel@localhost.localdomain>
	<1179785273.32247.742.camel@localhost.localdomain>
	<1179803367.32247.785.camel@localhost.localdomain>
	<1179831375.3827.4.camel@localhost.localdomain>
	<1179873742.32247.864.camel@localhost.localdomain>
	<1179887929.3656.2.camel@localhost.localdomain>
	<1179889736.32247.893.camel@localhost.localdomain>
	<995B09A8299C2C44B59866F6391D263595EF5F@zch01exm21.fsl.freescale.net>
Content-Type: text/plain
Date: Mon, 28 May 2007 19:24:08 +1000
Message-Id: <1180344249.19517.74.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-28 at 17:05 +0800, Liu Dave-r63238 wrote:
> Ben,
> 
> > You never "loose" IPIs in the sense that you always get at least 1
> > interrupt for N IPIs and it's up to software to make sure not to lose
> > any event. The linux kernel arch code usually handles that with a
> > synchronous IPI mecanism.
> 
> Due to the synchronous IPI mechanism for TLB invalidatation, it is
> very time exhausting, there are interrupt overhead and wait time for
> sync.

Yup, there is, though you can try to optimize it such that you only sync
the CPUs involved with the IPIs, which often are only few.

> I also noticed that tlb invalidation on the PowerPC 750 SMP system
> is using the IPI mechanism, that is because the 750 can not broadcast
> tlb invalidation ops.

Do we support that in linux ?
 
> If the broadcast tlbivax instruction is more effective than the IPI
> mechanism?
> 
> Did you evaluate the performance with the two different ways?

Not really... it depends on bus traffic, plus the need to spinlock the
broadcast tlbivax as well, etc..

I'm not working on real HW at the moment. I don't know what the exact
characteristics of your target HW are...

Ben.
