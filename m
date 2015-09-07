Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98C4A1A2350
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 13:17:03 +1000 (AEST)
Message-ID: <1441595823.12945.4.camel@ellerman.id.au>
Subject: Re: [PATCH v2 2/2] powerpc/PCI: Disable MSI/MSI-X interrupts at PCI
 probe time in OF case
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org,  gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, Fam Zheng <famz@redhat.com>,
 Yinghai Lu <yinghai@kernel.org>, Yijing Wang <wangyijing@huawei.com>, "Eric
 W. Biederman" <ebiederm@xmission.com>, "David S. Miller"
 <davem@davemloft.net>
Date: Mon, 07 Sep 2015 13:17:03 +1000
In-Reply-To: <20150906173838-mutt-send-email-mst@redhat.com>
References: <1439932430-13375-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1439932077-11427-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440010450-4549-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20150903175624.GI829@google.com> <55EA2678.5030801@linux.vnet.ibm.com>
 <20150906173838-mutt-send-email-mst@redhat.com>
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

On Sun, 2015-09-06 at 17:44 +0300, Michael S. Tsirkin wrote:
> On Fri, Sep 04, 2015 at 08:17:12PM -0300, Guilherme G. Piccoli wrote:
> > Hello Bjorn,
> > 
> > >of_create_pci_dev() already has a lot of code that duplicates
> > >pci_setup_device(), and it's a shame to add more.  There's also a sparc
> > >version of of_create_pci_dev() that presumably has the same problem you're
> > >fixing for powerpc.
> > 
> > Thanks for the information!
> > 
> > >Michael originally called pci_msi_setup_pci_dev() from
> > >pci_init_capabilities() [1].  A subsequent patch moved the call
> > >to pci_setup_device() [2] because an early quirk (called from
> > >pci_setup_device()) used pci_msi_off(), which depended on
> > >pci_msi_setup_pci_dev().
> > >
> > >But we later removed pci_msi_off() completely, so I think we probably
> > >*could* call pci_msi_setup_pci_dev() from pci_init_capabilities().
> > >
> > >That would be much nicer because it makes more sense there, and it
> > >would do the right thing for powerpc and sparc because they both
> > >already use that path.
> > >
> > >Can you look into moving the call?
> > 
> > I might have misunderstood something here (sorry if it's the case), but
> > moving the call to pci_init_capabilities() has the same practical
> > implications than reverting my 2 commmits [1] [2] and Michael Tsirkin's
> > commit [3], except when CONFIG_PCI_MSI is not set - in this case, moving the
> > call would initialize MSI capabilities anyway, since pci_init_capabilities()
> > executes even if CONFIG_PCI_MSI isn't set.
> > 
> > My question is: is necessary to initialize MSI capabilities even with
> > CONFIG_PCI_MSI not set? In negative case, would be "cleaner" revert the 3
> > commits, right?
> > 
> > On the other hand, if it's necessary to initialize MSI capabilities on
> > devices anyway, we can change the call place.
> 
> I think the reason why it's necessary is explained in
> commit log for commit 1851617cd2da9cc53cdc1738f4148f4f042c0e56 (that's
> [3] below).

Well yes and no.

What we want to do when CONFIG_PCI_MSI=n is disable MSI on the device. In order
to do that the code first initialises dev->msi[x]_cap.

But arguably that's wrong, ie. when CONFIG_PCI_MSI=n dev->msi[x]_cap *should*
be zero so that any code which erroneously tries to use them will fail.

But perhaps that's being too pedantic :)

cheers
