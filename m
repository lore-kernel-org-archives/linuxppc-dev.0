Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 658C92C010A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 05:06:44 +1100 (EST)
Date: Thu, 10 Oct 2013 20:07:05 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131010180704.GA15719@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <5254D397.9030307@zytor.com> <1381292648.645.259.camel@pasglop>
 <20131010101704.GC11874@dhcp-26-207.brq.redhat.com>
 <5256D5AB.4050105@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5256D5AB.4050105@zytor.com>
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

On Thu, Oct 10, 2013 at 09:28:27AM -0700, H. Peter Anvin wrote:
> On 10/10/2013 03:17 AM, Alexander Gordeev wrote:
> > On Wed, Oct 09, 2013 at 03:24:08PM +1100, Benjamin Herrenschmidt wrote:
> > 
> > Ok, this suggestion sounded in one or another form by several people.
> > What about name it pcim_enable_msix_range() and wrap in couple more
> > helpers to complete an API:
> > 
> > int pcim_enable_msix_range(pdev, msix_entries, nvec, minvec);
> > 	<0 - error code
> > 	>0 - number of MSIs allocated, where minvec >= result <= nvec
> > 
> > int pcim_enable_msix(pdev, msix_entries, nvec);
> > 	<0 - error code
> > 	>0 - number of MSIs allocated, where 1 >= result <= nvec 
> > 
> > int pcim_enable_msix_exact(pdev, msix_entries, nvec);
> > 	<0 - error code
> > 	>0 - number of MSIs allocated, where result == nvec
> > 
> > The latter's return value seems odd, but I can not help to make
> > it consistent with the first two.
> > 
> 
> Is there a reason for the wrappers, as opposed to just specifying either
> 1 or nvec as the minimum?

The wrappers are more handy IMO.

I.e. can imagine people start struggling to figure out what minvec to provide:
1 or 0? Why 1? Oh.. okay.. Or should we tolerate 0 (as opposite to -ERANGE)?

Well, do not know.. pcim_enable_msix(pdev, msix_entries, nvec, nvec) is 
less readable for me than just pcim_enable_msix_exact(pdev, msix_entries,
nvec).

> 	-hpa

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
