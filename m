Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A4E0DDDFFE
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 11:27:11 +1100 (EST)
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1bqkioh6z.fsf@ebiederm.dsl.xmission.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
	<1169876504.2294.23.camel@concordia.ozlabs.ibm.com>
	<m1k5z7smkj.fsf@ebiederm.dsl.xmission.com>
	<1169971963.19887.15.camel@concordia.ozlabs.ibm.com>
	<m14pqbsg2j.fsf@ebiederm.dsl.xmission.com>
	<1170015292.26655.6.camel@localhost.localdomain>
	<m1fy9uq3et.fsf@ebiederm.dsl.xmission.com>
	<1170019048.26655.27.camel@localhost.localdomain>
	<m1lkjmok2j.fsf@ebiederm.dsl.xmission.com>
	<1170026259.26655.114.camel@localhost.localdomain>
	<m1bqkioh6z.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 11:26:48 +1100
Message-Id: <1170030408.26655.137.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> That isn't even the reason it is that way.  It is because allocating
> 4096 irqs in a single vector is a bad idea

Why ?

> and because it requires you to pass type information of what kind of
> msi you are dealing with to the lower levels in an allocation routine 
> that make it bad idea.  
> Because if you don't consider the IBM HV it provides not benefit and 
> just puts unnecessary loops, and type information in architecture 
> code.

The only difference in practice is loop vs. no loop in fact. That is

alloc_irq (one MSI) for your version and
alloc_irqs (an array of MSIs) for our version.

Sure, the later, we also pass the type, but you don't use it for the
"raw" case, we only use it for the hypervisor case.

The difference is that one version (yours) cannot handle the HV case
while the other can. Makes a big difference to me.

> Face it.  Trying to make the allocation routine serve for both the
> raw and the HV case unmodified is a layering violation.

So you want two separate abstractions and I think that's gross.

Ben.
