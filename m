Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13B1BDDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 07:26:50 +1000 (EST)
Subject: Re: [PATCH 5/7] pci: Export the pci_restore_msi_state() function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20071022181336.GC4280@austin.ibm.com>
References: <1192829817.22064.559.camel@teletran1>
	<20071021.162131.43417026.davem@davemloft.net>
	<1193017764.10318.17.camel@concordia>
	<20071022181336.GC4280@austin.ibm.com>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 07:24:27 +1000
Message-Id: <1193088267.6745.108.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, mcarlson@broadcom.com,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, mchan@broadcom.com,
	linux-pci@atrey.karlin.mff.cuni.cz, David Miller <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-22 at 13:13 -0500, Linas Vepstas wrote:
> On Mon, Oct 22, 2007 at 11:49:24AM +1000, Michael Ellerman wrote:
> > 
> > On pseries there's a chance it will work for PCI error recovery, but if
> > so it's just lucky that firmware has left everything configured the same
> > way. 
> 
> ? The papr is quite clear that i is up to the OS to restore the msi
> state after an eeh error.

Via direct config space access or via firmware change-msi calls ?

> > Yes I think so. That way we can properly reconfigure via the firmware
> > interface. The other option would be to design some new arch hook to do
> > resume, but just doing a disable/enable seems simpler to me.
> 
> Err, If you read the code for suspend/resume, it never actually calls
> disable/enable (and thus doesn't go to the firmware); it calls 
> restore_msi_state() function!
> 
> If suspend/resume needs to call firmware to restore the state, then,
> at the moment, suspend/resume is broken.  As I mentioned earlier,
> I presumed that no powerpc laptops currently use msi-enabled devices,
> as otherwise, this would have been flushed out.

I don't know why you keep talking about powerpc laptops here ... 

Ben.
