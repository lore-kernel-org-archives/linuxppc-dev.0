Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 377E82C032E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 21:15:43 +1100 (EST)
Date: Thu, 10 Oct 2013 12:17:05 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131010101704.GC11874@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <5254D397.9030307@zytor.com> <1381292648.645.259.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381292648.645.259.camel@pasglop>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-ide@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, iss_storagedev@hp.com, linux-driver@qlogic.com,
 Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Jon Mason <jon.mason@intel.com>,
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

On Wed, Oct 09, 2013 at 03:24:08PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2013-10-08 at 20:55 -0700, H. Peter Anvin wrote:
> > Why not add a minimum number to pci_enable_msix(), i.e.:
> > 
> > pci_enable_msix(pdev, msix_entries, nvec, minvec)
> > 
> > ... which means "nvec" is the number of interrupts *requested*, and
> > "minvec" is the minimum acceptable number (otherwise fail).
> 
> Which is exactly what Ben (the other Ben :-) suggested and that I
> supports...

Ok, this suggestion sounded in one or another form by several people.
What about name it pcim_enable_msix_range() and wrap in couple more
helpers to complete an API:

int pcim_enable_msix_range(pdev, msix_entries, nvec, minvec);
	<0 - error code
	>0 - number of MSIs allocated, where minvec >= result <= nvec

int pcim_enable_msix(pdev, msix_entries, nvec);
	<0 - error code
	>0 - number of MSIs allocated, where 1 >= result <= nvec 

int pcim_enable_msix_exact(pdev, msix_entries, nvec);
	<0 - error code
	>0 - number of MSIs allocated, where result == nvec

The latter's return value seems odd, but I can not help to make
it consistent with the first two.


(Sorry if you see this message twice - my MUA seems struggle with one of CC).

> Cheers,
> Ben.
> 
> 

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
