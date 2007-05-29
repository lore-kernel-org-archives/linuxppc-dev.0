Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 978A9DE002
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 21:41:38 +1000 (EST)
Subject: Re: [RFC/PATCH 4/5] powerpc: Make syscall restart code more common
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070529113232.GA6071@lst.de>
References: <20070529064533.CA8C4DDFF8@ozlabs.org>
	<20070529113232.GA6071@lst.de>
Content-Type: text/plain
Date: Tue, 29 May 2007 21:41:25 +1000
Message-Id: <1180438885.19517.157.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, ulrich.weigand@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-29 at 13:32 +0200, Christoph Hellwig wrote:
> On Tue, May 29, 2007 at 04:45:23PM +1000, Benjamin Herrenschmidt
> wrote:
> > +static inline void check_syscall_restart(struct pt_regs *regs,
> > +                                      struct k_sigaction *ka,
> > +                                      int has_handler)
> > +{
> 
> I don't think this should be inlined.  Just create a new signal.c
> file,
> which can grow a lot more common signal code later on aswell.

I've been thinking about doing that too. In fact, some of the
ptrace-common.h stuff should probably be turned back into ptrace.c too
for the same reason. I'm still toying with that part of the designm but
yeah, I think that's something to do.

Ben.
