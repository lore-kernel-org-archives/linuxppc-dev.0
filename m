Return-Path: <sjmunroe@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3D5B2DDFD1
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 00:00:52 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4TE0n9Y020361
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 10:00:49 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4TE0nK3520964
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 10:00:49 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4TE0m7i004890
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 10:00:49 -0400
In-Reply-To: <710cb04ed3b82b11192cf54aa08c0230@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <OF23D1348F.B2E0AE28-ON862572EA.004C17B2-862572EA.004CF843@us.ibm.com>
From: Steve Munroe <sjmunroe@us.ibm.com>
Date: Tue, 29 May 2007 09:00:42 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Segher Boessenkool <segher@kernel.crashing.org> wrote on 05/29/2007
08:12:24 AM:

> >> - how can an application know that it can use 64 bit registers and
> >> call
> >>   the optimized routines?
> >
> > I'd say use the 32 bits ABI, AT_HWCAP will tell you if you are running
> > on a 64 bits capable machine. You can then either use hand tuned code
> > at
> > runtime, or I think ld.so can load alternate libs based on the bits in
> > there.
>
> Or you can simply only install 64-bit binaries on 64-bit
> machines.
>
Yes exactly why make an incompatible ABI change to the powerp32 ABI, when
you can just use the existing 64-bit ABI.

Especially as you can only run what is proposed on 64-bit hardware!

We don't need another ABI change to powerpc32 (still recovering from the
-msecure-plt ABI change) and WE DONT NEED a 3rd ABI.

ABI changes ripple everywhere (not just GCC/GLIBC) including all debuggers
and performance tools. Believe me you really don't want this.



Steven J. Munroe
Linux on Power Toolchain Architect
IBM Corporation, Linux Technology Center
