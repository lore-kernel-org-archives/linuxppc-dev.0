Return-Path: <sjmunroe@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AE720DDF2C
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 09:16:40 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4TNGbHt025681
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 19:16:37 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4TNGbXA511098
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 19:16:37 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4TNGaNg023823
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 19:16:37 -0400
In-Reply-To: <1180475055.19517.206.camel@localhost.localdomain>
Subject: Re: Saving to 32 bits of GPRs in signal context
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFB4FD81AE.95147932-ON862572EA.007EAB56-862572EA.007FDB77@us.ibm.com>
From: Steve Munroe <sjmunroe@us.ibm.com>
Date: Tue, 29 May 2007 18:16:32 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 05/29/2007
04:44:15 PM:

>
> > But unless you take the time to write it up like a full ABI change you
are
> > never sure that it IS compatible. And any change to the size/shape of
> > ucontext_t is an ABI change.
> >
> > Also if you want to debug this code (see long long variables correctly
from
> > GDB or even see the upper 32-bits of GPRs) you will need an ABI change
so
> > that GDB/DWARF knows what to do.
>
> I personally don't care about gdb seeing those or anything like that,
> those would be strictly local asm optimisations, at least that's my
> point of view on the matter.
>
Well others do. If gcc supports code gen for this they will expect GDB
support.

> I intend not to extend or change the shape of ucontext neither. I'll add
> the highregs after the ucontext32 on the compat signal frame, the only
> change/addition is the use of a pad field to point to it and maybe
> setting a flag that was previously unused and always 0 to indicate that
> it's there.
>
The pad field may be occupied with data if the code was compiled on a older
distro and ucontext_t is misaligned (an odd Doubleword). So the pad field
is free for reuse onless you version the code to handle unalligned VMX
registers.

> Do you see any possible compatibility problem there ? Do you know of any
> piece of software that makes hard assumptions on the shape and size of a
> complete signal frame (not just the ucontext part of it) ?
>

The signal frame can change, as long as the relative offset and size of the
ucontext_t is unchanged.
