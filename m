Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 3471C2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 18:31:33 +1100 (EST)
Date: Tue, 8 Oct 2013 09:33:02 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131008073301.GC10669@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <20131008043330.GF31666@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131008043330.GF31666@concordia>
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

On Tue, Oct 08, 2013 at 03:33:30PM +1100, Michael Ellerman wrote:
> On Wed, Oct 02, 2013 at 12:29:04PM +0200, Alexander Gordeev wrote:
> > This technique proved to be confusing and error-prone. Vast share
> > of device drivers simply fail to follow the described guidelines.
> 
> To clarify "Vast share of device drivers":
> 
>  - 58 drivers call pci_enable_msix()
>  - 24 try a single allocation and then fallback to MSI/LSI
>  - 19 use the loop style allocation as above
>  - 14 try an allocation, and if it fails retry once
>  - 1  incorrectly continues when pci_enable_msix() returns > 0
> 
> So 33 drivers (> 50%) successfully make use of the "confusing and
> error-prone" return value.

Ok, you caught me - 'vast share' is incorrect and is a subject to
rewording. But out of 19/58 how many drivers tested fallbacks on the
real hardware? IOW, which drivers are affected by the pSeries quota?

> And yes, one is buggy, so obviously the interface is too complex. Thanks
> drivers/ntb/ntb_hw.c

vmxnet3 would be the best example.

> cheers

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
