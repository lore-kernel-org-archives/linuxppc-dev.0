Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B13722C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 15:08:44 +1100 (EST)
Message-ID: <5254D397.9030307@zytor.com>
Date: Tue, 08 Oct 2013 20:55:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
References: <cover.1380703262.git.agordeev@redhat.com>
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, VMware@dhcp-26-207.brq.redhat.com,
 "Inc." <pv-drivers@vmware.com>, linux-nvme@lists.infradead.org,
 linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-pci@vger.kernel.org, iss_storagedev@hp.com, linux-driver@qlogic.com,
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

On 10/02/2013 03:29 AM, Alexander Gordeev wrote:
> 
> As result, device drivers will cease to use the overcomplicated
> repeated fallbacks technique and resort to a straightforward
> pattern - determine the number of MSI/MSI-X interrupts required
> before calling pci_enable_msi_block() and pci_enable_msix()
> interfaces:
> 
> 
> 	rc = pci_msix_table_size(adapter->pdev);
> 	if (rc < 0)
> 		return rc;
> 
> 	nvec = min(nvec, rc);
> 	if (nvec < FOO_DRIVER_MINIMUM_NVEC) {
> 		return -ENOSPC;
> 
> 	for (i = 0; i < nvec; i++)
> 		adapter->msix_entries[i].entry = i;
> 
> 	rc = pci_enable_msix(adapter->pdev,
> 			     adapter->msix_entries, nvec);
> 	return rc;
> 

Why not add a minimum number to pci_enable_msix(), i.e.:

pci_enable_msix(pdev, msix_entries, nvec, minvec)

... which means "nvec" is the number of interrupts *requested*, and
"minvec" is the minimum acceptable number (otherwise fail).

	-hpa
