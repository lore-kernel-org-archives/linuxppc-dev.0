Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA2EDDDEAB
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 10:32:31 +1000 (EST)
Subject: Re: [BUG] powerpc does not save msi state [was Re: [PATCH 5/7]
	pci: Export the pci_restore_msi_state() function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20071022.172332.112621497.davem@davemloft.net>
References: <20071020004610.GR29903@austin.ibm.com>
	<20071019.175308.54212640.davem@davemloft.net>
	<20071022195451.GE4280@austin.ibm.com>
	<20071022.172332.112621497.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 10:32:15 +1000
Message-Id: <1193099535.6745.172.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, mcarlson@broadcom.com, linuxppc-dev@ozlabs.org,
	mchan@broadcom.com, linux-pci@atrey.karlin.mff.cuni.cz
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-22 at 17:23 -0700, David Miller wrote:
> From: linas@austin.ibm.com (Linas Vepstas)
> Date: Mon, 22 Oct 2007 14:54:52 -0500
> 
> > As discussed in the other thread, I'll try to set up a patch
> > for an arch callback for restoring msi state.

>From what it looks like at this stage, pSeries might need to
differenciate restoring MSI state after a device reset (PCI error
recovery) from restoring MSI state after suspend/resume (if we ever
implement that one).

The former apparently require manual saving & restoring of the config
space bits. (Linas, do you have a pointer to the bit of PAPR spec that
specifies that we need to save & restore the MSI message ourselves ?)

For the later (suspend/resume), that will definitely not work, or at
least, will not be enough, especially with something like suspend to
disk, where we'll need to have the firmware reconfigure the MSIs for us
(to make sure, among others, that the interrupt controllers are properly
configured for MSIs etc...).

Ben.
