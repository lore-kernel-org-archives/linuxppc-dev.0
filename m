Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LHwl4G6bzF2Nx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 05:56:07 +1000 (AEST)
Date: Tue, 10 Apr 2018 14:55:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com
Subject: Re: [PATCH, RESEND, pci, v2] pci: Delete PCI disabling informational
 messages
Message-ID: <20180410195556.GF54986@bhelgaas-glaptop.roam.corp.google.com>
References: <20180404151035.12140-1-desnesn@linux.vnet.ibm.com>
 <20180410193631.GC54986@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180410193631.GC54986@bhelgaas-glaptop.roam.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 10, 2018 at 02:36:31PM -0500, Bjorn Helgaas wrote:
> On Wed, Apr 04, 2018 at 12:10:35PM -0300, Desnes A. Nunes do Rosario wrote:
> > The disabling informational messages on the PCI subsystem should be deleted
> > since they do not represent any real value for the system logs.
> > 
> > These messages are either not presented, or presented for all PCI devices
> > (e.g., powerpc now realigns all PCI devices to its page size). Thus, they
> > are flooding system logs and can be interpreted as a false positive for
> > total PCI failure on the system.
> > 
> > [root@system user]# dmesg | grep -i disabling
> > [    0.692270] pci 0000:00:00.0: Disabling memory decoding and releasing memory resources
> > [    0.692324] pci 0000:00:00.0: disabling bridge mem windows
> > [    0.729134] pci 0001:00:00.0: Disabling memory decoding and releasing memory resources
> > [    0.737352] pci 0001:00:00.0: disabling bridge mem windows
> > [    0.776295] pci 0002:00:00.0: Disabling memory decoding and releasing memory resources
> > [    0.784509] pci 0002:00:00.0: disabling bridge mem windows
> > ... and goes on for all PCI devices on the system ...
> > 
> > Fixes: 38274637699 ("powerpc/powernv: Override pcibios_default_alignment() to force PCI devices to be page aligned")
> > Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
> 
> Applied to pci/resource for v4.18, thanks!
> 
> I should have gotten this in for v4.17, but I didn't; sorry about that.

This is trivial and I'm planning to squeeze a few more things into v4.17,
so I moved this to my "for-linus" branch for v4.17.

> > ---
> >  drivers/pci/pci.c       | 1 -
> >  drivers/pci/setup-res.c | 2 --
> >  2 files changed, 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 8c71d1a66cdd..1563ce1ee091 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5505,7 +5505,6 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
> >  		return;
> >  	}
> >  
> > -	pci_info(dev, "Disabling memory decoding and releasing memory resources\n");
> >  	pci_read_config_word(dev, PCI_COMMAND, &command);
> >  	command &= ~PCI_COMMAND_MEMORY;
> >  	pci_write_config_word(dev, PCI_COMMAND, command);
> > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> > index 369d48d6c6f1..6bd35e8e7cde 100644
> > --- a/drivers/pci/setup-res.c
> > +++ b/drivers/pci/setup-res.c
> > @@ -172,8 +172,6 @@ EXPORT_SYMBOL(pci_claim_resource);
> >  
> >  void pci_disable_bridge_window(struct pci_dev *dev)
> >  {
> > -	pci_info(dev, "disabling bridge mem windows\n");
> > -
> >  	/* MMIO Base/Limit */
> >  	pci_write_config_dword(dev, PCI_MEMORY_BASE, 0x0000fff0);
> >  
> > -- 
> > 2.14.3
> > 
