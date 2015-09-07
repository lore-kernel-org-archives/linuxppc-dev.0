Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C55B11A234F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 13:10:03 +1000 (AEST)
Message-ID: <1441595403.12945.3.camel@ellerman.id.au>
Subject: Re: [PATCH v2 2/2] powerpc/PCI: Disable MSI/MSI-X interrupts at PCI
 probe time in OF case
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mst@redhat.com, Fam Zheng <famz@redhat.com>, Yinghai Lu
 <yinghai@kernel.org>,  Yijing Wang <wangyijing@huawei.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>, "David S. Miller" <davem@davemloft.net>
Date: Mon, 07 Sep 2015 13:10:03 +1000
In-Reply-To: <20150903175624.GI829@google.com>
References: <1439932430-13375-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1439932077-11427-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440010450-4549-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20150903175624.GI829@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-03 at 12:56 -0500, Bjorn Helgaas wrote:
> [+cc Fam, Yinghai, Yijing, Eric (reviewers of MST's original series), Dave]
> 
> Hi Guilherme,
> 
> On Wed, Aug 19, 2015 at 03:54:10PM -0300, Guilherme G. Piccoli wrote:
> > diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> > index 42e02a2..0e920f3 100644
> > --- a/arch/powerpc/kernel/pci_of_scan.c
> > +++ b/arch/powerpc/kernel/pci_of_scan.c
> > @@ -191,6 +191,9 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
> >  
> >  	pci_device_add(dev, bus);
> >  
> > +	/* Disable MSI/MSI-X here to avoid bogus interrupts */
> > +	pci_msi_setup_pci_dev(dev);
> 
> of_create_pci_dev() already has a lot of code that duplicates
> pci_setup_device(), and it's a shame to add more.  There's also a sparc
> version of of_create_pci_dev() that presumably has the same problem you're
> fixing for powerpc.
> 
> Michael originally called pci_msi_setup_pci_dev() from
> pci_init_capabilities() [1].  A subsequent patch moved the call
> to pci_setup_device() [2] because an early quirk (called from
> pci_setup_device()) used pci_msi_off(), which depended on
> pci_msi_setup_pci_dev().  
> 
> But we later removed pci_msi_off() completely, so I think we probably
> *could* call pci_msi_setup_pci_dev() from pci_init_capabilities().
> 
> That would be much nicer because it makes more sense there, and it
> would do the right thing for powerpc and sparc because they both
> already use that path.

Sounds reasonable to me.

Guilherme can you please try this and let us know.

cheers
