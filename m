Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPJvy0h5mzDw04
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 10:49:17 +1100 (AEDT)
Date: Wed, 23 Nov 2016 17:49:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 clsoto@us.ibm.com
Subject: Re: [PATCH v3 0/2] Disable VF's memory space on updating IOV BARs
Message-ID: <20161123234910.GN16033@bhelgaas-glaptop.roam.corp.google.com>
References: <1477444536-29612-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477444536-29612-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 26, 2016 at 12:15:34PM +1100, Gavin Shan wrote:
> This moves pcibios_sriov_enable() to the point before VF and VF BARs
> are enabled on PowerNV platform. Also, pci_update_resource() is used
> to update IOV BARs on PowerNV platform, the PF might have been functional
> when the function is called. We shouldn't disable PF's memory decoding
> at that point. Instead, the VF's memory space should be disabled.
> 
> Changelog
> =========
> v3:
>   * Disable VF's memory space when IOV BARs are updated in
>     pcibios_sriov_enable().
> v2:
>   * Added one patch calling pcibios_sriov_enable() before the VF
>     and VF BARs are enabled.
> 
> Gavin Shan (2):
>   PCI: Call pcibios_sriov_enable() before IOV BARs are enabled
>   PCI: Disable VF's memory space on updating IOV BAR in
>     pci_update_resource()
> 
>  drivers/pci/iov.c       | 14 +++++++-------
>  drivers/pci/setup-res.c | 28 ++++++++++++++++++++--------
>  2 files changed, 27 insertions(+), 15 deletions(-)

I applied these to pci/virtualization for v4.10.  Thanks for your
patience, Gavin.
