Return-Path: <bhelgaas@google.com>
Received: from mail-io0-x22d.google.com (mail-io0-x22d.google.com
 [IPv6:2607:f8b0:4001:c06::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C3871A1E1F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 03:56:30 +1000 (AEST)
Received: by iofh134 with SMTP id h134so67618539iof.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2015 10:56:28 -0700 (PDT)
Date: Thu, 3 Sep 2015 12:56:24 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, mst@redhat.com,
 Fam Zheng <famz@redhat.com>, Yinghai Lu <yinghai@kernel.org>,
 Yijing Wang <wangyijing@huawei.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 2/2] powerpc/PCI: Disable MSI/MSI-X interrupts at PCI
 probe time in OF case
Message-ID: <20150903175624.GI829@google.com>
References: <1439932430-13375-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1439932077-11427-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440010450-4549-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440010450-4549-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[+cc Fam, Yinghai, Yijing, Eric (reviewers of MST's original series), Dave]

Hi Guilherme,

On Wed, Aug 19, 2015 at 03:54:10PM -0300, Guilherme G. Piccoli wrote:
> Changes since v2:
>  * Added "Fixes" line
>  * Improved commit reference by using 12 first chars of SHA
> 
> >8----------8<
> 
> Since the commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even
> if kernel doesn't support MSI"), MSI/MSI-X interrupts aren't being
> disabled at PCI probe time, as the logic responsible for this was moved
> in the aforementioned commit from pci_device_add() to pci_setup_device().
> The latter function is not reachable on PowerPC pSeries platform during
> Open Firmware PCI probing time.
> 
> This patch calls pci_msi_setup_pci_dev() explicitly to disable MSI/MSI-X
> during PCI probe time on pSeries platform.
> 
> Fixes: 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel
> doesn't support MSI")
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/pci_of_scan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index 42e02a2..0e920f3 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -191,6 +191,9 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
>  
>  	pci_device_add(dev, bus);
>  
> +	/* Disable MSI/MSI-X here to avoid bogus interrupts */
> +	pci_msi_setup_pci_dev(dev);

of_create_pci_dev() already has a lot of code that duplicates
pci_setup_device(), and it's a shame to add more.  There's also a sparc
version of of_create_pci_dev() that presumably has the same problem you're
fixing for powerpc.

Michael originally called pci_msi_setup_pci_dev() from
pci_init_capabilities() [1].  A subsequent patch moved the call
to pci_setup_device() [2] because an early quirk (called from
pci_setup_device()) used pci_msi_off(), which depended on
pci_msi_setup_pci_dev().  

But we later removed pci_msi_off() completely, so I think we probably
*could* call pci_msi_setup_pci_dev() from pci_init_capabilities().

That would be much nicer because it makes more sense there, and it
would do the right thing for powerpc and sparc because they both
already use that path.

Can you look into moving the call?

Bjorn

[1] http://lkml.kernel.org/r/1427641227-7574-3-git-send-email-mst@redhat.com
[2] http://lkml.kernel.org/r/1427641227-7574-4-git-send-email-mst@redhat.com

>  	return dev;
>  }
>  EXPORT_SYMBOL(of_create_pci_dev);
> -- 
> 2.1.0
> 
