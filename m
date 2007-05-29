Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6FC8DE0D1
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 07:44:27 +1000 (EST)
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steve Munroe <sjmunroe@us.ibm.com>
In-Reply-To: <OF611013C9.F9C3C2DB-ON862572EA.0050F570-862572EA.005197A3@us.ibm.com>
References: <OF611013C9.F9C3C2DB-ON862572EA.0050F570-862572EA.005197A3@us.ibm.com>
Content-Type: text/plain
Date: Wed, 30 May 2007 07:44:15 +1000
Message-Id: <1180475055.19517.206.camel@localhost.localdomain>
Mime-Version: 1.0
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


> But unless you take the time to write it up like a full ABI change you are
> never sure that it IS compatible. And any change to the size/shape of
> ucontext_t is an ABI change.
> 
> Also if you want to debug this code (see long long variables correctly from
> GDB or even see the upper 32-bits of GPRs) you will need an ABI change so
> that GDB/DWARF knows what to do.

I personally don't care about gdb seeing those or anything like that,
those would be strictly local asm optimisations, at least that's my
point of view on the matter.

I intend not to extend or change the shape of ucontext neither. I'll add
the highregs after the ucontext32 on the compat signal frame, the only
change/addition is the use of a pad field to point to it and maybe
setting a flag that was previously unused and always 0 to indicate that
it's there.

Do you see any possible compatibility problem there ? Do you know of any
piece of software that makes hard assumptions on the shape and size of a
complete signal frame (not just the ucontext part of it) ?

Ben.
