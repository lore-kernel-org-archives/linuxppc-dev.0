Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1EDA0DDFF3
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 10:59:55 +1100 (EST)
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070128.153156.63125702.davem@davemloft.net>
References: <m1fy9uq3et.fsf@ebiederm.dsl.xmission.com>
	<1170019048.26655.27.camel@localhost.localdomain>
	<m1lkjmok2j.fsf@ebiederm.dsl.xmission.com>
	<20070128.153156.63125702.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 10:59:38 +1100
Message-Id: <1170028778.26655.134.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: greg@kroah.com, kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	brice@myri.com, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, ebiederm@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Look, I have no idea where all this resistence come from to abstract
> this stuff behind enough levels to support things like RTAS et al.
> properly.  Please stop it now.

Note that to be totally fair, in some aspects (mostly simplicity gained
from not handling the RTAS-type setup), Eric code is nicer than our
proposal.

What annoys me is that Eric wants to completely separate the handling of
RTAS-type via a separate abstraction than the "classic" case.

The main thing here is that with Eric code, the backend really only
cares about one interrupt at a time, via the alloc/free hook, and thus
can totally ignore wether it's an MSI or one of multiple MSI-X (or even
one of multiple MSIs if we ever support that).

Michael's code makes it a little bit less transparent... alloc() /
free() has to operate on a level that matches the HV interfaces, thus
are called for either a single MSI or a set of MSI-X, though we made
that interface nice enough so we really only deal with an array and a
count (with the count being 1 for a single MSI).

One thing we could do, is remove our enable/disable hooks. The
functionality can be kept into the core, as is with Eric's code,
provided we have a way for alloc/free to say "job done, nothing else
needed", via either a special result code or maybe an ops "member"
variable set to 1 statically in the definition of the RTAS ops.

Another thing is we still need to have the addr/data returned for the
non-RTAS case. Eric doesn't like the setup_msi_msg() callback through
the ops because it operates at a different layer than alloc/free. The
option there would have to have alloc/free return the setup infos and
store them in the msi data on platforms where that is useful.

At this point I don't really have a firm preference of either taking
Michael's code and changing it in some areas to please Eric or try to
evolve from Eric's code, though I do feel that the later would still
have strong resistance in the area where alloc/free are concerned, that
is the whole idea of allocating the whole set at once or per-MSI, the
later being unsuitable for RTAS-like implementations.

Ben.
