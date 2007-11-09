Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3016CDDE00
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 08:08:58 +1100 (EST)
Subject: Re: Hardware watchpoints on Cell/B.E. broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ulrich Weigand <uweigand@de.ibm.com>
In-Reply-To: <200711091854.lA9IsJEB027041@d12av02.megacenter.de.ibm.com>
References: <200711091854.lA9IsJEB027041@d12av02.megacenter.de.ibm.com>
Content-Type: text/plain
Date: Sat, 10 Nov 2007 08:08:40 +1100
Message-Id: <1194642520.21340.18.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-09 at 19:54 +0100, Ulrich Weigand wrote:
> Hello,
> 
> I've noticed that GDB hardware watchpoints do not work at all on Cell/B.E.
> (when running without hypervisor); the kernel accepts the PTRACE_SET_DEBUGREG
> call without error, but watchpoints never trigger.
> 
> This turns out to be caused by a new hardware feature in the PowerPC 2.02
> architecture level: the DABRX register.  This register controls in which
> modes of operation (problem state, privileged state, hypervisor state)
> the DABR register takes effect.  (See Book III v 2.02 page 40.)
> 
> The default setting of that register on Cell/B.E. (at least on IBM blades),
> which the Linux kernel currently never modifies, is to ignore DABR in all
> modes -- thus watchpoints do not work at all.
> 
> The following hack sets the bit in the DABRX that enables the DABR for
> problem state, whenever the DABR is set.  With this patch on top of the
> current Fedora 8 update kernel (kernel-2.6.23.1-48.fc8) watchpoints work
> again -- all relevant test cases in the GDB test suite now pass.
> 
> Obviously, the patch cannot be applied as-is; we need to make sure we are
> on a machine that supports the DABRX feature.  Arnd asked me to post this
> anyway as a heads-up on that problem ...

Hrm, ok, something we missed, I'll have a look. The whole DABR / debug
register handling need work anyway.

Ben.
