Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2ED5DDFCB
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 22:10:08 +1000 (EST)
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <fa74d8c78910a77c011f9e72dd750d19@kernel.crashing.org>
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
	<OF611013C9.F9C3C2DB-ON862572EA.0050F570-862572EA.005197A3@us.ibm.com>
	<18012.61822.197988.279764@cargo.ozlabs.ibm.com>
	<ce91696e7837282dd93df408461a64fb@kernel.crashing.org>
	<1180526470.19517.274.camel@localhost.localdomain>
	<fa74d8c78910a77c011f9e72dd750d19@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 30 May 2007 22:09:51 +1000
Message-Id: <1180526992.19517.277.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Steve Munroe <sjmunroe@us.ibm.com>,
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

On Wed, 2007-05-30 at 14:07 +0200, Segher Boessenkool wrote:
> > Actually, it's the opposite... the prctl becomes a problem if you
> have
> > libs wanting to use 64 bits for optims
> 
> The host application, or the dynamic loader, can call
> the prctl() when it loads the DSO that needs it.

Provided you know it does... and with static binaries it gets harder...

> In almost all cases this should all be transparent
> for the user IMHO, based on some ELF flag.

You reckon ? I was wondering about that ... maybe we should define some
ELF personality for that ...

But that means that existing programs wouldn't get it even while some
libs they depend on might have such optims without the program knowing
about it ...

Also, if I can avoid changing glibc ... (you know how hard it is !)

Ben.
