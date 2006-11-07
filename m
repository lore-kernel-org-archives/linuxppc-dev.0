Return-Path: <greg@kroah.com>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id 8122B67C4F
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 19:04:42 +1100 (EST)
Date: Tue, 7 Nov 2006 17:02:57 +0900
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 0/7] Powerpc MSI Implementation
Message-ID: <20061107080257.GA5874@kroah.com>
References: <1162884080.585336.70559261997.qpush@cradle>
	<1162885276.28571.444.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1162885276.28571.444.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, "Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 07, 2006 at 06:41:16PM +1100, Benjamin Herrenschmidt wrote:
> 
> >  * Moved msi_info into the pci_dev. This is ugly, but not sure where else
> >    we can put it, pci_dn is no longer an option.
> 
> It's only ugly because it's currently powerpc specific (and thus needs
> an ifdef). It's the right way to go in the long run for the generic
> code. 
> 
> Now the question is wether Eric is interested in our work and thus
> wether it's worth trying to port the intel & altix MSI stuff to our
> infrastructure, in which case there is no more reason not to add the
> msi_info to pci_dev without any ifdef (just define it as an empty struct
> if CONFIG_PCI_MSI is not set).

I have no objection to taking this core change, and I do think the intel
and altix stuff should be moved over to this new model.

Oh, and I think your first two patches can be applied now to the tree
(header file changes).  Any objection to me doing this?

thanks,

greg k-h
