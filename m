Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5F6DDE07E
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:33:00 +1100 (EST)
Subject: Re: [PATCH 0/6] MSI portability cleanups
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1170065487.19887.91.camel@concordia.ozlabs.ibm.com>
References: <m1hcuaohqj.fsf@ebiederm.dsl.xmission.com>
	<20070128.153707.30184351.davem@davemloft.net>
	<m1tzyammv0.fsf@ebiederm.dsl.xmission.com>
	<20070128.212554.23015561.davem@davemloft.net>
	<1170050737.26655.233.camel@localhost.localdomain>
	<m1sldukxwm.fsf@ebiederm.dsl.xmission.com>
	<1170065487.19887.91.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 30 Jan 2007 07:32:10 +1100
Message-Id: <1170102731.26655.277.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: tony.luck@intel.com, grundler@parisc-linux.org, jeff@garzik.org,
	greg@kroah.com, linux-kernel@vger.kernel.org,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	shaohua.li@intel.com, mingo@elte.hu,
	David Miller <davem@davemloft.net>, brice@myri.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> You can read config space, but it's not clear to me if the HV is allowed
> to filter it and hide things. 

I've seen it do it for example with EADS bridges. I haven't seen doing
it with devices (other than hiding entire functions) but I wouldn't
exclude it...

> It's also possible that the device
> supports MSI, but for some reason the HV doesn't allow it on that device
> etc. so you really have to ask the HV if it's enabled. So pci_find_cap()
> shouldn't crash or anything, but it may lie to you.

Yup.

> One thing I did like about my code, is that pci_enable_msi() and
> pci_enable_msix() are just small wrappers around generic_enable_msi() -
> which does all the work, and is the same regardless of whether it's an
> MSI or MSI-X. Although that's facilitated by the type arg which you
> don't like.

Part of the reason is you make MSI look like MSI-X (a vector of 1 entry)
while Eric does the opposite.

Ben.
