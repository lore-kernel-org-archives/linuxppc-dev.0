Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DD2622C0246
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 03:29:43 +1100 (EST)
Message-ID: <5256D5AB.4050105@zytor.com>
Date: Thu, 10 Oct 2013 09:28:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
References: <cover.1380703262.git.agordeev@redhat.com>
 <5254D397.9030307@zytor.com> <1381292648.645.259.camel@pasglop>
 <20131010101704.GC11874@dhcp-26-207.brq.redhat.com>
In-Reply-To: <20131010101704.GC11874@dhcp-26-207.brq.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On 10/10/2013 03:17 AM, Alexander Gordeev wrote:
> On Wed, Oct 09, 2013 at 03:24:08PM +1100, Benjamin Herrenschmidt wrote:
> 
> Ok, this suggestion sounded in one or another form by several people.
> What about name it pcim_enable_msix_range() and wrap in couple more
> helpers to complete an API:
> 
> int pcim_enable_msix_range(pdev, msix_entries, nvec, minvec);
> 	<0 - error code
> 	>0 - number of MSIs allocated, where minvec >= result <= nvec
> 
> int pcim_enable_msix(pdev, msix_entries, nvec);
> 	<0 - error code
> 	>0 - number of MSIs allocated, where 1 >= result <= nvec 
> 
> int pcim_enable_msix_exact(pdev, msix_entries, nvec);
> 	<0 - error code
> 	>0 - number of MSIs allocated, where result == nvec
> 
> The latter's return value seems odd, but I can not help to make
> it consistent with the first two.
> 

Is there a reason for the wrappers, as opposed to just specifying either
1 or nvec as the minimum?

	-hpa
