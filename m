Return-Path: <sjmunroe@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 69AACDE0B0
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 00:51:23 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4TEpJfS006216
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 10:51:19 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4TEpJJR473026
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 10:51:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4TEpIdX000425
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 10:51:18 -0400
In-Reply-To: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
Subject: Re: Saving to 32 bits of GPRs in signal context
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Message-ID: <OF611013C9.F9C3C2DB-ON862572EA.0050F570-862572EA.005197A3@us.ibm.com>
From: Steve Munroe <sjmunroe@us.ibm.com>
Date: Tue, 29 May 2007 09:51:12 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Ulrich Weigand <Ulrich.Weigand@de.ibm.com> wrote on 05/29/2007 09:08:39 AM:

>
> Steve Munroe <sjmunroe@us.ibm.com> wrote on 05/29/2007 04:00:42 PM:
>
> > Yes exactly why make an incompatible ABI change to the powerp32 ABI,
when
> > you can just use the existing 64-bit ABI.
> >
> > Especially as you can only run what is proposed on 64-bit hardware!
> >
> > We don't need another ABI change to powerpc32 (still recovering from
the
> > -msecure-plt ABI change) and WE DONT NEED a 3rd ABI.
> >
> > ABI changes ripple everywhere (not just GCC/GLIBC) including all
debuggers
> > and performance tools. Believe me you really don't want this.
>
> Fully agreed.  This may have gotten lost in the discussion thread, but
what
> Ben originally proposed was *not* an ABI change, for exactly that reason.

> We simply want to allow strictly local use of 64-bit registers for
> performance optimization purposes, while still fully complying with
> the 32-bit ABI.
>

But unless you take the time to write it up like a full ABI change you are
never sure that it IS compatible. And any change to the size/shape of
ucontext_t is an ABI change.

Also if you want to debug this code (see long long variables correctly from
GDB or even see the upper 32-bits of GPRs) you will need an ABI change so
that GDB/DWARF knows what to do.


Steven J. Munroe
Linux on Power Toolchain Architect
IBM Corporation, Linux Technology Center
