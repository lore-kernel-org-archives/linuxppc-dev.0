Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id DA8782C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 18:27:50 +1000 (EST)
Date: Fri, 4 Oct 2013 10:29:20 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Ben Hutchings <bhutchings@solarflare.com>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-pci@vger.kernel.org,
 iss_storagedev@hp.com, linux-driver@qlogic.com, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, e1000-devel@lists.sourceforge.net,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 03, 2013 at 11:49:45PM +0100, Ben Hutchings wrote:
> On Wed, 2013-10-02 at 12:48 +0200, Alexander Gordeev wrote:
> > This update converts pci_enable_msix() and pci_enable_msi_block()
> > interfaces to canonical kernel functions and makes them return a
> > error code in case of failure or 0 in case of success.
> [...]
> 
> I think this is fundamentally flawed: pci_msix_table_size() and
> pci_get_msi_cap() can only report the limits of the *device* (which the
> driver usually already knows), whereas MSI allocation can also be
> constrained due to *global* limits on the number of distinct IRQs.

Even the current implementation by no means addresses it. Although it
might seem a case for architectures to report the number of IRQs available
for a driver to retry, in fact they all just fail. The same applies to
*any* other type of resource involved: irq_desc's, CPU interrupt vector
space, msi_desc's etc. No platform cares about it and just bails out once
a constrain met (please correct me if I am wrong here). Given that Linux
has been doing well even on embedded I think we should not change it.

The only exception to the above is pSeries platform which takes advantage
of the current design (to implement MSI quota). There are indications we
can satisfy pSeries requirements, but the design proposed in this RFC
is not going to change drastically anyway. The start of the discusstion
is here: https://lkml.org/lkml/2013/9/5/293

> Currently pci_enable_msix() will report a positive value if it fails due
> to the global limit.  Your patch 7 removes that.  pci_enable_msi_block()
> unfortunately doesn't appear to do this.

pci_enable_msi_block() can do more than one MSI only on x86 (with IOMMU),
but it does not bother to return positive numbers, indeed.

> It seems to me that a more useful interface would take a minimum and
> maximum number of vectors from the driver.  This wouldn't allow the
> driver to specify that it could only accept, say, any even number within
> a certain range, but you could still leave the current functions
> available for any driver that needs that.

Mmmm.. I am not sure I am getting it. Could you please rephrase?

> Ben.

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
