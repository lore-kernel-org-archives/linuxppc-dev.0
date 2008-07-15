Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 93F1BDDFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 12:24:55 +1000 (EST)
Date: Mon, 14 Jul 2008 21:24:40 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] kill useless SMT code in prom_hold_cpus
Message-ID: <20080715022440.GU9594@localdomain>
References: <20080708223631.GP9594@localdomain>
	<1216087555.7740.42.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1216087555.7740.42.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2008-07-08 at 17:36 -0500, Nathan Lynch wrote:
> > I think this code that counts SMT threads and compares against NR_CPUS
> > is an artifact of pre-powerpc-merge ppc64.  We care about starting
> > only primary threads in the OF client code.
> > 
> > Signed-off-by: Nathan Lynch <ntl@pobox.com>
> 
> That looks good. I'm not merging it right now because I want to dbl
> check that it's allright on all SMT machines. IE. We compare reg[0]
> against _prom->cpu now instead of interrupt_server[0] and I thus
> want to ensure it's the same everywhere.

Thanks.  Looks like prom_find_boot_cpu is setting _prom->cpu to reg
(or 0), so I think it should be fine... a system where reg differed
from interrupt_server[0] would have been broken before this patch
anyway, I think?
