Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0E73DE182
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:27:00 +1100 (EST)
Subject: Re: [PATCH 0/6] MSI portability cleanups
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1sldukxwm.fsf@ebiederm.dsl.xmission.com>
References: <m1hcuaohqj.fsf@ebiederm.dsl.xmission.com>
	<20070128.153707.30184351.davem@davemloft.net>
	<m1tzyammv0.fsf@ebiederm.dsl.xmission.com>
	<20070128.212554.23015561.davem@davemloft.net>
	<1170050737.26655.233.camel@localhost.localdomain>
	<m1sldukxwm.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 30 Jan 2007 07:22:38 +1100
Message-Id: <1170102158.26655.273.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: tony.luck@intel.com, grundler@parisc-linux.org, jeff@garzik.org,
	greg@kroah.com, linux-kernel@vger.kernel.org,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, brice@myri.com,
	shaohua.li@intel.com, mingo@elte.hu, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This is the most straight forward and handles machines with really
> weird msi setups, so I lean in this direction.
> 
> The question is there anything at all we can do generically?
> 
> I can't see a case where ppc_md would not wind up with the hooks
> that decide if it is a hypervisor or not.  Even if we came up
> with a better set of functions you need to hook.

Sure, but with Michael's approach, the only hook was get_msi_ops(pdev) 

Anyway, there isn't -that- much that can be done generically in the HV
case. Mostly some argument sanity checking, the logic for saving &
restoring pdev->irq for MSIs, that sort of thing.

> Ok. I think I get the point of check.  I believe I need to look at your
> code a little more and see what you are doing to see if there is anything
> generic worth doing, that we can always do outside of architecture code
> no matter how much of the job the Hypervisor wants to do for us.

I understand.

> I'd hate to hit a different Hypervisor that did something close but
> not quite the same and have the code fail then.  So definitely
> avoiding touching pci config space at all in the calls seems to make a
> lot of sense.  This includes avoiding pci_find_capability right?

Quite possibly yes. I'm pretty sure it will work on IBM HV but we aren't
really supposed to use it...

> Off the top of my head the only things we can do generically are
> some data structure things and flags like dev->msi_enabled or
> dev->msix_enabled.

That and the saving & restoring of pdev->irq. That is not very much.

> Anyway have a nice night and more in the morning.

Ben.
