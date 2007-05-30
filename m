Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B396DDF71
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:49:14 +1000 (EST)
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <3cbbec8c34b1beabb091c343132730d5@kernel.crashing.org>
References: <OF611013C9.F9C3C2DB-ON862572EA.0050F570-862572EA.005197A3@us.ibm.com>
	<1180475055.19517.206.camel@localhost.localdomain>
	<3cbbec8c34b1beabb091c343132730d5@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 30 May 2007 21:48:53 +1000
Message-Id: <1180525733.19517.271.camel@localhost.localdomain>
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

On Wed, 2007-05-30 at 13:40 +0200, Segher Boessenkool wrote:
> 
> > I personally don't care about gdb seeing those or anything like
> that,
> > those would be strictly local asm optimisations, at least that's my
> > point of view on the matter.
> 
> GDB can step into asm though, it will have to know
> about it for full functionality.

It can already... there are ptrace hooks to get both halves if you are a
32 bits gdb and the 64 bits ptrace will return the full 64 bits. There
is no way to know wether an app or a lib is using both halves or not
though.

> Perhaps something in a test suite somewhere; other
> than that, nothing important I suspect.  Well some
> version of some JVM will abuse it I'm sure ;-)

That's what I was worried about :-)

Ben.
