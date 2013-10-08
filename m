Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id B9E332C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 18:55:36 +1100 (EST)
Date: Tue, 8 Oct 2013 09:56:59 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC 05/77] PCI/MSI: Convert pci_msix_table_size() to a
 public interface
Message-ID: <20131008075658.GE10669@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <e8b51bd48c24d0fc4ee8adea5c138c9bf84191e9.1380703262.git.agordeev@redhat.com>
 <20131007181043.GA27396@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131007181043.GA27396@htj.dyndns.org>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-pci@vger.kernel.org,
 iss_storagedev@hp.com, linux-driver@qlogic.com,
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

On Mon, Oct 07, 2013 at 02:10:43PM -0400, Tejun Heo wrote:
> On Wed, Oct 02, 2013 at 12:48:21PM +0200, Alexander Gordeev wrote:
> > Make pci_msix_table_size() to return a error code if the device
> > does not support MSI-X. This update is needed to facilitate a
> > forthcoming re-design MSI/MSI-X interrupts enabling pattern.
> > 
> > Device drivers will use this interface to obtain maximum number
> > of MSI-X interrupts the device supports and use that value in
> > the following call to pci_enable_msix() interface.
> 
> Hmmm... I probably missed something but why is this necessary?  To
> discern between -EINVAL and -ENOSPC?  If so, does that really matter?

pci_msix_table_size() is kind of helper and returns 0 if a device does
not have MSI-X table. If we want drivers to use it we need return -EINVAL
for MSI-X incapable/disabled devices. Nothing about -ENOSPC.

> tejun

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
