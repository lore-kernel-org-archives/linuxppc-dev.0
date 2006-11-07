Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B29167C38
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 18:41:36 +1100 (EST)
Subject: Re: [RFC/PATCH 0/7] Powerpc MSI Implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <1162884080.585336.70559261997.qpush@cradle>
References: <1162884080.585336.70559261997.qpush@cradle>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 18:41:16 +1100
Message-Id: <1162885276.28571.444.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  * Moved msi_info into the pci_dev. This is ugly, but not sure where else
>    we can put it, pci_dn is no longer an option.

It's only ugly because it's currently powerpc specific (and thus needs
an ifdef). It's the right way to go in the long run for the generic
code. 

Now the question is wether Eric is interested in our work and thus
wether it's worth trying to port the intel & altix MSI stuff to our
infrastructure, in which case there is no more reason not to add the
msi_info to pci_dev without any ifdef (just define it as an empty struct
if CONFIG_PCI_MSI is not set).

Cheers,
Ben.
