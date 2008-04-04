Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6243CDDECF
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 09:47:04 +1100 (EST)
Subject: Re: [PATCH v2] powerpc: Add irqtrace support for 32-bit powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20080404223522.GA16958@farnsworth.org>
References: <20080404213932.GA15847@farnsworth.org>
	<1207346851.10388.427.camel@pasglop>
	<20080404223522.GA16958@farnsworth.org>
Content-Type: text/plain
Date: Sat, 05 Apr 2008 09:46:24 +1100
Message-Id: <1207349184.10388.438.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Right, it's not needed on 4xx/BookE, but I didn't think it worth
> optimizing at this point, since it will split the code into 4xx/BookE
> and classic versions. Let's get it working solid first.

Yup, it's just that I spotted it while reading the code.

> That's what I originally thought and had in my first version.
> However, in the BookE case, we must save at least r3, r4, and r5.
> (See data_access: in head_fsl_booke.S.)  It isn't clear what the
> rules are, and I didn't want to set a trap for when a handler is
> added that uses a fourth argument.

Ok, this definitely is worth some rework around the edges. For now, I
suppose keeping it stable will do.

> If you think it's worth it, I could test a version that saves
> r3, r4, and r5 and restores the others from ptregs.

Don't bother for now. I'll see if we can do things differently later.

> > Also, only the system call really cares about -restoring- them. Maybe
> > you could stick that in an ifdef CONFIG_TRACE_IRQFLAGS section in
> > DoSyscall pulling them back off the ptregs in the stackframe. 
> 
> Another optimization that I'm not convinced is worth the trouble
> for this tracing code.  I'll try to take a look at it though.
> As you say below, it's scary code.

Yup. The RESTOREALL case doesn't write the result to the PT_REGS but I'm
not yet sure if that's a big issue to do it regardless or not.

Ben.
