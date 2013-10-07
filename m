Return-Path: <htejun@gmail.com>
Received: from mail-qa0-x22f.google.com (mail-qa0-x22f.google.com
 [IPv6:2607:f8b0:400d:c00::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 194272C019C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 05:21:24 +1100 (EST)
Received: by mail-qa0-f47.google.com with SMTP id k4so3262379qaq.20
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Oct 2013 11:21:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 7 Oct 2013 14:21:17 -0400
From: Tejun Heo <tj@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131007182117.GC27396@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
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

Hello, Alexander.

On Wed, Oct 02, 2013 at 12:48:16PM +0200, Alexander Gordeev wrote:
> Alexander Gordeev (77):
>   PCI/MSI: Fix return value when populate_msi_sysfs() failed
>   PCI/MSI/PPC: Fix wrong RTAS error code reporting
>   PCI/MSI/s390: Fix single MSI only check
>   PCI/MSI/s390: Remove superfluous check of MSI type
>   PCI/MSI: Convert pci_msix_table_size() to a public interface
>   PCI/MSI: Factor out pci_get_msi_cap() interface
>   PCI/MSI: Re-design MSI/MSI-X interrupts enablement pattern
>   PCI/MSI: Get rid of pci_enable_msi_block_auto() interface
>   ahci: Update MSI/MSI-X interrupts enablement code
>   ahci: Check MRSM bit when multiple MSIs enabled
...

Whee.... that's a lot more than I expected.  I was just scanning
multiple msi users.  Maybe we can stage the work in more manageable
steps so that you don't have to go through massive conversion only to
do it all over again afterwards and likewise people don't get
bombarded on each iteration?  Maybe we can first update pci / msi code
proper, msi and then msix?

Thanks.

-- 
tejun
