Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 44992DE039
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 08:58:26 +1100 (EST)
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@parisc-linux.org>
In-Reply-To: <20070126074833.GF328@colo.lackof.org>
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
	<20070126065613.GB328@colo.lackof.org>
	<m18xfqw95v.fsf@ebiederm.dsl.xmission.com>
	<20070126074833.GF328@colo.lackof.org>
Content-Type: text/plain
Date: Sat, 27 Jan 2007 08:58:03 +1100
Message-Id: <1169848684.24996.162.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hrm ok. IRQ migration shouldn't surprise anyone.
> I expect the "virq" (linux IRQ #) would hide the values changing
> in a Suspend/resume event. If the code isn't doing that for platforms
> that support suspend/resume, then I agree it's broken.

All if this is entirely backend business at this point. Michael's latest
code drop is apparently still missing suspend/resume hooks though, we
need to fix that. What those hooks do is backend specific. For example,
on MPIC machines, the vector will stay the same and it's really only a
matter of re-programming the HW with the same values. On RTAS (if we
ever implement suspend-to-something on pSeries), we would probably get
different vectors and thus have to update the virq->vector mapping.

Since virtual IRQs are something implemented by each platform
differently, none of that can be put in the generic code anyway.

Ben.
